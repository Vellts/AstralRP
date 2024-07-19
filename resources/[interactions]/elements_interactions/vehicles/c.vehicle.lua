local sendNotification = false
local isNear = false
local vehicleInv = nil
local timer = nil

function handleVehicleComponent(vehicle)
    -- iprint(vehicle)
    if (not vehicle) then return end
    if (not isElement(vehicle)) then return end

    local x, y, z = getElementPosition(localPlayer)
    -- get vehicle matrix
    local matrix = getElementMatrix(vehicle)

    local x1, y1, z1 = getPositionFromElementOffset(vehicle, 0, -2.5, 0)
    -- check if player is near trunk vehicle
    local distance = getDistanceBetweenPoints3D(x, y, z, x1, y1, z1)
    -- iprint(distance)
    if (distance < 1.5) then
        if (sendNotification) then return end
        exports.core_notifications:createNotification("interaction", {
            icon = "TB",
            message = "Presiona {letter} para abrir el maletero del vehículo."
        })
        sendNotification = true
        isNear = true
        vehicleInv = vehicle
        timer = setTimer(checkerVehicle, 300, 0)
    else
        vehicleInv = nil
        isNear = false
        sendNotification = false
        if (isTimer(timer)) then
            killTimer(timer)
        end
    end
end
addEvent("interactions::vehicle::handleVehicleComponent", true)
addEventHandler("interactions::vehicle::handleVehicleComponent", localPlayer, handleVehicleComponent)

function checkerVehicle()
    if (isElement(vehicleInv)) then
        handleVehicleComponent(vehicleInv)
    end
end

function onButtonPressed(button, isPressed)
    if (button == "tab" and isPressed and isNear) then
        checkerVehicle()
        iprint("[Menu interacción: vehículo]")
        triggerServerEvent("interactions::vehicle::moveVehicleComponent", localPlayer, vehicleInv, 1)
    end
end
addEventHandler("onClientKey", root, onButtonPressed)

