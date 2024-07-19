local pickup = createPickup(1788.7271728516,-1409.2097167969,15.7578125, 2, 42, 1000, 9999)
local marker = createMarker(1810.4616699219,-1434.9210205078,12.2296875, "cylinder", 2, 255, 0, 0, 255)
local marker2 = createMarker(1806.3117675781,-1434.9184570312,12.2296875, "cylinder", 2, 255, 0, 0, 255)

local vehiculosBombero = {}

addEventHandler("onPickupHit", pickup, function (p)
    iprint(getElementData(p, "Bombero.isactive"))
    if getElementData(p, "Job") ~= "Bombero" and getElementData(p, "Bombero.isactive") == true then cancelEvent() end
end)

addEventHandler("onMarkerHit", marker, function (p)
    if getElementType(p) == "player" then
        if getElementData(p, "Job") == "Bombero" and getElementData(p, "Bombero.isactive") == true then
        -- if getElementData(p, "Bombero.isactive") == true then
            local vehicle = createVehicle(407, 1810.9174804688,-1415.4088134766,13.421185493469, -0, 0, 174.12617492676)
            if vehicle then
                warpPedIntoVehicle( p, vehicle )
                local mx, my, mz = getElementPosition(vehicle)
                local col = createColSphere(mx, my, mz, 2)
                local col2 = createColSphere(mx, my, mz, 2)

                attachElements(col, vehicle, -1, -5, -1)
                attachElements(col2, vehicle, 1, -5, -1)

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
                setElementData(vehicle, "Bombero.vehicle", vehiculosBombero[vehicle])
                -- iprint(getElementData(vehicle, "Bombero.vehicle"))
            end
        end
    end
end)

addEventHandler("onMarkerHit", marker2, function (p)
    if getElementType(p) == "player" then
        if getElementData(p, "Job") == "Bombero" and getElementData(p, "Bombero.isactive") == true then
        -- if getElementData(p, "Bombero.isactive") == true then
            local vehicle = createVehicle(544, 1810.9174804688,-1415.4088134766,13.421185493469, -0, 0, 174.12617492676)
            if vehicle then
                warpPedIntoVehicle( p, vehicle )
                local mx, my, mz = getElementPosition(vehicle)
                local col = createColSphere(mx, my, mz, 1)
                local col2 = createColSphere(mx, my, mz, 1)

                attachElements(col, vehicle, -1, -5, -1)
                attachElements(col2, vehicle, 1, -5, -1)

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
                setElementData(vehicle, "Bombero.vehicle", vehiculosBombero[vehicle])
                -- iprint(getElementData(vehicle, "Bombero.vehicle"))
            end
        end
    end
end)

addEventHandler("onElementClicked", root, function(btn, state, player)
    if btn == "left" and state == "down" then
        if vehiculosBombero[source] then
            local element = vehiculosBombero[source]
            local col = element.col
            local col2 = element.col2
            local vehicle = element.vehicle
            local typeVehicle = getElementModel(vehicle)
            local capacity = element.capacity

            if not element.playersUp[player] then
                if capacity.left == true and capacity.right == true then
                    return
                end

                local x, y, z = getElementPosition(col)
                local x1, y1, z1 = getElementPosition(col2)
                local px, py, pz = getElementPosition(player)
                local distance = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
                local distance2 = getDistanceBetweenPoints3D(x1, y1, z1, px, py, pz)

                -- iprint("Distancia: "..distance, distance2)
                if distance < 1 then
                    -- iprint(capacity)
                    if capacity.left == false and capacity.right == true then
                        -- iprint("coso1")
                        capacity.left = true
                        element.playersUp[player] = "left"
                        local x = typeVehicle == 407 and attachElements(player, vehicle, 1, -4, 0.3) or attachElements(player, vehicle, 1, -3, 0.3)
                    elseif capacity.left == true and capacity.right == false then
                        -- iprint("coso2")
                        capacity.right = true
                        element.playersUp[player] = "right"
                        local x = typeVehicle == 407 and attachElements(player, vehicle, -1, -4, 0.3) or attachElements(player, vehicle, -1, -3, 0.3)
                    else
                        -- iprint("coso3")
                        capacity.left = true
                        element.playersUp[player] = "left"
                        local x = typeVehicle == 407 and attachElements(player, vehicle, -1, -4, 0.3) or attachElements(player, vehicle, -1, -3, 0.3)
                    end
                    setElementData(vehicle, "Bombero.vehicle", vehiculosBombero[vehicle])
                elseif distance2 < 1 then
                    -- iprint(capacity)
                    if capacity.left == false and capacity.right == true then
                        capacity.left = true
                        element.playersUp[player] = "left"
                        local x = typeVehicle == 407 and attachElements(player, vehicle, -1, -4, 0.3) or attachElements(player, vehicle, -1, -3, 0.3)
                    elseif capacity.left == true and capacity.right == false then
                        capacity.right = true
                        element.playersUp[player] = "rigth"
                        local x = typeVehicle == 407 and attachElements(player, vehicle, 1, -4, 0.3) or attachElements(player, vehicle, 1, -3, 0.3)
                    else
                        capacity.right = true
                        element.playersUp[player] = "right"
                        local x = typeVehicle == 407 and attachElements(player, vehicle, 1, -4, 0.3) or attachElements(player, vehicle, 1, -3, 0.3)
                    end
                    setElementData(vehicle, "Bombero.vehicle", vehiculosBombero[vehicle])
                end
            else
                if element.playersUp[player] then
                    local x, y, z = getElementPosition(player)
                    detachElements(player, vehicle)
                    capacity[element.playersUp[player]] = false
                    local x = element.playersUp[player] == "left" and x+1 or x-1
                    -- iprint(element.playersUp[player])
                    element.playersUp[player] = nil
                    -- iprint(element.playersUp[player])
                    setElementPosition(player, x, y, z)
                    setElementData(vehicle, "Bombero.vehicle", vehiculosBombero[vehicle])
                end
            end
        end
    end
end)

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
        setElementData(source, "Bombero.vehicle", nil)
        destroyElement(element.vehicle)
        destroyElement(element.col)
        destroyElement(element.col2)
        vehiculosBombero[source] = nil
        iprint(vehiculosBombero, vehiculosBombero[source])
    end
end)
