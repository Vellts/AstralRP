addEventHandler("onVehicleEnter", root, function(player)
    if (isElement(player)) then
        triggerClientEvent(player, "vel::draw", player, source)
        exports.core_notifications:createNotification(player, "interaction", {
            icon = "X",
            message = "Presiona la letra {letter} para abrocharte el cinturón.",
        })
    end
end)

addEventHandler("onVehicleExit", root, function(player)
    if (isElement(player)) then
        triggerClientEvent(player, "vel::remove", player)
    end
end)