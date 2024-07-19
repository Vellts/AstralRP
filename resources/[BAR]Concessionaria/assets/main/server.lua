local server = {
    concessionaria = {};
    detrans = {};
    garagens = {};
    blipdetran = {};
    blipgaragem = {};
    blipconce = {};
    tracker = {};
    car = {};
    dados = {};
    contaDono = {};
    carTest = {};
    positionAtual = {};
    cooldownPlayer = {};
    cooldownPlayer2 = {};   
}

db = dbConnect("sqlite", "assets/database/database.sqlite")
dbExec(db, "CREATE TABLE IF NOT EXISTS carros(id INTEGER PRIMARY KEY AUTOINCREMENT, user TEXT, model INTEGER, state TEXT, seguro TEXT, infos TEXT, dados TEXT, plate TEXT)")
dbExec(db, "CREATE TABLE IF NOT EXISTS estoque(model INTEGER, value INTEGER)")
dbExec(db, "CREATE TABLE IF NOT EXISTS slots(user TEXT, slots_liberados INTEGER)")

addEventHandler("onResourceStart", resourceRoot, function()
    if db then 
        outputDebugString("SQUADY [SISTEMA DE CONCESSIONARIA] Banco de dados conectado com sucesso.", 4, 14, 158, 247)
    else
        outputDebugString("SQUADY [SISTEMA DE CONCESSIONARIA] Houve um erro ao conectar o banco de dados.", 4, 255, 0, 0)
    end

    for i, v in ipairs(config["lojas"]) do
        server["concessionaria"][i] = createMarker(v[1], v[2], v[3] -1, "cylinder", 1.1, 0, 0, 0, 0)
        setElementData(server["concessionaria"][i], "markerData", {tittle = "Concessionaria", desc = "Compre seu veículo aqui nesta loja!", icon = "exchange"})
        server["blipconce"][i] = createBlip(v[1], v[2], v[3], 55)
    end

    for i, v in ipairs(config["garagens"]) do 
        server["garagens"][i] = createMarker(v[1], v[2], v[3] -1, "cylinder", 1.1, 0, 0, 0, 0)
        setElementData(server["garagens"][i], "markerData", {tittle = "Garagem", desc = "Pegue seu veículo aqui!", icon = "garage"})
        server["blipgaragem"][i] = createBlip(v[1], v[2], v[3], 53)
    end

    for i, v in ipairs(config["detrans"]) do 
        server["detrans"][i] = createMarker(v[1], v[2], v[3] -1, "cylinder", 1.1, 0, 0, 0, 0)
        setElementData(server["detrans"][i], "markerData", {tittle = "Detran", desc = "Veja as pendências dos seus veículos!", icon = "office"})
        server["blipdetran"][i] = createBlip(v[1], v[2], v[3], 24)
    end

    for i, v in ipairs(getElementsByType("player")) do 
        local result = dbPoll(dbQuery(db, "SELECT * FROM slots WHERE user = ?", getAccountName(getPlayerAccount(v))), -1)
        local vip = getPlayerVIP(v)
    
        if (#result == 0) then 
            if not config["slots"][vip] then 
                slots = (config["slots"]["Everyone"] or 0)
            else
                slots = config["slots"][vip]
            end
            dbExec(db, "INSERT INTO slots (user, slots_liberados) VALUES (?, ?)", getAccountName(getPlayerAccount(v)), slots)
        end
    end
end)

addEventHandler("onMarkerHit", root, function(hitElement, matchingDimension)
    if matchingDimension and getElementType(hitElement) == "player" then
        for i, v in ipairs(server["concessionaria"]) do 
            if source == v then 
                triggerClientEvent(hitElement, "squady.openConce", hitElement)
                break 
            elseif i == #server["concessionaria"] then 
                for i, v in ipairs(server["garagens"]) do 
                    if source == v then 
                        local result = dbPoll(dbQuery(db, "SELECT * FROM slots WHERE user = ?", getAccountName(getPlayerAccount(hitElement))), -1)
                        local vip = getPlayerVIP(hitElement)
                        if (#result == 0) then 
                            if not config["slots"][vip] then 
                                slots = (config["slots"]["Everyone"] or 0)
                            else
                                slots = config["slots"][vip]
                            end
                            dbExec(db, "INSERT INTO slots (user, slots_liberados) VALUES (?, ?)", getAccountName(getPlayerAccount(hitElement)), slots)
                        end
                        local result_slots = dbPoll(dbQuery(db, "SELECT * FROM slots WHERE user = ?", getAccountName(getPlayerAccount(hitElement))), -1)
                        triggerClientEvent(hitElement, "squady.openGarage", hitElement, result_slots[1]["slots_liberados"])
                        break
                    elseif i == #server["garagens"] then
                        for i, v in ipairs(server["detrans"]) do
                            if source == v then 
                                local result = dbPoll(dbQuery(db, "SELECT * FROM carros WHERE user = ?", pullAccount(hitElement)), -1)
                                triggerClientEvent(hitElement, "squady.openDetran", hitElement, result)
                                break
                            end
                        end
                    end
                end
            end
        end
    end
end)

addCommandHandler("setestoque", function(player, _, model, qntd)
    if isPlayerInACL(player) then 
        if model and qntd then 
            local result = dbPoll(dbQuery(db, "SELECT * FROM estoque WHERE model = ?", tonumber(model)), -1)
            if (#result ~= 0) then 
                dbExec(db, "UPDATE estoque SET value = ? WHERE model = ?", tonumber(qntd), tonumber(model))
                sendMessage("server", player, "Você setou "..qntd.."x de estoque do veículo "..model.." com sucesso.", "success")
                messageDiscord("O(A) "..getPlayerName(player).." ("..pullID(player)..") setou "..qntd.."x de estoque do veículo "..model.." na concessionária.", config["logs"]["web-hook"])
            else
                sendMessage("server", player, "Veículo não encontrado.", "error")
            end
        end
    end
end)

setTimer(function()
    for i, veh in ipairs(config["veiculos"]) do 
        local data = dbPoll(dbQuery(db, "SELECT * FROM estoque WHERE model = ?", veh[2]), -1)
        if (#data == 0) then 
            dbExec(db, "INSERT INTO estoque (model, value) VALUES(?, ?)", veh[2], 35)
        end
    end
end, 1000, 1)

local colshape = createColSphere(1321.813, 2673.429, 11.239, 80)

addEventHandler("onColShapeLeave", colshape, function(veh)
    if isElement(veh) and getElementType(veh) == "vehicle" and server["carTest"][veh] and isElement(server["carTest"][veh]) then 
        triggerClientEvent(server["carTest"][veh], "squady.onTestDrive", server["carTest"][veh], "remove")
        if server["car"][server["carTest"][veh]] and isElement(server["car"][server["carTest"][veh]]) then 
            destroyElement(server["car"][server["carTest"][veh]])
        end
        setTimer(function(player)
            if server["positionAtual"][player] then 
                sendMessage("server", player, "Você saiu do estacionamento e perdeu o teste drive.", "error")
                setElementPosition(player, server["positionAtual"][player][1]+2, server["positionAtual"][player][2], server["positionAtual"][player][3])
                if isTimer(server["cooldownPlayer2"][player]) then killTimer(server["cooldownPlayer2"][player]) end
            end
        end, 500, 1, server["carTest"][veh])
    end
end)

addEvent("squady.testDrive", true)
addEventHandler("squady.testDrive", getRootElement(), function(model, color)
    if model then 
        if not isTimer(server["cooldownPlayer"][source]) then 
            server["positionAtual"][source] = {getElementPosition(source)}
            server["car"][source] = createVehicle(model, 1549.552, -1250.934, 17.406, -0, 0, 359.342)
            setElementData(server["car"][source], "Owner", source)
            setElementData(server["car"][source], "JOAO.fuel", 100)
            setVehicleColor(server["car"][source], color[1], color[2], color[3], color[4], color[5], color[6], color[7], color[8], color[9])
            server["carTest"][server["car"][source]] = source
            warpPedIntoVehicle(source, server["car"][source])
            triggerClientEvent(source, "squady.closeConce", source)
            triggerClientEvent(source, "squady.onTestDrive", source, "add")
            server["cooldownPlayer"][source] = setTimer(function()end, 10 * 60000, 1)
            sendMessage("server", source, "Você está testando um veículo.", "success")

            server["cooldownPlayer2"][source] = setTimer(function(player)
                if player and isElement(player) then
                    triggerClientEvent(player, 'squady.onTestDrive', player, 'remove')
                    if server["car"][player] and isElement(server["car"][player]) then
                        destroyElement(server["car"][player])
                    end
                    setTimer(function(player)
                        if player and isElement(player) and server["positionAtual"][player] then
                            setElementPosition(player, server["positionAtual"][player][1]+2, server["positionAtual"][player][2], server["positionAtual"][player][3])
                            sendMessage("server", player, "O Test drive foi encerrado.", "info")
                        end
                    end, 500, 1, player)
                end
            end, 60000, 1, source)
        else
            sendMessage("server", source, "Você já testou um veículo recentemente.", "error")
        end
    end
end)

addEventHandler("onVehicleExit", getRootElement(), function(player)
    if source == server["car"][player] and isElement(server["car"][player]) then 
        if isTimer(server["cooldownPlayer2"][player]) then killTimer(server["cooldownPlayer2"][player]) end
        destroyElement(server["car"][player])
        triggerClientEvent(player, "squady.onTestDrive", player, "remove")
        sendMessage("server", player, "Você saiu do veículo e perdeu o Test Drive.", "error")
        setElementPosition(player, server["positionAtual"][player][1]+2, server["positionAtual"][player][2], server["positionAtual"][player][3])
    end
end)

addEvent("squady.buyVehicle", true)
addEventHandler("squady.buyVehicle", getRootElement(), function(player, model, name, price, color, type)
    local account = getPlayerAccount(player)
    local playerName = getPlayerName(player)
    local model = tonumber(model)

    local query = dbQuery(db, "SELECT * FROM carros WHERE user = ? AND model = ?", getAccountName(getPlayerAccount(player)), model)
    local result = dbPoll(query, -1)

    local result_slots = dbPoll(dbQuery(db, "SELECT * FROM slots WHERE user = ?", getAccountName(getPlayerAccount(player))), -1)

    if result and #result > 0 then
        sendMessage("server", player, "Você já possui esse veículo na garagem.", "error")
    else
        if isPlayerMoney(player, tostring(type)) < tonumber(price) then 
            sendMessage("server", player, "Você não possui dinheiro suficiente.", "error")
        else
            if not descEstoque(tonumber(model), tostring(type)) then 
                sendMessage("server", player, "Esse veículo está fora de estoque.", "error")
            else
                if isPlayerVip(player) then 
                    price = math.floor(tonumber((price / 100) * 90))
                else
                    price = tonumber(price)
                end

                if (#result_slots > 0) then
                    local slotsLiberados = tonumber(result_slots[1]["slots_liberados"])
                    local queryCarrosDoJogador = dbQuery(db, "SELECT * FROM carros WHERE user = ?", getAccountName(account))
                    local resultCarrosDoJogador = dbPoll(queryCarrosDoJogador, -1)
                    
                    if resultCarrosDoJogador and #resultCarrosDoJogador >= slotsLiberados then
                        sendMessage("server", player, "Você não possui slots suficientes na garagem para comprar esse veículo.", "error")
                    else
                        descPlayerMoney(player, tostring(type), price)
                        sendMessage("server", player, "Você comprou o veículo "..name.." por " .. (type == "Dinheiro" and "R$" or "ap$") .. convertNumber(price) .. " com sucesso.", "success")
                        messageDiscord("O(A) " .. playerName .. " (" .. pullID(player) .. ") comprou o veículo " .. name .. " (" .. model .. ") por " .. (type == "Dinheiro" and "R$" or "ap$") .. convertNumber(price) .. ".", config["logs"]["web-hook"])
                        sendMessage("server", player, "Vá até a garagem mais próxima para pegá-lo.", "info")
                        local dados_veh = {vida = 1000, tunagem = {}, color = {color[1], color[2], color[3], color[4], color[5], color[6], color[7], color[8], color[9]}, light = {255, 255, 255}, gasolina = 100, malas = {}}
                        dbExec(db, "INSERT INTO carros (user, model, state, seguro, infos, dados, plate) VALUES (?, ?, ?, ?, ?, ?, ?)", pullAccount(player), model, "guardado", ((getRealTime().timestamp) + 604800), toJSON({name, price, type}), toJSON({dados_veh}), "")
                        local data = dbPoll(dbQuery(db, "SELECT * FROM estoque"), -1)
                        triggerClientEvent(player, "squady.insertEstoque-c", player, data)
                    end
                end
            end
        end
    end
end)

addEvent("squady.licenseVehicle", true)
addEventHandler("squady.licenseVehicle", getRootElement(), function(player, model)
    local query = dbQuery(db, "SELECT plate FROM carros WHERE user = ? AND model = ?", getAccountName(getPlayerAccount(player)), model)
    local result = dbPoll(query, -1)

    if result and #result > 0 then
        local plate = result[1].plate
        if plate ~= "" then
            sendMessage("server", player, "Esse veículo já está emplacado.", "error")
        else
            local valor = (findPriceByModelVehicle(model)/100)*4
            if getPlayerMoney(player) >= valor then
                takePlayerMoney(player, valor)
                plate = createVehiclePlate()
                dbExec(db, "UPDATE carros SET plate = ? WHERE user = ? AND model = ?", plate, getAccountName(getPlayerAccount(player)), model)
                sendMessage("server", player, "Você emplacou o veículo com sucesso.", "success")
            else
                sendMessage("server", player, "Você não possui dinheiro suficiente.", "error")
            end
        end
    end
end)

addEvent("squady.buySlot", true)
addEventHandler("squady.buySlot", getRootElement(), function(player)
    local aPoints = (getElementData(player, "aPoints") or 0)
    if aPoints >= config["gerais"]["price.slot"] then 
        setElementData(player, "aPoints", aPoints - config["gerais"]["price.slot"])
        local result_slots = dbPoll(dbQuery(db, "SELECT * FROM slots WHERE user = ?", getAccountName(getPlayerAccount(player))), -1)
        dbExec(db, "UPDATE slots SET slots_liberados = ? WHERE user = ? ", result_slots[1]["slots_liberados"] + 1, getAccountName(getPlayerAccount(player)))
        sendMessage("server", player, "Você comprou +1 slot para sua garagem.", "success")
        messageDiscord("O(A) "..getPlayerName(player).." ("..pullID(player)..") comprou +1 slot para a garagem por ap$"..convertNumber(config["gerais"]["price.slot"])..".", config["logs"]["web-hook"])
    else
        sendMessage("server", player, "Você não possui aPoints suficiente.", "error")
    end
end)

function checkVehicleExpiration()
    local currentTimestamp = getRealTime().timestamp
    local expiredVehicles = dbPoll(dbQuery(db, 'SELECT * FROM carros WHERE seguro < ?', currentTimestamp), -1)

    for _, vehicle in ipairs(expiredVehicles) do
        dbExec(db, 'DELETE FROM carros WHERE model = ? AND user = ?', vehicle.model, vehicle.user)
    end
end

addEvent("MeloSCR:buyCashVehicle", true)
addEventHandler("MeloSCR:buyCashVehicle", getRootElement(), function(player, name, model, money)
    if tonumber(model) then 
        local accountName = getAccountName(getPlayerAccount(player))
        local expirationTimestamp = getRealTime().timestamp + 30 * 24 * 60 * 60

        if not (#dbPoll(dbQuery(db, 'SELECT * FROM carros WHERE user = ? AND model = ?', accountName, tonumber(model)), -1) == 0) then
            sendMessage("server", player, "Você já possui esse veículo na garagem.", "error")
        else
            sendMessage("server", player, "Vá até a garagem mais próxima para pegar seu novo veículo.", "info")

            local dados_veh = {
                vida = 1000,
                tunagem = {},
                color = {255, 255, 255, 255, 255, 255, 255, 255, 255},
                light = {255, 255, 255},
                gasolina = 100,
                malas = {},
                block_sell = true,
                expirationTimestamp = expirationTimestamp
            }

            dbExec(db, 'INSERT INTO carros (user, model, state, seguro, infos, dados, plate) VALUES (?, ?, ?, ?, ?, ?, ?)', accountName, tonumber(model), 'guardado', expirationTimestamp, toJSON({name, money, "moneycoins"}), toJSON({dados_veh}), "")
        end
    end
end)

addEvent("squady.spawnVehicle", true)
addEventHandler("squady.spawnVehicle", getRootElement(), function(model, position)
    if not model or not position then
        return
    end

    local result = dbPoll(dbQuery(db, 'SELECT * FROM carros WHERE model = ? AND user = ?', tonumber(model), getAccountName(getPlayerAccount(source))), -1)

    if #result == 0 or type(result) ~= 'table' then
        return
    end

    if result[1]['state'] == 'spawnado' then
        sendMessage("server", source, "Seu carro já está spawnado.", "error")
    elseif result[1]['state'] == 'recuperar' then
        sendMessage("server", source, "Vá até o detran para recuperar o veículo.", "error")
    elseif tonumber(result[1]["seguro"]) > getRealTime().timestamp then
        local vehicle = createVehicle(tonumber(model), unpack(position))
        setElementCollisionsEnabled(vehicle, false)
        local veiculoDados = fromJSON(result[1]['dados'])
        setDadosVeh(vehicle, veiculoDados[1])
        if tonumber(veiculoDados[1].vida) <= 100 then
            setElementHealth(vehicle, 400)
        else
            setElementHealth(vehicle, tonumber(veiculoDados[1].vida))
        end
        setElementData(vehicle, 'Owner', source)
        setElementData(vehicle, 'Schootz.idVehicle', result[1]['id'])
        setVehiclePlateText(vehicle, result[1]['plate'])
        setElementData(vehicle, 'Schootz.pesoMalas', getMalasByID(model))
        server["contaDono"][vehicle] = getAccountName(getPlayerAccount(source))
        dbExec(db, 'UPDATE carros SET state = ? WHERE model = ? AND user = ?', 'spawnado', tonumber(model), getAccountName(getPlayerAccount(source)))
        server["dados"][vehicle] = {owner = source, account = getAccountName(getPlayerAccount(source)), id = result[1]['id']}
        sendMessage("server", source, "Você spawnou o veículo " .. findNameByModelVehicle(tonumber(model)) .. " com sucesso.", "success")
        triggerClientEvent(source, 'squady.closeConce', source)
        warpPedIntoVehicle(source, vehicle)
        setElementCollisionsEnabled(vehicle, true)
        setVehicleEngineState(vehicle, false)
    else
        sendMessage("server", source, "Seu veículo possui impostos ativos. Vá até o Detran para pagar!", "error")
    end
end)

addEvent("squady.saveVehicle", true)
addEventHandler("squady.saveVehicle", getRootElement(), function(model)
    if model and tonumber(model) then
        local result = dbPoll(dbQuery(db, 'SELECT * FROM carros WHERE model = ? AND user = ?', tonumber(model), getAccountName(getPlayerAccount(source))), - 1)
        if (#result ~= 0) then
            if result[1]['state'] == 'guardado' then
                sendMessage("server", source, "Esse veículo não está spawnado.", "error")
            else
                if not getVehicleCar(source, tonumber(model)) then 
                    sendMessage("server", source, "O veículo não está próximo a você.", "error")
                else
                    local vehicle = getVehicleCar(source, tonumber(model))
                    if isElement(vehicle) then
                        destroyElement(vehicle)
                        sendMessage("server", source, "Você guardou o veículo com sucesso.", "success")
                        triggerClientEvent(source, 'squady.closeConce', source)
                    end
                end
            end
        end
    end
end)

dadosVenda = {}

local lastOfferTime = {}

addEvent("squady.sellVehicle", true)
addEventHandler("squady.sellVehicle", getRootElement(), function(model, action, id, value)
    if model and action then
        local result = dbPoll(dbQuery(db, 'SELECT * FROM carros WHERE model = ? AND user = ?', tonumber(model), getAccountName(getPlayerAccount(source))), -1)

        if result and #result > 0 then
            local currentTime = getTickCount()
            local lastTime = lastOfferTime[source] or 0
            local cooldownTime = 60000

            if currentTime - lastTime >= cooldownTime then
                lastOfferTime[source] = currentTime

                if action == 'loja' then
                    local vehicle = getVehicleCar2(source, tonumber(model))
                    if isElement(vehicle) then
                        destroyElement(vehicle)
                    end

                    local money = fromJSON(result[1]['infos'])
                    local vehiclePrice = tonumber(money[2]) or 0
                    local sellingValue = vehiclePrice * 0.8

                    if money[3] == 'aPoints' then
                        setElementData(source, 'aPoints', (getElementData(source, 'aPoints') or 0) + sellingValue)
                    else
                        givePlayerMoney(source, sellingValue)
                    end

                    local vehicleName = findNameByModelVehicle(model)
                    local currency = (money[3] == "aPoints") and "ap$" or "R$"

                    sendMessage("server", source, 'Você vendeu o veículo ' .. vehicleName .. ' por ' .. currency .. ' ' .. convertNumber(sellingValue) .. ' com sucesso!', 'success')
                    messageDiscord("O(A) " .. getPlayerName(source) .. " (" .. pullID(source) .. ") vendeu o seu veículo " .. vehicleName .. " para Concessionaria por " .. currency .. " " .. convertNumber(sellingValue) .. ".", config["logs"]["web-hook"])
                    dbExec(db, 'DELETE FROM carros WHERE model = ? AND user = ?', tonumber(model), getAccountName(getPlayerAccount(source)))
                    local result = dbPoll(dbQuery(db, 'SELECT * FROM carros WHERE user = ?', getAccountName(getPlayerAccount(source))), -1)
                    triggerClientEvent(source, 'squady.insertGaragem-c', source, result)
                elseif action == "player" and value and tonumber(value) and id and tonumber(id) then
                    if tonumber(value) <= 0 then
                        sendMessage("server", source, 'Insira um valor válido.', 'error')
                    else
                        local receiver = getPlayerByID(id)

                        if receiver and isElement(receiver) then
                            local result = dbPoll(dbQuery(db, 'SELECT * FROM carros WHERE user = ? AND model = ?', getAccountName(getPlayerAccount(receiver)), tonumber(model)), -1)

                            if #result == 0 then
                                if getPlayerMoney(receiver) >= tonumber(value) then
                                    triggerClientEvent(receiver, 'squady.openDrawOffer', receiver, getPlayerName(source), findNameByModelVehicle(tonumber(model)), tonumber(value))
                                    dadosVenda[receiver] = { vendedor = source, modelVeh = model, valor = value }
                                    sendMessage("server", source, 'Oferta enviada para o jogador.', 'success')
                                else
                                    sendMessage("server", source, 'O jogador não possui dinheiro para comprar o veículo', 'error')
                                end
                            else
                                sendMessage("server", source, 'O jogador já possui este modelo de veículo.', 'error')
                            end
                        else
                            sendMessage("server", source, 'O jogador não está online ou não existe.', 'error')
                        end
                    end
                else
                    local remainingTime = math.ceil((cooldownTime - (currentTime - lastTime)) / 1000)
                    sendMessage("server", source, 'Aguarde ' .. remainingTime .. ' segundos antes de enviar outra oferta.', 'error')
                end
            else
                local remainingTime = math.ceil((cooldownTime - (currentTime - lastTime)) / 1000)
                sendMessage("server", source, 'Aguarde ' .. remainingTime .. ' segundos antes de enviar outra oferta.', 'error')
            end
        else
            sendMessage("server", source, 'Veículo não encontrado ou pertence a outro jogador.', 'error')
        end
    end
end)

--addEvent("squady.sellVehicle", true)
--addEventHandler("squady.sellVehicle", getRootElement(), function(model, action, id, value)
--    if model and action then
--        local result = dbPoll(dbQuery(db, 'SELECT * FROM carros WHERE model = ? AND user = ?', tonumber(model), getAccountName(getPlayerAccount(source))), -1)
--        
--        if result and #result ~= 0 then
--            if (action == 'loja') then
--                local vehicle = getVehicleCar2(source, tonumber(model))
--                if isElement(vehicle) then
--                    destroyElement(vehicle)
--                end
--
--                local money = fromJSON(result[1]['infos'])
--                local vehiclePrice = tonumber(money[2]) or 0
--                local sellingValue = vehiclePrice * 0.8
--
--                if money[3] == 'aPoints' then
--                    setElementData(source, 'aPoints', (getElementData(source, 'aPoints') or 0) + sellingValue)
--                else
--                    givePlayerMoney(source, sellingValue)
--                end
--
--                vehicle_name = findNameByModelVehicle(model)
--                if money[3] == "aPoints" then 
--                    a = "ap$"
--                else
--                    a = "R$"
--                end
--                
--                sendMessage("server", source, 'Você vendeu o veículo '..vehicle_name..' por '..a..' ' .. convertNumber(sellingValue) .. ' com sucesso!', 'success')
--                messageDiscord("O(A) "..getPlayerName(source).." ("..pullID(source)..") vendeu o seu veiculo "..vehicle_name.." para Concessionaria por "..a.." "..convertNumber(sellingValue)..".", config["logs"]["web-hook"])
--                dbExec(db, 'DELETE FROM carros WHERE model = ? AND user = ?', tonumber(model), getAccountName(getPlayerAccount(source)))
--                local result = dbPoll(dbQuery(db, 'SELECT * FROM carros WHERE user = ?', getAccountName(getPlayerAccount(source))), -1)
--                triggerClientEvent(source, 'squady.insertGaragem-c', source, result)
--            elseif (action == "player") and value and tonumber(value) and id and tonumber(id) then
--                if tonumber(value) <= 0 then
--                    sendMessage("server", source, 'Insira um valor válido.', 'error')
--                else
--                    local receiver = getPlayerByID(tonumber(id))
--                    
--                    if isElement(receiver) then
--                        local result = dbPoll(dbQuery(db, 'SELECT * FROM carros WHERE user = ? AND model = ?', getAccountName(getPlayerAccount(receiver)), tonumber(model)), -1)
--
--                        if #result == 0 then
--                            if getPlayerMoney(receiver) >= tonumber(value) then
--                                triggerClientEvent(receiver, 'squady.openDrawOffer', receiver, getPlayerName(source), findNameByModelVehicle(tonumber(model)), tonumber(value))
--                                dadosVenda[receiver] = { vendedor = source, modelVeh = model, valor = value }
--                                sendMessage("server", source, 'Oferta enviada para o jogador.', 'success')
--                            else
--                                sendMessage("server", source, 'O jogador não possui dinheiro para comprar o veículo', 'error')
--                            end
--                        else
--                            sendMessage("server", source, 'O jogador já possui este modelo de veículo.', 'error')
--                        end
--                    else
--                        sendMessage("server", source, 'Este passaporte não está na cidade.', 'error')
--                    end
--                end
--            end
--        else
--            sendMessage("server", source, 'Veículo não encontrado ou pertence a outro jogador.', 'error')
--        end
--    end
--end)

addEvent("squady.payImpost", true)
addEventHandler("squady.payImpost", getRootElement(), function(thePlayer, model)
    if thePlayer and isElement(thePlayer) and model and tonumber(model) then 
        local select = dbQuery(db, "SELECT * FROM carros WHERE user=? AND model=?", getAccountName(getPlayerAccount(thePlayer)), model)
        local sql = dbPoll(select, -1)
        if #sql > 0 and getRealTime().timestamp > tonumber(sql[1]["seguro"]) then 
            local newExpirationTime = getRealTime(getRealTime().timestamp + 604800)
            local formattedDateTime = string.format("%02d/%02d/%d %02d:%02d:%02d", newExpirationTime.monthday, newExpirationTime.month + 1, newExpirationTime.year + 1900, newExpirationTime.hour, newExpirationTime.minute, newExpirationTime.second)

            local valor = (findPriceByModelVehicle(model)/100)*4
            if getPlayerMoney(thePlayer) >= valor then 
                takePlayerMoney(thePlayer, valor)
                sendMessage("server", source, "Você pagou os impostos desse veículo. A nova data de vencimento é " .. formattedDateTime, "success")
                dbExec(db, "UPDATE carros SET seguro=? WHERE user=? AND model=?", (getRealTime().timestamp + 604800), getAccountName(getPlayerAccount(thePlayer)), model)
            else 
                sendMessage("server", source, "Você não possui dinheiro suficiente para pagar os impostos desse veículo.", "error")
            end 
        else 
            local dateTime = getRealTime(tonumber(sql[1]["seguro"]))
            local formattedDateTime = string.format("%02d/%02d/%d %02d:%02d:%02d", dateTime.monthday, dateTime.month + 1, dateTime.year + 1900, dateTime.hour, dateTime.minute, dateTime.second)

            sendMessage("server", source, "Esse veículo não tem impostos ativos.", "error")
            sendMessage("server", source, "A data de vencimento é " .. formattedDateTime, "info")
        end
    end
end)

addEvent("squady.recoverVehicle", true)
addEventHandler("squady.recoverVehicle", getRootElement(), function(thePlayer, model)
    if thePlayer and isElement(thePlayer) and model and tonumber(model) then
        local result = dbPoll(dbQuery(db, 'SELECT * FROM carros WHERE user = ? AND model = ?', getAccountName(getPlayerAccount(thePlayer)), model), -1)
        if (#result ~= 0) then
            if result[1]['state'] ~= 'recuperar' then
                sendMessage("server", source, "Esse veículo não precisa ser recuperado.", "error")
            else
                local valor = (findPriceByModelVehicle(model)/100)*4
                if getPlayerMoney(thePlayer) < tonumber(valor) then
                    sendMessage("server", source, "Você não tem dinheiro suficiente para recuperar o veículo.", "error")
                else
                    takePlayerMoney(thePlayer, valor)
                    sendMessage("server", source, "Você recuperou o veículo com sucesso.", "success")
                    dbExec(db, 'UPDATE carros SET state=? WHERE user=? AND model=?', 'guardado', getAccountName(getPlayerAccount(thePlayer)), model)
                end
            end
        end
    end 
end)

addEvent("squady.lockVehicle", true)
addEventHandler("squady.lockVehicle", getRootElement(), function(player, model)
    for _, vehicle in ipairs(getElementsByType("vehicle")) do
        local owner = getElementData(vehicle, "Owner")
        local vehicleModel = getElementModel(vehicle)

        if owner and owner == player and vehicleModel == tonumber(model) then
            setVehicleLocked(vehicle, true)
            sendMessage("server", player, "Veículo trancado com sucesso.", "success")
            break
        end
    end
end)

addEvent("squady.responseOffer", true)
addEventHandler("squady.responseOffer", getRootElement(), function(action)
    if dadosVenda[source] and dadosVenda[source].vendedor and isElement(dadosVenda[source].vendedor) then
        if (action == 'aceitar') then
            local result = dbPoll(dbQuery(db, 'SELECT * FROM carros WHERE user = ? AND model = ?', getAccountName(getPlayerAccount(dadosVenda[source].vendedor)), dadosVenda[source].modelVeh), - 1)
            if (#result ~= 0) then
                if getPlayerMoney(source) >= tonumber(dadosVenda[source].valor) then
                    local vehicle = getVehicleCar2(dadosVenda[source].vendedor, dadosVenda[source].modelVeh)
                    if isElement(vehicle) then
                        server["dados"][vehicle] = {owner = source, account = getAccountName(getPlayerAccount(source)), id = result[1]['id']}
                    end
                    sendMessage("server", source, "Você aceitou a oferta do jogador.", "success")
                    sendMessage("server", dadosVenda[source].vendedor, "O jogador aceitou sua oferta.", "info")
                    takePlayerMoney(source, tonumber(dadosVenda[source].valor))
                    givePlayerMoney(dadosVenda[source].vendedor, tonumber(dadosVenda[source].valor))
                    dbExec(db, 'UPDATE carros SET user = ? WHERE user = ? AND model = ?', getAccountName(getPlayerAccount(source)), getAccountName(getPlayerAccount(dadosVenda[source].vendedor)), dadosVenda[source].modelVeh)
                    triggerClientEvent(source, 'squady.insertGaragem-c', source, result)
                    messageDiscord("O(A) "..getPlayerName(dadosVenda[source].vendedor).." ("..pullID(dadosVenda[source].vendedor)..") vendeu o seu veículo "..findNameByModelVehicle(dadosVenda[source].modelVeh).." para "..getPlayerName(source).." ("..pullID(source)..") por R$ "..(dadosVenda[source].valor)..".", config["logs"]["web-hook"])
                else
                    sendMessage("server", source, "Você não possui dinheiro suficiente.", "error")
                end
            else
                sendMessage("server", source, "O veículo não está mais disponível.", "error")
            end
        else
            sendMessage("server", source, "Você recusou a oferta do jogador.", "info")
            sendMessage("server", dadosVenda[source].vendedor, "O jogador recusou a oferta.", "error")
        end
    else
        sendMessage("server", source, "O vendedor está offline", "error")
    end
end)

addEvent("squady.insertEstoque-s", true)
addEventHandler("squady.insertEstoque-s", getRootElement(), function()
    local data = dbPoll(dbQuery(db, 'SELECT * FROM estoque'), - 1)
    triggerClientEvent(source, 'squady.insertEstoque-c', source, data)
end)

addEvent("squady.insertGaragem-s", true)
addEventHandler("squady.insertGaragem-s", getRootElement(), function()
    local result = dbPoll(dbQuery(db, 'SELECT * FROM carros WHERE user = ?', getAccountName(getPlayerAccount(source))), -1)
    local result_slots = dbPoll(dbQuery(db, "SELECT * FROM slots WHERE user = ?", getAccountName(getPlayerAccount(source))), -1)
    triggerClientEvent(source, 'squady.insertGaragem-c', source, result, #result_slots > 0 and result_slots[1]["slots_liberados"] or 1)
end)

addEvent("squady.insertDetran-s", true)
addEventHandler("squady.insertDetran-s", getRootElement(), function()
    local result = dbPoll(dbQuery(db, "SELECT * FROM carros WHERE user = ?", getAccountName(getPlayerAccount(source))), -1)
    triggerClientEvent(source, "squady.insertDetran-c", source, result)
end)

setTimer(function()
    for _, vehicle in ipairs(getElementsByType('vehicle')) do
        if vehicle and isElement(vehicle) and getElementType(vehicle) == "vehicle" and isElementInWater(vehicle) and getVehicleType(vehicle) ~= "Boat" and server["dados"][vehicle] then
            local result = dbPoll(dbQuery(db, 'SELECT * FROM carros WHERE user = ? AND model = ?', server["dados"][vehicle].account, getElementModel(vehicle)), - 1)
            if (#result ~= 0) then
                dbExec(db, 'UPDATE carros SET state = ? WHERE user = ? AND model = ?', 'recuperar', server["dados"][vehicle].account, getElementModel(vehicle))
                destroyElement(vehicle)
            end
        end
    end
end, 60000, 0)

addCommandHandler("guardarcarros", function(player)
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup("Console")) then
        dbExec(db, "UPDATE carros SET state = ?", "guardado")
        sendMessage("server", player, "Todos veiculos do banco de dados foram definidos como guardado.", "success")
    end
end)

addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), function()
    db = dbConnect("sqlite", "assets/database/database.sqlite")
    for i, v in ipairs(getElementsByType("vehicle")) do 
        if server["dados"][v] then 
            saveDadosVeh(v)
            local result = dbPoll(dbQuery(db, 'SELECT * FROM carros WHERE model = ? AND user = ?', getElementModel(v), server["dados"][v].account), - 1)
            if (#result ~= 0) and (type(result) == 'table') then
                if result[1]['state'] == 'spawnado' then
                    dbExec(db, 'UPDATE carros SET state = ? WHERE model = ? AND user = ?', 'guardado', getElementModel(v), server["dados"][v].account)
                end
            end
        end
    end
end)

-- // functions uteis

function getVehicleDataFromPlate(plate)
    return dbPoll(dbQuery(db, 'SELECT * FROM carros WHERE plate = ?', plate), - 1)
end

function findSpawnedVehicleByModel(model)
    local query = dbQuery(db, "SELECT * FROM carros WHERE model = ? AND state = ?", model, "spawnado")
    local result = dbPoll(query, -1)

    if result and #result > 0 then
        return result[1]
    else
        return nil
    end
end

function setVehicleState(identity, state)
    if (identity) and (state) then
        local result = dbPoll(dbQuery(db, 'SELECT * FROM carros WHERE id = ?', identity), - 1)
        if (#result ~= 0) then
            if result[1]['id'] == identity then
                dbExec(db, 'UPDATE carros SET state = ? WHERE id = ?', state, identity)
                return true
            end
        end
    end
    return false
end

function exploseVehicle()
    if (getElementType(source) == 'vehicle') then
        if server["dados"][source] then
            saveDadosVeh(source)
            local result = dbPoll(dbQuery(db, 'SELECT * FROM carros WHERE model = ? AND user = ?', getElementModel(source), server["dados"][source].account), - 1)
            if (#result ~= 0) and (type(result) == 'table') then
                if result[1]['state'] == 'spawnado' then
                    dbExec(db, 'UPDATE carros SET state = ? WHERE model = ? AND user = ?', 'guardado', getElementModel(source), server["dados"][source].account)
                end
            end
        end
    end
end
addEventHandler('onVehicleExplode', root, exploseVehicle)

function elementDestroy()
    if (getElementType(source) == 'vehicle') then
        if server["dados"][source] then
            saveDadosVeh(source)
            local result = dbPoll(dbQuery(db, 'SELECT * FROM carros WHERE model = ? AND user = ?', getElementModel(source), server["dados"][source].account), - 1)
            if (#result ~= 0) and (type(result) == 'table') then
                if result[1]['state'] == 'spawnado' then
                    dbExec(db, 'UPDATE carros SET state = ? WHERE model = ? AND user = ?', 'guardado', getElementModel(source), server["dados"][source].account)
                end
            end
        end
    
        for i=0, 3 do
            local player = getVehicleOccupant(source, i)
            if (player and isElement(player) and getElementType(player) == 'player') then
                if getElementData(player, 'v.cinto') then
                    removeElementData(player, 'v.cinto')
                end
            end
        end
    end
end
addEventHandler('onElementDestroy', root, elementDestroy)

addEvent('onPlayerRequestCellphoneVehicles', true)
addEventHandler('onPlayerRequestCellphoneVehicles', root, 
    function(player)
        local vehiclesTable = {}
        local data = dbPoll(dbQuery(db, 'Select * from carros where user = ?', getAccountName(getPlayerAccount(player))), - 1)
        for i, v in ipairs(data) do 
            if (v['state'] == 'spawnado') then 
                table.insert(vehiclesTable, {findNameByModelVehicle(v['model']), v['model']})
            end
        end
        triggerClientEvent(player, 'onClientReceiveCellphoneVehicles', player, vehiclesTable)
    end 
)

addEvent('onPlayerTrackVehicle', true)
addEventHandler('onPlayerTrackVehicle', root, 
    function(player, model)
        for i, v in ipairs(getElementsByType('vehicle')) do 
            if (tonumber(getElementModel(v)) == tonumber(model)) then 
                local vehicleOwner = server["contaDono"][v]
                
                if vehicleOwner and vehicleOwner == getAccountName(getPlayerAccount(player)) then 
                    if isElement(server["tracker"][player]) then 
                        destroyElement(server["tracker"][player])
                    end 

                    local blip = createBlipAttachedTo(v, 41, _, _, _, _, _, _, _, player)
                    server["tracker"][player] = blip

                    if blip then
                        sendMessage("server", source, 'Veículo localizado com sucesso.', 'success')
                        
                        local timer = setTimer(function()
                            if isElement(player) and isElement(v) then
                                local playerPos = {getElementPosition(player)}
                                local vehiclePos = {getElementPosition(v)}
                                
                                local distance = getDistanceBetweenPoints3D(playerPos[1], playerPos[2], playerPos[3], vehiclePos[1], vehiclePos[2], vehiclePos[3])
                                
                                if distance < 3 then
                                    if isElement(server["tracker"][player]) then
                                        destroyElement(server["tracker"][player])
                                    end
                                    if isTimer(timer) then
                                        killTimer(timer)
                                    end
                                end
                            end
                        end, 1000, 0)
                    else
                        sendMessage("server", source, 'Erro ao localizar veículo.', 'error')
                    end
                    break
                end
            end
        end
    end 
)

function descEstoque(model, type)
    if type == 'Dinheiro' then            
        local estoques = dbPoll(dbQuery(db, 'SELECT * FROM estoque WHERE model = ?', model), - 1)
        if tonumber(estoques[1]['value']) > 0 then
            dbExec(db, 'UPDATE estoque SET value = ? WHERE model = ?', (estoques[1]['value'] - 1), model)
            return true
        else
            return false
        end
    end
    return true
end

function saveDadosVeh (veh)
    if isElement(veh) and (getElementType(veh) == 'vehicle') then
        local result = (#dbPoll(dbQuery(db, 'SELECT * FROM carros WHERE model = ? AND user = ?', getElementModel(veh), server["dados"][veh].account), - 1) ~= 0)
        if result then
            local vehicle = getElementData(veh, 'Itens') or {}
            dados_veh = { vida = getElementHealth(veh), tunagem = getVehicleUpgrades(veh), color = {getVehicleColor(veh, true)}, light = {getVehicleHeadLightColor(veh)}, gasolina = (getElementData(veh, 'JOAO.fuel') or 100), malas = vehicle, position = {getElementPosition(veh)}, rotation = {getElementRotation(veh)}, engine = (getElementData(veh, 'tuning.engine') or 0), neon = (getElementData(veh, "JOAO.Neon") or nil), lsddoor = (getElementData(veh, "JOAO.Lsddoor") or nil), blindagem_pneu = (getElementData(veh, "JOAO.Armortires") or nil), horns = (getElementData(veh, "JOAO.Horns") or nil), engines = (getElementData(veh, "JOAO.Engines") or nil), traction = (getElementData(veh, "JOAO.Traction") or nil), weight = (getElementData(veh, "JOAO.Weight") or nil), direction_lock = (getElementData(veh, "JOAO.Directionlock") or nil), hydraulics = (getElementData(veh, "JOAO.Hydraulics") or nil), sizewhells = (getElementData(veh, "JOAO.SizeWheels") or nil) }
            dbExec(db, 'UPDATE carros SET dados = ? WHERE model = ? AND user = ?', toJSON({dados_veh}), getElementModel(veh), server["dados"][veh].account)
        end
    end
end

addEventHandler('onPlayerLogin', root,
    function ()
        for i,v in ipairs(getElementsByType("vehicle")) do 
            if server["contaDono"][v] and server["contaDono"][v] == getAccountName(getPlayerAccount(source)) then 
                setElementData(v, "Owner", source)
                server["dados"][v].owner = source 
            end 
        end 
    end
)

function getVehicleCar(player, model)
    if (model) then
        local posv = {getElementPosition(player)}
        for i, v in ipairs(getElementsByType('vehicle')) do
            if (getElementModel(v) == tonumber(model)) then
                local pos = {getElementPosition(v)}
                if (getDistanceBetweenPoints3D(posv[1], posv[2], posv[3], pos[1], pos[2], pos[3]) < 10) then
                    if (server["dados"][v]) and (server["dados"][v].owner == player) then
                        return v
                    end
                end
            end
        end
    end
    return false
end

function getVehicleCar2(player, model)
    if (model) then
        local posv = {getElementPosition(player)}
        for i, v in ipairs(getElementsByType('vehicle')) do
            if (getElementModel(v) == tonumber(model)) then
                if (server["dados"][v]) and (server["dados"][v].owner == player) then
                    return v
                end
            end
        end
    end
    return false
end

addEventHandler('onPlayerQuit', root, 
    function()
        if (isElement(server["tracker"][source])) then 
            destroyElement(server["tracker"][source])
        end 
    end
)