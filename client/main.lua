ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
ESX = exports["es_extended"]:getSharedObject()
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("mayne-starterspack:client:vehicle", function(vehicleName, plate)
    local newPlate = plate
    ESX.Game.SpawnLocalVehicle(vehicleName, GetEntityCoords(PlayerPedId()) - vector3(0,0,5), 90, function(vehicle)
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        vehicleProps.plate = newPlate
        TriggerServerEvent('esx_vehicleshop:setVehicleOwned', vehicleProps)
        DeleteEntity(vehicle)
    end)
end)

TriggerEvent('chat:addSuggestion', '/voertuig', 'Ontvang een voertuig van ons als cadeau!')