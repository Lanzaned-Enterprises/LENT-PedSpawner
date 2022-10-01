-- [[ Metadata ]] --
fx_version 'cerulean'
games { 'gta5' }

-- [[ Author ]] --
author 'Izumi S. <https://discordapp.com/users/871877975346405388>'
description 'Lananed Development | ped World Spawner'
discord 'https://discord.gg/kmKcHWGqbP'
github 'https://github.com/Lanzaned-Enterprises/LENT-PedSpawner'
docs 'https://lanzaned-development.gitbook.io/lanzaned-development-or-documentation/'

-- [[ Version ]] --
version '1.0.0'

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