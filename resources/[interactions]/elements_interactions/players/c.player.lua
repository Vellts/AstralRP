local sendNotification = false
local canOpen = false
local elm = nil
local timer = nil

function handlePlayerInteraction(playerTo)
    if (not playerTo) then return end
    if (not isElement(playerTo)) then return end

    local x, y, z = getElementPosition(localPlayer)
    local x1, y1, z1 = getElementPosition(playerTo)

    local distance = getDistanceBetweenPoints3D(x, y, z, x1, y1, z1)

    if (distance > 1.5) then
        sendNotification = false
        canOpen = false
        elm = nil
        if (isTimer(timer)) then
            killTimer(timer)
        end
        return
    end

    if (sendNotification) then return end
    exports.core_notifications:createNotification("interaction", {
        icon = "TB",
        message = "Presiona {letter} para interactuar con el jugador."
    })
    sendNotification = true
    canOpen = true
    elm = playerTo
    timer = setTimer(checkerPlayer, 300, 0)
end
addEvent("interactions::player::handlePlayerInteraction", true)
addEventHandler("interactions::player::handlePlayerInteraction", localPlayer, handlePlayerInteraction)

function onButtonPressed(button, isPressed)
    if (button == "tab" and isPressed and canOpen) then
        iprint("[Menu interacción: jugador]")
    end
end
addEventHandler("onClientKey", root, onButtonPressed)

function checkerPlayer()
    if (isElement(elm)) then
        handlePlayerInteraction(elm)
    end
end