-- [[ Metadata ]] --
fx_version 'cerulean'
games { 'gta5' }

-- [[ Author ]] --
author 'Izumi S. <https://discordapp.com/users/871877975346405388>'
description 'Lananed Development | ped World Spawner'
discord 'https://discord.lanzaned.com'
github 'https://github.com/Lanzaned-Enterprises/LENT-PedSpawner'
docs 'https://docs.lanzaned.com/'

-- [[ Version ]] --
version '1.1.5'

-- [[ Dependencies ]] --
dependencies {
    'qb-core',
    'qb-target',
    'PolyZone',
}

-- [[ Files ]] --
shared_scripts {
    'peds.lua',
}

server_scripts {
    'server/*.lua',
}

client_scripts {
    -- Polyzone
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    -- Client Events
    'client/*.lua',
}

-- [[ Tebex ]] --
lua54 'yes'