-- local db = 
local cache = {}

addEvent("player::loginRequest", true)
addEventHandler("player::loginRequest", root, function(username, password, checkStatus)
    if (not client) then return end
    -- local hashPass = passwordHash(password, "bcrypt", {})
    local player = client
    local query = dbQuery(function(qh)
        local result = dbPoll(qh, 0)
        if #result > 0 then
            local data = result[1]
            if passwordVerify(password, data.password) then
                setElementData(player, "player::account_id", data.account_id, false)
                local canLogin = logIn(player, getAccount(username, password), password)
                local characters = dbQuery(function(qh)
                    local result = dbPoll(qh, 0)
                    exports.character_creation:selectCharacter(player, username, 0, result)
                    exports.core_notifications:createNotification(player, "normal", {
                        icon = "in",
                        message = "Bienvenido al servidor, "..username.."."
                    })
                end, exports.databaseManager:getDatabaseConnection(), "SELECT character_name, age, positions, character_id, money_bank FROM characters WHERE account_id = ?", data.account_id)

                triggerClientEvent(player, "player::loginResponse", player, true, "nice", username, checkStatus)
            else
                triggerClientEvent(client, "player::loginResponse", client, false, "fail")
            end
        else
            triggerClientEvent(client, "player::loginResponse", client, false, "que hace")
        end
    end, exports.databaseManager:getDatabaseConnection(), "SELECT password, account_id FROM accounts WHERE username = ?", username)
end)

addEvent("player::registerRequest", true)
addEventHandler("player::registerRequest", root, function(username, password, email)
    if (not client) then return end
    local player = client

    if (string.len(username) >= 20) or (string.len(username) < 1) or (string.len(password) >= 50) or (string.len(password) < 1) or (string.len(email) >= 50) or (string.len(email) < 1) then
        triggerClientEvent(client, "player::registerResponse", client, false, "invalid data")
        return
    end

    local query = dbQuery(function(qh)
        local result = dbPoll(qh, 0)
        if #result > 2 then
            iprint(result)
            triggerClientEvent(player, "player::registerResponse", player, false, "username, email or serial already exists")
        else
            local ID = exports.databaseManager:generateUUID()
            local ip = getPlayerIP(player)
            local serial = getPlayerSerial(player)
            local hashPass = passwordHash(password, "bcrypt", {})
            local exec = dbExec(exports.databaseManager:getDatabaseConnection(), "INSERT INTO accounts (account_id, username, password, email, ip, serial) VALUES (?, ?, ?, ?, ?, ?)", ID, username, hashPass, email, ip, serial)
            if (exec) then
                iprint("registro exitoso")
                triggerClientEvent(player, "player::registerResponse", player, true)
                addAccount(username, password)
            else
                iprint("nao nao")
            end
        end
    end, exports.databaseManager:getDatabaseConnection(), "SELECT * FROM accounts WHERE (username = ? or email = ? or serial = ?)", username, email, getPlayerSerial(player))
end)