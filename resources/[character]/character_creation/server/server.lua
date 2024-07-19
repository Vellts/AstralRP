local dataCharacters = {}
local cache_username = nil

function selectCharacter(element, username, coin, characters)
    if not element or not coin or not username then return end
    if (not isElement(element) or getElementType(element) ~= "player") then return end
    local accs = {}
    cache_username = username
    for i, v in ipairs(characters) do
        dataCharacters[i] = v
        table.insert(accs, {
            character_id = i,
            character_name = v.character_name,
            age = v.age,
            positions = v.positions,
            money_bank = v.money_bank,
        })
    end
    -- iprint("Data Characters:")
    -- iprint(dataCharacters)
    -- iprint("Accounts:")
    -- iprint(accs)

    local args = {
        coins = 5600,
        accounts = accs,
    }
    -- iprint(args.accounts)
    spawnPlayer(element, 1724.0239257812,-1648.9959716797,20.11315536499)
    setElementFrozen(element, true)
    setElementInterior(element, 18)
    triggerClientEvent(element, "system::characterSelect", element, username, args)
end

function getCharacterSkin(id)
    -- iprint("ID: ")
    -- iprint(id)
    if (not client) then return end
    if (not id) then return end

    -- iprint("Data Characters:")
    -- iprint(dataCharacters[id])
    if (not dataCharacters[id]) then return end

    local character_id = dataCharacters[id].character_id
    -- iprint("Character ID: " .. chatacter_id)
    local player = client
    local query = dbQuery(function(qh)
        local result = dbPoll(qh, 0)
        iprint("Resultado: ")
        iprint(result)
        if (#result > 0) then
            setElementModel(player, result[1].skin)
            local data_clothes = {
                ["skin"] = result[1].skin,
                ["perna"] = fromJSON(result[1].pants),
                ["cabelo"] = fromJSON(result[1].hair),
                ["camisa"] = fromJSON(result[1].shirt),
                ["tenis"] = fromJSON(result[1].tenis),
                ["face"] = fromJSON(result[1].face),
                ["body"] = fromJSON(result[1].body),
                ["oculos"] = fromJSON(result[1].glasses),
                ["mochila"] = fromJSON(result[1].backpack),
                ["coxa"] = fromJSON(result[1].pectoral),
                ["pec"] = fromJSON(result[1].feets),
                ["mascara"] = fromJSON(result[1].mask),
            }
            -- iprint(data)
            exports.playerManager:UpdatePlayerClothes(player, data_clothes, ddata_clothesata)
        else
            setElementModel(player, 14)
            local data_clothes = {
                ["skin"] = 14,
                ["perna"] = {1, 1},
            }
            exports.playerManager:UpdatePlayerClothes(player, data_clothes, data_clothes)
        end
    end, exports.databaseManager:getDatabaseConnection(), "SELECT * FROM characters_clothes WHERE character_id = ?", character_id)
end
addEvent("system::getCharacterSkin", true)
addEventHandler("system::getCharacterSkin", root, getCharacterSkin)

addEvent("system::characterSelected", true)
addEventHandler("system::characterSelected", root, function(id)
    if (not client) or (not id) then return end
    if (not dataCharacters[id]) then return end

    -- if (not isElement(client)) or (getElementType(client) ~= "player") then return end
    iprint("aqui:)")
    local character_id = dataCharacters[id].character_id
    -- iprint(character_id)
    setElementFrozen(client, false)
    setCameraTarget(client, client)
    setElementInterior(client, 0)
    exports.playerManager:loadCharacter(client, character_id)
end)

function createCharacter(character_data, character_clothes)
    if (not client) then return end
    if (not character_data) then return end
    if (not character_clothes) then return end

    local player = client

    ---- character

    local account_id = getElementData(player, "player::account_id")
    local character_id = exports.databaseManager:generateUUID()
    local positions = toJSON({1475.4038085938,-1767.1776123047,18.795755386353, 0, 0, 0})
    -- iprint("Character Data:")
    -- iprint(account_id, character_id, character_data)

    -- iprint("Character clothes: ")
    -- iprint(character_clothes)
    local exec_character = dbExec(exports.databaseManager:getDatabaseConnection(), "INSERT INTO `characters` (`character_id`, `character_name`, `age`, `account_id`, `positions`) VALUES (?, ?, ?, ?, ?)", character_id, character_data.character_name, character_data.age, account_id, positions)

    ---- clothes

    -- character_clothes["character_id"] = character_data["character_id"]
    character_clothes["backpack"] = { 0, 0 }
    character_clothes["mask"] = { 0, 0 }
    character_clothes["glasses"] = character_clothes["glasses"] or { 0, 0 }
    iprint("Character Clothes: ")
    iprint(character_id, character_clothes["skin"], toJSON(character_clothes["hair"]), toJSON(character_clothes["shirt"]), toJSON(character_clothes["tenis"]), toJSON(character_clothes["pants"]), toJSON(character_clothes["face"]), toJSON(character_clothes["body"]), toJSON(character_clothes["glasses"]), toJSON(character_clothes["backpack"]), toJSON(character_clothes["pectoral"]), toJSON(character_clothes["feets"]), toJSON(character_clothes["mask"]))
    -- local exec_clothes = dbExec(exports.databaseManager:getDatabaseConnection(), "INSERT INTO characters_clothes SET ?", character_clothes)
    local exec_clothes = dbExec(exports.databaseManager:getDatabaseConnection(), "INSERT INTO `characters_clothes` (`character_id`, `skin`, `hair`, `shirt`, `tenis`, `pants`, `face`, `body`, `glasses`, `backpack`, `pectoral`, `feets`, `mask` ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", character_id, character_clothes["skin"], toJSON(character_clothes["hair"]), toJSON(character_clothes["shirt"]), toJSON(character_clothes["tenis"]), toJSON(character_clothes["pants"]), toJSON(character_clothes["face"]), toJSON(character_clothes["body"]), toJSON(character_clothes["glasses"]), toJSON(character_clothes["backpack"]), toJSON(character_clothes["pectoral"]), toJSON(character_clothes["feets"]), toJSON(character_clothes["mask"]))
    -- if (not exec_clothes) then    
    --     iprint("Error al crear la ropa del personaje.")
    --     return
    -- end

    iprint("Personaje creado correctamente.")
    local characters = dbQuery(function(qh)
        local result = dbPoll(qh, 0)
        selectCharacter(player, cache_username, 5600, result)
        -- selectCharacter(player,)
    end, exports.databaseManager:getDatabaseConnection(), "SELECT character_name, age, positions, character_id, money_bank FROM characters WHERE account_id = ?", account_id)
    -- setElementPosition(player, 1475.4038085938,-1767.1776123047,18.795755386353)
    -- setElementFrozen(player, false)
    -- setElementInterior(player, 0)
    -- setElementModel(player, character_clothes.skin)
    -- setCameraTarget(player, player)
    -- fadeCamera(player, true)
end
addEvent("system::createCharacter", true)
addEventHandler("system::createCharacter", root, createCharacter)