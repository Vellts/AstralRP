-- addEventHandler("onPlayerJoin", root, function()
--     showChat(false)
-- end)

function loadCharacter(element, character_id)
    local account_id = getElementData(element, "player::account_id")
    -- iprint(element, character_id, account_id)
    if (not account_id) then return end

    local player = element
    -- iprint("en playerManager")
    local query = dbQuery(function(qh)
        local result = dbPoll(qh, 0)
        -- iprint(result)
        if (#result > 0) then
            outputDebugString("[DATABASE] Cargando datos del jugador con ID: "..account_id)
            local character = result[1]
            local x, y, z, rx, ry, rz = unpack(fromJSON(character.positions))
            local interior = character.interior
            local dimension = character.dimension
    

            -- spawnPlayer(player, x, y, z, rz, character.gender, interior, dimension)
            setElementPosition(player, x, y, z)
            setElementRotation(player, rx, ry, rz)
            setElementInterior(player, interior)
            setElementDimension(player, dimension)
            setElementModel(player, character.gender)

            fadeCamera(player, true)
            setCameraTarget(player, player)
    
            setElementData(player, "player::isLogged", true)
            setElementData(player, "player::character_name", character.character_name)
            setElementData(player, "player::character_id", character.character_id, false)
            setElementData(player, "player::hunger", character.hunger)
            setElementData(player, "player::thirst", character.thirst)
            setElementData(player, "player::money", character.money)
            setElementData(player, "player::money_bank", character.money_bank)
    
            local weapons = fromJSON(character.weapons)
            if (not weapons) then
                weapons = {}
            end
            for i, weapon in ipairs(weapons) do
                giveWeapon(player, weapon[1], weapon[2])
            end

            exports.core_player:drawHud(player)
            exports.core_notifications:createNotification(player, "normal", {
                icon = "in",
                message = "Bienvenido de vuelta, "..character.character_name
            })

            -- createVehicle(466, 215.55642700195,-145.50924682617,1.5858916044235)
        end
    end, exports.databaseManager:getDatabaseConnection(), "SELECT * FROM characters WHERE character_id = ?", character_id)

end

local function onPlayerQuit()
    if (source ~= nil) then
        player = source
    end

    if (not isElement(player)) then return end
    if (not getElementData(player, "player::isLogged")) then return end

    local x, y, z = getElementPosition(player)
    local rx, ry, rz = getElementRotation(player)
    local positions = toJSON({x, y, z, rx, ry, rz})

    local health = getElementHealth(player)
    local armor = getPedArmor(player)

    local interior = getElementInterior(player)
    local dimension = getElementDimension(player)

    local money = getElementData(player, "player::money") or 0
    local money_bank = getElementData(player, "player::money_bank") or 0
    local gender = getElementModel(player)

    local weapons = {}
    for i = 0, 12 do
        local weapon = getPedWeapon(player, i)
        local ammo = getPedTotalAmmo(player, i)
        if weapon and ammo > 0 then
            table.insert(weapons, {weapon, ammo})
        end
    end

    -- local character_name = getElementData(player, "player::character_name") or "Unknown"
    local hunger = getElementData(player, "player::hunger") or 100
    local thirst = getElementData(player, "player::thirst") or 100
    local account_id = getElementData(player, "player::account_id")
    local character_id = getElementData(player, "player::character_id")

    local query = dbExec(exports.databaseManager:getDatabaseConnection(), [[
        UPDATE
            `characters`
        SET
            `positions` = ?,
            `interior` = ?,
            `dimension` = ?,
            `health` = ?,
            `armor` = ?,
            `money` = ?,
            `money_bank` = ?,
            `gender` = ?,
            `hunger` = ?,
            `thirst` = ?,
            `weapons` = ?
        WHERE
            `character_id` = ?
    ]], positions, interior, dimension, health, armor, money, money_bank, gender, hunger, thirst, toJSON(weapons),character_id)

    if (query) then
        outputDebugString("[DATABASE] Datos del jugador con ID: "..account_id.." guardados correctamente.")
        setElementData(source, "player::isLogged", false)
    else
        outputDebugString("[DATABASE] Error al guardar los datos del jugador ["..character_name.."] con ID: "..account_id..".")
    end
end

local function createTestCharacter(player, cmd)
    local id = getElementData(player, "player::account_id")
    if (not id) then return end
    local character_name = "Jose Osorio"
    local age = 23
    local positions = {
        1481.0744628906,-1768.4147949219,18.795755386353, 0, 0, 0
    }
    local character_id = exports.databaseManager:generateUUID()
    local interior = 0
    local dimension = 0
    local health = getElementHealth(player)
    local armor = getPedArmor(player)
    local money = getElementData(player, "player::money") or 1000
    local money_bank = getElementData(player, "player::money_bank") or 10000
    local gender = 14
    local weapons = toJSON({})
    -- iprint(exports.databaseManager:getDatabaseConnection())
    -- iprint(id, character_name, character_id, positions, interior, dimension, health, armor, money, money_bank, gender, weapons)

    local query = dbExec(exports.databaseManager:getDatabaseConnection(), "INSERT INTO `characters` (`account_id`, `character_name`, `age`, `character_id`, `positions`, `interior`, `dimension`, `health`, `armor`, `money`, `money_bank`, `gender`, `weapons`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", id, character_name, age, character_id, toJSON(positions), interior, dimension, health, armor, money, money_bank, gender, weapons)
    -- iprint(query)
    if (query) then
        outputDebugString("[DATABASE] Cuenta de prueba creada correctamente.")
        -- setElementData(player, "player::account_id", uid, false)
    else          
        outputDebugString("[DATABASE] Error al crear la cuenta de prueba.")
    end
end
addCommandHandler("acctest", createTestCharacter)

addEventHandler("onPlayerQuit", root, onPlayerQuit)
addEvent("system::loadCharacter", true)
addEventHandler("system::loadCharacter", root, loadCharacter)
