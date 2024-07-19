addEventHandler("onClientKey", root, function(button, press)
    if button == "m" then
        if press then
            if isCursorShowing( localPlayer ) then
                showCursor(false)
            else
                showCursor(true)
            end
        end
    end
end)

addEventHandler("onClientVehicleStartEnter", root, function (player)
    if getElementData(player, "Job") ~= "Bombero" then
        if getElementModel(source) == 544 or getElementModel(source) == 407 then
            cancelEvent()
        end
    end
end)