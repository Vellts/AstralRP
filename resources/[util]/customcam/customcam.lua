function startCustomcam()
	preset = {
		mode = {},
		posX = {},
		posY = {},
		posZ = {},
		facetoX = {},
		facetoY = {},
		facetoZ = {},
		fov = {},
		roll = {},
		slot = {}
	}	
	
	GUI = {
		screenX = {},
		screenY = {},
		checkbox = {},
		radiobutton = {},
		edit = {},
		button = {},
		window = {},
		label = {},
		tab = {},
		tabpanel = {},
		combobox = {}
	}	
	
	camera = {
		mode = {},
		presetfromX = {},
		presetfromY = {},
		presetfromZ = {},
		presettoX = {},
		presettoY = {},
		presettoZ = {},
		fov = {},
		roll = {},
		from = {},
		to = {},	
		markerfromX = {},
		markerfromY = {},
		markerfromZ = {},
		markertoX = {},
		markertoY = {},
		markertoZ = {}
	}	
	
	marker = {
		from = {},
		to = {}
	}
	
	temp = {
		fromX = {},
		fromY = {},	
		fromZ = {},
		toX = {},	
		toY = {},
		toZ = {},	
		fov = {},	
		roll = {},
		ok = {}
	}
	
	showDist = false
	is_attach_1 = true
	
	GUI.screenX[0],GUI.screenY[0] = guiGetScreenSize()
	local width_1,height_1 = 306,246
	local width_2,height_2 = 281,222
	GUI.screenX[1],GUI.screenY[1] = (GUI.screenX[0]/2)-(width_1/2),(GUI.screenY[0]/3)-(height_1/3)
	GUI.screenX[2],GUI.screenY[2] = (GUI.screenX[0]/2)-(width_2/2),(GUI.screenY[0]/3)-(height_2/3)
	
	marker.from[1] = createMarker(5000,5000,0,"corona",0.2,20,250,20,255)
	marker.to[1] = createMarker(5000,5000,0,"corona",0.2,100,100,250,255)
	
	camera.from[1] = createObject(1337,5000,5000,0)
	setElementAlpha(camera.from[1],0)
	setObjectScale(camera.from[1],0.01)
	setElementCollisionsEnabled(camera.from[1],false)
	
	camera.to[1] = createObject(1337,5000,5000,0)
	setElementAlpha(camera.to[1],0)
	setObjectScale(camera.to[1],0.01)
	setElementCollisionsEnabled(camera.to[1],false)
	
	camera.from[2] = createObject(1337,5000,5000,0)
	setElementAlpha(camera.from[2],0)
	setObjectScale(camera.from[2],0.01)
	setElementCollisionsEnabled(camera.from[2],false)
	
	camera.to[2] = createObject(1337,5000,5000,0)
	setElementAlpha(camera.to[2],0)
	setObjectScale(camera.to[2],0.01)
	setElementCollisionsEnabled(camera.to[2],false)
	
	createGuiPanel()	
	
	if (GUI.window[1] ~= nil) then
		outputChatBox("#FFFFFFResource #44BB99customcam #FFFFFFstarted. Press #FFFF55F2 #FFFFFFto show or hide the GUI.",255,255,255,true)
	else
		outputChatBox("An unexpected error has occurred. Please,restart the resource.",255,60,60,true)
		stopCustomcam()
	end	
	isMainGuiVis = false
	guiSetVisible(GUI.window[1],false)
	-- guiBringToFront(GUI.window[1],true)
	showCursor(false)
	guiSetInputEnabled(false)
	importPresets()
	if isPedInVehicle(localPlayer) then	
		local vehicle = getPedOccupiedVehicle(localPlayer)
		setElementVelocity(vehicle,0,0,0.1)
	else
		setElementVelocity(localPlayer,0,0,0.175)
	end	
	setTimer(markerAnim,100,1)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),startCustomcam)

function addthehandlers()
	handlethedata()
	addEventHandler("onClientKey",root,boundKeys)
	addEventHandler("onClientRender",root,renderStuff)
	addEventHandler("onClientGUIClick",root,loadandsave,true)
	addEventHandler("onClientGUIClick",GUI.button[24],getWorldPos1,false)
	addEventHandler("onClientGUIClick",GUI.button[25],getWorldPos2,false)
	addEventHandler("onClientGUIClick",GUI.button[26],resetFields,false)
	addEventHandler("onClientGUIClick",GUI.button[20],openHelpGui,false)
	addEventHandler("onClientGUIClick",GUI.button[21],closeHelpGui,false)
	addEventHandler("onClientGUIClick",GUI.button[22],movingGui,false)

	addEventHandler("onClientGUIAccepted",root,handlethedata,true)
	addEventHandler("onClientClick",root,handlethedata,false)
	addEventHandler("onClientGUIBlur",root,handlethedata,true)
	addEventHandler("onClientKey",root,saveData)
	
	addEventHandler("onClientClick",getRootElement(),getNewSubject)
	
	addEventHandler("onClientGUIClick",GUI.button[1],prepareToLaunch,false)
	addEventHandler("onClientGUIClick",GUI.button[23],camMove,false)

	addEventHandler("onClientGUIClick",GUI.radiobutton[1],clickCheck,false)
	addEventHandler("onClientGUIClick",GUI.radiobutton[2],clickCheck,false)
	addEventHandler("onClientGUIClick",GUI.radiobutton[3],clickCheck,false)	
	
	addEventHandler("onClientResourceStop",getResourceRootElement(getThisResource()),stopCustomcam)
	handlethedata()
end

function handlethedata()
	if (guiRadioButtonGetSelected(GUI.radiobutton[1])) then
		is_attach_1 = true
		is_attach_2 = false
		is_static = false
	elseif (guiRadioButtonGetSelected(GUI.radiobutton[2])) then
		is_attach_1 = false
		is_attach_2 = true
		is_static = false
	elseif (guiRadioButtonGetSelected(GUI.radiobutton[3])) then
		is_attach_1 = false
		is_attach_2 = false
		is_static = true
	end		
	
	if theSubject then
		local player_X,player_Y,player_Z = getElementPosition(theSubject)
		local tdx,tdy,tdz = math.floor(player_X*100)/100,math.floor(player_Y*100)/100,math.floor(player_Z*100)/100
		if is_attach_1 then	
			a1_box1,a1_box2,a1_box3 = tonumber(guiGetText(GUI.edit[1])),tonumber(guiGetText(GUI.edit[2])),tonumber(guiGetText(GUI.edit[3]))
			a1_box4,a1_box5,a1_box6 = tonumber(guiGetText(GUI.edit[4])),tonumber(guiGetText(GUI.edit[5])),tonumber(guiGetText(GUI.edit[6]))
			if a1_box1==nil then a1_box1 = 0 end
			if a1_box2==nil then a1_box2 = 0 end
			if a1_box3==nil then a1_box3 = 0 end
			if a1_box4==nil then a1_box4 = 0 end
			if a1_box5==nil then a1_box5 = 0 end
			if a1_box6==nil then a1_box6 = 0 end
		elseif is_attach_2 then
			a2_box1,a2_box2,a2_box3 = tonumber(guiGetText(GUI.edit[1])),tonumber(guiGetText(GUI.edit[2])),tonumber(guiGetText(GUI.edit[3]))
			a2_box4,a2_box5,a2_box6 = tonumber(guiGetText(GUI.edit[4])),tonumber(guiGetText(GUI.edit[5])),tonumber(guiGetText(GUI.edit[6]))
			if a2_box1==nil then a2_box1 = tdx end
			if a2_box2==nil then a2_box2 = tdy end
			if a2_box3==nil then a2_box3 = tdz end
			if a2_box4==nil then a2_box4 = 0 end
			if a2_box5==nil then a2_box5 = 0 end
			if a2_box6==nil then a2_box6 = 0 end
		elseif is_static then
			s_box1,s_box2,s_box3 = tonumber(guiGetText(GUI.edit[1])),tonumber(guiGetText(GUI.edit[2])),tonumber(guiGetText(GUI.edit[3]))
			s_box4,s_box5,s_box6 = tonumber(guiGetText(GUI.edit[4])),tonumber(guiGetText(GUI.edit[5])),tonumber(guiGetText(GUI.edit[6]))
			if s_box1==nil then s_box1 = tdx end
			if s_box2==nil then s_box2 = tdy end
			if s_box3==nil then s_box3 = tdz end
			if s_box4==nil then s_box4 = tdx end
			if s_box5==nil then s_box5 = tdy end
			if s_box6==nil then s_box6 = tdz end
		end
		
		if is_attach_1 then
			box1 = a1_box1
			box2 = a1_box2
			box3 = a1_box3
			box4 = a1_box4
			box5 = a1_box5
			box6 = a1_box6
		elseif is_attach_2 then
			box1 = a2_box1
			box2 = a2_box2
			box3 = a2_box3
			box4 = a2_box4
			box5 = a2_box5
			box6 = a2_box6
		elseif is_static then
			box1 = s_box1
			box2 = s_box2
			box3 = s_box3
			box4 = s_box4
			box5 = s_box5
			box6 = s_box6
		end
		fov,roll = tonumber(guiGetText(GUI.edit[7])),tonumber(guiGetText(GUI.edit[8]))
	end
end

addEventHandler("onClientElementDestroy", getRootElement(), function ()
	if source == theSubject then
		selectedSubject = false
		theSubject = getLocalPlayer()
		outputChatBox("Selected target has mysteriously disappeared. \n#CCCCCCYou are the new target.",255,60,60,true)
	end
end)

function renderStuff()
	if not just_started or not isElement(theSubject) then
		theSubject = getLocalPlayer()
		just_started = true
	end
	if not selectedSubject and just_started then
		if isPedInVehicle(localPlayer) then	
			theSubject = getPedOccupiedVehicle(localPlayer)
		else
			theSubject = getLocalPlayer()
		end	
	elseif selectedSubject then
		if (getElementType(selectedSubject) == "player") then
			if isPedInVehicle(selectedSubject) then	
				theSubject = getPedOccupiedVehicle(selectedSubject)
			else
				theSubject = selectedSubject
			end	
		else
			theSubject = selectedSubject
		end
	end
	
	renderGUIelements()
	renderMarkers()
	renderAttach()
	
	local playerx,playery,playerz = getElementPosition(getLocalPlayer())
	local font = "sans"
	local size = 2
	local color1,color2,color3 = 255,255,255
	local color4,color5,color6 = 255,25,25
	
	if is_attach_1 and not move_cam then
		local camx,camy,camz = getElementPosition(camera.from[1])
		distance = getDistanceBetweenPoints3D (playerx,playery,playerz,camx,camy,camz)
		if showDist then
			if (distance >= 250) then
				dxDrawText("Distance between player and camera: "..(math.floor(distance*10)/10),GUI.screenX[0]*0.1815,GUI.screenX[0]*0.754,GUI.screenX[0],GUI.screenY[0]*0.95,tocolor(0,0,0,255),size,font,"left","center")
				dxDrawText("Distance between player and camera: "..(math.floor(distance*10)/10),GUI.screenX[0]*0.18,GUI.screenX[0]*0.75,GUI.screenX[0],GUI.screenY[0]*0.95,tocolor(color4,color5,color6,255),size,font,"left","center")

			else
				dxDrawText("Distance between player and camera: "..(math.floor(distance*10)/10),GUI.screenX[0]*0.1815,GUI.screenX[0]*0.754,GUI.screenX[0],GUI.screenY[0]*0.95,tocolor(0,0,0,255),size,font,"left","center")
				dxDrawText("Distance between player and camera: "..(math.floor(distance*10)/10),GUI.screenX[0]*0.18,GUI.screenX[0]*0.75,GUI.screenX[0],GUI.screenY[0]*0.95,tocolor(color1,color2,color3,255),size,font,"left","center")
			end
		end
	elseif not is_attach_1 and not move_cam then
		local camx,camy,camz = getElementPosition(camera.from[2])
		distance = getDistanceBetweenPoints3D (playerx,playery,playerz,camx,camy,camz)
		if showDist then
			if (distance >= 250) then
				dxDrawText("Distance between player and camera: "..(math.floor(distance*10)/10),GUI.screenX[0]*0.1815,GUI.screenX[0]*0.754,GUI.screenX[0],GUI.screenY[0]*0.95,tocolor(0,0,0,255),size,font,"left","center")
				dxDrawText("Distance between player and camera: "..(math.floor(distance*10)/10),GUI.screenX[0]*0.18,GUI.screenX[0]*0.75,GUI.screenX[0],GUI.screenY[0]*0.95,tocolor(color4,color5,color6,255),size,font,"left","center")
			else
				dxDrawText("Distance between player and camera: "..(math.floor(distance*10)/10),GUI.screenX[0]*0.1815,GUI.screenX[0]*0.754,GUI.screenX[0],GUI.screenY[0]*0.95,tocolor(0,0,0,255),size,font,"left","center")
				dxDrawText("Distance between player and camera: "..(math.floor(distance*10)/10),GUI.screenX[0]*0.18,GUI.screenX[0]*0.75,GUI.screenX[0],GUI.screenY[0]*0.95,tocolor(color1,color2,color3,255),size,font,"left","center")
			end
		end
	elseif move_cam then
		if mode_1 == "Fully Attached" then
			local camx,camy,camz = getElementPosition(camera.from[1])
			distance = getDistanceBetweenPoints3D (playerx,playery,playerz,camx,camy,camz)
		else
			local camx,camy,camz = getElementPosition(camera.from[2])
			distance = getDistanceBetweenPoints3D (playerx,playery,playerz,camx,camy,camz)
		end
	end
	
	if (distance >= 250) and simple_cam then
		if isPedInVehicle(getLocalPlayer()) then
			occupiedVehicle = getPedOccupiedVehicle(getLocalPlayer())
			setElementFrozen(occupiedVehicle,true)
		else
			setElementFrozen(getLocalPlayer(),true)
		end
	elseif move_cam then
		if (distance >= 250) then 
			if isPedInVehicle(getLocalPlayer()) then
				occupiedVehicle = getPedOccupiedVehicle(getLocalPlayer())
				setElementFrozen(occupiedVehicle,true)
			else
				setElementFrozen(getLocalPlayer(),true)
			end
		end
	elseif not simple_cam and not move_cam and (isElementFrozen(getLocalPlayer())) then 
		setElementFrozen(getLocalPlayer(),false)
	elseif not simple_cam and not move_cam then 
		if occupiedVehicle and isElement(occupiedVehicle) then
			if  isElementFrozen(occupiedVehicle) then
				setElementFrozen(occupiedVehicle,false)
			end		
		end
	elseif (distance <= 250) and (isElementFrozen(getLocalPlayer())) then 
		setElementFrozen(getLocalPlayer(),false)
	elseif (distance <= 250) and occupiedVehicle and (isElementFrozen(occupiedVehicle)) then 
		setElementFrozen(occupiedVehicle,false)
	end
	
	if isMainGuiVis then
		guiSetProperty(GUI.window[1],"CaptionColour",titlebar_color)
		guiSetProperty(GUI.window[2],"CaptionColour",titlebar_color)
		guiSetProperty(GUI.window[3],"CaptionColour",titlebar_color)
		guiSetProperty(GUI.button[21],"NormalTextColour",titlebar_color) 
	end
end

function renderGUIelements()
	if not isMainGuiVis then
		handlethedata()
	end
	
	if theSubject then
		local player_X,player_Y,player_Z = getElementPosition(theSubject)
		local tdx,tdy,tdz = math.floor(player_X*100)/100,math.floor(player_Y*100)/100,math.floor(player_Z*100)/100
		if (guiRadioButtonGetSelected(GUI.radiobutton[1])) then
			for i=1,6 do
				guiSetVisible(GUI.label[i],true)
			end
			guiSetVisible(GUI.button[24],false)
			guiSetVisible(GUI.button[25],false)
			guiSetProperty(GUI.radiobutton[1],"NormalTextColour","FFFFFFFF")
			guiSetProperty(GUI.radiobutton[2],"NormalTextColour","FF999999")
			guiSetProperty(GUI.radiobutton[3],"NormalTextColour","FF999999")
			if justclicked then
				if temp.ok[1] then
					getData(1)
				end
				handlethedata()
			end
		elseif (guiRadioButtonGetSelected(GUI.radiobutton[2])) then 
			for i=1,3 do
				guiSetVisible(GUI.label[i],false)
				guiSetVisible(GUI.label[i+3],true)
			end
			guiSetVisible(GUI.button[24],true)
			guiSetVisible(GUI.button[25],false)
			guiSetProperty(GUI.radiobutton[1],"NormalTextColour","FF999999")
			guiSetProperty(GUI.radiobutton[2],"NormalTextColour","FFFFFFFF")
			guiSetProperty(GUI.radiobutton[3],"NormalTextColour","FF999999")
			if justclicked then
				if temp.ok[2] then
					getData(2)
				elseif not firstTime_2 then
					guiSetText(GUI.edit[1],tdx)
					guiSetText(GUI.edit[2],tdy)
					guiSetText(GUI.edit[3],tdz)
					guiSetText(GUI.edit[4],"0")
					guiSetText(GUI.edit[5],"0")
					guiSetText(GUI.edit[6],"0")
					guiSetText(GUI.edit[7],"70")
					guiSetText(GUI.edit[8],"0")
					firstTime_2 = true
				end
				handlethedata()
			end
		elseif (guiRadioButtonGetSelected(GUI.radiobutton[3])) then
			for i=1,6 do
				guiSetVisible(GUI.label[i],false)
			end
			guiSetVisible(GUI.button[24],true)
			guiSetVisible(GUI.button[25],true)
			guiSetProperty(GUI.radiobutton[1],"NormalTextColour","FF999999")
			guiSetProperty(GUI.radiobutton[2],"NormalTextColour","FF999999")
			guiSetProperty(GUI.radiobutton[3],"NormalTextColour","FFFFFFFF")	
			if justclicked then
				if temp.ok[3] then
					getData(3)
				elseif not firstTime_3 then
					guiSetText(GUI.edit[1],tdx)
					guiSetText(GUI.edit[2],tdy)
					guiSetText(GUI.edit[3],tdz)
					guiSetText(GUI.edit[4],tdx)
					guiSetText(GUI.edit[5],tdy)
					guiSetText(GUI.edit[6],tdz)
					guiSetText(GUI.edit[7],"70")
					guiSetText(GUI.edit[8],"0")
					firstTime_3 = true
				end
				handlethedata()
			end
		end
		justclicked = false
		if not handledever then
			handlethedata()
			handledever = true
		end
	end
	
	local itema = guiComboBoxGetSelected(GUI.combobox[1])
	local item1 = tonumber(guiComboBoxGetItemText(GUI.combobox[1],itema))
	local itemb = guiComboBoxGetSelected(GUI.combobox[2])
	local item2 = tonumber(guiComboBoxGetItemText(GUI.combobox[2],itemb))
	
	if preset.slot[item1] then
		mode_1 = camera.mode[item1]
	else
		mode_1 = preset.mode[item1]
	end
	
	if preset.slot[item2] then
		mode_2 = camera.mode[item2]
	else
		mode_2 = preset.mode[item2]
	end	
	
	if (mode_1 == mode_2) and (mode_1 ~= nil) then
		guiSetText(GUI.label[17],mode_1)
		guiLabelSetHorizontalAlign(GUI.label[17],"center",false) 
		guiLabelSetColor(GUI.label[17],63,255,63)
	else
		guiSetText(GUI.label[17],"Not matching")
		guiLabelSetHorizontalAlign(GUI.label[17],"center",false) 
		guiLabelSetColor(GUI.label[17],255,63,63)
	end
	
	
	
	
	
	if simple_cam and not move_cam then
		guiSetText(GUI.button[1],"Reset View")
		guiSetProperty(GUI.button[1],"NormalTextColour",titlebar_color)
		guiSetText(GUI.button[23],"Start")
		guiSetProperty(GUI.button[23],"NormalTextColour","FFFFFFFF")
	elseif move_cam then
		guiSetText(GUI.button[1],"Reset View")
		guiSetProperty(GUI.button[1],"NormalTextColour",titlebar_color)
		guiSetText(GUI.button[23],"Reset View")
		guiSetProperty(GUI.button[23],"NormalTextColour",titlebar_color)
	elseif not simple_cam and not move_cam then
		guiSetText(GUI.button[1],"Start")
		guiSetProperty(GUI.button[1],"NormalTextColour","FFFFFFFF")
		guiSetText(GUI.button[23],"Start")
		guiSetProperty(GUI.button[23],"NormalTextColour","FFFFFFFF")
	end
	
	if la_text then
		guiSetText(GUI.label[50],"Last Action: " .. la_text)
	end
end

function renderAttach()
	if theSubject then		
		if move_cam then
			if mode_2 == "Fully Attached" then
				attachElements(camera.from[1],theSubject,i_from_X,i_from_Y,i_from_Z)
				attachElements(camera.to[1],theSubject,i_to_X,i_to_Y,i_to_Z)
			elseif mode_2 == "Semi Attached" then
				setElementPosition(camera.from[2],i_from_X,i_from_Y,i_from_Z)
				attachElements(camera.to[1],theSubject,i_to_X,i_to_Y,i_to_Z)
			elseif mode_2 == "Static" then
				setElementPosition(camera.from[2],i_from_X,i_from_Y,i_from_Z)
				setElementPosition(camera.to[2],i_to_X,i_to_Y,i_to_Z)
			end
		else
			if is_attach_1 then
				attachElements(camera.from[1],theSubject,box1,box2,box3)
				attachElements(camera.to[1],theSubject,box4,box5,box6)
			elseif is_attach_2 then
				setElementPosition(camera.from[2],box1,box2,box3)
				attachElements(camera.to[1],theSubject,box4,box5,box6)
			elseif is_static then
				setElementPosition(camera.from[2],box1,box2,box3)
				setElementPosition(camera.to[2],box4,box5,box6)
			end
		end
	end
end

function resetCamera()
	removeEventHandler("onClientPreRender",root,setCamMatrix)
	removeEventHandler("onClientPreRender",getRootElement(),renderCamMove)
	setCameraTarget(localPlayer)
	simple_cam,move_cam = false,false
end

function resetFields()
	if theSubject then
		local player_X,player_Y,player_Z = getElementPosition(theSubject)
		if guiRadioButtonGetSelected(GUI.radiobutton[1]) then
			guiSetText(GUI.edit[1],"0")
			guiSetText(GUI.edit[2],"0")
			guiSetText(GUI.edit[3],"0")
			guiSetText(GUI.edit[4],"0")
			guiSetText(GUI.edit[5],"0")
			guiSetText(GUI.edit[6],"0")
		elseif guiRadioButtonGetSelected(GUI.radiobutton[2]) then
			guiSetText(GUI.edit[1],(math.floor(player_X*100))/100)
			guiSetText(GUI.edit[2],(math.floor(player_Y*100))/100)
			guiSetText(GUI.edit[3],(math.floor(player_Z*100))/100)
			guiSetText(GUI.edit[4],"0")
			guiSetText(GUI.edit[5],"0")
			guiSetText(GUI.edit[6],"0")
		elseif guiRadioButtonGetSelected(GUI.radiobutton[3]) then
			guiSetText(GUI.edit[1],(math.floor(player_X*100))/100)
			guiSetText(GUI.edit[2],(math.floor(player_Y*100))/100)
			guiSetText(GUI.edit[3],(math.floor(player_Z*100))/100)
			guiSetText(GUI.edit[4],(math.floor(player_X*100))/100)
			guiSetText(GUI.edit[5],(math.floor(player_Y*100))/100)
			guiSetText(GUI.edit[6],(math.floor(player_Z*100))/100)
		end
		
		guiSetText(GUI.edit[7],"70")
		guiSetText(GUI.edit[8],"0")
		
		if simple_cam or move_cam then
			resetCamera()
		end
	end
end

function boundKeys(button,press)
	if not isChatBoxInputActive() then
		if press then
			if (button == "F2") then
				if isMainGuiVis then
					guiSetVisible(GUI.window[1],false)
					guiSetVisible(GUI.window[2],false)
					guiSetVisible(GUI.window[3],false)
					if not selecting then
						showCursor(false)
						guiSetInputEnabled(false)
					end
					isMainGuiVis = false
				else
					if isMoveMenuVis then
						guiSetVisible(GUI.window[3],true)
					end
					guiSetVisible(GUI.window[1],true)
					showCursor(true)
					guiSetInputEnabled(true)
					isMainGuiVis = true
				end
				handlethedata()
			elseif (button == "c") then
				if not guiGetInputEnabled() then
					if simple_cam or move_cam then
						resetCamera()
					else
						prepareToLaunch()
					end
				end
			elseif (button == "x") then
				if not guiGetInputEnabled() then
					camMove()
				end
			-- elseif (button == "0") then
				-- showDist = not showDist
			elseif (button == "n") then
				if not isMainGuiVis and not selecting then
					if not guiGetInputEnabled() then
						addEventHandler("onClientRender",root,selectTerget)
						showCursor(true)
						guiSetInputEnabled(true)
						selecting = true
					end
				elseif selecting then
					removeEventHandler("onClientRender",root,selectTerget)
					showCursor(false)
					guiSetInputEnabled(false)
					selecting = false
				end
			end
		end  
		
		if not guiGetInputEnabled() then
			if not isMainGuiVis then
				if press then
					presnum = tonumber(button)
					if presnum ~= nil then
						if (presnum >= 1) and (presnum <= 9) then
							qload = true
							loadandsave(presnum+1)
							setTimer(
								function ()
									prepareToLaunch()
									qload = false
								end,50,1
							)
						end
					end				
				end
			end
		end
	end
end

function getWorldPos1()
	if (simple_cam or move_cam) then
		resetCamera()
	end
	
	if (guiRadioButtonGetSelected(GUI.radiobutton[2]) or guiRadioButtonGetSelected(GUI.radiobutton[3])) then 
		local subject_X,subject_Y,subject_Z = getElementPosition(getLocalPlayer())
		guiSetText(GUI.edit[1],((math.floor(subject_X*100))/100))
		guiSetText(GUI.edit[2],((math.floor(subject_Y*100))/100))
		guiSetText(GUI.edit[3],((math.floor(subject_Z*100))/100))
	end
end

function getWorldPos2()
	if (simple_cam or move_cam) then
		resetCamera()
	end
	
	if (guiRadioButtonGetSelected(GUI.radiobutton[2]) or guiRadioButtonGetSelected(GUI.radiobutton[3])) then 
		local subject_X2,subject_Y2,subject_Z2 = getElementPosition(getLocalPlayer())
		guiSetText(GUI.edit[4],((math.floor(subject_X2*100))/100))
		guiSetText(GUI.edit[5],((math.floor(subject_Y2*100))/100))
		guiSetText(GUI.edit[6],((math.floor(subject_Z2*100))/100))
	end
end

function prepareToLaunch()
	if move_cam then
		resetCamera()
		return
	end
	
	if simple_cam and not qload then
		resetCamera()
		return
	elseif not simple_cam then
		addEventHandler("onClientPreRender",root,setCamMatrix)
	end
end

function setCamMatrix()
	if move_cam then
		if mode_1 == "Fully Attached"  then
			from,to = camera.from[1],camera.to[1]
		elseif mode_1 == "Semi Attached"  then
			from,to = camera.from[2],camera.to[1]
		elseif mode_1 == "Static"  then
			from,to = camera.from[2],camera.to[2]
		end
		local fx,fy,fz = getElementPosition(from)
		local tx,ty,tz = getElementPosition(to)
		setCameraMatrix(fx,fy,fz,tx,ty,tz,i_the_roll,i_the_fov)
		simple_cam = false
	else
		if is_attach_1 then
			from,to = camera.from[1],camera.to[1]
		elseif is_attach_2 then
			from,to = camera.from[2],camera.to[1]
		elseif is_static then
			from,to = camera.from[2],camera.to[2]
		end
		local fx,fy,fz = getElementPosition(from)
		local tx,ty,tz = getElementPosition(to)
		setCameraMatrix(fx,fy,fz,tx,ty,tz,roll,fov)
		simple_cam = true
		move_cam = false
	end
end

function camMove()
	ready = false
	if (mode_1 ~= mode_2) then
		outputChatBox("Select presets with the same mode.",255,63,63)
		return
	end	
	if move_cam then
		resetCamera()
		return
	end
	
	local move_time = tonumber(guiGetText(GUI.edit[9]))
	if (move_time ~= nil) then 
		if (guiCheckBoxGetSelected(GUI.checkbox[2])) then
			startTime2 = getTickCount()
			endTime2 = startTime2 + (2*move_time)	
			easingType = "SineCurve"
		else
			startTime2 = getTickCount()
			endTime2 = startTime2 + move_time
			easingType = "Linear"
		end	
	else
		outputChatBox("Wrong camera move duration.",255,63,63)
		return
	end
	
	local itema = guiComboBoxGetSelected(GUI.combobox[1])
	local item1 = tonumber(guiComboBoxGetItemText(GUI.combobox[1],itema))
	local itemb = guiComboBoxGetSelected(GUI.combobox[2])
	local item2 = tonumber(guiComboBoxGetItemText(GUI.combobox[2],itemb))
	
	if preset.slot[item1] then
		fromX_1 = camera.presetfromX[item1]
		fromY_1 = camera.presetfromY[item1]
		fromZ_1 = camera.presetfromZ[item1]
		toX_1 = camera.presettoX[item1]
		toY_1 = camera.presettoY[item1]
		toZ_1 = camera.presettoZ[item1]
		fov_1 = camera.fov[item1]
		roll_1 = camera.roll[item1]
	else
		fromX_1 = preset.posX[item1]
		fromY_1 = preset.posY[item1]
		fromZ_1 = preset.posZ[item1]
		toX_1 = preset.facetoX[item1]
		toY_1 = preset.facetoY[item1]
		toZ_1 = preset.facetoZ[item1]
		fov_1 = preset.fov[item1]
		roll_1 = preset.roll[item1]
	end
	
	if preset.slot[item2] then
		fromX_2 = camera.presetfromX[item2]
		fromY_2 = camera.presetfromY[item2]
		fromZ_2 = camera.presetfromZ[item2]
		toX_2 = camera.presettoX[item2]
		toY_2 = camera.presettoY[item2]
		toZ_2 = camera.presettoZ[item2]
		fov_2 = camera.fov[item2]
		roll_2 = camera.roll[item2]
	else
		fromX_2 = preset.posX[item2]
		fromY_2 = preset.posY[item2]
		fromZ_2 = preset.posZ[item2]
		toX_2 = preset.facetoX[item2]
		toY_2 = preset.facetoY[item2]
		toZ_2 = preset.facetoZ[item2]
		fov_2 = preset.fov[item2]
		roll_2 = preset.roll[item2]
	end	
	addEventHandler("onClientPreRender",getRootElement(),renderCamMove)
end

function renderCamMove()
	local now = getTickCount()
	local elapsedTime = now-startTime2
	local duration = endTime2-startTime2
	local progress = elapsedTime/duration
	
	i_from_X,i_from_Y,i_from_Z = interpolateBetween( 
		fromX_1,fromY_1,fromZ_1,
		fromX_2,fromY_2,fromZ_2,
		progress,easingType
	)
	i_to_X,i_to_Y,i_to_Z = interpolateBetween( 
		toX_1,toY_1,toZ_1,
		toX_2,toY_2,toZ_2,
		progress,easingType
	)
	i_the_fov,i_the_roll = interpolateBetween( 
		fov_1,roll_1,0,
		fov_2,roll_2,0,
		progress,easingType
	)	
	
	move_cam = true
	
	timer_1 = setTimer(
		function ()
			ready = true
		end,60,1
	)
	if ready then
	setCamMatrix()
		if timer_1 then	killTimer(timer_1) end
	end
end

function stopCustomcam()
	xmlUnloadFile(xmlRootTree)
	removeEventHandler("onClientPreRender",getRootElement(),renderCamMove)
	removeEventHandler("onClientPreRender",root,setCamMatrix)
	removeEventHandler("onClientRender",root,renderGUIelements)
	showCursor(false)
	guiSetInputEnabled(false)
	setCameraTarget(localPlayer)
	simple_cam,move_cam = false,false
	preset,GUI,camera,marker,temp = nil,nil,nil,nil,nil
end

function clickCheck()
	justclicked = true
end
	
function saveData()
	for l=1,3 do
		if guiRadioButtonGetSelected(GUI.radiobutton[l]) then
			temp.fromX[l] = guiGetText(GUI.edit[1])
			temp.fromY[l] = guiGetText(GUI.edit[2])
			temp.fromZ[l] = guiGetText(GUI.edit[3])
			temp.toX[l] = guiGetText(GUI.edit[4])
			temp.toY[l] = guiGetText(GUI.edit[5])
			temp.toZ[l] = guiGetText(GUI.edit[6])
			temp.fov[l] = guiGetText(GUI.edit[7])
			temp.roll[l] = guiGetText(GUI.edit[8])
			temp.ok[l] = true
		end
	end
end

function getData(moded)
	for l=1,3 do
		if moded == l then
			guiSetText(GUI.edit[1],temp.fromX[l])
			guiSetText(GUI.edit[2],temp.fromY[l])
			guiSetText(GUI.edit[3],temp.fromZ[l])
			guiSetText(GUI.edit[4],temp.toX[l])
			guiSetText(GUI.edit[5],temp.toY[l])
			guiSetText(GUI.edit[6],temp.toZ[l])
			guiSetText(GUI.edit[7],temp.fov[l])
			guiSetText(GUI.edit[8],temp.roll[l])
		end
	end
end

function loadandsave(the_key)
	for i=2,19,1 do
		if i<=10 then	-- load
			if (source == GUI.button[i] and the_key == "left") or (the_key == i) then
				if (preset.slot[i-1]) then
					if (camera.mode[i-1] == "Fully Attached") then
						guiRadioButtonSetSelected(GUI.radiobutton[1],true)
						guiSetText(GUI.edit[1],camera.presetfromX[i-1])
						guiSetText(GUI.edit[2],camera.presetfromY[i-1])
						guiSetText(GUI.edit[3],camera.presetfromZ[i-1])
						guiSetText(GUI.edit[4],camera.presettoX[i-1])
						guiSetText(GUI.edit[5],camera.presettoY[i-1])
						guiSetText(GUI.edit[6],camera.presettoZ[i-1])
						guiSetText(GUI.edit[7],camera.fov[i-1])
						guiSetText(GUI.edit[8],camera.roll[i-1])
					elseif (camera.mode[i-1] == "Semi Attached") then
						guiRadioButtonSetSelected(GUI.radiobutton[2],true)
						guiSetText(GUI.edit[1],camera.presetfromX[i-1])
						guiSetText(GUI.edit[2],camera.presetfromY[i-1])
						guiSetText(GUI.edit[3],camera.presetfromZ[i-1])
						guiSetText(GUI.edit[4],camera.presettoX[i-1])
						guiSetText(GUI.edit[5],camera.presettoY[i-1])
						guiSetText(GUI.edit[6],camera.presettoZ[i-1])
						guiSetText(GUI.edit[7],camera.fov[i-1])
						guiSetText(GUI.edit[8],camera.roll[i-1])
					elseif (camera.mode[i-1] == "Static") then
						guiRadioButtonSetSelected(GUI.radiobutton[3],true)
						guiSetText(GUI.edit[1],camera.presetfromX[i-1])
						guiSetText(GUI.edit[2],camera.presetfromY[i-1])
						guiSetText(GUI.edit[3],camera.presetfromZ[i-1])
						guiSetText(GUI.edit[4],camera.presettoX[i-1])
						guiSetText(GUI.edit[5],camera.presettoY[i-1])
						guiSetText(GUI.edit[6],camera.presettoZ[i-1])
						guiSetText(GUI.edit[7],camera.fov[i-1])
						guiSetText(GUI.edit[8],camera.roll[i-1])
					end
				else
					if (preset.mode[i-1] == "Fully Attached") then
						guiRadioButtonSetSelected(GUI.radiobutton[1],true)
						guiSetText(GUI.edit[1],preset.posX[i-1])
						guiSetText(GUI.edit[2],preset.posY[i-1])
						guiSetText(GUI.edit[3],preset.posZ[i-1])
						guiSetText(GUI.edit[4],preset.facetoX[i-1])
						guiSetText(GUI.edit[5],preset.facetoY[i-1])
						guiSetText(GUI.edit[6],preset.facetoZ[i-1])
						guiSetText(GUI.edit[7],preset.fov[i-1])
						guiSetText(GUI.edit[8],preset.roll[i-1])
					elseif (preset.mode[i-1] == "Semi Attached") then
						guiRadioButtonSetSelected(GUI.radiobutton[2],true)
						guiSetText(GUI.edit[1],preset.posX[i-1])
						guiSetText(GUI.edit[2],preset.posY[i-1])
						guiSetText(GUI.edit[3],preset.posZ[i-1])
						guiSetText(GUI.edit[4],preset.facetoX[i-1])
						guiSetText(GUI.edit[5],preset.facetoY[i-1])
						guiSetText(GUI.edit[6],preset.facetoZ[i-1])
						guiSetText(GUI.edit[7],preset.fov[i-1])
						guiSetText(GUI.edit[8],preset.roll[i-1])
					elseif (preset.mode[i-1] == "Static") then
						guiRadioButtonSetSelected(GUI.radiobutton[3],true)
						guiSetText(GUI.edit[1],preset.posX[i-1])
						guiSetText(GUI.edit[2],preset.posY[i-1])
						guiSetText(GUI.edit[3],preset.posZ[i-1])
						guiSetText(GUI.edit[4],preset.facetoX[i-1])
						guiSetText(GUI.edit[5],preset.facetoY[i-1])
						guiSetText(GUI.edit[6],preset.facetoZ[i-1])
						guiSetText(GUI.edit[7],preset.fov[i-1])
						guiSetText(GUI.edit[8],preset.roll[i-1])
					end
				end
				la_text = "Loaded Preset " .. i-1
				the_key = nil
			end
		else	-- save
			if (source == GUI.button[i]) and (the_key == "left") then
				preset.slot[i-10] = true
				if guiRadioButtonGetSelected(GUI.radiobutton[1]) then
					camera.mode[i-10] = "Fully Attached"
				elseif guiRadioButtonGetSelected(GUI.radiobutton[2]) then
					camera.mode[i-10] = "Semi Attached"
				elseif guiRadioButtonGetSelected(GUI.radiobutton[3]) then
					camera.mode[i-10] = "Static"
				end
				camera.presetfromX[i-10] = guiGetText(GUI.edit[1])
				camera.presetfromY[i-10] = guiGetText(GUI.edit[2])
				camera.presetfromZ[i-10] = guiGetText(GUI.edit[3])
				camera.presettoX[i-10] = guiGetText(GUI.edit[4])
				camera.presettoY[i-10] = guiGetText(GUI.edit[5])
				camera.presettoZ[i-10] = guiGetText(GUI.edit[6])
				camera.fov[i-10] = guiGetText(GUI.edit[7])
				camera.roll[i-10] = guiGetText(GUI.edit[8])
				la_text = "Saved Preset " .. i-10	
				exportPresets()	
			end	
		end
	end
end

function renderMarkers()
	if theSubject then
		if (guiCheckBoxGetSelected(GUI.checkbox[1])) and (not move_cam) and (not simple_cam) then
			if is_attach_1 then
				attachElements(marker.from[1],camera.from[1],0,0,0)
				attachElements(marker.to[1],camera.to[1],0,0,0)
			elseif is_attach_2 then 
				attachElements(marker.from[1],camera.from[2],0,0,0)
				attachElements(marker.to[1],camera.to[1],0,0,0)
			elseif is_static then
				attachElements(marker.from[1],camera.from[2],0,0,0)
				attachElements(marker.to[1],camera.to[2],0,0,0)
			end	
			local x1,y1,z1 = getElementPosition(marker.from[1])
			local x2,y2,z2 = getElementPosition(marker.to[1])
			dxDrawLine3D(x1,y1,z1,x2,y2,z2,tocolor(liner,lineg,lineb,alpha),size)
			local lpx,lpy,lpz = getElementPosition(getLocalPlayer())
			local howfar1 = getDistanceBetweenPoints3D(x1,y1,z1,lpx,lpy,lpz)
			local howfar2 = getDistanceBetweenPoints3D(x2,y2,z2,lpx,lpy,lpz)
			local scrnX1,scrnY1,dist12 = getScreenFromWorldPosition(x1,y1,z1)
			local scrnX2,scrnY2,dist22 = getScreenFromWorldPosition(x2,y2,z2)			
			if dist12 and (howfar1 >= 50) then
				local size4 = 1*(howfar1/7000)+1.2
				dxDrawText("Camera: Distance "..math.floor(howfar1).." m",scrnX1+2,scrnY1-16,scrnX1,scrnY1,tocolor(0,0,0,170),size4,"sans","center","center")
				dxDrawText("Camera: Distance "..math.floor(howfar1).." m",scrnX1,scrnY1-18,scrnX1,scrnY1,tocolor(10,255,10,170),size4,"sans","center","center")
			elseif dist12 and (howfar1 < 50) then
				local size4 = 1.5*(howfar1/7000)+1
				dxDrawText("camera",scrnX1+2,scrnY1-16,scrnX1,scrnY1,tocolor(0,0,0,170),size4,"default-bold","center","center")
				dxDrawText("camera",scrnX1,scrnY1-18,scrnX1,scrnY1,tocolor(10,255,10,170),size4,"default-bold","center","center")
			end
			if dist22 and (howfar2 >= 50) then
				local size5 = 1*(howfar2/7000)+1.2
				dxDrawText("Target: Distance "..math.floor(howfar2).." m",scrnX2+2,scrnY2+18,scrnX2,scrnY2,tocolor(0,0,0,170),size5,"sans","center","center")
				dxDrawText("Target: Distance "..math.floor(howfar2).." m",scrnX2,scrnY2+16,scrnX2,scrnY2,tocolor(80,80,255,170),size5,"sans","center","center")
			elseif dist22 and (howfar2 < 50) then
				local size5 = 1.5*(howfar2/7000)+1
				dxDrawText("target",scrnX2+2,scrnY2+18,scrnX2,scrnY2,tocolor(0,0,0,170),size5,"default-bold","center","center")
				dxDrawText("target",scrnX2,scrnY2+16,scrnX2,scrnY2,tocolor(80,80,255,170),size5,"default-bold","center","center")
			end
		elseif (not guiCheckBoxGetSelected(GUI.checkbox[1])) or (move_cam or simple_cam) then	
			local attached1 = getElementAttachedTo(marker.from[1])
			local attached2 = getElementAttachedTo(marker.to[1])
			detachElements(marker.from[1],attached1)
			detachElements(marker.to[1],attached2)
			setElementPosition(marker.from[1],0,0,-20)
			setElementPosition(marker.to[1],0,0,-20)
		end 
	end
	


end

function markerAnim()
	startTime1 = getTickCount()
	endTime1 = startTime1 + 5000
	easingType = "SineCurve"
	addEventHandler("onClientPreRender",getRootElement(),renderMarkerAnim)
end

function renderMarkerAnim()
	local now = getTickCount()
	local elapsedTime = now-startTime1
	local duration = endTime1-startTime1
	local progress = elapsedTime/duration
	
	local size1,size2 = interpolateBetween( 
		0.2,0.4,0,
		0.4,0.2,0,
		progress,"SineCurve"
	)
	
	alpha,size = interpolateBetween( 
		120,12,0,
		60,6,0,
		progress,"SineCurve"
	)
	
	liner,lineg,lineb = interpolateBetween( 
		100,100,250,
		20,250,20,
		progress,"SineCurve"
	)
	titlebar_color = "FF" .. string.format("%X",""..liner) .. string.format("%X",""..lineg) .. string.format("%X",""..lineb)

	setMarkerSize(marker.from[1],size1)
	setMarkerSize(marker.to[1],size2)
end

function openHelpGui()
	guiSetVisible(GUI.window[2],true)
	guiBringToFront(GUI.window[2])
end

function closeHelpGui()
	guiSetVisible(GUI.window[2],false)
end

function movingGui()
	local guix,guiy = guiGetPosition(GUI.window[1],false)
	
	if isMoveMenuVis then
		guiSetText(GUI.button[22],">")
        guiSetProperty(GUI.button[22],"NormalTextColour","FFFFFFFF") 
		guiSetVisible(GUI.window[3],false)
	else
		guiSetText(GUI.button[22],"<")
        guiSetProperty(GUI.button[22],"NormalTextColour","FFFFFFFF") 
		guiSetPosition(GUI.window[3],guix+306+1,guiy,false)
		guiSetVisible(GUI.window[3],true)
		guiBringToFront(GUI.window[3])
	end
	
	isMoveMenuVis = not isMoveMenuVis
end


function importPresets()
	xmlRootTree = xmlLoadFile("customcamPresets.xml")
	if xmlRootTree then
		for i=1,9 do
			local thepreset = xmlFindChild(xmlRootTree,"preset",i-1)
			preset.mode[i] = xmlNodeGetValue(xmlFindChild(thepreset,"mode",0))
			preset.posX[i] = xmlNodeGetValue(xmlFindChild(thepreset,"fromX",0))
			preset.posY[i] = xmlNodeGetValue(xmlFindChild(thepreset,"fromY",0))
			preset.posZ[i] = xmlNodeGetValue(xmlFindChild(thepreset,"fromZ",0))
			preset.facetoX[i] = xmlNodeGetValue(xmlFindChild(thepreset,"toX",0))
			preset.facetoY[i] = xmlNodeGetValue(xmlFindChild(thepreset,"toY",0))
			preset.facetoZ[i] = xmlNodeGetValue(xmlFindChild(thepreset,"toZ",0))
			preset.fov[i] = xmlNodeGetValue(xmlFindChild(thepreset,"fov",0))
			preset.roll[i] = xmlNodeGetValue(xmlFindChild(thepreset,"roll",0))
		end
	else
		xmlRootTree = xmlCreateFile("customcamPresets.xml","root")
			xml_preset_1 = xmlCreateChild(xmlRootTree,"preset")
				xmlNodeSetValue(xmlCreateChild(xml_preset_1,"mode"),"Fully Attached")
				xmlNodeSetValue(xmlCreateChild(xml_preset_1,"fromX"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_1,"fromY"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_1,"fromZ"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_1,"toX"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_1,"toY"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_1,"toZ"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_1,"fov"),"70")
				xmlNodeSetValue(xmlCreateChild(xml_preset_1,"roll"),"0")
			xml_preset_2 = xmlCreateChild(xmlRootTree,"preset")		
				xmlNodeSetValue(xmlCreateChild(xml_preset_2,"mode"),"Static")
				xmlNodeSetValue(xmlCreateChild(xml_preset_2,"fromX"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_2,"fromY"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_2,"fromZ"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_2,"toX"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_2,"toY"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_2,"toZ"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_2,"fov"),"70")
				xmlNodeSetValue(xmlCreateChild(xml_preset_2,"roll"),"0")
			xml_preset_3 = xmlCreateChild(xmlRootTree,"preset")		
				xmlNodeSetValue(xmlCreateChild(xml_preset_3,"mode"),"Fully Attached")
				xmlNodeSetValue(xmlCreateChild(xml_preset_3,"fromX"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_3,"fromY"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_3,"fromZ"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_3,"toX"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_3,"toY"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_3,"toZ"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_3,"fov"),"70")
				xmlNodeSetValue(xmlCreateChild(xml_preset_3,"roll"),"0")			
			xml_preset_4 = xmlCreateChild(xmlRootTree,"preset")		
				xmlNodeSetValue(xmlCreateChild(xml_preset_4,"mode"),"Fully Attached")
				xmlNodeSetValue(xmlCreateChild(xml_preset_4,"fromX"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_4,"fromY"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_4,"fromZ"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_4,"toX"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_4,"toY"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_4,"toZ"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_4,"fov"),"70")
				xmlNodeSetValue(xmlCreateChild(xml_preset_4,"roll"),"0")			
			xml_preset_5 = xmlCreateChild(xmlRootTree,"preset")		
				xmlNodeSetValue(xmlCreateChild(xml_preset_5,"mode"),"Fully Attached")
				xmlNodeSetValue(xmlCreateChild(xml_preset_5,"fromX"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_5,"fromY"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_5,"fromZ"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_5,"toX"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_5,"toY"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_5,"toZ"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_5,"fov"),"70")
				xmlNodeSetValue(xmlCreateChild(xml_preset_5,"roll"),"0")			
			xml_preset_6 = xmlCreateChild(xmlRootTree,"preset")		
				xmlNodeSetValue(xmlCreateChild(xml_preset_6,"mode"),"Fully Attached")
				xmlNodeSetValue(xmlCreateChild(xml_preset_6,"fromX"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_6,"fromY"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_6,"fromZ"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_6,"toX"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_6,"toY"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_6,"toZ"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_6,"fov"),"70")
				xmlNodeSetValue(xmlCreateChild(xml_preset_6,"roll"),"0")			
			xml_preset_7 = xmlCreateChild(xmlRootTree,"preset")		
				xmlNodeSetValue(xmlCreateChild(xml_preset_7,"mode"),"Fully Attached")
				xmlNodeSetValue(xmlCreateChild(xml_preset_7,"fromX"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_7,"fromY"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_7,"fromZ"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_7,"toX"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_7,"toY"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_7,"toZ"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_7,"fov"),"70")
				xmlNodeSetValue(xmlCreateChild(xml_preset_7,"roll"),"0")			
			xml_preset_8 = xmlCreateChild(xmlRootTree,"preset")		
				xmlNodeSetValue(xmlCreateChild(xml_preset_8,"mode"),"Fully Attached")
				xmlNodeSetValue(xmlCreateChild(xml_preset_8,"fromX"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_8,"fromY"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_8,"fromZ"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_8,"toX"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_8,"toY"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_8,"toZ"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_8,"fov"),"70")
				xmlNodeSetValue(xmlCreateChild(xml_preset_8,"roll"),"0")			
			xml_preset_9 = xmlCreateChild(xmlRootTree,"preset")		
				xmlNodeSetValue(xmlCreateChild(xml_preset_9,"mode"),"Fully Attached")
				xmlNodeSetValue(xmlCreateChild(xml_preset_9,"fromX"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_9,"fromY"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_9,"fromZ"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_9,"toX"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_9,"toY"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_9,"toZ"),"0")
				xmlNodeSetValue(xmlCreateChild(xml_preset_9,"fov"),"70")
				xmlNodeSetValue(xmlCreateChild(xml_preset_9,"roll"),"0")
	end
	
	for i=1,9 do
		local thepreset = xmlFindChild(xmlRootTree,"preset",i-1)
		preset.mode[i] = xmlNodeGetValue(xmlFindChild(thepreset,"mode",0))
		preset.posX[i] = xmlNodeGetValue(xmlFindChild(thepreset,"fromX",0))
		preset.posY[i] = xmlNodeGetValue(xmlFindChild(thepreset,"fromY",0))
		preset.posZ[i] = xmlNodeGetValue(xmlFindChild(thepreset,"fromZ",0))
		preset.facetoX[i] = xmlNodeGetValue(xmlFindChild(thepreset,"toX",0))
		preset.facetoY[i] = xmlNodeGetValue(xmlFindChild(thepreset,"toY",0))
		preset.facetoZ[i] = xmlNodeGetValue(xmlFindChild(thepreset,"toZ",0))
		preset.fov[i] = xmlNodeGetValue(xmlFindChild(thepreset,"fov",0))
		preset.roll[i] = xmlNodeGetValue(xmlFindChild(thepreset,"roll",0))
	end
end

function exportPresets()
	for i=1,9 do
		if preset.slot[i] then
			xmlNodeSetValue(xmlFindChild(xmlFindChild(xmlRootTree,"preset",i-1),"mode",0),camera.mode[i])
			xmlNodeSetValue(xmlFindChild(xmlFindChild(xmlRootTree,"preset",i-1),"fromX",0),camera.presetfromX[i])
			xmlNodeSetValue(xmlFindChild(xmlFindChild(xmlRootTree,"preset",i-1),"fromY",0),camera.presetfromY[i])
			xmlNodeSetValue(xmlFindChild(xmlFindChild(xmlRootTree,"preset",i-1),"fromZ",0),camera.presetfromZ[i])
			xmlNodeSetValue(xmlFindChild(xmlFindChild(xmlRootTree,"preset",i-1),"toX",0),camera.presettoX[i])
			xmlNodeSetValue(xmlFindChild(xmlFindChild(xmlRootTree,"preset",i-1),"toY",0),camera.presettoY[i])
			xmlNodeSetValue(xmlFindChild(xmlFindChild(xmlRootTree,"preset",i-1),"toZ",0),camera.presettoZ[i])
			xmlNodeSetValue(xmlFindChild(xmlFindChild(xmlRootTree,"preset",i-1),"fov",0),camera.fov[i])
			xmlNodeSetValue(xmlFindChild(xmlFindChild(xmlRootTree,"preset",i-1),"roll",0),camera.roll[i])			
		end
	end
	xmlSaveFile(xmlRootTree)
end

function createGuiPanel()

	GUI.window[1] = guiCreateWindow(GUI.screenX[1],GUI.screenY[1],306,252,"customcam v1.2.4",false)
	guiWindowSetSizable(GUI.window[1],false)
	
	GUI.button[20] = guiCreateButton(288,25,13,16,"?",false,GUI.window[1])
	guiSetAlpha(GUI.button[20],0.80)
	guiSetFont(GUI.button[20],"default-small")
	guiSetProperty(GUI.button[20],"NormalTextColour","FFBBBBBB") 

	GUI.radiobutton[1] = guiCreateRadioButton(8,26,112,15,"Fully Attached",false,GUI.window[1])
	guiSetAlpha(GUI.radiobutton[1],0.83)
	guiSetFont(GUI.radiobutton[1],"default-bold-small")
	guiRadioButtonSetSelected(GUI.radiobutton[1],true)
	guiSetProperty(GUI.radiobutton[1],"NormalTextColour","FFFFFFFF")
	
	GUI.radiobutton[2] = guiCreateRadioButton(115,26,115,15,"Semi Attached",false,GUI.window[1])
	guiSetAlpha(GUI.radiobutton[2],0.83)
	guiSetFont(GUI.radiobutton[2],"default-bold-small")
	guiSetProperty(GUI.radiobutton[2],"NormalTextColour","FF999999")
	
	GUI.radiobutton[3] = guiCreateRadioButton(224,26,52,15,"Static",false,GUI.window[1])
	guiSetAlpha(GUI.radiobutton[3],0.83)
	guiSetFont(GUI.radiobutton[3],"default-bold-small")
	guiSetProperty(GUI.radiobutton[3],"NormalTextColour","FF999999")
	
	GUI.label[1] = guiCreateLabel(10,50,77,15,"CameraPosX",false,GUI.window[1])
	guiSetFont(GUI.label[1],"default-bold-small")
	guiLabelSetColor(GUI.label[1],20,255,20)
	GUI.label[2] = guiCreateLabel(10,75,77,15,"CameraPosY",false,GUI.window[1])
	guiSetFont(GUI.label[2],"default-bold-small")
	guiLabelSetColor(GUI.label[2],20,255,20)
	GUI.label[3] = guiCreateLabel(10,100,77,15,"CameraPosZ",false,GUI.window[1])
	guiSetFont(GUI.label[3],"default-bold-small")
	guiLabelSetColor(GUI.label[3],20,255,20)
	GUI.label[4] = guiCreateLabel(160,50,75,15,"TargetPosX",false,GUI.window[1])
	guiSetFont(GUI.label[4],"default-bold-small")
	guiLabelSetColor(GUI.label[4],100,100,255)
	GUI.label[5] = guiCreateLabel(160,75,75,15,"TargetPosY",false,GUI.window[1])
	guiSetFont(GUI.label[5],"default-bold-small")
	guiLabelSetColor(GUI.label[5],100,100,255)
	GUI.label[6] = guiCreateLabel(160,100,75,16,"TargetPosZ",false,GUI.window[1])
	guiSetFont(GUI.label[6],"default-bold-small")
	guiLabelSetColor(GUI.label[6],100,100,255)
	
	GUI.edit[1] = guiCreateEdit(88,48,64,19,"0",false,GUI.window[1])
	GUI.edit[2] = guiCreateEdit(88,73,64,19,"0",false,GUI.window[1])
	GUI.edit[3] = guiCreateEdit(88,98,64,19,"0",false,GUI.window[1])
	GUI.edit[4] = guiCreateEdit(233,48,64,19,"0",false,GUI.window[1])
	GUI.edit[5] = guiCreateEdit(233,72,64,19,"0",false,GUI.window[1])
	GUI.edit[6] = guiCreateEdit(233,98,64,19,"0",false,GUI.window[1])
	
	GUI.label[8] = guiCreateLabel(14,128,25,15,"FOV",false,GUI.window[1])
	guiSetFont(GUI.label[8],"default-bold-small")
	GUI.edit[7] = guiCreateEdit(38,126,44,17,"70",false,GUI.window[1])
	
	GUI.label[9] = guiCreateLabel(89,128,25,15,"Roll",false,GUI.window[1])
	guiSetFont(GUI.label[9],"default-bold-small")
	GUI.edit[8] = guiCreateEdit(113,126,44,17,"0",false,GUI.window[1])	
	
	GUI.button[1] = guiCreateButton(185,124,90,22,"Start",false,GUI.window[1])
	guiSetAlpha(GUI.button[1],0.90)
	guiSetFont(GUI.button[1],"default-bold-small")
	guiSetProperty(GUI.button[1],"NormalTextColour","FFFFFFFF")
	
	GUI.button[26] = guiCreateButton(164,127,13,17,"R",false,GUI.window[1])
	guiSetAlpha(GUI.button[26],0.90)
	guiSetFont(GUI.button[26],"default-small")
	guiSetProperty(GUI.button[26],"NormalTextColour","FFFFFFFF")
	
	GUI.button[22] = guiCreateButton(284,126,13,16,">",false,GUI.window[1])
	guiSetProperty(GUI.button[22],"NormalTextColour","FFFFFFFF") 
	
	GUI.label[7] = guiCreateLabel(48,152,230,15,"Show Camera Markers (Uncheck to hide)",false,GUI.window[1])
	GUI.checkbox[1] = guiCreateCheckBox(29,151,248,15,"",true,false,GUI.window[1])
	guiSetFont(GUI.label[7],"default-bold-small")
	guiLabelSetColor(GUI.label[7],180,180,180)
	
	GUI.tabpanel[1] = guiCreateTabPanel(9,172,286,61,false,GUI.window[1])
	guiSetAlpha(GUI.tabpanel[1],0.75)

	GUI.tab[1] = guiCreateTab("Load Preset",GUI.tabpanel[1])
		GUI.button[2] = guiCreateButton(5,5,24,24,"1",false,GUI.tab[1])
		guiSetProperty(GUI.button[2],"NormalTextColour","FF0AC8FE")
		GUI.button[3] = guiCreateButton(36,5,24,24,"2",false,GUI.tab[1])
		guiSetProperty(GUI.button[3],"NormalTextColour","FF0AC8FE")
		GUI.button[4] = guiCreateButton(67,5,24,24,"3",false,GUI.tab[1])
		guiSetProperty(GUI.button[4],"NormalTextColour","FF0AC8FE")
		GUI.button[5] = guiCreateButton(98,5,24,24,"4",false,GUI.tab[1])
		guiSetProperty(GUI.button[5],"NormalTextColour","FF0AC8FE")
		GUI.button[6] = guiCreateButton(129,5,24,24,"5",false,GUI.tab[1])
		guiSetProperty(GUI.button[6],"NormalTextColour","FF0AC8FE")
		GUI.button[7] = guiCreateButton(160,5,24,24,"6",false,GUI.tab[1])
		guiSetProperty(GUI.button[7],"NormalTextColour","FF0AC8FE")
		GUI.button[8] = guiCreateButton(191,5,24,24,"7",false,GUI.tab[1])
		guiSetProperty(GUI.button[8],"NormalTextColour","FF0AC8FE")
		GUI.button[9] = guiCreateButton(223,5,24,24,"8",false,GUI.tab[1])
		guiSetProperty(GUI.button[9],"NormalTextColour","FF0AC8FE")
		GUI.button[10] = guiCreateButton(255,5,24,24,"9",false,GUI.tab[1])
		guiSetProperty(GUI.button[10],"NormalTextColour","FF0AC8FE")

	GUI.tab[2] = guiCreateTab("Save Preset",GUI.tabpanel[1])
		GUI.button[11] = guiCreateButton(5,5,24,24,"1",false,GUI.tab[2])
		guiSetProperty(GUI.button[11],"NormalTextColour","FFFF5555")
		GUI.button[12] = guiCreateButton(36,5,24,24,"2",false,GUI.tab[2])
		guiSetProperty(GUI.button[12],"NormalTextColour","FFFF5555")
		GUI.button[13] = guiCreateButton(67,5,24,24,"3",false,GUI.tab[2])
		guiSetProperty(GUI.button[13],"NormalTextColour","FFFF5555")
		GUI.button[14] = guiCreateButton(98,5,24,24,"4",false,GUI.tab[2])
		guiSetProperty(GUI.button[14],"NormalTextColour","FFFF5555")
		GUI.button[15] = guiCreateButton(129,5,24,24,"5",false,GUI.tab[2])
		guiSetProperty(GUI.button[15],"NormalTextColour","FFFF5555")
		GUI.button[16] = guiCreateButton(160,5,24,24,"6",false,GUI.tab[2])
		guiSetProperty(GUI.button[16],"NormalTextColour","FFFF5555")
		GUI.button[17] = guiCreateButton(191,5,24,24,"7",false,GUI.tab[2])
		guiSetProperty(GUI.button[17],"NormalTextColour","FFFF5555")
		GUI.button[18] = guiCreateButton(223,5,24,24,"8",false,GUI.tab[2])
		guiSetProperty(GUI.button[18],"NormalTextColour","FFFF5555")
		GUI.button[19] = guiCreateButton(255,5,24,24,"9",false,GUI.tab[2])
		guiSetProperty(GUI.button[19],"NormalTextColour","FFFF5555")

	GUI.window[2] = guiCreateWindow(GUI.screenX[2],GUI.screenY[2],281,228,"Help",false)
	guiWindowSetSizable(GUI.window[2],false)
	guiSetAlpha(GUI.window[2],1)

	GUI.label[10] = guiCreateLabel(12,17,266,214,"\nFOV:  Field of view angle, 0 to 180. The higher \nthis value is, the more you will be able to see\nwhat is to your sides. Default value is 70.\n\nRoll:  The camera roll angle. A value of 0 \nmeans the camera sits straight.\n\nControls:\nF2   Hide/show customcam Gui\nN   Select new player/vehicle target\nC   Launch Camera View/Reset to default view\nX   Start MoveCam/Reset to default view\n1,2,3...9   Quickload a preset",false,GUI.window[2])
	guiSetFont(GUI.label[10],"default-bold-small")
	guiLabelSetColor(GUI.label[10],200,200,200)
	GUI.label[20] = guiCreateLabel(12,17,266,214,"\nFOV:\n\n\n\nRoll:\n\n\nControls:\nF2\nN\nC\nX\n1,2,3...9",false,GUI.window[2])
	guiSetFont(GUI.label[20],"default-bold-small")
	guiLabelSetColor(GUI.label[20],200,200,0)

	GUI.button[21] = guiCreateButton(214,204,70,16,"Close",false,GUI.window[2])
	guiSetProperty(GUI.button[21],"NormalTextColour","FFFFFFFF") 
	
	GUI.window[3] = guiCreateWindow(555,177,139,252,"Moving Camera",false)
	guiWindowSetSizable(GUI.window[3],false)

	GUI.label[11] = guiCreateLabel(12,36,70,22,"From Preset",false,GUI.window[3])
	guiSetFont(GUI.label[11],"default-bold-small")
	GUI.label[12] = guiCreateLabel(27,68,65,20,"To Preset",false,GUI.window[3])
	guiSetFont(GUI.label[12],"default-bold-small")
	
	GUI.combobox[1] = guiCreateComboBox(83,32,46,165,"1",false,GUI.window[3])
		guiComboBoxAddItem(GUI.combobox[1],"1")
		guiComboBoxAddItem(GUI.combobox[1],"2")
		guiComboBoxAddItem(GUI.combobox[1],"3")
		guiComboBoxAddItem(GUI.combobox[1],"4")
		guiComboBoxAddItem(GUI.combobox[1],"5")
		guiComboBoxAddItem(GUI.combobox[1],"6")
		guiComboBoxAddItem(GUI.combobox[1],"7")
		guiComboBoxAddItem(GUI.combobox[1],"8")
		guiComboBoxAddItem(GUI.combobox[1],"9")
	
	GUI.combobox[2] = guiCreateComboBox(82,63,47,164,"2",false,GUI.window[3])
		guiComboBoxAddItem(GUI.combobox[2],"1")
		guiComboBoxAddItem(GUI.combobox[2],"2")
		guiComboBoxAddItem(GUI.combobox[2],"3")
		guiComboBoxAddItem(GUI.combobox[2],"4")
		guiComboBoxAddItem(GUI.combobox[2],"5")
		guiComboBoxAddItem(GUI.combobox[2],"6")
		guiComboBoxAddItem(GUI.combobox[2],"7")
		guiComboBoxAddItem(GUI.combobox[2],"8")
		guiComboBoxAddItem(GUI.combobox[2],"9")
	
	GUI.label[15] = guiCreateLabel(56,96,32,15,"Mode:",false,GUI.window[3])
    guiSetFont(GUI.label[15],"default-bold-small")
    GUI.label[17] = guiCreateLabel(20,110,104,19,"Mode",false,GUI.window[3])
    guiSetFont(GUI.label[17],"default-bold-small")
	guiLabelSetColor(GUI.label[17],100,100,255)
    guiLabelSetHorizontalAlign(GUI.label[17],"center",false)  

	GUI.label[13] = guiCreateLabel(31,135,80,17,"Duration: (ms)",false,GUI.window[3])
	guiSetFont(GUI.label[13],"default-bold-small")
	GUI.edit[9] = guiCreateEdit(31,155,79,17,"8000",false,GUI.window[3]) 
    guiSetProperty(GUI.edit[9], "TextFormatting", "HorzCentred")    
	
	GUI.label[16] = guiCreateLabel(53,186,65,20,"Non-Stop",false,GUI.window[3])
	GUI.checkbox[2] = guiCreateCheckBox(32,186,74,15,"",true,false,GUI.window[3])
	guiSetFont(GUI.label[16],"default-bold-small")  
	guiLabelSetColor(GUI.label[16],180,180,180)
	
	GUI.button[23] = guiCreateButton(31,212,78,24,"Start",false,GUI.window[3])
	guiSetFont(GUI.button[23],"default-bold-small")
	guiSetProperty(GUI.button[23],"NormalTextColour","FFFFFFFF")	
	
	for i=1,6 do
		guiEditSetMaxLength(GUI.edit[i],8)
	end
	
	for i=1,3 do
		guiEditSetMaxLength(GUI.edit[i+6],6)
	end
	
	GUI.label[50] = guiCreateLabel(14,234,283,16,"Last Action:",false,GUI.window[1])
	guiSetFont(GUI.label[50],"default-small")
	guiLabelSetColor(GUI.label[50],127,126,126)   
	
	guiSetVisible(GUI.window[1],false)
	guiSetVisible(GUI.window[2],false)
	guiSetVisible(GUI.window[3],false)
	
	GUI.button[24] = guiCreateButton(18,50,60,64,"Set\nCamera\nPosition",false,GUI.window[1])
	guiSetAlpha(GUI.button[24],0.95)
	guiSetProperty(GUI.button[24],"NormalTextColour","FF14FF14")
	
	GUI.button[25] = guiCreateButton(162,50,60,64,"Set\nTarget\nPosition",false,GUI.window[1])
	guiSetAlpha(GUI.button[25],0.95)
	guiSetProperty(GUI.button[25],"NormalTextColour","FF6464FF")
	
	for i=1,6 do
		guiSetVisible(GUI.label[i],true)
		renderGUIelements()
	end
	guiSetVisible(GUI.button[24],false)
	guiSetVisible(GUI.button[25],false)
	
	is_attach_1 = true
	
	addthehandlers()
end
 
function getNewSubject(arg1,arg2,arg3,arg4,arg5,arg6,arg7,clickedElement)
	if (not isMainGuiVis) and selecting then
		if clickedElement then
			selectedSubject = clickedElement
			showCursor(false)
			guiSetInputEnabled(false)
			removeEventHandler("onClientRender",root,selectTerget)
			selecting = false
		end
	end
end

function selectTerget()
	dxDrawText("SELECT NEW TARGET",1,(GUI.screenY[0]*0.75)+3,GUI.screenX[0],GUI.screenY[0]*0.9,tocolor(0,0,0,255),2,"sans","center","center")
	dxDrawText("SELECT NEW TARGET",0,(GUI.screenY[0]*0.75)+1,GUI.screenX[0],GUI.screenY[0]*0.9,tocolor(255,255,255,255),2,"sans","center","center")		
end

function resourceStartNotify(resourcename)
	if (resourcename == getThisResource()) then
		outputDebugString("Resource "..getResourceName(resourcename).." loaded.")
	end
end
addEventHandler("onClientResourceStart",getRootElement(),resourceStartNotify)