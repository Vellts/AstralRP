function handlePlayerMove(player)
    if (not player) then return end
    if (not isElement(player)) then return end

    local isInVehicle = isPedInVehicle(player)
    if (isInVehicle) then return end

    -- get elements near the player
    local x, y, z = getElementPosition(player)
    local elements = getElementsWithinRange(x, y, z, 3)
    for _, v in ipairs(elements) do
        if (getElementType(v) == "vehicle") then
            handleVehicleInteraction(player, v)
        elseif (getElementType(v) == "ped") then
            handlePlayerInteraction(player, v)
        end
    end
end

function startPlayerHandle(player)
    setTimer(handlePlayerMove, 1000, 0, player)
end
addCommandHandler("startp", startPlayerHandle)