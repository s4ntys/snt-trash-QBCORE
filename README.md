# EN - QBCore Trash Search Script

![Framework](https://img.shields.io/badge/Framework-QBCore-blue.svg)
![Status](https://img.shields.io/badge/Status-Functional-brightgreen.svg)

An advanced script for the QBCore framework that allows players to search through trash cans and dumpsters. It includes a unique minigame for randomly finding items, a chance of getting injured, and detailed logging via Discord webhooks.

## 🎥 Preview

- https://www.tiktok.com/@prostesanty/video/7519269867745348866

## ✨ Features

-   **Targeting via `qb-target`**: A modern and optimized targeting system for containers.
-   **Interactive Minigame**: Upon starting a search, a NUI minigame (4x4 grid) is displayed where the player searches for items.
-   **Randomized Rewards**: A fully configurable loot table with individual chances for each item.
-   **Risk System**: Players can get cut while searching and lose a portion of their health.
-   **Cooldown System**: Each container has its own cooldown to prevent farming.
-   **Inventory Lock**: During the search, the player's access to their inventory is blocked to prevent glitches.
-   **Discord Logs**: Detailed logs about which player searched a container and what they found are sent via webhook.
-   **Easy Configuration**: Most settings can be easily adjusted in `config.lua`.

## (Dependencies)

Before running this script, ensure you have the following resources installed and running:

-   [**qb-core**](https://github.com/qbcore-framework/qb-core)
-   [**qb-target**](https://github.com/qbcore-framework/qb-target)

## 🔧 Installation

1.  Download the script files.
2.  Place the script folder (e.g., `snt-trash`) into your `resources` directory (ideally inside `[qb]` or `[standalone]`).
3.  **IMPORTANT:** Open `config.lua` and verify that the item names in `Config.ItemsToFind` match the item names in your `qb-core/shared/items.lua` file.
4.  In `config.lua`, set your Discord webhook URL in the `Config.WebhookURL` field.
5.  Add `ensure snt-trash` (or your folder name) to your `server.cfg` or `resources.cfg` file.
6.  Restart your server or load the script.

## ⚙️ Configuration

All major settings can be found in the `config.lua` file.

| Setting               | Description                                                                    |
| --------------------- | ------------------------------------------------------------------------------ |
| `Config.Trashcans`    | A list of container models that will be targetable.                            |
| `Config.ItemsToFind`  | The loot table. For each item, you can define its name, amount, and find chance. |
| `Config.GridSize`     | The size of the minigame grid (e.g., `{ rows = 4, cols = 4 }`).                  |
| `Config.MaxAttempts`  | The maximum number of clicks allowed in the minigame.                          |
| `Config.ItemSlots`    | The number of slots in the grid that will contain a reward.                    |
| `Config.CutSlots`     | The number of slots that will cause injury.                                    |
| `Config.CooldownTime` | The time in seconds before the same container can be searched again.           |
| `Config.SearchTime`   | The duration of the search in seconds before the minigame appears.             |
| `Config.WebhookURL`   | The URL for the Discord webhook to log findings.                               |

## 🙏 Credits

-   **SanTy** - Original author of the script.


# SK/CZ QBCore Skript na Prehľadávanie Kontajnerov (Trash Search)

![Framework](https://img.shields.io/badge/Rámec-QBCore-blue.svg)
![Stav](https://img.shields.io/badge/Stav-Funkčný-brightgreen.svg)

Pokročilý skript pre QBCore framework, ktorý hráčom umožňuje prehľadávať smetné koše a kontajnery. Obsahuje unikátnu minihru pre náhodné hľadanie predmetov, možnosť porezania a detailné logovanie cez Discord webhook.

## 🎥 Ukážka

- https://www.tiktok.com/@prostesanty/video/7519269867745348866

## ✨ Vlastnosti

-   **Cielenie cez `qb-target`**: Moderný a optimalizovaný systém cielenia na kontajnery.
-   **Interaktívna Minihra**: Po spustení hľadania sa zobrazí NUI minihra (mriežka 4x4), kde hráč hľadá predmety.
-   **Náhodné Odmeny**: Plne konfigurovateľný zoznam predmetov s individuálnou šancou na nájdenie.
-   **Systém Rizika**: Hráč sa môže pri hľadaní porezať a stratiť časť zdravia.
-   **Cooldown Systém**: Každý kontajner má vlastný cooldown, aby sa zabránilo farmeniu.
-   **Blokovanie Inventára**: Počas prehľadávania je hráčovi zablokovaný prístup do inventára, aby sa predišlo chybám.
-   **Discord Logy**: Detailné záznamy o tom, ktorý hráč prehľadal kôš a čo našiel, odosielané cez webhook.
-   **Jednoduchá Konfigurácia**: Väčšina nastavení sa dá ľahko upraviť v `config.lua`.

## Čo potrebuješ ?

Pred spustením tohto skriptu sa uistite, že máte nainštalované a funkčné nasledujúce zdroje:

-   [**qb-core**](https://github.com/qbcore-framework/qb-core)
-   [**qb-target**](https://github.com/qbcore-framework/qb-target)

## 🔧 Inštalácia

1.  Stiahnite si súbory skriptu.
2.  Vložte priečinok `snt-trash` (alebo iný názov) do vašej zložky `resources` (ideálne do `[qb]` alebo `[standalone]`).
3.  **DÔLEŽITÉ:** Otvorte `config.lua` a skontrolujte, či sa názvy predmetov v `Config.ItemsToFind` zhodujú s názvami predmetov vo vašom `qb-core/shared/items.lua`.
4.  V `config.lua` nastavte URL vášho Discord webhooku v `Config.WebhookURL`.
5.  Pridajte `ensure snt-trash` (alebo názov vášho priečinka) do vášho súboru `server.cfg` alebo `resources.cfg`.
6.  Reštartujte server alebo načítajte skript.

## ⚙️ Konfigurácia

Všetky hlavné nastavenia nájdete v súbore `config.lua`.

| Nastavenie            | Popis                                                                          |
| --------------------- | ------------------------------------------------------------------------------ |
| `Config.Trashcans`    | Zoznam modelov kontajnerov, ktoré budú cieľiteľné.                              |
| `Config.ItemsToFind`  | Tabuľka s predmetmi. Pre každý predmet môžete nastaviť názov, množstvo a šancu.   |
| `Config.GridSize`     | Veľkosť mriežky v minihre (napr. `{ rows = 4, cols = 4 }`).                     |
| `Config.MaxAttempts`  | Maximálny počet kliknutí v minihre.                                            |
| `Config.ItemSlots`    | Počet políčok v mriežke, ktoré budú obsahovať odmenu.                          |
| `Config.CutSlots`     | Počet políčok, ktoré spôsobia zranenie.                                        |
| `Config.CooldownTime` | Čas v sekundách, po ktorom je možné opäť prehľadať ten istý kontajner.           |
| `Config.SearchTime`   | Dĺžka prehľadávania v sekundách pred zobrazením minihry.                        |
| `Config.WebhookURL`   | URL adresa pre Discord webhook na logovanie nálezov.                           |

## 🙏 Poďakovanie

-   **SanTy** - Pôvodný autor skriptu.
