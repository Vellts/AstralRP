local dgs = exports.dgs
local screenW, screenH = guiGetScreenSize()
local drawData = {
    ["font"] = nil,
    ["info"] = nil,
    ["progressBar"] = nil,
    ["width"] = 300,
    ["height"] = 200,
    ["timeFires"] = 0
}

------------------- [ Evento: Dibuja la información ] -------------------

-- Dibuja la información de los fuegos restantes y el tiempo restante.
-- fires: Número de fuegos restantes.
-- state: Estado de la información (true: ocultar, false: mostrar).
-- time: Tiempo restante.

function drawInfo(fires, state, time)
    if (not state) then

        -------- POSITIONS --------

        local x, y = (screenW - drawData.width) / 3, (screenH - drawData.height)
        
        if (not drawData.font) or (type(drawData.font == "userdata")) then
            drawData.font = dgs:dgsCreateFont("assets/Poppins-SemiBold.ttf", 16)
        end

        -------- FUEGOS RESTANTES --------

        local shader =dgs: dgsCreateRoundRect(6, false, tocolor(23, 22, 22, 255))
        drawData.info = dgs:dgsCreateImage(x, y, (drawData.width * 2) / 3, (drawData.height / 4), shader, false)
        drawData["infoLabel"] = dgs:dgsCreateLabel(0.4, 0.5, 0.2, 0.1, "#FFFFFFFuegos restantes: #E1D358" .. fires, true, drawData.info)
        dgs:dgsSetProperties(drawData["infoLabel"], {
            ["font"] = drawData.font,
            ["colorCoded"] = true,
            ["alignment"] = { "center", "center" }
        })
        dgs:dgsAttachToAutoDestroy(drawData.info, shader)

        -------- TIEMPO RESTANTE --------

        drawData["timeInfo"] = dgs:dgsCreateImage(x, y - 55, (drawData.width * 2) / 3, (drawData.height / 4), shader, false)
        drawData["timeLabel"] = dgs:dgsCreateLabel(0.4, 0.5, 0.2, 0.1, "#FFFFFFTiempo restante: #E1D358" .. parseTime(time), true, drawData["timeInfo"])
        dgs:dgsSetProperties(drawData["timeLabel"], {
            ["font"] = drawData.font,
            ["colorCoded"] = true,
            ["alignment"] = { "center", "center" },
        })
        drawData["fireTimeTimer"] = setTimer(function()
            time = time - 1000
            if (isElement(drawData["timeLabel"])) then
                dgs:dgsSetText(drawData["timeLabel"], "#FFFFFFTiempo restante: #E1D358" .. parseTime(time))
            end
        end, 1000, 0)
    else
        if (isElement(drawData.info)) then
            destroyElement(drawData.info)
        end
        if (isElement(drawData.font)) then
            destroyElement(drawData.font)
        end
        if (isElement(drawData["timeInfo"])) then
            destroyElement(drawData["timeInfo"])
        end
        if (isElement(drawData["timeLabel"])) then
            destroyElement(drawData["timeLabel"])
        end

        if (isElement(drawData["progressBar"])) then
            destroyElement(drawData["progressBar"])
        end

        if (isTimer(drawData["fireTimeTimer"])) then
            killTimer(drawData["fireTimeTimer"])
        end
    end
end
addEvent("fireman>>drawInfoDx", true)
addEventHandler("fireman>>drawInfoDx", root, drawInfo)

------------------- [ Evento: Dibuja la progresión ] -------------------

-- Dibuja la progresión de un fuego.
-- timeNeeded: Tiempo necesario para extinguir el fuego.
-- timeLeft: Tiempo restante.

function drawFireProgression(timeNeeded, timeLeft)
    if (not drawData["progressBar"]) then
        generateProgressBar()
    end
    if (not isElement(drawData["progressBar"])) then
        return
    end
    local fullTime = timeNeeded
    local time = timeLeft
    dgs:dgsProgressBarSetProgress(drawData["progressBar"], (time / fullTime) * 100)
end
addEvent("fireman>>startProgressionDx", true)
addEventHandler("fireman>>startProgressionDx", root, drawFireProgression)

------------------- [ Evento: Detiene la progresión ] -------------------

-- Detiene la progresión del fuego.

function stopProgression()
    if (isElement(drawData["progressBar"])) then
        destroyElement(drawData["progressBar"])
        drawData["progressBar"] = nil
    end
end
addEvent("fireman>>stopProgressionDx", true)
addEventHandler("fireman>>stopProgressionDx", root, stopProgression)

------------------- [ Evento: Actualiza los fuegos restantes ] -------------------

-- Actualiza los fuegos restantes.
-- new_fires: Número de fuegos restantes.

function updateRestFires(new_fires)
    if (isElement(drawData["infoLabel"])) then
        dgs:dgsSetText(drawData["infoLabel"], "#FFFFFFFuegos restantes: #E1D358" .. new_fires)
    end
end
addEvent("fireman>>updateRestFiresDx", true)
addEventHandler("fireman>>updateRestFiresDx", root, updateRestFires)

------------------- [ Función: Genera la barra de progreso ] -------------------

-- Genera la barra de progreso.

function generateProgressBar()
    local x, y = (screenW - drawData["width"]) / 3, (screenH - drawData["height"]) + 60
    local w, h = 200, 25
    drawData["progressBar"] = dgs:dgsCreateProgressBar(x, y, w, h, false)
    local shader = dgs:dgsCreateRoundRect(6, false, tocolor(23, 22, 22, 255))
    local shader2 = dgs:dgsCreateRoundRect(6, false, tocolor(255, 211, 88, 255))
    dgs:dgsAttachToAutoDestroy(drawData["progressBar"], shader)
    dgs:dgsAttachToAutoDestroy(drawData["progressBar"], shader2)
    dgs:dgsSetProperties(drawData["progressBar"], {
        ["bgImage"] = shader,
        ["bgColor"] = tocolor(23, 22, 22, 255),
        ["indicatorImage"] = shader2,
        ["indicatorColor"] = tocolor(255, 211, 88, 255)
    })
end

------------------- [ Función: Convierte el tiempo ] -------------------

-- Convierte el tiempo de milisegundos a minutos y segundos.
-- miliseconds: Tiempo en milisegundos.

function parseTime(miliseconds)
    local seconds = math.floor(miliseconds / 1000)
    local minutes = math.floor(seconds / 60)
    local hours = math.floor(minutes / 60)
    local days = math.floor(hours / 24)
    return string.format("%02d:%02d", minutes % 60, seconds % 60)
end