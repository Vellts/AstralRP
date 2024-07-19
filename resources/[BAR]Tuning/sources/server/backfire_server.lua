local CarsSettings = {}

function setElementSpeed(element, unit, speed)
	if (unit == nil) then unit = 0 end
	if (speed == nil) then speed = 0 end
	speed = tonumber(speed)
	local acSpeed = getElementSpeed(element, unit)
	if (acSpeed~=false) then
		local diff = speed/acSpeed
		local x,y,z = getElementVelocity(element)
		setElementVelocity(element,x*diff,y*diff,z*diff)
		return true
	end
 
	return false
end

function getElementSpeed(element,unit)
	if (unit == nil) then unit = 0 end
	if (isElement(element)) then
		local x,y,z = getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit =='1') then
			return (x^2 + y^2 + z^2) ^ 0.5 * 100
		else
			return (x^2 + y^2 + z^2) ^ 0.5 * 1.61 * 100
		end
	else
		outputDebugString("Not an element. Can't get speed")
		return false
	end
end

addEventHandler ( "onResourceStart", resourceRoot,
	function ( )
		local StationsFile = xmlLoadFile ( "backfire_settings.xml" )
		if ( StationsFile ) then
			outputDebugString ( "backfire_settings.xml successfully open")
			for _, data in ipairs ( xmlNodeGetChildren ( StationsFile ) ) do
				local attrs = xmlNodeGetAttributes ( data )
				CarsSettings[tostring(attrs.name)] = { x = tonumber(attrs.x), y = tonumber(attrs.y), z = tonumber(attrs.z) }
			end
		else
			outputDebugString ( "Failed to open to backfire_settings.xml", 1 )
		end
	end
)



addEvent ( "create3DBackfireSound", true )
addEventHandler ( "create3DBackfireSound", root,
	function ( theVehicle)
		if ( theVehicle ) then
			local vehicleName = getVehicleName( theVehicle )
			if ( type(CarsSettings[vehicleName]) == "table" ) then
				local x, y, z = tonumber(CarsSettings[vehicleName].x), tonumber(CarsSettings[vehicleName].y), tonumber(CarsSettings[vehicleName].z);
				triggerClientEvent(root, "create3DBackfireSoundClient", root, theVehicle, x, y, z)
			end
		end
	end
)


function startMonitoring ( thePlayer, seat, jacked )
	if (seat == 0) then
		triggerClientEvent(thePlayer, "chandeMonitoringState", thePlayer, true, source)
	end
end
addEventHandler ( "onVehicleEnter", getRootElement(), startMonitoring )
 
function stopMonitoring ( thePlayer, seat, jacked )
    if (seat == 0) then
		triggerClientEvent(thePlayer, "chandeMonitoringState", thePlayer, false)
	end
end
addEventHandler ( "onVehicleExit", getRootElement(), stopMonitoring )