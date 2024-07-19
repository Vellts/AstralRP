---@diagnostic disable: undefined-global, lowercase-global
 ------------- TRASPASADO -------------

-- local marker = createMarker(1789.0268554688,-1405.1290283203,14.8578125, "cylinder", 1.4, 242, 57, 57, 255)

-- addEventHandler("onPlayerMarkerHit", getRootElement(), function (markerP)
--     if marker == markerP then
--         if not isPedInVehicle( source ) and getElementData(source, "Job") == "Bombero" then
--         -- if not isPedInVehicle( source ) then
--             if not getElementData(source, "Bombero.isactive") then
--                 triggerClientEvent(source, "Bombero>>panel", source, false)
--             else
--                 triggerClientEvent(source, "Bombero>>panel", source, true)
--             end
--         end
--     end
-- end)

-- local fires = {}
-- local players = {}
-- local blips = {
--     alertBlip = {},
--     miniBlips = {}
-- }
-- local positions = {
--     -- {2476.0285644531,-2116.4174804688, 13.246875, 40},
--     -- {1526.5812988281,-2345.6179199219,12.846875, 50},
--     -- {821.61694335938,-2034.2893066406,12.2671875, 30},
--     -- {742.66906738281,-1273.6005859375,13.2546875, 40},
--     {1789.6293945312,-1452.1384277344,12.373775482178, 30},
--     -- {671.65899658203,344.63851928711,19.821212387085, 30},
--     -- {-1089.8707275391,-1307.5825195312,128.21875, 50},
-- }
-- function Generar_coordenadas(x, y, z, cantidad, radio)
--     local coords = {}
--     if not fireStarted then
--         for i = 1, cantidad do
--             local x, y, z = math.random(x, x+radio), math.random(y, y+radio+10), math.random(z, z+z*0.008)
--             table.insert(coords, {x, y, z})
--         end
--         local location = getZoneName(x, y, z)
--         iprint("[Bombero] Coordenadas generadas en: "..location.." ("..x..", "..y..", "..z..")")
--         area = createColCuboid(x-50, y-50, z, radio*5, radio*5, radio)
--         addEventHandler("onColShapeHit", area, onPlayerHitColShape)
--         return coords
--     end
--     return false
-- end

-- function Generar_fuegos(coordenadas)
--     for _, p in ipairs(players) do
--         for _, v in ipairs(coordenadas) do
--             if #fires == cantidadFuegos then break end
--             local x, y, z = v[1], v[2], v[3]
--             local marker = createMarker(x, y, z, "corona", 1, 255, 0, 0, 255, p)
--             -- setElementAlpha(marker, 0)
--             local miniBlip = createBlipAttachedTo(marker, 0, 2, 255, 0, 0, 255, 0, 20000, p)
--             -- table.insert(blips, miniBlip)
--             blips.miniBlips[marker] = miniBlip
--             addEventHandler("onMarkerHit", marker, onPlayerMarkerFire)
--             table.insert(fires, marker)
--         end
--         -- iprint(fires)
--         local blip = createBlipAttachedTo(fires[1], 20, 2, 0, 0, 0, 255, 0, 20000, p)
--         table.insert(blips.alertBlip, blip)
--         setElementPosition(p, getElementPosition(fires[1]))
--         setTimer(onPlayerIsFiring, 1000, 0, p)
--     end
-- end
------------- TRASPASADO -------------


local fireStarted = false
local minutos = 7
local cantidadFuegos = 160
local init = false
local availablePlayersToPay = {}
local area = nil
local dinero = 70000
local vehicleFiring = false
local lastFireTick = 0


armedVehicles = {[407]=true}
function vehicleWeaponFire(thePresser, key, keyState, vehicleFireType)
	local vehModel = getElementModel(getPedOccupiedVehicle(thePresser))
	if (armedVehicles[vehModel]) then
        if (vehicleFireType == "primary") then
            if (vehicleFiring) then
                return
            end
            lastFireTick = getTickCount()
            vehicleFiring = true
            setTimer(function()
                vehicleFiring = false
            end, 2000, 1)
        end
	end
end


addEvent("onTableChange", true)
addEventHandler("onTableChange", root, function(marker)
    if marker then
        for i = 1, #fires do
            if fires[i] == marker then
                table.remove(fires, i)
                destroyElement( marker )
                iprint("Fuego eliminado #"..i)
                break
            end
        end
    end
end)

function onPlayerMarkerFire(hit)
    if getElementType(hit) == "player" then
        setPedOnFire(hit, true)
    end
end

function onPlayerIsFiring(p)
    if fireStarted and isPlayerInTable(p, players) then
        if vehicleFiring then
            local px, py, pz = getPositionFromElementOffset(p, 0, 0, 3)
            local elements = getElementsWithinRange(px, py, pz, 6, "marker")
            iprint(elements)
            if #elements > 0 then
                local v = elements[1]
                local x, y, z = getElementPosition(v)
                local distancia = getDistanceBetweenPoints3D(px, py, pz, x, y, z)
                iprint(distancia)
                if distancia < 20 then
                    local count = getTickCount(  )
                    if ( count - lastFireTick ) > 1000 then
                        triggerToClientFromTable(players, "Bombero>>efecto2", v)
                        for marker, blip in ipairs(blips.miniBlips) do
                            if marker == v then
                                destroyElement(blip)
                                table.remove(blips.miniBlips, marker)
                            end
                        end
                        lastFireTick = getTickCount(  )
                    end
                end
            end
            -- for _, v in ipairs(elements) do
            --     local x, y, z = getElementPosition(v)
            --     local distancia = getDistanceBetweenPoints3D( px, py, pz, x, y, z )
            --     -- iprint(distancia)
            --     if distancia < 6 then
            --         local count = getTickCount()
            --         -- iprint(count - lastFireTick, lastFireTick - count)
            --         if count - lastFireTick > 1000 then
            --             triggerToClientFromTable(players, "Bombero>>efecto2", v)
            --             -- triggerClientEvent(players, "Bombero>>efecto2", p, v)
            --             for marker, blip in pairs(blips.miniBlips) do
            --                 if marker == v then
            --                     destroyElement(blip)
            --                     blips.miniBlips[marker] = nil
            --                     break
                    
            --                 end
            --             end
            --             lastFireTick = getTickCount()
            --         end
            --     end
            -- end
        else
            local px, py, pz = getPositionFromElementOffset(p, 0, 2, 0)
            local elements = getElementsWithinRange(px, py, pz, 0.2, "marker")
            -- if #elements > 0 then iprint(elements[1]) end
            -- iprint(elements)
            if #elements > 0 then
                local v = elements[1]
                local x, y, z = getElementPosition(v)
                local distancia = getDistanceBetweenPoints3D( px, py, pz, x, y, z )
                iprint(distancia)
                if distancia < 2 then
                    local isFiring = getControlState(p, "fire")
                    local weapon = getPedWeapon(p)
                    if isFiring and weapon == 42 then
                        local count = getTickCount()
                        setTimer(function ()
                            if getTickCount(  ) - count > 1000 then
                                triggerToClientFromTable(players, "Bombero>>efecto2", v)
                                -- triggerClientEvent(players, "Bombero>>efecto2", p, v)
                                for marker, blip in pairs(blips.miniBlips) do
                                    if marker == v then
                                        destroyElement(blip)
                                        blips.miniBlips[marker] = nil
                                        break
                                    end
                                end
                            end
                        end, 2000, 1)
                    end
                end
            end
            -- for _, v in ipairs(elements) do
            --     local x, y, z = getElementPosition(v)
            --     local distancia = getDistanceBetweenPoints3D( px, py, pz, x, y, z )
            --     if distancia < 2 then
            --         local isFiring = getControlState(p, "fire")
            --         local weapon = getPedWeapon(p)
            --         if isFiring and weapon == 42 then
            --             local count = getTickCount()
            --             setTimer(function ()
            --                 if getTickCount() - count > 1000 then
            --                     -- triggerClientEvent(players, "Bombero>>efecto2", p, v)
            --                     iprint(true)
            --                     triggerToClientFromTable(players, "Bombero>>efecto2", v)
            --                     for marker, blip in pairs(blips.miniBlips) do
            --                         if marker == v then
            --                             destroyElement(blip)
            --                             blips.miniBlips[marker] = nil
            --                             break
            --                         end
            --                     end
            --                 end
            --             end, 2000, 1)
            --         end
            --     end
            -- end
        end

        if #fires == 0 then
            contador = getTickCount() - (6 * 60 * 1000)
            -- convertir a minutos
            -- iprint(contador / (60 * 1000))
            outputChatBox("Los bomberos han apagado el fuego.", p)
            payPlayers()
            Remover_fuegos()

        end
    end
        -- if fireStarted and isPlayerInTable(p, players) then
        --     local px, py, pz = getElementPosition(p)
        --     local elements = getElementsWithinRange( px, py, pz, 1, "marker" )
            
        --     for _, v in ipairs(elements) do
        --         local x, y, z = getElementPosition(v)
        --         local distance = getDistanceBetweenPoints3D(px, py, pz, x, y, z)
        --         if distance < 1.89 then
        --             local isFiring = getControlState(p, "fire")
        --             local weapon = getPedWeapon(p)
        --             if isFiring and weapon == 42 then
        --                 local count = getTickCount(  )
        --                 setTimer(function()
        --                     if getTickCount() - count > 2000 then
        --                         triggerClientEvent(players, "Bombero>>efecto2", p, v)
        --                         -- iprint(blips.miniBlips)
        --                         for marker, blip in pairs(blips.miniBlips) do
        --                             if marker == v then
        --                                 destroyElement(blip)
        --                                 blips.miniBlips[marker] = nil
        --                                 break

        --                             end
        --                         end
        --                     end
        --                 end, 2000, 1)
        --             end
        --         end
        --     end
            
        --     if #fires == 0 then
        --         contador = getTickCount() - (6 * 60 * 1000)
        --         -- convertir a minutos
        --         -- iprint(contador / (60 * 1000))
        --         outputChatBox("Los bomberos han apagado el fuego.", p)
        --         payPlayers()
        --         Remover_fuegos()
        --     end
        -- end
end



function Remover_fuegos()
    for _, fire in ipairs(fires) do
        if isElement(fire) then
            for marker, blip in pairs(blips.miniBlips) do
                if marker == fire then
                    destroyElement(blip)
                    blips.miniBlips[marker] = nil
                    break
                end
            end
            removeEventHandler("onMarkerHit", fire, onPlayerMarkerFire)
            destroyElement(fire)
        end
    end
    for _, blip in ipairs(blips.alertBlip) do
        if isElement(blip) then
            destroyElement(blip)
        end
    end
    if isElement(area) then
        removeEventHandler("onColShapeHit", area, onPlayerHitColShape)
        destroyElement(area)
    end
    -- triggerClientEvent(players, "Bombero>>efecto", getRootElement(  ), false, fires)
    triggerToClientFromTable(players, "Bombero>>efecto", false, fires)
    availablePlayersToPay = {}
    fires = {}
    fireStarted = false
end

-- addEvent("Bombero>>addplayer", true)
-- addEventHandler("Bombero>>addplayer", root, function(state)
--     if state then
--         if not isPlayerInTable(source, players) then
--             table.insert(players, source)
--             bindKey(source, "vehicle_fire", "down", vehicleWeaponFire, "primary")
--             -- local xd = getPlayerFromName("Stondark")
--             -- table.insert(players, xd)
--             -- iprint(players)

--             iprint("[Bombero] "..getPlayerName(source).." ha empezado servicio.")
--         end
--     else
--         for i = 1, #players do
--             if players[i] == source then
--                 triggerClientEvent(source, "Bombero>>efecto", source, false, fires)
--                 table.remove(players, i)
--                 unbindKey(source, "vehicle_fire", "down", vehicleWeaponFire, "primary")
--                 iprint("[Bombero] "..getPlayerName(source).." ha terminado servicio.")
--                 break
--             end
--         end
--     end
-- end)

addEventHandler("onResourceStart", resourceRoot, function ()
    setTimer(function ()
        if not init then
            if #players > 0 then
                if not fireStarted then
                    local randomCd = math.random(1, #positions)
                    local coords = Generar_coordenadas(positions[randomCd][1], positions[randomCd][2], positions[randomCd][3], cantidadFuegos, positions[randomCd][4])
                    setTimer(function()
                        local zone = getZoneName(positions[randomCd][1], positions[randomCd][2], positions[randomCd][3])
                        outputChatBox("[Bombero] Ha iniciado un incendio en : "..zone, players, 255, 255, 255)
                        Generar_fuegos(coords)
                        -- triggerClientEvent(players, "Bombero>>alarma", getRootElement(  ))
                        triggerToClientFromTable(players, "Bombero>>alarma")
                        -- iprint("coso2")
                        -- triggerClientEvent(players, "Bombero>>efecto", getRootElement(  ), true, fires)
                        triggerToClientFromTable(players, "Bombero>>efecto", true, fires)
                        fireStarted = true
                        contador = getTickCount(  )
                        -- iprint(1, contador)
                        init = true
                        return true
                    end, 5000, 1)
                end
            end
        else
            if contador then
                -- iprint(contador, minutos * 60000)
                if getTickCount() - contador > minutos * 60000 then
                    if #players > 0 then
                        local randomCd = math.random(1, #positions)
                        local coords = Generar_coordenadas(positions[randomCd][1], positions[randomCd][2], positions[randomCd][3], cantidadFuegos, positions[randomCd][4])
                        if not fireStarted then
                            if #fires == 0 then
                                setTimer(function()
                                    local zone = getZoneName(positions[randomCd][1], positions[randomCd][2], positions[randomCd][3])
                                    outputChatBox("[Bombero] Ha iniciado un incendio en : "..zone, players, 255, 255, 255)
                                    Generar_fuegos(coords)
                                    -- triggerClientEvent(players, "Bombero>>alarma", getRootElement(  ))
                                    triggerToClientFromTable(players, "Bombero>>alarma")
                                    -- iprint(#fires)
                                    -- triggerClientEvent(players, "Bombero>>efecto", getRootElement(  ), true, fires)
                                    triggerToClientFromTable(players, "Bombero>>efecto", true, fires)
                                    fireStarted = true
                                    contador = getTickCount(  )
                                    -- iprint(2, contador)
                                    return true
                                end, 8000, 1)
                            end
                        else
                            Remover_fuegos()
                            -- triggerClientEvent(players, "Bombero>>efecto", getRootElement(  ), false, fires)
                            outputChatBox("[Bombero] Se ha quemado todo gran mlp", players)
                        end
                    end
                end
            end
        end
    end, 9000, 0)
end)

function payPlayers()
    -- iprint(availablePlayersToPay)
    for _, p in ipairs(availablePlayersToPay) do
        if isElement(p) then
            local jobRank = getElementData(p, "Job Rank")
            local multiplicador = {
                ["Bombero novato"] = 1,
                ["Cabo"] = 1.5,
                ["Sargento"] = 2,
                ["Teniente"] = 2.6,
                ["Sub Comandante"] = 3,
                ["Comandante"] = 3.2,
                ["Mefisto"] = 3.8,
                ["Ghost Rider"] = 4
            }
            local money = math.floor(dinero * multiplicador[jobRank])
            givePlayerMoney(p, money)
            exports['NGJobs']:updateJobColumn ( getAccountName ( getPlayerAccount ( p ) ), "incendios", "AddOne" )
            outputChatBox("[Bombero] Se te ha pagado $"..money.." por tu servicio.", p, 255, 255, 255)

            -- givePlayerMoney(p, 8000)
            -- outputChatBox("Se te ha pagado ".. 8000 .."$ por tu servicio.", p, 255, 255, 255)
        end
    end
    availablePlayersToPay = {}
end

-- function isPlayerInTable(p, table)
--     for _, v in ipairs(table) do
--         if v == p then
--             return true
--         end
--     end
--     return false
-- end

function onPlayerHitColShape(element)
    if element then
        -- if getElementType(element) == "player" then local player = element end
        if getElementType(element) == "vehicle" then
            local data = getElementData(element, "Bombero.vehicle")
            -- iprint(data)
            if data then
                for _, v in pairs(getVehicleOccupants(element)) do
                    -- iprint(true, 'a')
                    -- iprint(isPlayerInTable(v))
                    if not isPlayerInTable(v, availablePlayersToPay) then
                        -- iprint(true, 'b')
                        table.insert(availablePlayersToPay, v)
                    end
                end

                for _, v in ipairs(data.playersUp) do iprint(v) if not isPlayerInTable(v, availablePlayersToPay) then table.insert(availablePlayersToPay, v) end end

                iprint(availablePlayersToPay)
            end
        end
    end
end

addEventHandler("onPlayerQuit", root, function()
    for i = 1, #players do
        if players[i] == source then
            Remover_fuegos()
            triggerClientEvent(source, "Bombero>>efecto", source, false, fires)
            table.remove(players, i)
            iprint(fires)
            iprint(players)
            iprint("[Bombero] "..getPlayerName(source).." ha terminado servicio.")
            break
        end
    end
end)

addEventHandler("onPlayerLogin", root, function ()
    if getElementData(source, "Job") == "Bombero" and getElementData(source, "Bombero.isactive") then
        if not isPlayerInTable(source, players) then
            table.insert(players, source)
            iprint("[Bombero] "..getPlayerName(source).." ha iniciado servicio.")
        end
    end
end)

-- function getPositionFromElementOffset(element,offX,offY,offZ) 
--     local m = getElementMatrix ( element )  -- Get the matrix 
--     local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform 
--     local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2] 
--     local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3] 
--     return x, y, z                               -- Return the transformed point 
-- end

function triggerToClientFromTable(table, event, ...)
    for _, v in ipairs(table) do
        if isElement(v) then
            triggerClientEvent(v, event, v, ...)
        end
    end
end
