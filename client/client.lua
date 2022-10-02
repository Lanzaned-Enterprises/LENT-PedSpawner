-- [[ QBCore Object ]] --
local QBCore = exports['qb-core']:GetCoreObject()

-- [[ Get the PedSpawned Return + The table ]] --
local pedSpawned = false
local PedCreated = {}

-- [[ When the resource starts create the peds ]] -- 
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        createPeds()
    end
end)

-- [[ When the resource stops delete all the peds ]] -- 
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        deletePeds()
    end
end)

-- [[ When the player is loaded create the peds (Extra safety to ensure they actually spawn.) ]] -- 
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    createPeds()
end)
-- [[ When the player is unloaded dlete the peds (Extra safety to ensure they actually get deleted.) ]] -
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    deletePeds()
end)

-- [[ Function to create the peds ]] --
function createPeds()
    if pedSpawned then 
        return 
    end

    for k, v in pairs(Peds.Placings) do
        if not PedCreated[k] then 
            PedCreated[k] = {} 
        end

        local current = v["ped"]
        current = type(current) == 'string' and joaat(current) or current
        RequestModel(current)

        while not HasModelLoaded(current) do
            Wait(0)
        end

        -- The coords + heading of the Ped
        PedCreated[k] = CreatePed(0, current, v["coords"].x, v["coords"].y, v["coords"].z-1, v["coords"].w, false, false)
        
        -- Start the scneario in a basic loop
        TaskStartScenarioInPlace(PedCreated[k], v["scenario"], true)
        
        if v["freeze"] then
            -- Let the entity stay in posistion
            FreezeEntityPosition(PedCreated[k], true)
        end

        if v["invincible"] then
            -- Set the ped to be invincible
            SetEntityInvincible(PedCreated[k], true)
        end

        if v["weapon"] then
            -- Give the ped a weapon with 999 ammo
            GiveWeaponToPed(PedCreated[k], v["weapon_hash"], 999, false, true) -- Give them the specified weapon with ammo
            -- Set the weapon equiped
            SetCurrentPedWeapon(PedCreated[k], v["weapon_hash"], true)
            -- Let the ped switch weapons
            SetPedCanSwitchWeapon(PedCreated[k], true) -- Allow them to switch weapon if applicible
        end

        -- Block events like bumping
        if v["block_events"] then
            SetBlockingOfNonTemporaryEvents(PedCreated[k], true)
        end

        -- Target Stuff.. Read Config
        if v["target"] then
            exports['qb-target']:AddTargetEntity(PedCreated[k], {
                options = {
                    {
                        type = v["type"],
                        event = v["event"],
                        icon = v["icon"],
                        label = v["text"],
                    },
                },
                distance = 2.0
            })
        end

        -- Clothing for MP Characters
        if v["clothing"] then
            SetPedComponentVariation(PedCreated[k], 2, v["head"], 0, 0)
            SetPedComponentVariation(PedCreated[k], 3, v["hands"], v["HA_Texture"], 0)
            SetPedComponentVariation(PedCreated[k], 8, v["undershirts"], v["U_Texture"], 0)
            SetPedComponentVariation(PedCreated[k], 11, v["tops"], v["T_Texture"], 0)
            SetPedComponentVariation(PedCreated[k], 9, v["kevlar"], v["K_Texture"], 0)
            SetPedComponentVariation(PedCreated[k], 10, v["decal"], v["D_Texture"], 0)
            SetPedComponentVariation(PedCreated[k], 7, v["accs"], v["A_Texture"], 0)
            SetPedComponentVariation(PedCreated[k], 5, v["bags"], v["B_Texture"], 0)
            SetPedComponentVariation(PedCreated[k], 4, v["pants"], v["P_Texture"], 0)
            SetPedComponentVariation(PedCreated[k], 6, v["shoes"], v["S_Texture"], 0)
            SetPedHeadBlendData(PedCreated[k], v["mother"], v["father"], 0,0, 0, 0, 0, v["mix"], 0, false)
            SetPedHairColor(PedCreated[k], v["HAIR_Texture"], v["HAIR_HIGHLIGHT"])
            SetPedHeadOverlay(PedCreated[k], 4, v["makeup"], v["makeup_OPACITY"])
            SetPedHeadOverlayColor(PedCreated[k], 4, 1, v["makeup_COLOR"], 0)
            SetPedHeadOverlay(PedCreated[k], 8, v["lipstick"], v["lipstick_OPACITY"])
            SetPedHeadOverlayColor(PedCreated[k], 8, 1, v["lipstick_COLOR"], 0)
            SetPedHeadOverlay(PedCreated[k], 2, v["eyebrows"], v["eyebrows_OPACITY"])
            SetPedHeadOverlayColor(PedCreated[k], 2, 1, v["eyebrows_COLOR"], 0)
            SetPedHeadOverlay(PedCreated[k], 1, v["beard"], v["eyebrows_OPACITY"])
            SetPedHeadOverlayColor(PedCreated[k], 1, 1, v["beard_COLOR"], 0)
            SetPedEyeColor(PedCreated[k], v['eye_COLOR'])
        end 
        -- Natives should really be used more they're neat to spawn MP characters

        if v["hostile"] then
            SetPedAsEnemy(PedCreated[k], true) -- Ped is now an enemy
            SetPedCombatMovement(PedCreated[k], 2) -- Offensive but will take cover
            SetPedCombatRange(PedCreated[k], 1) -- Medium Range
            SetPedAlertness(PedCreated[k], 3) -- Unsure but recommanded
            SetPedCombatAttributes(PedCreated[k], 46, true) -- Always fight
            SetPedCombatAttributes(PedCreated[k], 5, true) -- Can Fight without weapons
            SetPedCombatAttributes(PedCreated[k], 0, true) -- Make use of cover
            if v["weapon"] then
                GiveWeaponToPed(PedCreated[k], v["weapon_hash"], 999, false, false) -- Give them the specified weapon with ammo
            end
            SetPedRelationshipGroupHash(PedCreated[k], GetHashKey("HATES_PLAYER")) -- Makes them HATE the player
            SetPedCanSwitchWeapon(PedCreated[k], true) -- Allow them to switch weapon if applicible
        end
    end

    pedSpawned = true
end

-- [[ Delete the Ped ]] --
function deletePeds()
    if pedSpawned then
        for _, v in pairs(PedCreated) do
            DeletePed(v)
        end
    end
end

-- [[ Check if the Ped is dead and delete afther 1 Minute ]] --
CreateThread(function()
    while true do
        Wait(5000)
        if pedSpawned then
            for _, v in pairs(PedCreated) do
                if IsEntityDead(v) then 
                    DeletePed(v)
                end
            end
        end
    end
end)