function drawHud(player)
    -- iprint("drawHud")
    triggerClientEvent(player, "player::drawHud", player)
end