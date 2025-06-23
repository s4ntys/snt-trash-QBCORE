-- Debug výpis na overenie načítania
if Config.Debug then
    print("webhooks.lua načítaný")
end

function SendWebhook(playerName, discordId, trashCount, foundItems)
    if not Config.WebhookURL or Config.WebhookURL == "YOUR_WEBHOOK_URL_HERE" then
        if Config.Debug then
            print("Webhook URL nie je nastavené v config.lua!")
        end
        return
    end

    -- Priprav embed správu
    local embed = {
        {
            ["title"] = "Prehľadanie koša",
            ["color"] = 3447003, -- Modrá farba
            ["fields"] = {
                {
                    ["name"] = "Hráč",
                    ["value"] = playerName,
                    ["inline"] = true
                },
                {
                    ["name"] = "Discord ID",
                    ["value"] = discordId,
                    ["inline"] = true
                },
                {
                    ["name"] = "Počet prehľadaných košov",
                    ["value"] = tostring(trashCount),
                    ["inline"] = true
                },
                {
                    ["name"] = "Nájdené predmety",
                    ["value"] = table.concat(foundItems, ", "),
                    ["inline"] = false
                }
            },
            ["footer"] = {
                ["text"] = Config.ServerName .. " | " .. os.date("%Y-%m-%d %H:%M:%S")
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }
    }

    -- Odošli webhook
    PerformHttpRequest(Config.WebhookURL, function(err, text, headers)
        if err == 200 or err == 204 then
            if Config.Debug then
                print("Webhook uspešne odoslaný (HTTP " .. err .. ")")
            end
        else
            if Config.Debug then
                print("Chyba pri odosielaní webhooku: " .. err .. " - " .. (text or "Žiadna odpoveď"))
            end
        end
    end, 'POST', json.encode({
        username = "Trash Search Bot",
        avatar_url = Config.WebhookAvatar,
        embeds = embed
    }), { ['Content-Type'] = 'application/json' })
end