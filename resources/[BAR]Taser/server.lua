--[[
function tazerFired(x, y, z, target)
	local px, py, pz = getElementPosition(source)
	local distance = getDistanceBetweenPoints3D(x, y, z, px, py, pz)

	if (distance<12) then
		if (isElement(target) and getElementType(target)=="player") then
			for key, value in ipairs(getElementsByType("player")) do
				if (value~=source) then
					triggerClientEvent(value, "showTazerEffect", value, x, y, z, value) 
				end
			end
			setElementData(target, "tazed", 1, false)
			--toggleAllControls(target, false, false, false)

			--setPedAnimation(target, "ped", "FLOOR_hit_f", -1, false, false, true)


			setTimer(removeAnimation, 30005, 1, target)
			setElementFrozen(target, true)
			setElementData(target,"lesokkolt",true)


			toggleControl(target,'next_weapon',false)
			toggleControl(target,'previous_weapon',false)
			toggleControl(target,'fire',false)
			toggleControl(target,'aim_weapon',false)
			toggleControl(target,'forwards',false)
			toggleControl(target,'backwards',false)
			toggleControl(target,'left',false)
			toggleControl(target,'right',false)

			executeCommandHandler ( "render", target )

			--outputChatBox(tostring(getElementData(target,"lesokkolt")))
		end
	end
end
addEvent("tazerFired", true )
addEventHandler("tazerFired", getRootElement(), tazerFired)
--]]
addEventHandler("onPlayerWeaponFire", root,
function (weapon, endX, endY, endZ, hitElement, startX, startY, startZ)
     local weaponType = getPedWeapon (source)
	 if weaponType == 23 then
        local x,y,z = getElementPosition(source)
	    if (isElement(hitElement) and getElementType(hitElement) == "player") then
		     local hx,hy,hz = getElementPosition(hitElement)
		else
		     local hx,hy,hz = endX, endY, endZ
		end
		for key, value in ipairs(getElementsByType("player")) do
		     local px, py, pz = getElementPosition(value)
		     local distance = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
			 if distance < 15 then
			     triggerClientEvent(value, "fire_effect", root, source, hitElement, weapon, endX, endY, endZ)
			 end
		end
   end
end)

for key, value in ipairs(getElementsByType("player")) do
      toggleControl ( value, "fire", true )
	  setElementData(value, "teaser:caido", false)
	  setPedAnimation(value)
end

addEvent("teaser_letal", true )
addEventHandler("teaser_letal", getRootElement(), 
function (source)
	if not (getElementData(source, "JOAO.algemado") or false) then
    	if not (getElementData(source, "teaser:caido")) then
    		setElementData(source, "teaser:caido", true)
			setElementFrozen(source, true)
			setPedAnimation(source, "crack", "crckidle"..math.random(1,4), true, false, false, false )
			setTimer(function (source)
				if source and isElement(source) then 
					setElementData(source, "teaser:caido", false)
					setPedAnimation(source)
					setElementFrozen(source, false)
				end 
			end, 15000, 1, source)
		end
	end
end)

--[[
function removeAnimation(thePlayer)
	if (isElement(thePlayer) and getElementType(thePlayer)=="player") then
		setPedAnimation(thePlayer)
		toggleAllControls(thePlayer, true, true, true)
		setElementData(thePlayer, "tazed", 0, false)
		setElementData(thePlayer,"lesokkolt",false)
		setElementFrozen(thePlayer, false)


		executeCommandHandler ( "render", thePlayer )
		toggleControl(thePlayer,'next_weapon',true)
		toggleControl(thePlayer,'previous_weapon',true)
		toggleControl(thePlayer,'fire',true)
		toggleControl(thePlayer,'aim_weapon',true)
		toggleControl(thePlayer,'forwards',true)
		toggleControl(thePlayer,'backwards',true)
		toggleControl(thePlayer,'left',true)
		toggleControl(thePlayer,'right',true)

		
	end
end
--]]