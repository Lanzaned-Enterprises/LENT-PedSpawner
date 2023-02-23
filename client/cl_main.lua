-- [[ QBCore Object ]] --
local QBCore = exports['qb-core']:GetCoreObject()

-- [[ Get the PedSpawned Return + The table ]] --
local pedSpawned = false
local PedCreated = {}

local pedSpawned2 = false
local PedCreated2 = {}

local pedSpawned3 = false
local PedCreated3 = {}

-- [[ When the resource stops delete all the peds ]] -- 
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        deletePeds()
    end
end)

-- [[ Delete the Ped ]] --
function deletePeds()
    if pedSpawned then
        for _, v in pairs(PedCreated) do
            DeletePed(v)
        end
    end

    if pedSpawned2 then
        for _, v in pairs(PedCreated2) do
            DeletePed(v)
        end
    end

    if pedSpawned3 then
        for _, v in pairs(PedCreated3) do
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

        if pedSpawned2 then
            for _, v in pairs(PedCreated2) do
                if IsEntityDead(v) then 
                    DeletePed(v)
                end
            end
        end

        if pedSpawned3 then
            for _, v in pairs(PedCreated3) do
                if IsEntityDead(v) then 
                    DeletePed(v)
                end
            end
        end
    end
end)

-- [[ Singualar Thread ]] --
CreateThread(function()
    for k, v in pairs(Peds.Placings["1stEvent"]) do
        if pedSpawned then 
            return 
        end
    
        for k, v in pairs(Peds.Placings["1stEvent"]) do
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
                            job = v["job"],
                        },
                    },
                    distance = 2.0
                })
            end
    
            -- Clothing for MP Characters
            if v["clothing"] then
                SetPedComponentVariation(PedCreated[k], 2, v["hair"], 0, 0)
                SetPedComponentVariation(PedCreated[k], 3, v["hands"], v["HA_Texture"], 0)
                SetPedComponentVariation(PedCreated[k], 8, v["undershirts"], v["U_Texture"], 0)
                SetPedComponentVariation(PedCreated[k], 11, v["tops"], v["T_Texture"], 0)
                SetPedComponentVariation(PedCreated[k], 9, v["kevlar"], v["K_Texture"], 0)
                SetPedComponentVariation(PedCreated[k], 10, v["decal"], v["D_Texture"], 0)
                SetPedComponentVariation(PedCreated[k], 7, v["accs"], v["A_Texture"], 0)
                SetPedComponentVariation(PedCreated[k], 5, v["bags"], v["B_Texture"], 0)
                SetPedComponentVariation(PedCreated[k], 4, v["pants"], v["P_Texture"], 0)
                SetPedComponentVariation(PedCreated[k], 6, v["shoes"], v["S_Texture"], 0)
                SetPedComponentVariation(PedCreated[k], 1, v["mask"], v["mask_Texture"], 0)
                SetPedPropIndex(PedCreated[k], 0, v['hat'], v['hat_TEXTURE'], true)
                SetPedPropIndex(PedCreated[k], 1, v['glasses'], v['glasses_TEXTURE'], true)
                SetPedHeadBlendData(PedCreated[k], v["mother"], v["father"], 0,0, 0, 0, 0, v["mix"], 0, false)
                SetPedHairColor(PedCreated[k], v["HAIR_Texture"], v["HAIR_HIGHLIGHT"])
                SetPedHeadOverlay(PedCreated[k], 4, v["makeup"], v["makeup_OPACITY"])
                SetPedHeadOverlayColor(PedCreated[k], 4, 1, v["makeup_COLOR"], 0)
                SetPedHeadOverlay(PedCreated[k], 8, v["lipstick"], v["lipstick_OPACITY"])
                SetPedHeadOverlayColor(PedCreated[k], 8, 1, v["lipstick_COLOR"], 0)
                SetPedHeadOverlay(PedCreated[k], 2, v["eyebrows"], v["eyebrows_OPACITY"])
                SetPedHeadOverlayColor(PedCreated[k], 2, 1, v["eyebrows_COLOR"], 0)
                SetPedHeadOverlay(PedCreated[k], 1, v["beard"], v["beard_OPACITY"])
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
end)

CreateThread(function()
    for k, v in pairs(Peds.Placings["2ndEvent"]) do
        if pedSpawned2 then 
            return 
        end
    
        for k, v in pairs(Peds.Placings["2ndEvent"]) do
            if not PedCreated2[k] then 
                PedCreated2[k] = {} 
            end
    
            local current = v["ped"]
            current = type(current) == 'string' and joaat(current) or current
            RequestModel(current)
    
            while not HasModelLoaded(current) do
                Wait(0)
            end
    
            -- The coords + heading of the Ped
            PedCreated2[k] = CreatePed(0, current, v["coords"].x, v["coords"].y, v["coords"].z-1, v["coords"].w, false, false)
            
            -- Start the scneario in a basic loop
            TaskStartScenarioInPlace(PedCreated2[k], v["scenario"], true)
            
            if v["freeze"] then
                -- Let the entity stay in posistion
                FreezeEntityPosition(PedCreated2[k], true)
            end
    
            if v["invincible"] then
                -- Set the ped to be invincible
                SetEntityInvincible(PedCreated2[k], true)
            end
    
            if v["weapon"] then
                -- Give the ped a weapon with 999 ammo
                GiveWeaponToPed(PedCreated2[k], v["weapon_hash"], 999, false, true) -- Give them the specified weapon with ammo
                -- Set the weapon equiped
                SetCurrentPedWeapon(PedCreated2[k], v["weapon_hash"], true)
                -- Let the ped switch weapons
                SetPedCanSwitchWeapon(PedCreated2[k], true) -- Allow them to switch weapon if applicible
            end
    
            -- Block events like bumping
            if v["block_events"] then
                SetBlockingOfNonTemporaryEvents(PedCreated2[k], true)
            end
    
            -- Target Stuff.. Read Config
            if v["target"] then
                exports['qb-target']:AddTargetEntity(PedCreated2[k], {
                    options = {
                        {
                            num = 1,
                            type = v["type"],
                            event = v["event"],
                            icon = v["icon"],
                            label = v["text"],
                            job = v["job"],
                        },
                        {
                            num = 2,
                            type = v["type2"],
                            event = v["event2"],
                            icon = v["icon2"],
                            label = v["text2"],
                            job = v["job2"],
                        },
                    },
                    distance = 2.0
                })
            end
    
            -- Clothing for MP Characters
            if v["clothing"] then
                SetPedComponentVariation(PedCreated2[k], 2, v["hair"], 0, 0)
                SetPedComponentVariation(PedCreated2[k], 3, v["hands"], v["HA_Texture"], 0)
                SetPedComponentVariation(PedCreated2[k], 8, v["undershirts"], v["U_Texture"], 0)
                SetPedComponentVariation(PedCreated2[k], 11, v["tops"], v["T_Texture"], 0)
                SetPedComponentVariation(PedCreated2[k], 9, v["kevlar"], v["K_Texture"], 0)
                SetPedComponentVariation(PedCreated2[k], 10, v["decal"], v["D_Texture"], 0)
                SetPedComponentVariation(PedCreated2[k], 7, v["accs"], v["A_Texture"], 0)
                SetPedComponentVariation(PedCreated2[k], 5, v["bags"], v["B_Texture"], 0)
                SetPedComponentVariation(PedCreated2[k], 4, v["pants"], v["P_Texture"], 0)
                SetPedComponentVariation(PedCreated2[k], 6, v["shoes"], v["S_Texture"], 0)
                SetPedComponentVariation(PedCreated2[k], 1, v["mask"], v["mask_Texture"], 0)
                SetPedPropIndex(PedCreated2[k], 0, v['hat'], v['hat_TEXTURE'], true)
                SetPedPropIndex(PedCreated2[k], 1, v['glasses'], v['glasses_TEXTURE'], true)
                SetPedHeadBlendData(PedCreated2[k], v["mother"], v["father"], 0,0, 0, 0, 0, v["mix"], 0, false)
                SetPedHairColor(PedCreated2[k], v["HAIR_Texture"], v["HAIR_HIGHLIGHT"])
                SetPedHeadOverlay(PedCreated2[k], 4, v["makeup"], v["makeup_OPACITY"])
                SetPedHeadOverlayColor(PedCreated2[k], 4, 1, v["makeup_COLOR"], 0)
                SetPedHeadOverlay(PedCreated2[k], 8, v["lipstick"], v["lipstick_OPACITY"])
                SetPedHeadOverlayColor(PedCreated2[k], 8, 1, v["lipstick_COLOR"], 0)
                SetPedHeadOverlay(PedCreated2[k], 2, v["eyebrows"], v["eyebrows_OPACITY"])
                SetPedHeadOverlayColor(PedCreated2[k], 2, 1, v["eyebrows_COLOR"], 0)
                SetPedHeadOverlay(PedCreated2[k], 1, v["beard"], v["beard_OPACITY"])
                SetPedHeadOverlayColor(PedCreated2[k], 1, 1, v["beard_COLOR"], 0)
                SetPedEyeColor(PedCreated2[k], v['eye_COLOR'])
            end 
            -- Natives should really be used more they're neat to spawn MP characters
    
            if v["hostile"] then
                SetPedAsEnemy(PedCreated2[k], true) -- Ped is now an enemy
                SetPedCombatMovement(PedCreated2[k], 2) -- Offensive but will take cover
                SetPedCombatRange(PedCreated2[k], 1) -- Medium Range
                SetPedAlertness(PedCreated2[k], 3) -- Unsure but recommanded
                SetPedCombatAttributes(PedCreated2[k], 46, true) -- Always fight
                SetPedCombatAttributes(PedCreated2[k], 5, true) -- Can Fight without weapons
                SetPedCombatAttributes(PedCreated2[k], 0, true) -- Make use of cover
                if v["weapon"] then
                    GiveWeaponToPed(PedCreated2[k], v["weapon_hash"], 999, false, false) -- Give them the specified weapon with ammo
                end
                SetPedRelationshipGroupHash(PedCreated2[k], GetHashKey("HATES_PLAYER")) -- Makes them HATE the player
                SetPedCanSwitchWeapon(PedCreated2[k], true) -- Allow them to switch weapon if applicible
            end
        end
    
        pedSpawned2 = true
    end
end)

CreateThread(function()
    for k, v in pairs(Peds.Placings["3rdEvent"]) do
        if pedSpawned3 then 
            return 
        end
    
        for k, v in pairs(Peds.Placings["3rdEvent"]) do
            if not PedCreated3[k] then 
                PedCreated3[k] = {} 
            end
    
            local current = v["ped"]
            current = type(current) == 'string' and joaat(current) or current
            RequestModel(current)
    
            while not HasModelLoaded(current) do
                Wait(0)
            end
    
            -- The coords + heading of the Ped
            PedCreated3[k] = CreatePed(0, current, v["coords"].x, v["coords"].y, v["coords"].z-1, v["coords"].w, false, false)
            
            -- Start the scneario in a basic loop
            TaskStartScenarioInPlace(PedCreated3[k], v["scenario"], true)
            
            if v["freeze"] then
                -- Let the entity stay in posistion
                FreezeEntityPosition(PedCreated3[k], true)
            end
    
            if v["invincible"] then
                -- Set the ped to be invincible
                SetEntityInvincible(PedCreated3[k], true)
            end
    
            if v["weapon"] then
                -- Give the ped a weapon with 999 ammo
                GiveWeaponToPed(PedCreated3[k], v["weapon_hash"], 999, false, true) -- Give them the specified weapon with ammo
                -- Set the weapon equiped
                SetCurrentPedWeapon(PedCreated3[k], v["weapon_hash"], true)
                -- Let the ped switch weapons
                SetPedCanSwitchWeapon(PedCreated3[k], true) -- Allow them to switch weapon if applicible
            end
    
            -- Block events like bumping
            if v["block_events"] then
                SetBlockingOfNonTemporaryEvents(PedCreated3[k], true)
            end
    
            -- Target Stuff.. Read Config
            if v["target"] then
                exports['qb-target']:AddTargetEntity(PedCreated3[k], {
                    options = {
                        {
                            num = 1,
                            type = v["type"],
                            event = v["event"],
                            icon = v["icon"],
                            label = v["text"],
                            job = v["job"],
                        },
                        {
                            num = 2,
                            type = v["type2"],
                            event = v["event2"],
                            icon = v["icon2"],
                            label = v["text2"],
                            job = v["job2"],
                        },
                        {
                            num = 3,
                            type = v["type3"],
                            event = v["event3"],
                            icon = v["icon3"],
                            label = v["text3"],
                            job = v["job3"],
                        },
                    },
                    distance = 2.0
                })
            end
    
            -- Clothing for MP Characters
            if v["clothing"] then
                SetPedComponentVariation(PedCreated3[k], 2, v["hair"], 0, 0)
                SetPedComponentVariation(PedCreated3[k], 3, v["hands"], v["HA_Texture"], 0)
                SetPedComponentVariation(PedCreated3[k], 8, v["undershirts"], v["U_Texture"], 0)
                SetPedComponentVariation(PedCreated3[k], 11, v["tops"], v["T_Texture"], 0)
                SetPedComponentVariation(PedCreated3[k], 9, v["kevlar"], v["K_Texture"], 0)
                SetPedComponentVariation(PedCreated3[k], 10, v["decal"], v["D_Texture"], 0)
                SetPedComponentVariation(PedCreated3[k], 7, v["accs"], v["A_Texture"], 0)
                SetPedComponentVariation(PedCreated3[k], 5, v["bags"], v["B_Texture"], 0)
                SetPedComponentVariation(PedCreated3[k], 4, v["pants"], v["P_Texture"], 0)
                SetPedComponentVariation(PedCreated3[k], 6, v["shoes"], v["S_Texture"], 0)
                SetPedComponentVariation(PedCreated3[k], 1, v["mask"], v["mask_Texture"], 0)
                SetPedPropIndex(PedCreated3[k], 0, v['hat'], v['hat_TEXTURE'], true)
                SetPedPropIndex(PedCreated3[k], 1, v['glasses'], v['glasses_TEXTURE'], true)
                SetPedHeadBlendData(PedCreated3[k], v["mother"], v["father"], 0,0, 0, 0, 0, v["mix"], 0, false)
                SetPedHairColor(PedCreated3[k], v["HAIR_Texture"], v["HAIR_HIGHLIGHT"])
                SetPedHeadOverlay(PedCreated3[k], 4, v["makeup"], v["makeup_OPACITY"])
                SetPedHeadOverlayColor(PedCreated3[k], 4, 1, v["makeup_COLOR"], 0)
                SetPedHeadOverlay(PedCreated3[k], 8, v["lipstick"], v["lipstick_OPACITY"])
                SetPedHeadOverlayColor(PedCreated3[k], 8, 1, v["lipstick_COLOR"], 0)
                SetPedHeadOverlay(PedCreated3[k], 2, v["eyebrows"], v["eyebrows_OPACITY"])
                SetPedHeadOverlayColor(PedCreated3[k], 2, 1, v["eyebrows_COLOR"], 0)
                SetPedHeadOverlay(PedCreated3[k], 1, v["beard"], v["beard_OPACITY"])
                SetPedHeadOverlayColor(PedCreated3[k], 1, 1, v["beard_COLOR"], 0)
                SetPedEyeColor(PedCreated3[k], v['eye_COLOR'])
            end 
            -- Natives should really be used more they're neat to spawn MP characters
    
            if v["hostile"] then
                SetPedAsEnemy(PedCreated3[k], true) -- Ped is now an enemy
                SetPedCombatMovement(PedCreated3[k], 2) -- Offensive but will take cover
                SetPedCombatRange(PedCreated3[k], 1) -- Medium Range
                SetPedAlertness(PedCreated3[k], 3) -- Unsure but recommanded
                SetPedCombatAttributes(PedCreated3[k], 46, true) -- Always fight
                SetPedCombatAttributes(PedCreated3[k], 5, true) -- Can Fight without weapons
                SetPedCombatAttributes(PedCreated3[k], 0, true) -- Make use of cover
                if v["weapon"] then
                    GiveWeaponToPed(PedCreated3[k], v["weapon_hash"], 999, false, false) -- Give them the specified weapon with ammo
                end
                SetPedRelationshipGroupHash(PedCreated3[k], GetHashKey("HATES_PLAYER")) -- Makes them HATE the player
                SetPedCanSwitchWeapon(PedCreated3[k], true) -- Allow them to switch weapon if applicible
            end
        end
    
        pedSpawned3 = true
    end
end)

-- [[ Export ]] -- WIP
local function SpawnPed(data)
    local spawnedped
    local key, value = next(data)
    
    RequestModel(data.model)

    while not HasModelLoaded(data.model) do
        Wait(0)
    end

    if type(data.model) == 'string' then data.model = joaat(data.model) end

    
    spawnedped = CreatePed(0, data.model, data.coords.x, data.coords.y, data.coords.z - 1.0, data.coords.w, data.networked or false, true)

    if data.customped then
        SetPedComponentVariation(spawnedped, 2, data.customped.hair, 0, 0)
        SetPedComponentVariation(spawnedped, 3, data.customped.hands, data.customped.handsTexture, 0)
        SetPedComponentVariation(spawnedped, 8, data.customped.undershirt, data.customped.undershirtTexture, 0)
        SetPedComponentVariation(spawnedped, 11, data.customped.top, data.customped.topTexture, 0)
        SetPedComponentVariation(spawnedped, 9, data.customped.kevlar, data.customped.kevlarTexture, 0)
        SetPedComponentVariation(spawnedped, 10, data.customped.decal, data.customped.decalTexture, 0)
        SetPedComponentVariation(spawnedped, 7, data.customped.accessory, data.customped.accessoryTexture, 0)
        SetPedComponentVariation(spawnedped, 5, data.customped.bags, data.customped.bagsTexture, 0)
        SetPedComponentVariation(spawnedped, 4, data.customped.pants, data.customped.pantsTexture, 0)
        SetPedComponentVariation(spawnedped, 6, data.customped.shoes, data.customped.shoesTexture, 0)
        SetPedComponentVariation(spawnedped, 1, data.customped.mask, data.customped.maskTexture, 0)

        SetPedPropIndex(spawnedped, 0, data.customped.hat, data.customped.hatTexture, true)
        SetPedPropIndex(spawnedped, 1, data.customped.glasses, data.customped.glassesTexture, true)
        
        SetPedHeadBlendData(spawnedped, data.customped.mother, data.customped.father, 0,0, 0, 0, 0, data.customped.parentMix, 0, false)
        
        SetPedHairColor(spawnedped, data.customped.hairTexture, data.customped.hairHighlight)
        
        SetPedHeadOverlay(spawnedped, 4, data.customped.makeup, data.customped.makeupOppacity)
        SetPedHeadOverlayColor(spawnedped, 4, 1, data.customped.makeupColor, 0)
        
        SetPedHeadOverlay(spawnedped, 8, data.customped.lipstick, data.customped.lipstickOpacity)
        SetPedHeadOverlayColor(spawnedped, 8, 1, data.customped.lipstickColor, 0)
        
        SetPedHeadOverlay(spawnedped, 2, data.customped.eyebrows, data.customped.eyebrowsOpacity)
        SetPedHeadOverlayColor(spawnedped, 2, 1, data.customped.eyebrowsColor, 0)
        
        SetPedHeadOverlay(spawnedped, 1, data.customped.beard, data.customped.beardOpacity)
        SetPedHeadOverlayColor(spawnedped, 1, 1, data.customped.beardColor, 0)
        
        SetPedEyeColor(spawnedped, data.customped.eyeColor)
    end

    if data.allsettings then
        FreezeEntityPosition(spawnedped, true)
        SetEntityInvincible(spawnedped, true)
        SetBlockingOfNonTemporaryEvents(spawnedped, true)
        SetPedCanPlayAmbientAnims(spawnedped, true)
        TaskStartScenarioInPlace(spawnedped, data.allsettings.scenario, 0, true)
    elseif not data.allsettings then
        if data.freeze then
            FreezeEntityPosition(spawnedped, true)
        end

        if data.invincible then
            SetEntityInvincible(spawnedped, true)
        end

        if data.blockevents then
            SetBlockingOfNonTemporaryEvents(spawnedped, true)
        end

        if data.scenario then
            SetPedCanPlayAmbientAnims(spawnedped, true)
            TaskStartScenarioInPlace(spawnedped, data.scenario, 0, true)
        end
    end

    if data.target then
        exports['qb-target']:AddTargetModel(data.model, {
            options = data.target.options,
            distance = data.target.distance
        })
    end

    data.currentpednumber = spawnedped

    -- [[ Making sure peds are individual ]] --
    local nextnumber = #Exports.Peds + 1
    if nextnumber <= 0 then nextnumber = 1 end

    Exports.Peds[nextnumber] = data
    
end exports("SpawnPed", SpawnPed)