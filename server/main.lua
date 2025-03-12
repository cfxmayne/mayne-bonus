ESX = exports["es_extended"]:getSharedObject()

local claimed = json.decode(LoadResourceFile("mayne-starterspack", "claimed.json")) or {}
local vehicles = {
    "zip2000"
}

RegisterCommand('bonus', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()

    if not claimed[identifier] then
        claimed[identifier] = true
        for k, v in pairs(vehicles) do 
            local newPlate = GenerateUniquePlate()
            TriggerClientEvent("mayne-starterspack:client:vehicle", source, v, newPlate)
            Citizen.Wait(500)
        end

        xPlayer.addAccountMoney('bank', 250000)
        xPlayer.addInventoryItem('weapon_m1911', 1)
        xPlayer.addInventoryItem('ammo-9', 250)

        -- Markeer als geclaimd
        SaveResourceFile("mayne-starterspack", "claimed.json", json.encode(claimed, { indent = true }), -1)

        TriggerClientEvent('chat:addMessage', source, {
            template = '<div class="bubble-message" style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 6px;"><i class=""></i> <b><font color=white>{0}</b></font>: {1}</div>',
            args = { 'SYSTEM', 'Je hebt een cadeau gekregen van Codex Roleplay, veel plezier!' }
        })
            else
                TriggerClientEvent('chat:addMessage', source, {
                    template = '<div class="bubble-message" style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(200,0,0, 0.4); border-radius: 5px;"><i class=""></i> {0}</div>',
                    args = { 'Je hebt je starterspack al geclaimd!' }
                })
                    end
end)

function GenerateUniquePlate()
    local plateLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local plateNumbers = "0123456789"
    local plate = ""

    math.randomseed(os.time())

    for i = 1, 3 do
        local randomIndex = math.random(1, #plateLetters)
        local randomLetter = plateLetters:sub(randomIndex, randomIndex)
        plate = plate .. randomLetter
    end

    plate = plate .. " "

    for i = 1, 3 do
        local randomIndex = math.random(1, #plateNumbers)
        local randomDigit = plateNumbers:sub(randomIndex, randomIndex)
        plate = plate .. randomDigit
    end

    if plate and IsPlateUnique(plate) then
        return plate
    else
        Wait(100)
        GenerateUniquePlate()
    end
end

function IsPlateUnique(plate)
    local query = MySQL.Sync.fetchAll('SELECT COUNT(*) as count FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    })

    return query[1].count == 0
end
