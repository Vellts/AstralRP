marker = {}
tuningOpen = {}
markerOpen = {}
local playerVehicle = {}

addEventHandler("onResourceStart", resourceRoot,
function()
    if config["Mensagem Start"] then
        outputDebugString("["..getResourceName(getThisResource()).."] Startado com sucesso, qualquer bug contacte zJoaoFtw_#5562!")
    end
    for i, v in ipairs(config["Tuning's"]) do
        marker[i] = createMarker(v.Pos, "cylinder", 2.2, 0, 0, 0, 90)
        addEventHandler("onMarkerHit", marker[i],
        function(player, dim)
            if player and isElement(player) and getElementType(player) == "player" and dim then
                if aclGetGroup(v.ACL) and isObjectInACLGroup("user."..puxarConta(player), aclGetGroup(v.ACL)) then
                    if getElementAlpha(marker[i]) == 0 then return end
                    local vehicle = getPedOccupiedVehicle(player)
                    if not isElement(vehicle) then
                        notifyS(player, "Você não está dentro de um carro!", "error")
                        return
                    end
                    local model = getElementModel(vehicle)
                    local vehicleVerify = verifyVehicle(player, vehicle)
                    if not vehicleVerify then return notifyS(player, "Veículo não configurado nas handlings!", "error") end
                    if config["Vehicles blocked"][model] then notifyS(player, "Esse veículo é bloqueado!", "error") return end
                    setElementPosition(vehicle, v.Pos.x, v.Pos.y, v.Pos.z+0.5)
                    setElementRotation(vehicle, v.Rot)
                    setElementFrozen(vehicle, true)
                    setElementAlpha(marker[i], 0)
                    tuningOpen[player] = vehicle
                    markerOpen[vehicle] = marker[i]
                    triggerClientEvent(player, "JOAO.openTuning", player, vehicle)
                end
            end
        end)
    end
end)

addEvent("JOAO.openHornS", true)
addEventHandler("JOAO.openHornS", root,
function(player, keyState)
    local vehicle = getPedOccupiedVehicle(player)
    if not vehicle then return end
    local elementData = (getElementData(vehicle, "JOAO.Horns") or false)
    if elementData and elementData.tuningTable then
        local pos = {getElementPosition(player)}
        triggerClientEvent(root, "JOAO.openHorn", player, vehicle, keyState, elementData.tuningTable, pos)
    end
end)

addEventHandler("onPlayerQuit", root,
function()
    local vehicle = getPedOccupiedVehicle(source)
    if vehicle then
        setElementFrozen(vehicle, false)
        if markerOpen[vehicle] then
            setElementFrozen(vehicle, false)
            setElementAlpha(markerOpen[vehicle], 90)
        end
    end
end)

addEventHandler("onElementDestroy", root,
function()
    if (getElementType(source) == "vehicle") then
        if markerOpen[source] then
            setElementAlpha(markerOpen[source], 90)
        end
    end
end)

addEventHandler("onPlayerWasted", root,
function()
    if playerVehicle[source] and isElement(playerVehicle[source]) then
        if markerOpen[playerVehicle[source]] then
            setElementFrozen(playerVehicle[source], false)
            setElementAlpha(markerOpen[playerVehicle[source]], 90)
        end
    end
end)

addEventHandler("onVehicleEnter", root,
function(player)
    playerVehicle[player] = source
end)

addEventHandler("onVehicleExit", root,
function(player)
    playerVehicle[player] = nil
end)

buyUpgrades = {}

addEvent("JOAO.buyTuningCar", true)
addEventHandler("JOAO.buyTuningCar", root,
function(player, tableUpgrade, window, indxTuning)
    if tableUpgrade and window then
        local vehicle = getPedOccupiedVehicle(player)
        if not vehicle then return end
        local model = getElementModel(vehicle)
        local currentCoin = (getElementData(player, "JOAO.points") or 99999999999)
        if not buyUpgrades[vehicle] then buyUpgrades[vehicle] = {} end
        if tableUpgrade.Price then
            local elementTuning = (getElementData(vehicle, "JOAO."..upperCase(window)) or false)
            if elementTuning and elementTuning.indexTuning == indxTuning then
                notifyS(player, "Você já tem esse upgrade!", "error")
                return
            end
            -- if tableUpgrade.typeCoin == "money" then
            --     if getPlayerMoney(player) < tableUpgrade.Price then
            --         notifyS(player, "Você não tem dinheiro suficiente!", "error")
            --         return
            --     end
            -- else
            --     if currentCoin < tableUpgrade.Price then
            --         notifyS(player, "Você não tem pontos suficiente!", "error")
            --         return
            --     end
            -- end
            if window == "tires" or window == "engines" or window == "turbos" or window == "nitros" or window == "weight" or window == "bumperFront" or window == "bumperRear" or window == "roof" or window == "dischargepipe" or window == "spoiler" or window == "wheels" or window == "skirts" or window == "hydraulics" or window == "neon" or window == "sizewheels" or window == "offroadmode" or window == "traction" or window == "directionlock" or window == "armortires" or window == "horns" or window == "lsddoor" then
                if tableUpgrade.Type == "handling" then
                    if window == "sizewheels" then
                        setVehicleHandlingFlags(vehicle, {3, 4}, tableUpgrade.TypeWhell)
                        setElementData(vehicle, "JOAO."..upperCase(window), {indexTuning = indxTuning, tuningTable = tableUpgrade.TypeWhell})
                    elseif window == "offroadmode" then
                        setVehicleHandlingFlags(vehicle, 6, tableUpgrade.TypeOffroad)
                        setElementData(vehicle, "JOAO."..upperCase(window), {indexTuning = indxTuning, tuningTable = tableUpgrade.TypeOffroad})
                    else
                        for i, v in pairs(tableUpgrade.Tunings) do
                            if not config["Handlings"] then return end
                            if not config["Handlings"][model] then return end
                            if not config["Handlings"][model][i] then return end
                            local data = config["Handlings"][model][i]
                            if i == "suspensionLowerLimit" then
                            else
                                if v and data then 
                                    setVehicleHandling(vehicle, i, data, false)
                                    if type(data) == "string" then
                                        setVehicleHandling(vehicle, i, v, false)
                                    else
                                        setVehicleHandling(vehicle, i, data + v, false)
                                    end
                                end
                            end
                        end
                        setElementData(vehicle, "JOAO."..upperCase(window), {indexTuning = indxTuning, tuningTable = tableUpgrade.Tunings})
                    end
                elseif tableUpgrade.Type == "custom" then
                    if tableUpgrade.typeTuning == "turbos" then
                        if tableUpgrade.tuningManage == "on" then
                            if (getElementData(vehicle, "JOAO.noiseVeh") or false) then
                                notifyS(player, "Você já possui essa tuning!", "error")
                                return
                            else
                                setElementData(vehicle, "JOAO.noiseVeh", true)
                            end
                            setElementData(vehicle, "JOAO."..upperCase(window), {indexTuning = indxTuning, tuningTable = "on"})
                        elseif tableUpgrade.tuningManage == "off" then
                            if (getElementData(vehicle, "JOAO.noiseVeh") or false) then
                                setElementData(vehicle, "JOAO.noiseVeh", false)
                            else
                                notifyS(player, "Você não possui essa tuning!", "error")
                                return
                            end
                            setElementData(vehicle, "JOAO."..upperCase(window), false)
                        end
                    elseif tableUpgrade.typeTuning == "neon" then
                        setElementData(vehicle, "vehicle.neon.active", true)
                        triggerEvent("tuning->Neon", root, vehicle, tableUpgrade.Value)
                        setElementData(vehicle, "JOAO."..upperCase(window), {indexTuning = indxTuning, tuningTable = tableUpgrade.Value})
                        buyUpgrades[vehicle][tableUpgrade.typeTuning] = true
                    elseif tableUpgrade.typeTuning == "horns" then
                        setElementData(vehicle, "JOAO."..upperCase(window), {indexTuning = indxTuning, tuningTable = tableUpgrade.Value})
                    elseif tableUpgrade.typeTuning == "armortires" then
                        setElementData(vehicle, "JOAO."..upperCase(window), {indexTuning = indxTuning, tuningTable = tableUpgrade.Value})
                    elseif tableUpgrade.typeTuning == "lsddoor" then
                        iprint(upperCase(window))
                        setElementData(vehicle, "JOAO."..upperCase(window), {indexTuning = indxTuning, tuningTable = tableUpgrade.Value})
                        buyUpgrades[vehicle][tableUpgrade.typeTuning] = true
                    end
                elseif tableUpgrade.Type == "upgrade" then
                    if window == "nitros" then
                        addVehicleUpgrade(vehicle, 1010) 
                    else
                        for i, v in ipairs(tableUpgrade.Value) do
                            local inUpgrade = verifyUpgrade(vehicle, v)
                            if inUpgrade then
                                notifyS(player, "Você já possui esse upgrade!", "error")
                                return
                            end
                            addVehicleUpgrade(vehicle, v) 
                        end
                    end
                    if window == "nitros" then
                        setElementData(vehicle, "tuning.nitroLevel", tableUpgrade.Quantity)
                        triggerClientEvent(player, "JOAO.refreshVehicleNitroLevel", player, vehicle, tableUpgrade.Quantity)
                    end
                    if tableUpgrade.Quantity then
                        setElementData(vehicle, "JOAO."..upperCase(window), {indexTuning = indxTuning, tuningTable = tableUpgrade.Value, quantity = tableUpgrade.Quantity})
                    else
                        setElementData(vehicle, "JOAO."..upperCase(window), {indexTuning = indxTuning, tuningTable = tableUpgrade.Value})
                    end
                end
                if tableUpgrade.typeCoin == "money" then
                    takePlayerMoney(player, tableUpgrade.Price)
                else
                    setElementData(player, "JOAO.points", currentCoin-tableUpgrade.Price)
                end
                notifyS(player, "Você comprou a tunagem com sucesso!", "success")
            end
        else
            if window == "tires" or window == "engines" or window == "turbos" or window == "nitros" or window == "weight" or window == "bumperFront" or window == "bumperRear" or window == "roof" or window == "dischargepipe" or window == "spoiler" or window == "wheels" or window == "skirts" or window == "hydraulics" or window == "neon" or window == "sizewheels" or window == "offroadmode" or window == "traction" or window == "directionlock" or window == "armortires" or window == "horns" or window == "lsddoor" then
                if tableUpgrade.Type == "handling" then
                    if window == "sizewheels" then
                        setVehicleHandlingFlags(vehicle, {3, 4}, 0)
                        setElementData(vehicle, "JOAO."..upperCase(window), false)
                    elseif window == "offroadmode" then
                        setVehicleHandlingFlags(vehicle, 6, 0)
                        setElementData(vehicle, "JOAO."..upperCase(window), false)
                    else
                        if not tableUpgrade.Tuning then return end
                        for i, v in pairs(tableUpgrade.Tunings) do
                            local data = config["Handlings"][model][i]
                            setVehicleHandling(vehicle, i, data, false)
                        end
                        setElementData(vehicle, "JOAO."..upperCase(window), false)
                    end
                elseif tableUpgrade.Type == "custom" then
                    if tableUpgrade.typeTuning == "turbos" then
                        if tableUpgrade.tuningManage == "off" then
                            if (getElementData(vehicle, "JOAO.noiseVeh") or false) then
                                setElementData(vehicle, "JOAO.noiseVeh", false)
                            else
                                notifyS(player, "Você não possui essa tuning!", "error")
                                return
                            end
                            setElementData(vehicle, "JOAO."..upperCase(window), false)
                        end
                    elseif tableUpgrade.typeTuning == "neon" then
                        setElementData(vehicle, "vehicle.neon.active", false)
                        triggerEvent("tuning->Neon", root, vehicle, false)
                        setElementData(vehicle, "JOAO."..upperCase(window), false)
                        buyUpgrades[vehicle][tableUpgrade.typeTuning] = false
                    elseif tableUpgrade.typeTuning == "horns" then
                        setElementData(vehicle, "JOAO."..upperCase(window), false)
                    elseif tableUpgrade.typeTuning == "armortires" then
                        setElementData(vehicle, "JOAO."..upperCase(window), false)
                    elseif tableUpgrade.typeTuning == "lsddoor" then
                        setElementData(vehicle, "JOAO."..upperCase(window), false)
                        buyUpgrades[vehicle][tableUpgrade.typeTuning] = false
                    end
                elseif tableUpgrade.Type == "upgrade" then
                    for i, v in ipairs(tableUpgrade.Value) do
                        removeVehicleUpgrade(vehicle, v) 
                    end
                    if window == "nitros" then
                        setElementData(vehicle, "tuning.nitroLevel", false)
                        triggerClientEvent(player, "JOAO.refreshVehicleNitroLevel", player, vehicle, false)
                    end
                    setElementData(vehicle, "JOAO."..upperCase(window), false)
                end
            end
            notifyS(player, "Você retirou a tunagem com sucesso!", "success")
        end
    end
end)

addEvent("JOAO.buyTuningColor", true)
addEventHandler("JOAO.buyTuningColor", root,
function(player, tableBuy, colorType, colorTable)
    if tableBuy and colorType and colorTable then
        local vehicle = getPedOccupiedVehicle(player)
        if not vehicle then return end
        local currentCoin = (getElementData(player, "JOAO.points") or 0)
        if tableBuy.typeCoin == "money" then
            if getPlayerMoney(player) < tableBuy.Price then
                notifyS(player, "Você não tem dinheiro suficiente!", "error")
                return
            end
        else
            if currentCoin < tableBuy.Price then
                notifyS(player, "Você não tem pontos suficiente!", "error")
                return
            end
        end
        local colorVeh = {getVehicleColor(vehicle, true)}
       
        if colorType == "headlight" then
            setVehicleHeadLightColor(vehicle, colorTable[1], colorTable[2], colorTable[3])
            notifyS(player, "Cor no farol aplicada com sucesso!", "success")
        elseif colorType == "color1" then
            setVehicleColor(vehicle, colorTable[1], colorTable[2], colorTable[3], colorVeh[4], colorVeh[5], colorVeh[6], colorVeh[7], colorVeh[8], colorVeh[9], colorVeh[10], colorVeh[11], colorVeh[12])
            notifyS(player, "Cor primária aplicada com sucesso!", "success")
        elseif colorType == "color2" then
            setVehicleColor(vehicle, colorVeh[1], colorVeh[2], colorVeh[3], colorTable[1], colorTable[2], colorTable[3], colorVeh[7], colorVeh[8], colorVeh[9], colorVeh[10], colorVeh[11], colorVeh[12])
            notifyS(player, "Cor secundária aplicada com sucesso!", "success")
        elseif colorType == "color3" then
            setVehicleColor(vehicle, colorVeh[1], colorVeh[2], colorVeh[3], colorVeh[4], colorVeh[5], colorVeh[6], colorTable[1], colorTable[2], colorTable[3], colorVeh[10], colorVeh[11], colorVeh[12])
            notifyS(player, "Cor terciária aplicada com sucesso!", "success")
        elseif colorType == "color4" then
            setVehicleColor(vehicle, colorVeh[1], colorVeh[2], colorVeh[3], colorVeh[4], colorVeh[5], colorVeh[6], colorVeh[7], colorVeh[8], colorVeh[9], colorTable[1], colorTable[2], colorTable[3])
            notifyS(player, "Cor quartária aplicada com sucesso!", "success")
        end
        if tableBuy.typeCoin == "money" then
            takePlayerMoney(player, tableBuy.Price)
        else
            setElementData(player, "JOAO.points", currentCoin-tableBuy.Price)
        end
    end
end)

function setVehicleHandlingFlags(vehicle, byte, value)
	if vehicle then
		local handlingFlags = string.format("%X", getVehicleHandling(vehicle)["handlingFlags"])
		local reversedFlags = string.reverse(handlingFlags) .. string.rep("0", 8 - string.len(handlingFlags))
		local currentByte, flags = 1, ""
		
		for values in string.gmatch(reversedFlags, ".") do
			if type(byte) == "table" then
				for _, v in ipairs(byte) do
					if currentByte == v then
						values = string.format("%X", tonumber(value))
					end
				end
			else
				if currentByte == byte then
					values = string.format("%X", tonumber(value))
				end
			end
			
			flags = flags .. values
			currentByte = currentByte + 1
		end
		
		setVehicleHandling(vehicle, "handlingFlags", tonumber("0x"..string.reverse(flags)), false)
	end
end

function verifyUpgrade(vehicle, id)
    local upgrades = getVehicleUpgrades(vehicle)
    for i, v in ipairs(upgrades) do
        if v == id then
            return true
        end
    end
    return false
end

addEvent("JOAO.removeCarTuning", true)
addEventHandler("JOAO.removeCarTuning", root,
function(player)
    local vehicle = getPedOccupiedVehicle(player)
    if not vehicle then return end
    if not buyUpgrades[vehicle] then buyUpgrades[vehicle] = {} end
    setElementFrozen(vehicle, false)
    setCameraTarget(player, player)
    local colorVeh = {getVehicleColor(vehicle, true)}
    local colorHeadlight = {getVehicleHeadLightColor(vehicle)}
    if markerOpen[vehicle] then
        if isElement(markerOpen[vehicle]) then
            setElementAlpha(markerOpen[vehicle], 90)
        end
    end
    if (getElementData(vehicle, "JOAO.Neon") or false) then
        buyUpgrades[vehicle]["neon"] = true
    end
    local upgrades = getVehicleUpgrades(vehicle)
    triggerClientEvent(player, "JOAO.applyColorsVeh", player, vehicle, colorVeh, colorHeadlight, upgrades, buyUpgrades[vehicle]["neon"])
end)

function upperCase(text)
    return utf8.gsub(tostring(text), '%a', utf8.upper, 1)
end

function verifyVehicle(player, vehicle)
    if player and vehicle then
        if getElementType(vehicle) ~= "vehicle" then return end
        if config["Handlings"][getElementModel(vehicle)] then
            return true
        end
    end
    return false
end

for i, v in ipairs(getElementsByType("vehicles")) do 
    destroyElement(v) 
end

calcHand = {}

function loadHandling(vehicle)
	if vehicle then
		if config["Handlings"][(getElementModel(vehicle))] then
            calcHand[vehicle] = {}
            local tires = (getElementData(vehicle, "JOAO.Tires") or false)
            local engines = (getElementData(vehicle, "JOAO.Engines") or false) 
            local traction = (getElementData(vehicle, "JOAO.Traction") or false)
            local directionlock = (getElementData(vehicle, "JOAO.Directionlock") or false)
            local weight = (getElementData(vehicle, "JOAO.Weight") or false)
            local sizewheels = (getElementData(vehicle, "JOAO.SizeWheels") or false)
            local offroadmode = (getElementData(vehicle, "JOAO.Offroadmode") or false)
			for i, v in pairs(config["Handlings"][(getElementModel(vehicle))]) do
				setVehicleHandling(vehicle, i, v)
			end
            if tires and tires.tuningTable then
                for k, b in pairs(tires.tuningTable) do
                    local data = config["Handlings"][getElementModel(vehicle)][k]
                    setVehicleHandling(vehicle, k, data + b)
                end
            end
            if engines and engines.tuningTable then
                for k, b in pairs(engines.tuningTable) do
                    local data = config["Handlings"][getElementModel(vehicle)][k]
                    setVehicleHandling(vehicle, k, data + b)
                end
            end
            if traction and traction.tuningTable then
                for k, b in pairs(traction.tuningTable) do
                    setVehicleHandling(vehicle, k, b)
                end
            end
            if directionlock and directionlock.tuningTable then
                for k, b in pairs(directionlock.tuningTable) do
                    local data = config["Handlings"][getElementModel(vehicle)][k]
                    setVehicleHandling(vehicle, k, data + b)
                end
            end
            if weight and weight.tuningTable then
                for k, b in pairs(weight.tuningTable) do
                    local data = config["Handlings"][getElementModel(vehicle)][k]
                    setVehicleHandling(vehicle, k, data + b)
                end
            end
            if sizeWheels and sizeWheels.tuningTable then
                setVehicleHandlingFlags(vehicle, {3, 4}, sizeWheels.tuningTable)
            end
            if offroadmode and offroadmode.tuningTable then
                setVehicleHandlingFlags(vehicle, 6, offroadmode.tuningTable)
            end
		end
	end
end

function loadHandlings()
	for k, v in ipairs(getElementsByType('vehicle')) do
		loadHandling(v)
	end
end
addEventHandler('onResourceStart', getResourceRootElement(getThisResource()), loadHandlings)

function vehicleEnter()
	loadHandling(source)
end
addEventHandler('onVehicleEnter', getRootElement(), vehicleEnter)