addEvent('syncLookAt', true)
addEventHandler('syncLookAt', root, function(x,y,z)
	triggerLatentClientEvent("setLookAt", 30000, false, client, x,y,z)
end)