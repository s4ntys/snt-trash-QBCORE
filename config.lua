Config = {}

--- Debug Settings
Config.Debug = false -- Nastav na true pre debugovanie, false pre produkciu

-- Modely košov, ktoré môžu byť prehľadávané
Config.Trashcans = {
    'prop_bin_01a',
    'prop_bin_02a',
    'prop_dumpster_01a',
    'prop_dumpster_02a',
    'prop_dumpster_02b',
    'prop_dumpster_4a',
    'prop_dumpster_3a',
    'prop_cs_bin_02'
}

-- Možné itemy na nájdenie
Config.ItemsToFind = {
    { item = "water_bottle", amount = { min = 1, max = 3 }, chance = 50 },
    { item = "lockpick", amount = { min = 1, max = 3 }, chance = 45 },
    { item = "cash", amount = { min = 10, max = 155 }, chance = 90 },
    { item = "weapon_bottle", amount = { min = 1, max = 1 }, chance = 45 },
    { item = "vodka", amount = { min = 1, max = 1 }, chance = 48 },
    { item = "advancedlockpick", amount = { min = 1, max = 1 }, chance = 23 },
    { item = "spray", amount = { min = 1, max = 5 }, chance = 55 },
    { item = "perc30", amount = { min = 1, max = 2 }, chance = 22 },
    { item = "shitgpu", amount = { min = 1, max = 1 }, chance = 21 },
    { item = "printer", amount = { min = 1, max = 1 }, chance = 18 },
    { item = "skateboard", amount = { min = 1, max = 1 }, chance = 10 },
}

-- Nastavenia minihry
Config.GridSize = { rows = 4, cols = 4 } -- 4x4 mriežka
Config.MaxAttempts = 3 -- Maximálny počet pokusov
Config.ItemSlots = 1 -- Počet slotov, ktoré obsahujú itemy
Config.CutSlots = 2 -- Počet slotov, ktoré spôsobia porezanie
Config.CutChance = 100 -- Šanca na porezanie pri kliknutí na "cut" slot (100% ak je slot označený ako cut)

-- Ostatné nastavenia
Config.MaxItemsPerSearch = 155 -- Maximálny počet itemov za jedno prehľadanie (pridané)
Config.CooldownTime = 10 --  sekundách
Config.SearchTime = 5 -- Čas progress baru v sekundách

-- Discord Webhook URL
Config.WebhookURL = "https://discord.com/api/webhooks/1365698861229932594/tK9x6E7pyl00wZGA64O_DAiGPWAqd90QHI_RNyVhXm4wB0oOMgDCtyQ6yvZZPc5S3EUW" -- Nahraď za tvoj Discord webhook URL
Config.WebhookAvatar = "https://i.imgur.com/YourAvatar.png" -- Voliteľné: URL avatara pre webhook
Config.ServerName = "RPčko.eu" -- Názov servera pre embed