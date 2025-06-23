fx_version 'cerulean'
game 'gta5'

author 'SanTy'
description 'QBCore Trash Search Script with Hobo: Tough Life Style Mini Game'
version '1.0.1'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'webhooks.lua',
    'server.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
}

ui_page 'html/index.html'

dependencies {
    'qb-core',
    'qb-target'
}