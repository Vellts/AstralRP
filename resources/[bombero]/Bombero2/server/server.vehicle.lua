local marker = createMarker(1810.4616699219,-1434.9210205078,12.2296875, "cylinder", 2, 255, 211, 88, 255)
local marker2 = createMarker(1812.2471923828,-1396.4410400391,12.42301940918, "cylinder", 4, 255, 0, 0, 255)

vehiculosBombero = {}

------------------- [ Evento: Marker ] -------------------

-- Crea un vehiculo para el jugador que sea bombero.
-- p: Elemento jugador que entra al marker.
-- owner: Elemento jugador que es dueño del vehiculo.
-- vehicle: Elemento vehiculo que se crea.
-- col: Elemento col que se crea.
-- col2: Elemento col que se crea.
-- capacity: Tabla que contiene la capacidad del vehiculo.
-- playersUp: Tabla que contiene los jugadores que estan arriba del vehiculo.


addEventHandler("onMarkerHit", marker, function (p)
    if getElementType(p) == "player" then
        if getElementData(p, "Job") == "Bombero" and getElementData(p, "player:firemanService") == true then
            if (firemanHasVehicle(p)) then
                return
            end
            local vehicle = createVehicle(544, 1810.9174804688,-1415.4088134766,13.421185493469, -0, 0, 174.12617492676)
            if vehicle then
                warpPedIntoVehicle( p, vehicle )
                local mx, my, mz = getElementPosition(vehicle)
                local col = createColSphere(mx, my, mz, 1.3)
                local col2 = createColSphere(mx, my, mz, 1.3)

                attachElements(col, vehicle, -1, -4, -1)
                attachElements(col2, vehicle, 1, -4, -1)

                vehiculosBombero[vehicle] = {
                    owner = p,
                    vehicle = vehicle,
                    col = col,
                    col2 = col2,
                    capacity = {
                        left = false,
                        right = false
                    },
                    playersUp = {}
                }
                setElementData(vehicle, "fireman:vehicle", vehiculosBombero[vehicle])
            end
        end
    end
end)

------------------- [ Evento: Marker ] -------------------

-- Elimina el vehiculo bombero si el jugador que es bombero entra al marker.
-- player: Elemento jugador que entra al marker.

addEventHandler("onMarkerHit", marker2, function(player)
    if (not isElement(player)) then return end
    if getElementType(player) == "player" then
        if getElementData(player, "Job") == "Bombero" and getElementData(player, "player:firemanService") == true then
            if (firemanHasVehicle(player)) then
                local vehicle = getFiremanVehicle(player)
                local element = vehiculosBombero[vehicle]
                local capacity = element.capacity
                local playersUp = element.playersUp
                for player, _ in pairs(playersUp) do
                    detachElements(player, vehicle)
                    capacity[element.playersUp[player]] = false
                    element.playersUp[player] = nil
                end
                setElementData(vehicle, "fireman:vehicle", nil)
                destroyElement(vehicle)
                destroyElement(element.col)
                destroyElement(element.col2)
                vehiculosBombero[vehicle] = nil
            end
        end
    end
end)

------------------- [ Evento: Element ] -------------------

-- Serciora que el elemento sea un vehiculo y que sea bombero el que realizó el click.

addEventHandler("onElementClicked", root, function(btn, state, player)
    if btn == "left" and state == "down" then
        if vehiculosBombero[source] then
            local element = vehiculosBombero[source]
            local col = element.col
            local col2 = element.col2
            local vehicle = element.vehicle
            local typeVehicle = getElementModel(vehicle)
            local capacity = element.capacity
            if (element.playersUp[player] == nil) then
                if capacity.left == true and capacity.right == true then
                    return
                end

                if (isElementWithinColShape(player, col)) then
                    if capacity.left == false and capacity.right == true then
                        capacity.left = true
                        element.playersUp[player] = "left"
                        attachElements(player, vehicle, 1, -4, 0.3)
                    elseif capacity.left == true and capacity.right == false then
                        capacity.right = true
                        element.playersUp[player] = "right"
                        attachElements(player, vehicle, -1, -4, 0.3)
                    else
                        capacity.left = true
                        element.playersUp[player] = "left"
                        attachElements(player, vehicle, -1, -4, 0.3)
                    end
                    setElementData(vehicle, "fireman:vehicle", vehiculosBombero[vehicle])
                elseif (isElementWithinColShape(player, col2)) then
                    if capacity.left == false and capacity.right == true then
                        capacity.left = true
                        element.playersUp[player] = "left"
                        attachElements(player, vehicle, -1, -4, 0.3)
                    elseif capacity.left == true and capacity.right == false then
                        capacity.right = true
                        element.playersUp[player] = "rigth"
                        attachElements(player, vehicle, 1, -4, 0.3)
                    else
                        capacity.right = true
                        element.playersUp[player] = "right"
                        attachElements(player, vehicle, 1, -4, 0.3)
                    end
                    setElementData(vehicle, "fireman:vehicle", vehiculosBombero[vehicle])
                
                end
            else
                if element.playersUp[player] then
                    detachElements(player, vehicle)
                    local x, y, z = getElementPosition(player)
                    capacity[element.playersUp[player]] = false
                    local x = element.playersUp[player] == "left" and x+1 or x-1
                    element.playersUp[player] = nil
                    setElementPosition(player, x, y, z)
                    setElementData(vehicle, "fireman:vehicle", vehiculosBombero[vehicle])
                end
            end
        end
    end
end)

------------------- [ Evento: Explosión ] -------------------

-- Elimina el vehiculo bombero si explota.

addEventHandler("onVehicleExplode", root, function()
    if vehiculosBombero[source]  then
        local element = vehiculosBombero[source]
        -- local capacity = element.capacity
        -- local playersUp = element.playersUp
        -- for player, _ in pairs(playersUp) do
        --     detachElements(player, source)
        --     capacity[element.playersUp[player]] = false
        --     element.playersUp[player] = nil
        -- end
        setElementData(source, "fireman:vehicle", nil)
        destroyElement(element.vehicle)
        destroyElement(element.col)
        destroyElement(element.col2)
        vehiculosBombero[source] = nil
        -- iprint(vehiculosBombero, vehiculosBombero[source])
    end
end)
