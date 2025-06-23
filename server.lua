local QBCore = exports['qb-core']:GetCoreObject()

-- Tabuľka na ukladanie štatistík (hráč -> počet prehľadaných košov)
local playerStats = {}

-- Funkcia na získanie Discord ID hráča
local function GetDiscordId(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)
    for _, identifier in pairs(identifiers) do
        if string.find(identifier, "discord:") then
            return identifier
        end
    end
    return "Není Discord ID"
end

-- Danie itemov hráčovi
RegisterServerEvent('trashsearch:reward', function(binNetId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then 
        if Config.Debug then
            print("Hráč " .. src .. " neexistuje!")
        end
        return 
    end
    
    -- Generovanie jedného náhodného itemu na základe šance
    local foundItems = {}
    local selectedItem = nil
    local selectedAmount = 0
    
    -- Zamiešaj zoznam itemov, aby sme náhodne skúšali
    local shuffledItems = {}
    for i, itemData in ipairs(Config.ItemsToFind) do
        shuffledItems[i] = itemData
    end
    for i = #shuffledItems, 2, -1 do
        local j = math.random(i)
        shuffledItems[i], shuffledItems[j] = shuffledItems[j], shuffledItems[i]
    end
    
    -- Skús nájsť jeden item na základe šance
    for _, itemData in ipairs(shuffledItems) do
        if math.random(1, 100) <= itemData.chance then
            selectedAmount = math.random(itemData.amount.min, itemData.amount.max)
            if itemData.item == 'cash' then
                -- Pridaj peniaze ako hotovosť
                Player.Functions.AddMoney('cash', selectedAmount)
                TriggerClientEvent('QBCore:Notify', src, "Našiel si $" .. selectedAmount .. "!", "success")
                foundItems[#foundItems + 1] = "$" .. selectedAmount
                if Config.Debug then
                    print("Hráč " .. src .. " našiel hotovosť: $" .. selectedAmount)
                end
            else
                -- Pridaj normálny item do inventára
                Player.Functions.AddItem(itemData.item, selectedAmount)
                -- Zobraz notifikáciu cez QBCore:Notify namiesto item boxu
                local itemLabel = QBCore.Shared.Items[itemData.item].label
                TriggerClientEvent('QBCore:Notify', src, "Našiel si " .. itemLabel .. " (" .. selectedAmount .. "x)!", "success")
                foundItems[#foundItems + 1] = itemLabel .. " (" .. selectedAmount .. "x)"
                if Config.Debug then
                    print("Hráč " .. src .. " našiel item: " .. itemData.item .. " (" .. selectedAmount .. "x)")
                end
            end
            break -- Prerušíme po nájdení prvého itemu
        end
    end
    
    -- Posielaj notifikáciu "Nič si nenašiel!" iba ak hráč naozaj nič nezískal
    if #foundItems == 0 then
        TriggerClientEvent('QBCore:Notify', src, "Nič si nenašiel!", "error")
        foundItems[#foundItems + 1] = "Nič"
        if Config.Debug then
            print("Hráč " .. src .. " nič nenašiel")
        end
    end
    
    -- Zaznamenaj prehľadanie koša
    local playerId = Player.PlayerData.source
    if not playerStats[playerId] then
        playerStats[playerId] = { discordId = GetDiscordId(playerId), count = 0 }
    end
    playerStats[playerId].count = playerStats[playerId].count + 1
    
    -- Pošli údaje na Discord cez webhook
    local playerName = GetPlayerName(playerId)
    local discordId = playerStats[playerId].discordId
    local trashCount = playerStats[playerId].count
    if type(SendWebhook) == "function" then
        SendWebhook(playerName, discordId, trashCount, foundItems)
    else
        if Config.Debug then
            print("Chyba: SendWebhook nie je definovaný! Skontroluj, či je webhooks.lua načítaný.")
        end
    end
end)

-- Mechanika porezania
RegisterServerEvent('trashsearch:cut', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then 
        if Config.Debug then
            print("Hráč " .. src .. " neexistuje pri porezaní!")
        end
        return 
    end
    
    -- Pošli udalosť na klienta, aby znížil zdravie
    TriggerClientEvent('trashsearch:reduceHealth', src)
end)