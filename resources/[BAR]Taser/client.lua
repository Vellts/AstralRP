local iRechargeDelay = 10000
local iHitWiresBlinkDuration = 5000
local iMissWiresBlinkDuration = 100
local iDisableDuration = 10000

local iMaxDistance = 9

local iLastShot = 0
local iLastHit = 0
local pTaserSound = nil
local pHeartbeatSound = nil
local pTaserShotsAround = {}
local pWakeUpTimer = {}
local fProgress = 0

local pTaserBeamMaterial = dxCreateTexture("files/img/beam.png")

local pBlockedControlsList = { "jump", "forwards", "backwards", "left", "right", "previous_weapon", "next_weapon", "aim_weapon" }

addEventHandler("onClientKey", root, function(button, press) 
     local theVehicle = getPedOccupiedVehicle ( localPlayer )
	 if theVehicle then
         if (button == "lctrl" or button == "rctrl") then
             cancelEvent() 
		 end
     end 
end)



function timerIn ()
    if not fProgress  then
	     fProgress = 0
	end
	fProgress = fProgress + 1
	if fProgress > 100 then
	     killTimer(execTimer)
		 fProgress = false
		 removeEventHandler( "onClientRender", root, DrawTaserCharge)
	end
end

function DrawTaserCharge()
		local tx, ty, tz = getPedTargetStart(localPlayer)
		local sx, sy = getScreenFromWorldPosition( tx, ty, tz )

		if sx and sy then
			if tonumber((fProgress or 0) > 100) then
			    removeEventHandler( "onClientRender", root, DrawTaserCharge)	
			end
			if (fProgress >= 1) then
				dxDrawRectangle( sx-70, sy+30, 200, 15, tocolor( 50, 50, 50, 150 ) )
				dxDrawRectangle( sx-70, sy+30, 2*fProgress, 15, tocolor( 200-(fProgress), 50+(fProgress), 50 ) )
				dxDrawText( "    Recarregando: "..math.floor(fProgress).."%", sx-70, sy+30, sx+90, sy+45, tocolor(255,255,255), 1, "default-bold", "center", "center"  )
			end
		end
	end


addEvent("fire_effect", true )
addEventHandler("fire_effect", getRootElement(),
function (attack, vitima, weapons, fx, fy, fz)
     if attack then
		 if weapons then 
	         local shot_data = 
	         {
		         started = getTickCount(),
		         source = attack,
		         target = vitima,
				 fix    = fx,
				 fiy    = fy,
				 fiz    = fz,
	         }
			 table.insert(pTaserShotsAround, shot_data)
			 if #pTaserShotsAround == 1 then
			     addEventHandler( "onClientRender", root, dxFio)
			 end		 
		 end
	 end
	 if localPlayer == vitima then
	     if isElement(viSound) then stopSound(viSound) end
	     viSound = playSound( "files/sound/heartbeat.mp3")
		 setTimer(stopSound, 20000, 1, viSound)
		 triggerServerEvent("teaser_letal", localPlayer, localPlayer)
	 end
	 if attack == localPlayer then
		 toggleControl("fire", false)	
		 setTimer(toggleControl, 12000, 1, "fire", true)
		 execTimer = setTimer(timerIn, 100, 0)
		 fProgress = 0
	     addEventHandler( "onClientRender", root, DrawTaserCharge)	 
	 end
     if isElement(pTaserSound) then stopSound(pTaserSound) end
	 x,y,z = getElementPosition(attack)
     pTaserSound = playSound3D( "files/sound/taser.mp3", x,y,z )
end)

addEvent("cancel_effect", true )
addEventHandler("cancel_effect", getRootElement(),
function ()
     if isElement(pTaserSound) then
          stopSound(pTaserSound)
	 end
     removeEventHandler( "onClientRender", root, dxFio)
end)

function dxFio ()
     if #pTaserShotsAround == 0 then
	     removeEventHandler( "onClientRender", root, dxFio)
	 end
	 for i, shot in pairs(pTaserShotsAround) do
	     if getPedWeapon(shot.source) == 23 then

			     local x,y,z = getPedWeaponMuzzlePosition( shot.source )
				 if isElement(shot.target) then
				      local vx,vy,vz = getElementPosition(shot.target)
				 end
				for i=1,3 do
					local vecRandBias = Vector3( math.random(1,3)/10, math.random(1,3)/10, math.random(1,3)/10 )
					if isElement(shot.target) then
						if getElementType(shot.target) == "player" then
							local tx,ty,tz = getPedBonePosition( shot.target, 2 )
							dxDrawMaterialLine3D( x,y,z, Vector3(tx,ty,tz)+vecRandBias, pTaserBeamMaterial, 0.01 )
						else
							dxDrawMaterialLine3D( x,y,z, Vector3(shot.fix,shot.fiy,shot.fiz)+vecRandBias, pTaserBeamMaterial, 0.01 )
						end
					end 
				end

				if getTickCount() - shot.started >= iHitWiresBlinkDuration then
					if shot.source == localPlayer then
						toggleControl( "aim_weapon", true )
					end
					table.remove(pTaserShotsAround, i)
				end
			else
				if getTickCount() - shot.started >= iMissWiresBlinkDuration then
					table.remove(pTaserShotsAround, i)
				end
		end
	end
end


function cancelTazerDamage(attacker, weapon, bodypart, loss)
	if (weapon==23) then
		cancelEvent()
	end
end
addEventHandler("onClientPlayerDamage", localPlayer, cancelTazerDamage)

local txd = engineLoadTXD ( "files/mdl/taser.txd" )
engineImportTXD ( txd, 347 )
local dff = engineLoadDFF ( "files/mdl/taser.dff" )
engineReplaceModel ( dff, 347 )

addEventHandler("onClientKey", getRootElement(), 
	function (b)
		if b == "tab" then
			if getPedWeapon(localPlayer) == 23 then
				cancelEvent()
			end
		end
	end
)