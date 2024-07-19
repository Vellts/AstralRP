_getPlayerName = getPlayerName;
function getPlayerName(element)
    return _getPlayerName(element):gsub("#%x%x%x%x%x%x", "") or _getPlayerName(element);
end

function isPlayerInACL(player)
    for i, v in ipairs(config["gerais"]["permissions"]) do
        if aclGetGroup(v) and isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup(v)) then
            return true
        end
    end
    return false
end

function getPlayerByID(id)
    if tonumber(id) then
        for _, player in ipairs(getElementsByType('player')) do
            if getElementData(player, 'ID') and (getElementData(player, 'ID') == tonumber(id)) then
                return player
            end
        end
    end
    return false
end

function pullID(player)
    return (getElementData(player, "ID") or 0)
end

function pullAccount(player)
    return getAccountName(getPlayerAccount(player))
end

function convertNumber(number)   
    local formatted = number   
    while true do       
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')     
        if ( k==0 ) then       
            break   
        end   
    end   
    return formatted 
end

function joinVehicle(player, seat)
    if seat == 0 then
        outputChatBox('#49a6fc[BAR] #FFFFFFClique no veículo para abrir o porta-malas.', player, 255, 255, 255, true)
        outputChatBox('#49a6fc[BAR] #FFFFFFAperte \'L\' para ligar o farol.', player, 255, 255, 255, true)
        outputChatBox('#49a6fc[BAR] #FFFFFFAperte \'K\' para trancar o veiculo.', player, 255, 255, 255, true)
        outputChatBox('#49a6fc[BAR] #FFFFFFPressione a tecla \'J\' para ligar o veículo.', player, 255, 255, 255, true)
    end
end
addEventHandler('onVehicleEnter', root, joinVehicle)

function setDadosVeh (veh, table, painel)
    if isElement(veh) then
        if table.sizewhells then 
            setElementData(veh, "JOAO.SizeWhells", table.sizewhells)
        end 
        if table.weight then 
            setElementData(veh, "JOAO.Weight", table.weight)
        end 
        if table.engines and type(table.engines) == "table" then 
            setElementData(veh, "JOAO.Engines", table.engines)
        end 
        if table.traction then 
            setElementData(veh, "JOAO.Traction", table.traction)
        end 
        if table.hydraulics then 
            setElementData(veh, "JOAO.Hydraulics", table.hydraulics)
        end 
        if table.direction_lock then 
            setElementData(veh, "JOAO.Directionlock", table.direction_lock)
        end 
        if table.neon then 
            setElementData(veh, "JOAO.Neon", table.neon)
        end 
        if table.lsddoor then 
            setElementData(veh, "JOAO.Lsddoor", table.lsddoor)
        end 
        if table.blindagem_pneu then 
            setElementData(veh, "JOAO.Armortires", table.blindagem_pneu)
        end 
        if table.horns then 
            setElementData(veh, "JOAO.Horns", table.horns)
        end 
        setVehicleColor(veh, unpack(table.color))
        setVehicleHeadLightColor(veh, unpack(table.light))
        setElementData(veh, 'JOAO.fuel', tonumber(table.gasolina))
        setElementData(veh, 'tuning.engine', tonumber(table.engine))
        for _, upgrades in ipairs(table.tunagem) do
            addVehicleUpgrade(veh, tonumber(upgrades))
        end
        setElementData(veh, 'Itens', table.malas)
        if painel then
            if (table.position and type(table.position) == 'table') then
                setElementPosition(veh, unpack(table.position))
            end
            if (table.rotation and type(table.rotation) == 'table') then
                setElementRotation(veh, unpack(table.rotation))
            end
        end

    end
end

function isPlayerMoney(player, type)
    if type == 'Dinheiro' then
        return getPlayerMoney(player)
    else
        return tonumber(getElementData(player, 'aPoints') or 0)
    end
end

function getPlayerVIP(player) 
    for _, acl in ipairs(config['vips']) do 
        if aclGetGroup(acl) and isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(player)), aclGetGroup(acl)) then 
            return acl 
        end
    end
    return false
end

function findNameByModelVehicle(model)
    for category, vehicles in pairs(config['veiculos']) do
        for _, vehicleData in ipairs(vehicles) do
            if vehicleData[2] == model then
                return vehicleData[1]
            end
        end
    end
    return ''
end

function findPriceByModelVehicle(model)
    for category, vehicles in pairs(config['veiculos']) do
        for _, vehicleData in ipairs(vehicles) do
            if vehicleData[2] == model then
                return vehicleData[3]
            end
        end
    end
    return ''
end

function getMalasByID(model)
    for category, vehicles in pairs(config['veiculos']) do
        for _, v in ipairs(vehicles) do
            if v[2] == model then
                return v[5]
            end
        end
    end
    return 150
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

function descPlayerMoney(player, type, amount)
    if type == 'Dinheiro' then
        return takePlayerMoney(player, tonumber(amount))
    else
        return setElementData(player, 'aPoints', (getElementData(player, 'aPoints') or 0) - tonumber(amount))
    end
end

function getCarProx(player)
    local posv = {getElementPosition(player)}
    for i, v in ipairs(getElementsByType('vehicle')) do
        local pos = {getElementPosition(v)}
        if (getDistanceBetweenPoints3D(posv[1], posv[2], posv[3], pos[1], pos[2], pos[3]) < 5) then
            if ((getElementData(v, 'Schootz.idVehicle') or false)) then
                return v
            end
        end
    end
    return false
end

function getVehiclePrice(model)
    if (model) then
        for category, vehicles in pairs(config['veiculos']) do
            for _, v in ipairs(vehicles) do
                if v[2] == model then
                    return v[3]
                end
            end
        end
        return 0
    end
end

function isPlayerVip(player) 
    for _, acl in ipairs(config['vips']) do 
        if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(player)), aclGetGroup(acl)) then 
            return true 
        end
    end
    return false
end

function createVehiclePlate()
    local plate = ''
    local letters = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'R', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'}
    local nums = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'}
    for i = 1, 7 do
        if i <= 3 or i == 5 then 
            plate = plate..letters[math.random(1, #letters)]
        else
            plate = plate..nums[math.random(1, #nums)]
        end
    end
    return plate
end

function messageDiscord(message, theWebhook)
	sendOptions = {
		queueName = "dcq",
		connectionAttempts = 3,
		connectTimeout = 5000,
		formFields = {
		  content="```"..message.."```"
		},
	}   
	fetchRemote(theWebhook, sendOptions, function()end)
end