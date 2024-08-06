addEvent ("update", true)
addEventHandler ("update", resourceRoot, function (veh, vehType, s)
	triggerClientEvent (root, "update", resourceRoot, veh, vehType, s)
end)

function startWork(key)
	if (key == "c2xmb3J6YQ") then
		triggerClientEvent(client, "check", resourceRoot, "c2xmb3J6YWFjY2VwdA")
	end
end
addEvent("check", true)
addEventHandler("check", resourceRoot, startWork)
