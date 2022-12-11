--[[ Metadata ]]--
fx_version 'cerulean'
games { 'gta5' }

-- [[ Author ]] --
author 'Izumi S. <https://discordapp.com/users/871877975346405388> + AnnaLou <https://discordapp.com/users/585839151564193812>'
description 'Lananed Development | PedSpawner with MP character compatibility!'
discord 'https://discord.lanzaned.com'
github 'https://github.com/Lanzaned-Enterprises/LENT-PedSpawner'
docs 'https://docs.lanzaned.com/'

-- [[ Version ]] --
version '200'

-- [[ Dependencies ]] --
dependencies { 
    'PolyZone',
}

-- [[ Files ]] --
shared_scripts { 
    'shared/*.lua',
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

escrow_ignore {
    'shared/*.lua'
}