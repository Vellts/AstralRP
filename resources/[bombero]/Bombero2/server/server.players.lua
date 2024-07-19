------------------- [ Utilidades ] -------------------

players = {}
local timer = nil
local fireTimeSend = false
local inColShape = false
local fire = nil

------------------- [ Agrega jugadores ] -------------------

-- Agrega un jugador al equipo.

function addPlayerToTeam()
    if (not client) then return end
    if (not isElement(client)) then return end
    if (not getElementType(client) == "player") then return end
    if (not stateData.isStarted) then
        if (not table.isPlayerInTable(client, players)) then
            table.insert(players, client)
            outputDebugString("[Bombero] >> "..getPlayerName(client).." se ha unido a la partida")
        end
    else
        if (stateData["coords"] ~= nil) then
            if (not table.isPlayerInTable(client, players)) then
                table.insert(players, client)
                outputDebugString("[Bombero] >> "..getPlayerName(client).." se ha unido a la partida")
                generateFires(stateData["coords"], true, client)
            end
        end
    end
end
addEvent("fireman>>addPlayer", true)
addEventHandler("fireman>>addPlayer", root, addPlayerToTeam)

------------------- [ Remueve jugadores ] -------------------

-- Remueve un jugador del equipo.

function removePlayerFromTeam()
    if (not client) then return end
    if (not isElement(client)) then return end
    if (not getElementType(client) == "player") then return end

    if (table.isPlayerInTable(client, players)) then
        removeFire(true, _, client)
        table.remove(players, table.find(players, client))
        outputDebugString("[Bombero] >> "..getPlayerName(client).." se ha ido de la partida")
    end

    if (table.size(players) == 0) then
        if (stateData.isStarted) then
            lostGame()
        end
    end
end
addEvent("fireman>>removePlayer", true)
addEventHandler("fireman>>removePlayer", root, removePlayerFromTeam)

------------------- [ Evento: Inicia el conteo ] -------------------

-- Si el jugador está dentro de la colisión, se inicia el conteo.
-- element: Elemento que entra en la colisión (jugador).
-- matchDimension: Si el elemento coincide con la dimensión.

function onFireHit(element, matchDimension)
    if (not stateData.isStarted) then return end
    if (getElementType(element) ~= "player") then return end
    if (not table.isPlayerInTable(element, players)) then return end
    if (not matchDimension) then return end
    
    if (not isTimer(timer)) then
        fire = source
        countFire(fire, element)
    end
end

------------------- [ Función: Verificación del conteo ] -------------------

-- Verifica si el jugador está disparando y si el tiempo de extinción ha terminado.
-- fire: ID del fuego.
-- player: Jugador que está disparando.

function countFire(fire, player)
    local count = 0
    timer = setTimer(function()
        if (not stateData.isStarted) then
            if (isTimer(timer)) then
                killTimer(timer)
                timer = nil
                count = 0
                return
            end
        end
        local fireTime = fires[fire].minimumExtinguishTime or 0
        local isFiring = getControlState(player, "fire")

        if (not isFiring) then
            count = 0
            return
        end

        local weapon = getPedWeapon(player)
        if (weapon ~= 42) then 
            count = 0
            return
        end

        count = count + 1000
        triggerClientEvent(player, "fireman>>startProgressionDx", player, fireTime, count)
        if ((count) >= fireTime) then
            removeFire(false, fire, player)
            if (isTimer(timer)) then
                killTimer(timer)
                timer = nil
                count = 0
            end
            triggerClientEvent(player, "fireman>>stopProgressionDx", player)
        end
    end, 1000, 0)
end

------------------- [ Evento: Sale de la colisión ] -------------------

-- Si el jugador sale de la colisión, se detiene el conteo.
-- element: Elemento que sale de la colisión (jugador).
-- matchDimension: Si el elemento coincide con la dimensión.

function onFireLeave(element, matchDimension)
    if (not stateData.isStarted) then return end
    if (getElementType(element) ~= "player") then return end
    if (not table.isPlayerInTable(element, players)) then return end
    if (not matchDimension) then return end

    if (isTimer(timer)) then
        killTimer(timer)
        timer = nil
        triggerClientEvent(element, "fireman>>stopProgressionDx", element)
    end
end

------------------- [ Evento: Jugador ] -------------------

-- Evento que se activa cuando un jugador se desconecta.
-- Se elimina al jugador de la tabla de jugadores, si es que está en ella.
-- Se detiene el temporizador si es que está activo.
-- Si no hay jugadores en la tabla, se pierde el juego.

function onPlayerQuit()
    if (not isElement(source)) then return end
    if (not getElementType(source) == "player") then return end
    if (table.isPlayerInTable(source, players)) then
        table.remove(players, table.find(players, source))
    end

    if (isTimer(timer)) then
        killTimer(timer)
        timer = nil
    end

    if (table.size(players) == 0) then
        if (stateData.isStarted) then
            lostGame()
        end
    end
end
addEventHandler("onPlayerQuit", root, onPlayerQuit)