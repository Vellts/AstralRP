gui = {
    button = {},
    window = {},
    memo = {}
}


local screenX, screenY = guiGetScreenSize()

addEventHandler("onClientResourceStart", resourceRoot, function ()
    gui.window[1] = guiCreateStaticImage(screenX / 2 - 300, screenY / 2 - 200, 700, 400, "assets/fondo_1.png", false)
    gui.window[2] = guiCreateStaticImage(screenX / 2 - 300, screenY / 2 - 200, 700, 400, "assets/fondo_2.png", false)

    cancelar = guiCreateStaticImage(screenX / 2 - 660, screenY / 2 - 40, 151, 38, "assets/cancelar_1.png", false, gui.window[1])
    cancelar1 = guiCreateStaticImage(screenX / 2 - 660, screenY / 2 - 40, 151, 38, "assets/cancelar_2.png", false, gui.window[1])
    gui.button[1] = guiCreateLabel(screenX / 2 - 660, screenY / 2 - 40, 151, 38, "", false, gui.window[1])

    cancelarr = guiCreateStaticImage(screenX / 2 - 660, screenY / 2 - 40, 151, 38, "assets/cancelar_1.png", false, gui.window[2])
    cancelarr1 = guiCreateStaticImage(screenX / 2 - 660, screenY / 2 - 40, 151, 38, "assets/cancelar_2.png", false, gui.window[2])
    gui.button[2] = guiCreateLabel(screenX / 2 - 660, screenY / 2 - 40, 151, 38, "", false, gui.window[2])

    aceptar = guiCreateStaticImage(screenX / 2 - 160, screenY / 2 - 40, 151, 38, "assets/empezar_1.png", false, gui.window[1])
    aceptar2 = guiCreateStaticImage(screenX / 2 - 160, screenY / 2 - 40, 151, 38, "assets/empezar_2.png", false, gui.window[1])
    gui.button[3] = guiCreateLabel(screenX / 2 - 160, screenY / 2 - 40, 151, 38, "", false, gui.window[1])

    terminar = guiCreateStaticImage(screenX / 2 - 160, screenY / 2 - 40, 151, 38, "assets/terminar_1.png", false, gui.window[2])
    terminar2 = guiCreateStaticImage(screenX / 2 - 160, screenY / 2 - 40, 151, 38, "assets/terminar_2.png", false, gui.window[2])
    gui.button[4] = guiCreateLabel(screenX / 2 - 160, screenY / 2 - 40, 151, 38, "", false, gui.window[2])

    guiSetVisible(gui.window[1], false)
    guiSetVisible(gui.window[2], false)
    showCursor(false)
end)

function mostrarMenu(state)
    if not state then
        if not guiGetVisible(gui.window[1]) then
            guiSetVisible(gui.window[1], true)
            guiSetVisible(cancelar1, false)
            guiSetVisible(aceptar2, false)
            showCursor(true)
        else
            guiSetVisible(gui.window[1], false)
            showCursor(false)
        end
    else
        if not guiGetVisible(gui.window[2]) then
            guiSetVisible(gui.window[2], true)
            guiSetVisible(cancelarr1, false)
            guiSetVisible(terminar2, false)
            showCursor(true)
        else
            guiSetVisible(gui.window[2], false)
            showCursor(false)
        end
    end
end
addEvent("Bombero>>panel", true)
addEventHandler("Bombero>>panel", root, mostrarMenu)
-- addEventHandler("onClientMarkerHit", marker, mostrarMenu)

addEventHandler("onClientMouseLeave", root, function ()
    if source == gui.button[1] then
        guiSetVisible(cancelar, true)
        guiSetVisible(cancelar1, false)
    end
end)

addEventHandler("onClientMouseEnter", root, function ()
    if source == gui.button[1] then
        guiSetVisible(cancelar, false)
        guiSetVisible(cancelar1, true)
    end
end)

addEventHandler("onClientMouseLeave", root, function ()
    if source == gui.button[2] then
        guiSetVisible(cancelarr, true)
        guiSetVisible(cancelarr1, false)
    end
end)

addEventHandler("onClientMouseEnter", root, function ()
    if source == gui.button[2] then
        guiSetVisible(cancelarr, false)
        guiSetVisible(cancelarr1, true)
    end
end)

addEventHandler("onClientMouseLeave", root, function ()
    if source == gui.button[3] then
        guiSetVisible(aceptar, true)
        guiSetVisible(aceptar2, false)
    end
end)

addEventHandler("onClientMouseEnter", root, function ()
    if source == gui.button[3] then
        guiSetVisible(aceptar, false)
        guiSetVisible(aceptar2, true)
    end
end)

addEventHandler("onClientMouseLeave", root, function ()
    if source == gui.button[4] then
        guiSetVisible(terminar, true)
        guiSetVisible(terminar2, false)
    end
end)

addEventHandler("onClientMouseEnter", root, function ()
    if source == gui.button[4] then
        guiSetVisible(terminar, false)
        guiSetVisible(terminar2, true)
    end
end)

addEventHandler("onClientGUIClick", root, function ()
    if source == gui.button[1] then
        guiSetVisible(gui.window[1], false)
        showCursor( false )
    elseif source == gui.button[2] then
        guiSetVisible(gui.window[2], false)
        showCursor( false )
    elseif source == gui.button[3] then
        guiSetVisible(gui.window[1], false)
        guiSetVisible(gui.window[2], true)
        triggerServerEvent("Bombero>>addplayer", localPlayer, true)
        setElementData(localPlayer, "Bombero.isactive", true)
        hasInit = true
    elseif source == gui.button[4] then
        guiSetVisible(gui.window[1], true)
        guiSetVisible(gui.window[2], false)
        triggerServerEvent("Bombero>>addplayer", localPlayer, false)
        setElementData(localPlayer, "Bombero.isactive", false)
        hasInit = false
    end
end)
