-- get the near vehicle in real time
local vehiclesDetectables = {}
local needRemove = false

function detectVehicle(player)
    if (not vehiclesDetectables[player]) then
        vehiclesDetectables[player] = {}
    end
    local getVehicle = getNearestElement(player, "vehicle", 5)
    if (not getVehicle) or isPedInVehicle(player) then
        if (needRemove) then
            removeInteractionNotification(player)
            vehiclesDetectables[player] = {}
        end
        return
    end
    if (table.find(vehiclesDetectables[player], getVehicle)) then return end
    
    table.insert(vehiclesDetectables[player], getVehicle)
    createNotification(player, "interaction", {
        icon = "F",
        title = nil,
        message = "Presiona la letra {letter} para entrar al vehiculo.",
        duration = 3000,
        mainElement = getVehicle
    })
    needRemove = true
end

function table.find(t, value)
    for k, v in pairs(t) do
        if v == value then
            return k
        end
    end
    return false
end

addEventHandler("onPlayerJoin", resourceRoot, function()
    setTimer(detectVehicle, 1000, 0, source)
end)
