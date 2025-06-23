local QBCore = exports['qb-core']:GetCoreObject()
local isSearching = false
local currentBin = nil
local cooldowns = {}

-- Inicializácia - zabezpečíme, že UI je na štarte skryté
Citizen.CreateThread(function()
    for i = 1, 3 do
        SendNUIMessage({
            action = "close"
        })
        SetNuiFocus(false, false)
        Citizen.Wait(500)
    end
end)

-- Inicializácia qb-target pre koše
Citizen.CreateThread(function()
    for _, model in pairs(Config.Trashcans) do
        exports['qb-target']:AddTargetModel(model, {
            options = {
                {
                    type = "client",
                    event = "trashsearch:start",
                    icon = "fas fa-trash",
                    label = "Prehľadať kôš"
                }
            },
            distance = 2.0
        })
    end
end)

-- Spustenie prehľadávania
RegisterNetEvent('trashsearch:start', function(data)
    local entity = data.entity
    if not isSearching then
        -- Získaj netId koša
        local netId = NetworkGetNetworkIdFromEntity(entity)
        -- Kontrola cooldownu (lokálne pre hráča)
        if cooldowns[netId] and cooldowns[netId] > GetGameTimer() then
            QBCore.Functions.Notify("Tento kôš si nedávno prehľadal!", "error")
            return
        end
        
        currentBin = entity
        isSearching = true
        
        -- Uzamknutie inventára
        LocalPlayer.state:set('inv_busy', true, true)
        
        -- Skryjeme UI pred začatím prehľadávania
        SendNUIMessage({
            action = "close"
        })
        SetNuiFocus(false, false)
        
        -- Spustenie animácie
        local playerPed = PlayerPedId()
        TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
        
        -- Progress bar
        QBCore.Functions.Progressbar("search_trash", "Prehľadávaš kôš...", Config.SearchTime * 1000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            -- Inicializuj minihru
            local slots = {}
            local totalSlots = Config.GridSize.rows * Config.GridSize.cols
            local positions = {}
            
            -- Vytvor pole pozícií
            for i = 1, totalSlots do
                positions[i] = i
            end
            
            -- Zamiešaj pozície
            for i = #positions, 2, -1 do
                local j = math.random(i)
                positions[i], positions[j] = positions[j], positions[i]
            end
            
            -- Priraď itemy a zranenia
            local itemCount = 0
            local cutCount = 0
            for i = 1, totalSlots do
                if itemCount < Config.ItemSlots and i <= Config.ItemSlots then
                    slots[positions[i]] = "item"
                    itemCount = itemCount + 1
                elseif cutCount < Config.CutSlots and i <= (Config.ItemSlots + Config.CutSlots) then
                    slots[positions[i]] = "cut"
                    cutCount = cutCount + 1
                else
                    slots[positions[i]] = "empty"
                end
            end
            
            -- Zobraz UI s minihrou
            SendNUIMessage({
                action = "open",
                slots = slots,
                maxAttempts = Config.MaxAttempts,
                rows = Config.GridSize.rows,
                cols = Config.GridSize.cols
            })
            SetNuiFocus(true, true)
        end, function()
            -- Zrušenie
            isSearching = false
            currentBin = nil
            ClearPedTasks(playerPed)
            SendNUIMessage({ action = "close" })
            SetNuiFocus(false, false)
            LocalPlayer.state:set('inv_busy', false, true)
        end)
    end
end)

-- Zníženie zdravia na klientovi
RegisterNetEvent('trashsearch:reduceHealth', function()
    local playerPed = PlayerPedId()
    local currentHealth = GetEntityHealth(playerPed)
    SetEntityHealth(playerPed, currentHealth - 20)
end)

-- NUI Callback pre kliknutia na slot
RegisterNUICallback('clickSlot', function(data, cb)
    if not isSearching then
        cb('ok')
        return
    end
    
    local playerPed = PlayerPedId()
    local slotType = data.slotType
    
    if slotType == "item" then
        -- Úspešné nájdenie itemu
        TriggerServerEvent('trashsearch:reward', NetworkGetNetworkIdFromEntity(currentBin))
    elseif slotType == "cut" then
        -- Porezanie
        TriggerServerEvent('trashsearch:cut')
        QBCore.Functions.Notify("Porezal si sa, dávaj si pozor kam šaháš!", "error")
        StartScreenEffect("MP_DrugDrunk", 0, false)
        ApplyPedBlood(playerPed, 3, 0.0, 0.0, 0.0, "wound_sheet")
    else
        -- Prázdny slot
        QBCore.Functions.Notify("Nič si nenašiel!", "error")
    end
    
    cb('ok')
end)

-- Callback pre ukončenie minihry
RegisterNUICallback('endGame', function(data, cb)
    if isSearching then
        -- Nastav cooldown pre hráča
        local netId = NetworkGetNetworkIdFromEntity(currentBin)
        cooldowns[netId] = GetGameTimer() + (Config.CooldownTime * 1000)
    end
    
    isSearching = false
    currentBin = nil
    ClearPedTasks(PlayerPedId())
    SendNUIMessage({ action = "close" })
    SetNuiFocus(false, false)
    LocalPlayer.state:set('inv_busy', false, true)
    cb('ok')
end)

-- Callback pre zatvorenie UI
RegisterNUICallback('close', function(data, cb)
    isSearching = false
    currentBin = nil
    ClearPedTasks(PlayerPedId())
    SetNuiFocus(false, false)
    LocalPlayer.state:set('inv_busy', false, true)
    cb('ok')
end)

-- Správa cooldownov (lokálne pre hráča)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for netId, time in pairs(cooldowns) do
            if GetGameTimer() >= time then
                cooldowns[netId] = nil
            end
        end
    end
end)