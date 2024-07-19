addCommandHandler("vtest", function(player)
    local vehicle = getPedOccupiedVehicle(player)
    if vehicle then
        setVehicleDoorOpenRatio(vehicle, 0, 1, 1000)
    end
end)