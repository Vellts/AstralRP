function updateBadge(badge)
    if (badge == "devmode") then
        local status = getElementData(localPlayer, "player::devmode") or false
        iprint(status)
        if (status) then
            hud.dev = drawDeveloper()
        else
            if (isElement(hud.dev)) then
                destroyElement(hud.dev)
            end
        end
    end
end
addEvent("player::updateBadge", true)
addEventHandler("player::updateBadge", root, updateBadge)