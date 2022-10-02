Peds = {}

Peds.Placings = {
    -- ["exampleped"] = {
        -- ["coords"] = vector4(x, y, z, h), -- The start Coordinatos of the first mission
        
        -- ["ped"] = "mp_m_freemode_01", -- The model of chracter that you interact with
        -- ["scenario"] = "WORLD_HUMAN_CLIPBOARD", -- The animation they are playing
        -- ["block_events"] = true, -- Will block the ped from moving when hit or bumped into
        -- ["invincible"] = true, -- Makes the ped invincible
        -- ["freeze"] = true, -- Freezes the ped in it's location
  
        -- ["weapon"] = false, -- Leave false when using Scenario
        -- ["weapon_hash"] = "", -- Should be hash like "WEAPON_CARBINERIFLE"
        -- ["hostile"] = false, -- Should the ped attack the player?

        -- ["target"] = false, -- True = Allows interaction | False = Doesn't allow
        -- ["type"] = "",
        -- ["event"] = "", 
        -- ["icon"] = "", -- The icon that shows up
        -- ["text"] = "", -- The text which is cheap "locale" support

        -- [[ Do recommand that you use a clothing menu to get the right ID's ]] --
        -- ["clothing"] = true, -- True if ped = "mp_m_freemode_01" || "mp_f_freemode_01" else leave false
        -- ["mother"] = 0, ["father"] = 0, ["mix"] = 0.0,
        -- ["head"] = 7, ["HAIR_Texture"] = 3, ["HAIR_HIGHLIGHT"] = 0,
        -- ["hands"] = 1, ["HA_Texture"] = 0,
        -- ["undershirts"] = 1, ["U_Texture"] = 0,
        -- ["tops"] = 1, ["T_Texture"] = 0,
        -- ["kevlar"] = 1, ["K_Texture"] = 0,
        -- ["decal"] = 1, ["D_Texture"] = 0,
        -- ["accs"] = 1, ["A_Texture"] = 0,
        -- ["bags"] = 1, ["B_Texture"] = 0,
        -- ["pants"] = 1, ["P_Texture"] = 0,
        -- ["shoes"] = 1, ["S_Texture"] = 0,
    -- },
    ["mrpdPed"] = {
        ["coords"] = vector4(442.87, -981.95, 30.69, 86.96), -- Coordinates of the ped
 
        ["ped"] = "mp_m_freemode_01", -- The model of chracter that you interact with
        ["scenario"] = "WORLD_HUMAN_CLIPBOARD", -- The animation they are playing
        ["block_events"] = true, -- Will block the ped from moving when hit or bumped into
        ["invincible"] = true, -- Makes the ped invincible
        ["freeze"] = true, -- Freezes the ped in it's location
 
        ["weapon"] = false, -- Leave false when using Scenario
        ["weapon_hash"] = "", -- Should be hash like "WEAPON_CARBINERIFLE"
        ["hostile"] = false, -- Should the ped attack the player?

        ["target"] = false, -- True = Allows interaction | False = Doesn't allow
        ["type"] = "",  -- Is it a client or server event
        ["event"] = "", -- Event that should be executed by the target
        ["icon"] = "", -- The icon that shows up
        ["text"] = "", -- The text which is cheap "locale" support
 
        ["clothing"] = true, -- True if ped = "mp_m_freemode_01" || "mp_f_freemode_01" else leave false
        ["father"] = 0, ["mother"] = 0,
        ["head"] = 7, ["HAIR_Texture"] = 3, ["HAIR_HIGHLIGHT"] = 0,
        ["hands"] = 1, ["HA_Texture"] = 0,
        ["undershirts"] = 198, ["U_Texture"] = 0,
        ["tops"] = 416, ["T_Texture"] = 2,
        ["kevlar"] = -1, ["K_Texture"] = 0,
        ["decal"] = 135, ["D_Texture"] = 1,
        ["accs"] = 156, ["A_Texture"] = 0,
        ["bags"] = 111, ["B_Texture"] = 1,
        ["pants"] = 25, ["P_Texture"] = 0,
        ["shoes"] = 10, ["S_Texture"] = 0,
    },
    ["mrpdCaptain"] = {
        ["coords"] = vector4(463.26, -988.59, 30.69, 99.37), -- Coordinates of the ped
 
        ["ped"] = "mp_m_freemode_01", -- The model of chracter that you interact with
        ["scenario"] = "WORLD_HUMAN_AA_COFFEE", -- The animation they are playing
        ["block_events"] = true, -- Will block the ped from moving when hit or bumped into
        ["invincible"] = true, -- Makes the ped invincible
        ["freeze"] = true, -- Freezes the ped in it's location
 
        ["weapon"] = false, -- Leave false when using Scenario
        ["weapon_hash"] = "", -- Should be hash like "WEAPON_CARBINERIFLE"
        ["hostile"] = false, -- Should the ped attack the player?

        ["target"] = false, -- True = Allows interaction | False = Doesn't allow
        ["type"] = "",  -- Is it a client or server event
        ["event"] = "", -- Event that should be executed by the target
        ["icon"] = "", -- The icon that shows up
        ["text"] = "", -- The text which is cheap "locale" support
 
        ["clothing"] = true, -- True if ped = "mp_m_freemode_01" || "mp_f_freemode_01" else leave false
        ["mother"] = 7, ["father"] = 0, ["mix"] = 0.0,
        ["head"] = 7, ["HAIR_Texture"] = 3, ["HAIR_HIGHLIGHT"] = 0,
        ["hands"] = 1, ["HA_Texture"] = 0,
        ["undershirts"] = 193, ["U_Texture"] = 0,
        ["tops"] = 416, ["T_Texture"] = 1,
        ["kevlar"] = -1, ["K_Texture"] = 0,
        ["decal"] = 141, ["D_Texture"] = 1,
        ["accs"] = 156, ["A_Texture"] = 0,
        ["bags"] = 111, ["B_Texture"] = 2,
        ["pants"] = 25, ["P_Texture"] = 0,
        ["shoes"] = 10, ["S_Texture"] = 0,
    },
    ["drugrunPed"] = {
        ["coords"] = vector4(43.12, -1451.81, 29.31, 52.35), 
        
        ["ped"] = "a_m_y_genstreet_01", 
        ["scenario"] = "WORLD_HUMAN_LEANING", 
        ["block_events"] = true, 
        ["invincible"] = true, 
        ["freeze"] = true, 
  
        ["weapon"] = false, 
        ["weapon_hash"] = "", 
        ["hostile"] = false, 

        ["target"] = true,
        ["type"] = "client",
        ["event"] = "LENT:START:DRUGRUN", 
        ["icon"] = "fa-solid fa-pills", 
        ["text"] = "Start Drug Run",

        ["clothing"] = false,
        ["mother"] = 0, ["father"] = 0, ["mix"] = 0.0,
        ["head"] = 1, ["HAIR_Texture"] = 3, ["HAIR_HIGHLIGHT"] = 0,
        ["hands"] = 1, ["HA_Texture"] = 0,
        ["undershirts"] = 1, ["U_Texture"] = 0,
        ["tops"] = 1, ["T_Texture"] = 0,
        ["kevlar"] = 1, ["K_Texture"] = 0,
        ["decal"] = 1, ["D_Texture"] = 0,
        ["accs"] = 1, ["A_Texture"] = 0,
        ["bags"] = 1, ["B_Texture"] = 0,
        ["pants"] = 1, ["P_Texture"] = 0,
        ["shoes"] = 1, ["S_Texture"] = 0,
    },
}