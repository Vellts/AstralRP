vehicleStatus = {}
local binded = false
local timer = nil

addEventHandler("onVehicleEnter", root, function(player)
    if (isElement(player)) then
        if (not vehicleStatus[player]) then
            vehicleStatus[player] = {}
        end

        local vehicleHealth = getElementHealth(source)
        if (vehicleHealth > 300) then
            bindKey(player, "k", "down", toggleVehicleEngine)
            setVehicleDamageProof(source, false)
        else
            setVehicleEngineState(source, false)
            local player = getVehicleOccupant(source)
            if (not player) then return end
            vehicleStatus[player].vehicleEngineStatus = getVehicleEngineState(source)
            triggerClientEvent(player, "core_vehicle::svgChangeKeyState", player, vehicleStatus[player].vehicleEngineStatus, source)
            return
        end

        local data = vehicleStatus[player]
        setVehicleEngineState(source, data.vehicleEngineStatus or false)
        data.vehicleEngineStatus = getVehicleEngineState(source)
        triggerClientEvent(player, "core_vehicle::svgChangeKeyState", player, data.vehicleEngineStatus, source)
        bindKey(player, "l", "down", toggleVehicleLigths)
        bindKey(player, "lalt", "down", toggleHandBrakeInVehicle)
        bindKey(player, "x", "down", toggleCinturon)
    end
end)

addEventHandler("onVehicleExit", root, function(player)
    if (isElement(player)) then
        unbindKey(player, "k", "down", toggleVehicleEngine)
        unbindKey(player, "l", "down", toggleVehicleLigths)
        unbindKey(player, "lalt", "down", toggleHandBrakeInVehicle)
        unbindKey(player, "x", "down", toggleCinturon)
        handBrakeOutsideVehicle(player, source)
    end
end)

addEventHandler("onVehicleStartEnter", root, function(player)
    -- local ped = getVehicleOccupant(source)
    -- if (ped) then
    --     removePedFromVehicle(ped)
    --     destroyElement(ped)
    -- end
end)

addEventHandler("onVehicleStartExit", root, function(player)
    if (isElement(player)) then
        if (vehicleStatus[player]) then
            local cinturon = vehicleStatus[player].vehicleCinturon
            if (cinturon) then
                exports.core_notifications:createNotification(player, "interaction", {
                    icon = "X",
                    message = "Debes desabrocharte el cinturón {letter} de seguridad antes de salir del vehículo.",
                })
                cancelEvent()
            end
        end
    end
end)

function vehicleDamage ( loss ) 
    local vehHealth = getElementHealth ( source ) 
    if ( vehHealth < 300 ) then 
        setElementHealth ( source, 300 ) 
        setVehicleDamageProof ( source, true ) 
    end 
end 
addEventHandler ( "onVehicleDamage", root, vehicleDamage ) 

function toggleVehicleEngine(player)
    if (isElement(player) and getElementType(player) == "player") then
        local vehicle = getPedOccupiedVehicle(player)
        -- setElementData(vehicle, "vehicle::motorState", false, false)
        if (vehicle and getElementType(vehicle) == "vehicle") then
            -- iprint(getElementData(vehicle, "vehicle::motorState"))
            local data = vehicleStatus[player]
            if (getElementData(vehicle, "vehicle::motorState")) then
                data.vehicleEngineStatus = false
                return
            end
            data.vehicleEngineStatus = not getVehicleEngineState(vehicle)
            setVehicleEngineState(vehicle, data.vehicleEngineStatus)
            vehicleStatus[player] = data
            triggerClientEvent(player, "core_vehicle::svgChangeKeyState", player, data.vehicleEngineStatus, vehicle)
        end
    end
end

function toggleVehicleLigths(player)
    if (isElement(player) and getElementType(player) == "player") then
        local vehicle = getPedOccupiedVehicle(player)
        if (vehicle and getElementType(vehicle) == "vehicle") then
            local data = vehicleStatus[player]
            local vehicleLights = getVehicleOverrideLights(vehicle)
            data.vehicleLigthsMode = vehicleLights + 1
            if (data.vehicleLigthsMode > 2) then
                data.vehicleLigthsMode = 0
            end
            setVehicleOverrideLights(vehicle, data.vehicleLigthsMode)
            vehicleStatus[player] = data
            triggerClientEvent(player, "core_vehicle::svgChangeLightsState", player, data.vehicleLigthsMode)
        end
    end
end

function toggleHandBrakeInVehicle(player)
    if (isElement(player) and getElementType(player) == "player") then
        local vehicle = getPedOccupiedVehicle(player)
        if (vehicle and getElementType(vehicle) == "vehicle") then
            local data = vehicleStatus[player]
            data.vehicleHandBrake = not data.vehicleHandBrake
            setControlState(player,"handbrake", data.vehicleHandBrake)
            if (isElementFrozen(vehicle)) then
                setElementFrozen(vehicle, false)
            end
            vehicleStatus[player] = data
            triggerClientEvent(player, "core_vehicle::svgChangeHandBrakeState", player, data.vehicleHandBrake)
        end
    end
end

function countOcuppants(table)
    local count = 0
    for k, v in pairs(table) do
        count = count + 1
    end
    return count
end

function handBrakeOutsideVehicle(player, vehicle)
    if (vehicle and getElementType(vehicle) == "vehicle") then
        local data = vehicleStatus[player]
        if (not data) then return end
        if (data.vehicleHandBrake) then
            timer = setTimer(function()
                local ocuppants = getVehicleOccupants(vehicle)
                if (getVehicleSpeed(vehicle) < 1) and countOcuppants(ocuppants) == 0 then
                    setElementFrozen(vehicle, true)
                    if (isTimer(timer)) then
                        killTimer(timer)
                        timer = nil
                    end
                end
            end, 1000, 0)
        end
    end
end

function toggleCinturon(player)
    if (isElement(player) and getElementType(player) == "player") then
        local vehicle = getPedOccupiedVehicle(player)
        if (vehicle and getElementType(vehicle) == "vehicle") then
            local data = vehicleStatus[player]
            data.vehicleCinturon = not data.vehicleCinturon
            setElementData(vehicle, "vh::cinturonState", data.vehicleCinturon)
            vehicleStatus[player] = data
            exports.core_notifications:createNotification(player, "normal", {
                icon = "in",
                message = "Cinturón de seguridad " .. (data.vehicleCinturon and "abrochado." or "desabrochado.")
            })
            triggerClientEvent(player, "core_vehicle::svgChangeCinturonState", player, data.vehicleCinturon)
        end
    end
end
