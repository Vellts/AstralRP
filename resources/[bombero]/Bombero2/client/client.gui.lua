------------------- [ Utilidades ] -------------------

local dgs = exports.dgs

local sw, sy = dgs:dgsGetScreenSize()
local maxImgWidth = 820
local maxImgHeight = 460

local imgX = (sw - maxImgWidth) / 2
local imgY = (sy - maxImgHeight) / 2

local interfaceData = {
    ["img"] = nil,
    ["fontTitle"] = nil,
    ["fontText"] = nil
}

local initJob = [[
    #FFFFFFEmprende la misión de salvar vidas. Como #F23939bombero #FFFFFFtendrás el deber de apagar 
    incendios alrededor del mapa y evitar que se propague. Este trabajo es cooperativo, 
    por lo que tendrás que ir a la zona de incendios con más personas y lograrlo en 
    el menor tiempo posible.
]]

local cancelJob = [[
    Haz click en TERMINAR para salir de servicio. No recibirás llamados de emergencia
    ni recibirás pagos por cada incendio que tus compañeros apaguen.
]]

local jobState = false

------------------- [ Evento: Genera la interfaz ] -------------------

-- Genera la interfaz de trabajo.

function createInterface()
    showCursor(true)
    if (interfaceData["fontTitle"] ~= nil) then
        destroyElement(interfaceData["fontTitle"])
        interfaceData["fontTitle"] = nil
    end
    if (interfaceData["fontText"] ~= nil) then
        destroyElement(interfaceData["fontText"])
        interfaceData["fontText"] = nil
    end
    interfaceData["fontTitle"] = dgs:dgsCreateFont("assets/Poppins-SemiBold.ttf", 12)
    interfaceData["fontText"] = dgs:dgsCreateFont("assets/Poppins-Medium.ttf", 12)

    -- crear el fondo con corners redondeados
    local rounded = dgs:dgsCreateRoundRect(20, false, tocolor(22, 21, 21, 255))
    interfaceData["img"] = dgs:dgsCreateImage(imgX, imgY, maxImgWidth, maxImgHeight, rounded, false)
    dgs:dgsAttachToAutoDestroy(interfaceData["img"], rounded)
    dgs:dgsSetProperty(interfaceData["img"], "changeOrder", false)

    -- imagen de fondo
    local bg = dgs:dgsCreateImage(0, 0, maxImgWidth, maxImgHeight - 240, "imgs/bg.png", false, interfaceData["img"])
    dgs:dgsSetProperty(bg, "changeOrder", false)

    -- titulo
    local roundShader = dgs:dgsCreateRoundRect({
        {0, false},
        {20, false},
        {20, false},
        {0, false}
    }, tocolor(22, 21, 21, 255))
    local bgTitle = dgs:dgsCreateImage(0, 50, 200, 40, roundShader, false, interfaceData["img"])
    dgs:dgsSetProperty(bgTitle, "changeOrder", false)
    dgs:dgsAttachToAutoDestroy(bgTitle, roundShader)

    -- texto del titulo
    local title = dgs:dgsCreateLabel(0, 0, 200, 40, "BOMBERO", false, bgTitle)
    dgs:dgsSetProperties(title, {
        ["changeOrder"] = false,
        ["font"] = interfaceData["fontTitle"],
        ["alignment"] = {"center", "center"},
        ["textColor"] = tocolor(242, 57, 57, 255),
        ["textSize"] = {1.5, 1.5}
    })

    -- texto de la descripcion

    local getJobState = getElementData(localPlayer, "player:firemanService")


    local description = dgs:dgsCreateLabel(20, 290, maxImgWidth - 50, 40, (getJobState) and cancelJob or initJob, false, interfaceData["img"])
    dgs:dgsSetProperties(description, {
        ["changeOrder"] = false,
        ["font"] = interfaceData["fontText"],
        ["alignment"] = {"left", "center"},
        ["textColor"] = tocolor(255, 255, 255, 255),
        ["textSize"] = {1.5, 1.5},
        -- ["wordBreak"] = true,
        ["colorCoded"] = true
    })

    -- boton de aceptar
    local btnShader = dgs:dgsCreateRoundRect(20, false, tocolor(37, 37, 37, 255))
    local btnShader2 = dgs:dgsCreateRoundRect(20, false, tocolor(186, 44, 44, 255))
    local btnShader3 = dgs:dgsCreateRoundRect(20, false, tocolor(197, 32, 32, 255))
    local acceptText = (getJobState) and "TERMINAR" or "ACEPTAR"
    local btnAccept = dgs:dgsCreateButton(maxImgWidth - 200, maxImgHeight - 60, 180, 40, acceptText, false, interfaceData["img"])
    dgs:dgsSetProperties(btnAccept, {
        ["changeOrder"] = false,
        ["font"] = interfaceData["fontTitle"],
        ["image"] = { btnShader2, btnShader3, btnShader2 }
    })
    dgs:dgsAttachToAutoDestroy(btnAccept, btnShader)
    dgs:dgsAttachToAutoDestroy(btnAccept, btnShader2)
    dgs:dgsAttachToAutoDestroy(btnAccept, btnShader3)

    -- boton de cancelar

    local btnCancel = dgs:dgsCreateButton(20, maxImgHeight - 60, 180, 40, "CANCELAR", false, interfaceData["img"])
    dgs:dgsSetProperties(btnCancel, {
        ["changeOrder"] = false,
        ["font"] = interfaceData["fontTitle"],
        ["image"] = { btnShader, btnShader2, btnShader3 }
    })

    -- evento de los botones

    addEventHandler("onDgsMouseClick", btnCancel, function(btn, state)
        if (btn == "left" and state == "down") then
            if (interfaceData["img"] ~= nil and source == btnCancel) then
                playSound("assets/click.wav")
                destroyElement(interfaceData["img"])
                interfaceData["img"] = nil
                showCursor(false)
            end
        end
    end)

    addEventHandler("onDgsMouseClick", btnAccept, function(btn, state)
        if (btn == "left" and state == "down") then
            if (interfaceData["img"] ~= nil and source == btnAccept) then
                playSound("assets/click.wav")
                if (not (getElementData(localPlayer, "player:firemanService"))) then
                    showCursor(false)
                    destroyElement(interfaceData["img"])
                    interfaceData["img"] = nil
                    triggerServerEvent("fireman>>addPlayer", localPlayer)
                    outputChatBox("¡Bienvenido al trabajo de bombero!", 0, 255, 0)
                    setElementData(localPlayer, "player:firemanService", true)
                    setElementData(localPlayer, "Job", "Bombero")
                else
                    showCursor(false)
                    destroyElement(interfaceData["img"])
                    interfaceData["img"] = nil
                    triggerServerEvent("fireman>>removePlayer", localPlayer)
                    iprint("a")
                    outputChatBox("¡Has salido del trabajo de bombero!", 255, 0, 0)
                    setElementData(localPlayer, "player:firemanService", false)
                    setElementData(localPlayer, "Job", "Unemployed")
                end
            end
        end
    end)

    return interfaceData["img"]
end
addEvent("fireman>>createInterface", true)
addEventHandler("fireman>>createInterface", root, createInterface)

-- Remueve la interfaz de trabajo.

function removeInterface()
    if (interfaceData["img"] ~= nil) then
        destroyElement(interfaceData["img"])
        showCursor(false)
    end
end
addEvent("fireman>>removeInterface", true)
addEventHandler("fireman>>removeInterface", root, removeInterface)

-- Reproduce el sonido de la alarma.

addEvent("fireman>>playSoundEffect", true)
addEventHandler("fireman>>playSoundEffect", root, function()
    local sound = playSound3D("assets/alarm.wav", 1790.5552978516,-1417.8071289062,29.234375, false)
    setSoundMaxDistance(sound, 200)
    setSoundVolume(sound, 1.0)
end)