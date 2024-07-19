---@diagnostic disable: lowercase-global, undefined-global
function reproductir_alarma()
    local isSound = playSound3D( "assets/timbre.mp3", 1788.3143310547,-1407.9779052734,15.7578125 )
    setSoundMaxDistance( isSound, 200 )
end
addEvent("Bombero>>alarma", true)
addEventHandler("Bombero>>alarma", root, reproductir_alarma)

local effects = {}
local tiempoRestante = {}

addEvent("Bombero>>efecto", true)
addEventHandler("Bombero>>efecto", root, function(state, coords)
    -- iprint("a")
    iprint(localPlayer, 'efecto')
    if state then
        if not effects[v] then
            local firesitos = {}
            for _,fire in ipairs(coords) do
                local x, y, z = getElementPosition(fire)
                local fuego = createEffect("fire", x, y, z)
                firesitos[fire] = fuego
            end
            effects[localPlayer] = firesitos
            tiempoRestante.setupTimer(7) -- los minutos del contador
            addEventHandler("onClientRender", root, draw_fires)
        end
    else
        -- iprint(effects[localPlayer])
        if effects[localPlayer] then
            -- iprint("test")
            for _, fuego in pairs(effects[localPlayer]) do
                destroyElement(fuego)
            end
            if isTimer(tiempoRestante.timer) then
                killTimer(tiempoRestante.timer)
            end
            tiempoRestante.timer = nil
            effects[localPlayer] = nil
            removeEventHandler("onClientRender", root, draw_fires)
        end
    end
end)

addEvent("Bombero>>efecto2", true)
addEventHandler("Bombero>>efecto2", root, function(marker)
    -- iprint("cosoxd")
    if effects[localPlayer] then
        for fire, fuego in pairs(effects[localPlayer]) do
            if fire == marker then
                destroyElement(fuego)
                triggerServerEvent("onTableChange", localPlayer, marker)
                effects[localPlayer][fire] = nil
            end
        end
    end
end)

addEventHandler("onClientKey", root, function(button, press)
    if button == "m" then
        if press then
            if isCursorShowing( localPlayer ) then
                showCursor(false)
            else
                showCursor(true)
            end
        end
    end
end)

function tiempoRestante.dx()
    if getElementData(localPlayer, "Job") == "Bombero" and getElementData(localPlayer, "Bombero.isactive") then
        if not isTimer(tiempoRestante.timer) then removeEventHandler("onClientRender", root, tiempoRestante.dx); return end
        local tiempo = formatear_tiempo(tiempoRestante.timer)
        local screenX, screenY = guiGetScreenSize()
        -- dxDrawText( "Tiempo restante: " .. tiempo, screenX - 600, screenY - 500, screenX - 200, screenY - 50, tocolor(255, 255, 255, 255), 1.5, "default-bold", "center", "center", false, false, false, false, false )
        dxDrawBorderedText(3, "Tiempo restante: "..tiempo, screenX - 600, screenY - 500, screenX - 200, screenY - 50, tocolor(255, 255, 255, 255), 1.5, "default-bold", "center", "center", false, false, false, false, false)
    end
end


function formatear_tiempo(theTimer)
	if not isTimer(theTimer) then return false end
	local remaining = getTimerDetails(theTimer)
	local s = remaining/1000
	return string.format("%.2d:%.2d", s/60%60, s%60)
end

function tiempoRestante.setupTimer(minutes)
	tiempoRestante.timer = setTimer(function()
		tiempoRestante.timer = nil
	end, (60*1000*minutes), 1)	
	addEventHandler("onClientRender", root, tiempoRestante.dx)
end

function draw_fires()
    if effects and tiempoRestante.timer ~= nil and getElementData(localPlayer, "Job") == "Bombero" and getElementData(localPlayer, "Bombero.isactive") then
        local total = 0
        for _, fires in pairs(effects[localPlayer]) do
            total = total + 1
        end
        local screenX, screenY = guiGetScreenSize()
        -- dxDrawText( "Fuegos restantes: " .. total, screenX - 600, screenY - 450, screenX - 200, screenY - 50, tocolor(255, 255, 255, 255), 1.5, "default-bold", "center", "center", false, false, false, false, false )
        dxDrawBorderedText(3, "Fuegos restantes: "..total, screenX - 600, screenY - 450, screenX - 200, screenY - 50, tocolor(255, 255, 255, 255), 1.5, "default-bold", "center", "center")
    end
end

function dxDrawBorderedText (outline, text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    for oX = (outline * -1), outline do
        for oY = (outline * -1), outline do
            dxDrawText (text, left + oX, top + oY, right + oX, bottom + oY, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
        end
    end
    dxDrawText (text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end

addEventHandler("onClientVehicleStartEnter", root, function (player)
    if getElementData(player, "Job") ~= "Bombero" then
        if getElementModel(source) == 544 or getElementModel(source) == 407 then
            cancelEvent()
        end
    end
end)
