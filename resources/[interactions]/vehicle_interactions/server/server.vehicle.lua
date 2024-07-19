local alreadyHandled = {}

function vehicleInteraction(player)
    local pl = player
    if (not isElement(pl) or getElementType(pl) ~= "player") then return end
    
    if (not alreadyHandled[pl]) then
        alreadyHandled[pl] = {
            isHandled = false,
            timerFunction = nil,
            isDeleteHandled = false
        }
    end
    local vehicle = getNearestVehicle(pl, 3)
    if (vehicle) then
        if (alreadyHandled[pl].isHandled) then
            -- alreadyHandled[pl].timerFunction = setTimer(vehicleInteraction, 1000, 1, pl)
            return
        end
        alreadyHandled[pl].isHandled = true
        alreadyHandled[pl].isDeleteHandled = false
        triggerClientEvent(pl, "vehicle_interaction::handleVehicleDummy", resourceRoot, vehicle)
        -- if (isTimer(alreadyHandled[pl].timerFunction)) then
        --     killTimer(alreadyHandled[pl].timerFunction)
        -- end
    else
        if (not alreadyHandled[pl].isDeleteHandled) then
            triggerClientEvent(pl, "vehicle_interaction::handleVehicleDummy", resourceRoot, false, true)
            alreadyHandled[pl].isDeleteHandled = true
        end
        alreadyHandled[pl].isHandled = false
        -- alreadyHandled[pl].timerFunction = setTimer(vehicleInteraction, 1000, 1, pl)
    end
end

function vehicleClickled()
    for _, player in ipairs(getElementsByType("player")) do
        setTimer(vehicleInteraction, 1000, 0, player)
        -- vehicleInteraction(player)
    end
end
addEventHandler("onResourceStart", root, vehicleClickled)

function getNearestVehicle(player,distance)
    local lastMinDis = distance-0.0001
    local nearestVeh = false
    local px,py,pz = getElementPosition(player)
    local pint = getElementInterior(player)
    local pdim = getElementDimension(player)

    for _,v in pairs(getElementsByType("vehicle")) do
        local vint,vdim = getElementInterior(v),getElementDimension(v)
        if vint == pint and vdim == pdim then
            local vx,vy,vz = getElementPosition(v)
            local dis = getDistanceBetweenPoints3D(px,py,pz,vx,vy,vz)
            if dis < distance then
                if dis < lastMinDis then 
                    lastMinDis = dis
                    nearestVeh = v
                end
            end
        end
    end
    return nearestVeh
end