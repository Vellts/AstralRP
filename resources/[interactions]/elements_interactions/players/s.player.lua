local ped = createPed(0, 1828.7239990234,-1845.6644287109,14.578125, 0, true)

function handlePlayerInteraction(player, playerTo)
    -- iprint(player, playerTo)
    triggerClientEvent(player, "interactions::player::handlePlayerInteraction", player, playerTo)
end