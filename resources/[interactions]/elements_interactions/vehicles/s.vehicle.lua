function handleVehicleInteraction(player, vehicle)
    -- TODO: check if player have keys to open the vehicle
    triggerClientEvent(player, "interactions::vehicle::handleVehicleComponent", player, vehicle)
end

function moveVehicleComponent(vehicle, state)
    -- iprint(vehicle, state)
    if (not vehicle) or (not state) then return end
    if (not isElement(vehicle)) then return end
    local player = client
    -- vehicle trunk component
    setVehicleDoorOpenRatio(vehicle, 1, 1)
    setTimer(function()
        setVehicleDoorOpenRatio(vehicle, 1, 0)
    end, 10000, 1)
    -- player animation
    setPedAnimation(player, "CARRY", "crry_prtial", -1, false, false, false, true)
    setTimer(function()
        setPedAnimation(player)
    end, 300, 1)

end
addEvent("interactions::vehicle::moveVehicleComponent", true)
addEventHandler("interactions::vehicle::moveVehicleComponent", root, moveVehicleComponent)
