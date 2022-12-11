# LENT-PedSpawner

## Template
```lua
local hasPedSpawned = false

CreateThread(function()
    if not hasPedSpawned then
        exports["LENT-PedSpawner"]:SpawnPed({
            model = "mp_m_freemode_01",
            coords = vector4(0, 0, 0, 0),
            networked = false,
            allsettings = {
                scenario = "WORLD_HUMAN_CLIPBOARD",
            },
            customped = {
                hair = 0, hairTexture = 0,
                hands = 0, handsTexture = 0,
                undershirt = 0, undershirtTextures = 0,
                top = 0, topTexture  = 0,
                kevlar = 0, kevlarTexture = 0,
                decal = 0, decalTexture = 0,
                accessory = 0, accessoryTexture = 0,
                bags = 0, bagsTexture = 0,
                pants = 0, pantsTexture = 0,
                shoes = 0, shoesTexture = 0,
                mask = 0, maskTexture = 0,
                hat = 0, hatTexture = 0,
                glasses = 0, glassesTexture = 0,
    
                mother = 0,
                father = 0,
                mix = 0,
    
                makeup = 0, makeupOpacity = 0, makeupColor = 0,
                lipstick = 0, lipstickOpacity = 0, lipstickColor = 0,
                eyebrows = 0, eyebrowsOpacity = 0,eyebrowsColor = 0,
                beard = 0, beardOpacity = 0, beardColor = 0,
                eyecolor = 0,
            },
            target = {
                options = {
                    {
                        event = "testing:export:lent-pedspawner",
                        label = "Test Ped Spawner",
                        icon = "fas fa-example",
                    },
                },
                distance = 2.0,
            },
            currentpednumber = 0,
        })
        
        hasPedSpawned = true 
    end
end)
```