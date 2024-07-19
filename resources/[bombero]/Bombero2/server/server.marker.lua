-- Marker para abrir el panel de bombero

local marker = createMarker(1789.0268554688,-1405.1290283203,14.8578125, "cylinder", 1.4, 242, 57, 57, 255)
local pickup = createPickup(1788.5845947266,-1409.0168457031,15.7578125, 2, 42, 1000, 9999)

------------------- [ Evento: Marker ] -------------------

-- Abre el panel de bombero, si el jugador no está en un vehículo.

addEventHandler("onMarkerHit", marker, function(hitPlayer, matchingDimension)
    if (getElementType(hitPlayer) == "player") then
        if (isPedInVehicle(hitPlayer) == false) then
            triggerClientEvent(hitPlayer, "fireman>>createInterface", hitPlayer)
        end
    end
end)

addEventHandler("onMarkerLeave", marker, function(hitPlayer, matchingDimension)
    if (getElementType(hitPlayer) == "player") then
        if (isPedInVehicle(hitPlayer) == false) then
            triggerClientEvent(hitPlayer, "fireman>>removeInterface", hitPlayer)
        end
    end
end)
------------------- [ Evento: Pickup ] -------------------

-- Da el arma de bombero al jugador.

addEventHandler("onPickupHit", pickup, function (p)
    if (not getElementData(p, "Job") ~= "Bombero") and (not getElementData(p, "player:firemanService") == true) then cancelEvent() end
end)