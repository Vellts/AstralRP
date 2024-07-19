local vehicles = {}

addCommandHandler("xd", function(player)
    -- setPedAnimation(player, "gangs", "dealer_deal", -1, false)
    local x, y, z = getElementPosition(player)
    local vehicle = createVehicle(544,x + 2, y, z, -0, 0, 174.12617492676)
    local mx, my, mz = getElementPosition(vehicle)
    local col = createMarker(mx, my, mz, "cylinder", 1, 255, 255, 255, 255)
    -- local col = createColSphere(mx, my, mz, 1)

    -- attach to the from of the vehicle
    local attach = attachElements(col, vehicle, 1, -5, -1)

    vehicles[player] = {
        vehicle = vehicle,
        col = col,
        isUp = false
    }
end)


addEventHandler("onElementClicked", root, function(btn, state, player)
    if btn == "left" and state == "down" then
        if vehicles[player] then
            local col = vehicles[player].col
            local vehicle = vehicles[player].vehicle
            local x, y, z = getElementPosition(col)
            local px, py, pz = getElementPosition(player)
            local distance = getDistanceBetweenPoints3D(x, y, z, px, py, pz)

            if not vehicles[player].isUp then
                if distance < 1.5 then
                    vehicles[player].isUp = true
                    attachElements(player, vehicle, 1, -3, 0.3)
                end
            else
                local x, y, z = getElementPosition(player)
                detachElements(player, vehicle)
                setElementPosition(player, x + 1, y, z)
                vehicles[player].isUp = false
            end

            -- iprint(distance)
            -- if distance < 1.5 then
            --     iprint(true)
            --     if not vehicles[player].isUp then
            --         iprint(true)
            --         vehicles[player].isUp = true
            --         attachElements(player, vehicle, -1, -3, 0.3)
            --     else
            --         local x, y, z = getElementPosition(element)
            --         detachElements(element, source)
            --         setElementPosition(element, x + 1, y, z)
            --         vehicles[player].isUp = false
            --     end
            -- end
        end
    end
end)


-- addEventHandler("onColShapeHit", root, function(element)
--     if element then
--         if getElementType(element) == "player" then
--             -- verify if the player clicked the vehicle
--             addEventHandler("onElementClicked", root, function (btn, state,player)
--                 if btn == "left" and state == "down" then
--                     if getElementModel(source) == 544 then
--                         print("Nice")
--                         -- iprint(vehicles[player])
--                         if vehicles[player] then
--                             if not vehicles[player].isUp then
--                                 vehicles[player].isUp = true
--                                 setPedAnimation(element, "gangs", "dealer_deal", -1, false, false, false, false)
--                                 attachElements(element, source, -1, -3, 0.3)
--                                 removeEventHandler("onElementClicked", root, function() end)
--                                 -- detachElements(element, vehicles[player].col)
--                                 return true
--                             else
--                                 local x, y, z = getElementPosition(element)
--                                 detachElements(element, source)
--                                 setElementPosition(element, x + 1, y, z)
--                                 vehicles[player].isUp = false
--                             end
--                         end
--                     end
--                 end
--             end)
--         end
--     end
-- end)