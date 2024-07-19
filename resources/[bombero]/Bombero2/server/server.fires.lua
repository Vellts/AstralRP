fires = {}
local alertBlip = nil

------------------- [ Datos inicializados ] -------------------
stateData = {
    isStarted = false,
    area = nil,
    firesQuantity = 0,
    firesType = {
        1, -- pequeño
        2, -- mediano
        3, -- grande
    },
    extinguishTime = {
        2000,
        4000,
        6000,
    },
    timer = nil,
    coords = nil,
    initTimer = nil,
}

------------------- [ Almacenamiento de los blips ] -------------------

playerEssentials = {
}

------------------- [ Coordenadas ] -------------------

-- Genera las coordenadas del lugar donde se generará el incendio.
-- X: Coordenada X
-- Y: Coordenada Y
-- Z: Coordenada Z
-- Quantity: Cantidad de incendios a generar
-- Radio: Radio de generación de los incendios


function generateCoords(x, y, z, quantity, radio)
    local coords = {}
    if (not x) or (not y) or (not z) or (not quantity) or (not radio) then
        return coords
    end

    if (not stateData["isStarted"]) then
        local location = getZoneName(x, y, z)
        iprint("[Bombero] Coordenadas generadas en: "..location.." ("..x..", "..y..", "..z..")")
        stateData["area"] = createColCuboid(x-50, y-50, z, radio*5, radio*5, radio)
        local mtx = getElementMatrix(stateData["area"])
        -- obtiene el centro del cuboide
        local cx = mtx[4][1] + mtx[1][1] * 0.5 + mtx[2][1] * 0.5 + mtx[3][1] * 0.5
        local cy = mtx[4][2] + mtx[1][2] * 0.5 + mtx[2][2] * 0.5 + mtx[3][2] * 0.5
        local cz = mtx[4][3] + mtx[1][3] * 0.5 + mtx[2][3] * 0.5 + mtx[3][3] * 0.5
        for i = 1, quantity do
            local nx, ny, nz = math.random(cx, cx+radio+50), math.random(cy, cy+radio+50), math.random(cz, cz+cz*0.008)
            -- se crea un objeto y verifica que esté dentro del colshape
            local randomObject = createObject(1337, nx, ny, nz)
            setElementAlpha(randomObject, 0)
            local isValid = isElementWithinColShape(randomObject, stateData["area"])
            while (not isValid) do
                nx, ny, nz = math.random(cx, cx+radio+50), math.random(cy, cy+radio+50), math.random(cz, cz+cz*0.008)
                setElementPosition(randomObject, nx, ny, nz)
                isValid = isElementWithinColShape(randomObject, stateData["area"])
            end
            destroyElement(randomObject)
            table.insert(coords, {nx, ny, nz})
        end
        stateData["coords"] = coords
        return coords
    end
    stateData["coords"] = coords
    return coords
end

------------------- [ Fuegos ] -------------------

-- Coords: Genera los incendios en el mapa.
-- ToPlayer: Si es verdadero, genera los incendios para el jugador.
-- Player: Jugador al que se le generará el incendio, dado caso que ToPlayer sea verdadero.

function generateFires(coords, toPlayer, player)
    if (not coords) then return end
    if (toPlayer) then
        if (table.size(fires) >= 1) then
            for _, fire in pairs(fires) do
                triggerClientEvent(player, "fireman>>createFire", player, fire["position"][1], fire["position"][2], fire["position"][3], fire["type"], fire["col"])
                table.insert(playerEssentials[player], createBlip(fire["position"][1], fire["position"][2], fire["position"][3], 0, 2, 255, 0, 0, 255, 0, 99999, player))
            end
            triggerClientEvent(player, "fireman>>drawInfoDx", player, table.size(fires), false, getTimerDetails(stateData["timer"]))
            return true
        end
    end
    for _, player in ipairs(players) do
        playerEssentials[player] = {}
        for _, positions in ipairs(coords) do
            if table.size(fires) == stateData["firesQuantity"] then break end
            local x, y, z = positions[1], positions[2], positions[3]
            local colision = createColSphere(x, y, z, 1.5)
            
            table.insert(playerEssentials[player], createBlip(x, y, z, 0, 2, 255, 0, 0, 255, 0, 99999, player))
            local fireType = math.random(1, 3)
            local colisionFire = createColSphere(x, y, z, 0.8)

            local fireEvent = addEventHandler("onColShapeHit", colisionFire, onFirePlayer)
            local event = addEventHandler("onColShapeHit", colision, onFireHit)
            local stopEvent = addEventHandler("onColShapeLeave", colision, onFireLeave)

            fires[colision] = {
                ["col"] = colision,
                ["position"] = {x, y, z},
                ["type"] = fireType,
                ["blip"] = miniBlip,
                ["minimumExtinguishTime"] = stateData["extinguishTime"][fireType],
                ["event"] = event,
                ["stopEvent"] = stopEvent,
                ["colFire"] = colisionFire,
                ["fireEvent"] = fireEvent
            }
            -- client event
            triggerClientEvent(player, "fireman>>createFire", player, x, y, z, fireType, colision)
        end
        triggerClientEvent(player, "fireman>>drawInfoDx", player, table.size(fires), false, getTimerDetails(stateData["timer"]))
        -- alarm sound
        triggerClientEvent(player, "fireman>>playSoundEffect", player)
    end
end

------------------- [ Evento: Incendiar a jugador ] -------------------

-- Función que se activa cuando un jugador entra en contacto con el incendio (colshape).
-- player: Jugador que entra en contacto con el incendio.

function onFirePlayer(player)
    if (not isElement(player)) then return end
    if (getElementType(player) ~= "player") then return end

    -- Evita que el jugador se incendie si no pertenece a los bomberos.
    if (not table.isPlayerInTable(player, players)) then return end

    if (not isPedOnFire(player)) then
        local type = getFireType(source)
        setPedOnFire(player, true)
        setTimer(function()
            setPedOnFire(player, false)
        end, stateData["extinguishTime"][type], 1)
    end
end

------------------- [ Remover fuego ] -------------------

-- Remueve todo o un incendio en específico.
-- allFires: Si es verdadero, remueve todos los incendios.
-- fire: Incendio a remover.
-- player: Jugador al que se le removerá el incendio.

function removeFire(allFires, fire, player)
    if allFires then
        if (not player) then
            for _, fire in pairs(fires) do
                removeEventHandler("onColShapeHit", fire["col"], onFireHit)
                removeEventHandler("onColShapeLeave", fire["col"], onFireLeave)
                removeEventHandler("onColShapeHit", fire["colFire"], onFirePlayer)
                if (table.size(players) >= 1) then
                    triggerClientEvent(players, "fireman>>removeFire", root, fire["col"])
                end
                local col = fire["col"]
                if (isElement(fire["blip"])) then
                    destroyElement(fire["blip"])
                end
                destroyElement(fire["colFire"])
                destroyElement(col)
                fires[col] = nil
            end
            fires = {}
            if (isElement(stateData["area"])) then
                destroyElement(stateData["area"])
            end
            stateData["isStarted"] = false
        else
            -- Elimina los blips del jugador.
            for _, table_player in pairs(players) do
                if (table_player == player) then
                    if (table.size(playerEssentials[player]) >= 1) then
                        for _, blip in pairs(playerEssentials[player]) do
                            if (isElement(blip)) then
                                destroyElement(blip)
                            end
                        end
                    end
                end
            end
            triggerClientEvent(player, "fireman>>removeFire", player, fires)
            triggerClientEvent(player, "fireman>>drawInfoDx", root, _, true)
            if (isTimer(stateData["initTimer"])) then
                killTimer(stateData["initTimer"])
            end
        end
    else
        if (not fire) or (not isElement(fire)) then return end
        if (getElementType(fire) == "colshape") then
            local fireData = fires[fire]
            if (fireData) then
                removeEventHandler("onColShapeHit", fireData["col"], onFireHit)
                removeEventHandler("onColShapeLeave", fireData["col"], onFireLeave)
                removeEventHandler("onColShapeHit", fireData["colFire"], onFirePlayer)
                triggerClientEvent(player, "fireman>>removeFire", player, fireData["col"])
                destroyElement(fireData["col"])
                if (isElement(fireData["blip"])) then
                    destroyElement(fireData["blip"])
                end
                destroyElement(fireData["colFire"])
                fires[fire] = nil
                triggerClientEvent(player, "fireman>>updateRestFiresDx", player, table.size(fires))
            end

            if (table.size(fires) == 0) then
                stateData["isStarted"] = false
                iprint("No hay más incendios")

                outputChatBox("[Bombero] No hay más incendios, se ha terminado la emergencia.", player, 255, 255, 240)
                triggerClientEvent(player, "fireman>>drawInfoDx", player, _, true)
            end
            return
        end
    end
end

------------------- [ Terminar partida ] -------------------

-- Termina la partida si no hay jugadores conectados, o si ha pasado el tiempo límite.

function lostGame()
    if (table.size(players) >= 1) then
        removeFire(true)
        triggerClientEvent(players, "fireman>>drawInfoDx", root, _, true)
        outputDebugString("[Bombero] Se ha perdido el juego.")
    else
        removeFire(true)
        outputDebugString("[Bombero] No hay jugadores conectados, se ha perdido el juego.")
    end
end

------------------- [ Evento: Iniciar incendio ] -------------------

-- Genera un timer cuando se inicia el recurso, para generar un incendio en un lugar aleatorio.
-- Se genera un incendio cada 1 a 3 minutos.
-- Se genera un incendio si hay al menos un jugador conectado.

addEventHandler("onResourceStart", resourceRoot, function()
    setTimer(function()
        if not (stateData["isStarted"]) then
            if table.size(players) >= 1 then
                local randomPosition = math.random(1, #positions)
                local x, y, z = positions[randomPosition][1], positions[randomPosition][2], positions[randomPosition][3]
                local coords = generateCoords(x, y, z, positions[randomPosition][5], positions[randomPosition][4])
                stateData["isStarted"] = true
                local time = (math.random(1, 3) * 60 * 1000)
                outputDebugString("[Bombero] Se generará un incendio en "..(time / 60000).." minuto (s).")
                stateData["initTimer"] = setTimer(function()
                    local zone = getZoneName(x, y, z)
                    stateData["firesQuantity"] = positions[randomPosition][5]
                    outputChatBox("[Bombero] Se ha generado un incendio en: "..zone.." ("..x..", "..y..", "..z..")", players, 255, 255, 240)
                    stateData["timer"] = setTimer(function()
                        lostGame()
                    end, (fireTimerMultiplier * positions[randomPosition][5]), 1)
                    generateFires(coords)
                end, 7000, 1)
            end
        end
    end, 1000, 0)
end)
