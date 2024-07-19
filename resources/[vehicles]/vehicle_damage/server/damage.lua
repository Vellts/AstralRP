data = {
    vehicles = {},
    firstStepMotor = {
        180000,
        120000,
        60000,
    }
}

function onVehicleDamage()
    if (not data.vehicles[source]) then
        data.vehicles[source] = {}
        data.vehicles[source].lastHealth = getElementHealth(source)
    end

    local healthVehicle = getElementHealth(source)
    local stateMotor = getVehiclePanelState ( source, 1 )
    -- iprint(stateMotor)
    if ((stateMotor > 1) or (healthVehicle < 600) ) then
    -- iprint((data.vehicles[source].lastHealth - healthVehicle))
        if ((data.vehicles[source].lastHealth - healthVehicle) >= 50) then
            setVehicleEngineState ( source, false )
            -- send notification
            local player = getVehicleOccupant(source)
            if (not player) then return end
            exports.core_notifications:createNotification(player, "normal", {
                icon = "in",
                message = "El motor se ha apagado por daños."
            })
        end
    end
    data.lastHealth = healthVehicle

    local player = getVehicleOccupant(source)

    --------------- Check state motor ---------------

    checkStateMotor(player, source)
end
addEventHandler("onVehicleDamage", root, onVehicleDamage)

function checkStateMotor(player, vehicle)
    local vh = vehicle
    if (not vh) then return end
    local stateMotor = getVehiclePanelState ( vh, 5 )
    if (stateMotor == 2) then
        local chooseOption = math.random(1, #data.firstStepMotor)
        if (data.vehicles[vh].timer) then
            if (isTimer(data.vehicles[vh].timer)) then
                killTimer(data.vehicles[vh].timer)
                data.vehicles[vh].timer = nil
            end
        end
        data.vehicles[vh].timer = setTimer(function()
            if (not getVehicleOccupant(vehicle)) then
                -- kill timer
                if (data.vehicles[vehicle].timer) then
                    if (isTimer(data.vehicles[vehicle].timer)) then
                        killTimer(data.vehicles[vehicle].timer)
                        data.vehicles[vehicle].timer = nil
                    end
                end
                return
            end
            offMotor(player, vh, true)
            checkStateMotor(player, vh)
        end, data.firstStepMotor[chooseOption], 1)
    elseif (stateMotor == 3) then
        iprint("aca")
        setElementData(vh, "vehicle::motorState", true, false)
        offMotor(_, vh, false)
    end
end

function offMotor(player, vehicle, withNt)
    setVehicleEngineState(vehicle, false)
    if (withNt) then
        exports.core_notifications:createNotification(player, "interaction", {
            icon = "K",
            message = "El motor se ha pagado por los daños. Enciendelo con {letter}."
        })
    end
end

addEventHandler("onVehicleEnter", root, function(player)
    if (getElementType(player) == "player") then
        if (not data.vehicles[source]) then
            data.vehicles[source] = {}
            data.vehicles[source].lastHealth = getElementHealth(source)
        end
        checkStateMotor(player, source)
    end
end)

function setVehicleTo4x4(player)
    local vehicle = getPedOccupiedVehicle(player)
    if vehicle then
        setVehicleHandling(vehicle, "mass", 2025) -- Masa del vehículo en kg
        setVehicleHandling(vehicle, "turnMass", 4500) -- Masa de giro
        setVehicleHandling(vehicle, "dragCoeff", 0.3) -- Coeficiente de arrastre
        setVehicleHandling(vehicle, "centerOfMass", {0, 0.0, -0.2}) -- Centro de masa

        -- Suspensión
        setVehicleHandling(vehicle, "suspensionForceLevel", 1.8) -- Nivel de fuerza de la suspensión
        setVehicleHandling(vehicle, "suspensionDamping", 0.12) -- Amortiguación de la suspensión
        setVehicleHandling(vehicle, "suspensionHighSpeedDamping", 0.0) -- Amortiguación a alta velocidad
        setVehicleHandling(vehicle, "suspensionUpperLimit", 0.1) -- Límite superior de la suspensión
        setVehicleHandling(vehicle, "suspensionLowerLimit", -0.15) -- Límite inferior de la suspensión
        setVehicleHandling(vehicle, "suspensionAntiDiveMultiplier", 0.3) -- Anti-inmersión de suspensión

        -- Tracción y manejo
        setVehicleHandling(vehicle, "tractionMultiplier", 1.1) -- Multiplicador de tracción
        setVehicleHandling(vehicle, "tractionLoss", 0.85) -- Pérdida de tracción
        setVehicleHandling(vehicle, "tractionBias", 0.48) -- Sesgo de tracción
        setVehicleHandling(vehicle, "steeringLock", 35.0) -- Ángulo de giro

        -- Motor y transmisión
        setVehicleHandling(vehicle, "driveType", "rwd") -- Tracción trasera
        setVehicleHandling(vehicle, "engineAcceleration", 15.0) -- Aceleración del motor ajustada para que le cueste más llegar a la velocidad máxima
        setVehicleHandling(vehicle, "engineInertia", 35.0) -- Inercia del motor aumentada para reducir la respuesta del acelerador
        setVehicleHandling(vehicle, "maxVelocity", 312.0) -- Velocidad máxima ajustada a 312 km/h

        -- Frenos
        setVehicleHandling(vehicle, "brakeDeceleration", 10.0) -- Desaceleración de frenos
        setVehicleHandling(vehicle, "brakeBias", 0.6) -- Sesgo de frenado
        -- Otros ajustes
        setVehicleHandling(vehicle, "numberOfGears", 5) -- Número de marchas
        iprint("Vehículo configurado como 4x4.")
    else
        outputChatBox("No estás en un vehículo.", player)
    end
end

-- Agregar el comando /set4x4 que llamará a la función setVehicleTo4x4
addCommandHandler("set4x4", setVehicleTo4x4)