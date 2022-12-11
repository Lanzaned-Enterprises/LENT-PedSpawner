--[[ Version Checker ]] --
local version = "200"

AddEventHandler("onResourceStart", function(resource)
    if resource == GetCurrentResourceName() then
        checkResourceVersion()
    end
end)

function checkUpdateEmbed(color, name, message, footer)
    local content = {
        {
            ["color"] = color,
            ["title"] = " " .. name .. " ",
            ["description"] = message,
            ["footer"] = {
                ["text"] = " " .. footer .. " ",
            },
        }
    }
    PerformHttpRequest(Discord.DISCORD_WEBHOOK, function(err, text, headers) end, 
    'POST', json.encode({
        username = Discord.DISCORD_NAME, 
        embeds = content, 
        avatar_url = Discord.DISCORD_IMAGE
    }), { ['Content-Type'] = 'application/json '})
end

function checkResourceVersion()
    PerformHttpRequest("https://raw.githubusercontent.com/Lanzaned-Enterprises/LENT-PedSpawner/main/version.txt", function(err, text, headers)
        if (tonumber(version) > tonumber(text)) then
            print(" ")
            print("---------- LANZANED PEDSPAWNER ----------")
            print("PedSpawner is using a Development Build! Please download stable!")
            print("Curent Version: " .. version .. " Latest Version: " .. text)
            print("https://github.com/Lanzaned-Enterprises/LENT-PedSpawner")
            print("-----------------------------------------")
            print(" ")
            checkUpdateEmbed(5242880, "PedSpawner Update Checker", "PedSpawner is using a Development Build! Please download stable!\nCurent Version: " .. version .. " Latest Version: " .. text .. "\nhttps://github.com/Lanzaned-Enterprises/LENT-PedSpawner", "Script created by: https://discord.lanzaned.com")
        elseif (tonumber(version) < tonumber(text)) then
            print(" ")
            print("---------- LANZANED PEDSPAWNER ----------")
            print("PedSpawner is not up to date! Please update!")
            print("Curent Version: " .. version .. " Latest Version: " .. text)
            print("https://github.com/Lanzaned-Enterprises/LENT-PedSpawner")
            print("-----------------------------------------")
            print(" ")
            checkUpdateEmbed(5242880, "PedSpawner Update Checker", "PedSpawner is not up to date! Please update!\nCurent Version: " .. version .. " Latest Version: " .. text .. "\nhttps://github.com/Lanzaned-Enterprises/LENT-PedSpawner", "Script created by: https://discord.lanzaned.com")
        else
            print(" ")
            print("---------- LANZANED PEDSPAWNER ----------")
            print("PedSpawner is up to date and ready to go!")
            print("Running on Version: " .. version)
            print("https://github.com/Lanzaned-Enterprises/LENT-PedSpawner")
            print("-----------------------------------------")
            print(" ")
            checkUpdateEmbed(20480, "PedSpawner Update Checker", "PedSpawner is up to date and ready to go!\nRunning on Version: " .. version .. "\nhttps://github.com/Lanzaned-Enterprises/LENT-PedSpawner", "Script created by: https://discord.lanzaned.com")
        end
    end, "GET", "", {})
end