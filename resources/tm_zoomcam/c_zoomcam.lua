ogFov = getCameraFieldOfView("player")

local rendering = false
zoomEnabled = 1

function checkStateForZoom()
	currentFov = getCameraFieldOfView("player")
	if zoomEnabled == 1 then
		if currentFov > 50 then
			setCameraFieldOfView("player", currentFov-5)
		end
	end
end

function playerPressedKey(button, press)
	if zoomEnabled == 1 then
		if button==zoomKey and (press) then
			toggleControl("look_behind", false)
			toggleControl("vehicle_look_behind", false)
		end
		
		if button == zoomKey and (press) then -- Only output when they press it down
			if not rendering then
				rendering = true
				addEventHandler("onClientRender", root, checkStateForZoom)
				lookTimer = setTimer(pedLookAt, 200, 0)
			end
		elseif button == zoomKey then
			if rendering then
				removeEventHandler("onClientRender", root, checkStateForZoom)
				setCameraFieldOfView("player", ogFov)
				if isTimer(lookTimer) then
					killTimer(lookTimer)
				end
				setPedLookAt(localPlayer, 0, 0, 0, 0)
				rendering = false
			end
		end
	end
end
addEventHandler("onClientKey", root, playerPressedKey)

local screenSize_X, screenSize_Y = guiGetScreenSize()

function pedLookAt()
   local x, y, z = getWorldFromScreenPosition(screenSize_X / 2, screenSize_Y / 2, 15)
   setPedLookAt(localPlayer, x, y, z, -1, 0)
   if syncHeadTurn then
	triggerLatentServerEvent("syncLookAt", 30000, false, localPlayer, x,y,z)
   end
end

addEvent('setLookAt', true)
addEventHandler('setLookAt', root, function(x,y,z)
	if source == localPlayer then
		setPedLookAt(localPlayer, x,y,z)
	else
		setPedAimTarget(source, x,y,z)
		setPedLookAt(source, x,y,z)
	end
end)