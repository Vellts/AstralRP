gpsRoute = false;
gpsThread = false;
gpsWaypoints = {};
nextWp = false;
turnAround = false;
currentWaypoint = false;
waypointInterpolation = false;
waypointEndInterpolation = false;
reRouting = false;

local waypointColShapes = false;
local colShapes = {};

local checkForRerouteTimer = false;
local rerouteCheckRate = 1500;

local distanceDivider = 0.2;
local markedBlip = nil;

addEventHandler("onClientVehicleEnter", getRootElement(),

	function (player)

		if player == localPlayer then

			carCanGPS();

			if getElementData(source, "gpsDestination") then

				local destination = getElementData(source, "gpsDestination");

				gpsThread = coroutine.create(makeRoute);
				coroutine.resume(gpsThread, destination[1], destination[2], true);

			end

		end

	end

)

addEventHandler("onClientVehicleExit", getRootElement(),

	function (player)

		if player == localPlayer and gpsRoute then

			endRoute();

		end

	end

)

addEventHandler("onClientElementDestroy", getRootElement(),

	function ()

		if source == occupiedVehicle and getElementData(source, "gpsDestination") then

			setElementData(source, "gpsDestination", false);

			if gpsRoute then

				endRoute();

			end

		end

	end

)

addEventHandler("onClientResourceStart", getResourceRootElement(),
	function ()

		occupiedVehicle = getPedOccupiedVehicle(localPlayer);

		if occupiedVehicle then

			carCanGPS();

			if getElementData(occupiedVehicle, "gpsDestination") then

				local destination = getElementData(occupiedVehicle, "gpsDestination");

				gpsThread = coroutine.create(makeRoute);
				coroutine.resume(gpsThread, destination[1], destination[2], true);

			end

		end

	end

)


function getPositionFromElementOffset(element, x, y, z)

	local matrix = getElementMatrix(element);
	local posX = x * matrix[1][1] + y * matrix[2][1] + z * matrix[3][1] + matrix[4][1];
	local posY = x * matrix[1][2] + y * matrix[2][2] + z * matrix[3][2] + matrix[4][2];
	local posZ = x * matrix[1][3] + y * matrix[2][3] + z * matrix[3][3] + matrix[4][3];
	return posX, posY, posZ;

end

local function getAngle(x1, y1, x2, y2)

	local angle = math.atan2(x2, y2) - math.atan2(x1, y1);
	if angle <= -math.pi then

		angle = angle + math.pi * 2;

	elseif angle > math.pi then

		angle = angle - math.pi * 2;

	end

	return angle;

end

local function calculatePath(startNode, endNode)

	local usedNodes = {[startNode.id] = true};
	local currentNodes = {};
	local ways = {};

	for id, distance in pairs(startNode.neighbours) do

		usedNodes[id] = true;
		currentNodes[id] = distance;
		ways[id] = {startNode.id};

	end


	while true do

		local currentNode = -1;
		local maxDistance = 10000;

		for id, distance in pairs(currentNodes) do

			if distance < maxDistance then

				currentNode = id;
				maxDistance = distance;

			end

		end

		if currentNode == -1 then

			return false;

		end

		if endNode.id == currentNode then

			local lastNode = currentNode;
			local foundedNodes = {};

			while tonumber(lastNode) do

				local node = getVehicleNodeByID(lastNode);
				table.insert(foundedNodes, 1, node);
				lastNode = ways[lastNode];

			end

			return foundedNodes;

		end

		for id, distance in pairs(getVehicleNodeByID(currentNode).neighbours) do

			if not usedNodes[id] then

				ways[id] = currentNode;
				currentNodes[id] = maxDistance + distance;
				usedNodes[id] = true;

			end

		end

		currentNodes[currentNode] = nil;

	end

end

function getVehicleNodeByID(nodeID)

	local areaID = math.floor(nodeID / 65536);

	if areaID >= 0 and areaID <= 63 then

		return vehicleNodes[areaID][nodeID];

	end

end

function getVehicleNodeClosestToPoint(x, y)

	local foundedNode = -1;
	local lastNodeDistance = 10000;
	local areaID = math.floor((x + 3000) / 750) + math.floor((y + 3000) / 750) * 8;

	if not vehicleNodes[areaID] then

		return false;

	end

	for _, node in pairs(vehicleNodes[areaID]) do

		local nodeDistance = getDistanceBetweenPoints2D(x, y, node.x, node.y);

		if lastNodeDistance > nodeDistance then

			lastNodeDistance = nodeDistance;
			foundedNode = node;

		end

	end

	return foundedNode;

end


function calculateRoute(x1, y1, x2, y2)

	local startNode = getVehicleNodeClosestToPoint(x1, y1);
	local endNode = getVehicleNodeClosestToPoint(x2, y2);

	if not startNode then

		return false;

	end

	if not endNode then

		--showInfobox("Nenhuma rota encontrada para o destino selecionado.", "error");
		iprint("No fue posible encontrar una ruta para el destino seleccionado.")
		return false

	end

	return calculatePath(startNode, endNode);

end

function endRoute()

	if gpsRoute then

		if waypointColShapes then

			for k, v in pairs(waypointColShapes) do

				colShapes[waypointColShapes[k]] = nil;

				if isElement(v) then

					destroyElement(v);

				end

				waypointColShapes[k] = nil;

			end

		end

		nextWp = false;

		if isTimer(checkForRerouteTimer) then

			killTimer(checkForRerouteTimer);

		end

		checkForRerouteTimer = false;
		clearGPSRoute();
		waypointEndInterpolation = getTickCount();
		gpsRoute = false;
		gpsThread = false;

	end

end

function reRoute(checkShape)

	if not gpsRoute or not occupiedVehicle then

		return;

	end

	local vehiclePosX, vehiclePosY = getElementPosition(occupiedVehicle);

	if getDistanceBetweenPoints2D(gpsRoute[checkShape].x, gpsRoute[checkShape].y, vehiclePosX, vehiclePosY) >= 50 then

		if not makeRoute(lastDestinationX, lastDestinationY, true) then

			checkForRerouteTimer = setTimer(checkForReroute, 10000, 1);
			reRouting = true;

		end

	else

		checkForRerouteTimer = setTimer(checkForReroute, rerouteCheckRate, 1);
		reRouting = false;

	end

end

function checkForReroute()

	if not gpsRoute or not occupiedVehicle then

		return;

	end

	local vehiclePosX, vehiclePosY = getElementPosition(occupiedVehicle);
	local dist = getDistanceBetweenPoints2D(gpsRoute[currentNode].x, gpsRoute[currentNode].y, vehiclePosX, vehiclePosY);

	if dist >= 30 and dist < 80 and gpsRoute[currentNode + 1] and lastTurnAroundCheck and getTickCount() - lastTurnAroundCheck > 5000 then

		local x, y = getPositionFromElementOffset(occupiedVehicle, -1, 0, 0);
		local angle = math.deg(getAngle(gpsRoute[currentNode + 1].x - gpsRoute[currentNode].x, gpsRoute[currentNode + 1].y - gpsRoute[currentNode].y, x - vehiclePosX, y - vehiclePosY));

		if angle > 0 then

			lastTurnAroundCheck = getTickCount();
			checkForRerouteTimer = setTimer(checkForReroute, rerouteCheckRate, 1);

			turnAround = true;
			reRouting = false;

			return;

		else

			turnAround = false;
			reRouting = false;

		end

	end

	if isTimer(checkForRerouteTimer) then

		killTimer(checkForRerouteTimer);

	end

	if dist > 100 then

		checkForRerouteTimer = setTimer(reRoute, math.random(3000, 5000), 1, currentNode);
		reRouting = getTickCount();

	else

		checkForRerouteTimer = setTimer(checkForReroute, rerouteCheckRate, 1);

	end

end

function makeRoute(destinationX, destinationY, uTurned)

	local occupiedVehicle = getPedOccupiedVehicle(localPlayer);
	waypointInterpolation = false;

	if isTimer(checkForRerouteTimer) then

		killTimer(checkForRerouteTimer);

	end

	clearGPSRoute();
	gpsWaypoints = {};
	turnAround = false;
	gpsLines = {};
	gpsRoute = false;

	if waypointColShapes then

		for k, v in pairs(waypointColShapes) do

			colShapes[waypointColShapes[k]] = nil;

			if isElement(v) then

				destroyElement(v);

			end

			waypointColShapes[k] = nil;

		end

	end

	waypointColShapes = {};
	colShapes = {};

	if not occupiedVehicle then

		return;

	end

	local vehiclePosX, vehiclePosY = getElementPosition(occupiedVehicle);

	local currentZoneName = getZoneName(vehiclePosX, vehiclePosY, 0);
	local currentCityName = getZoneName(vehiclePosX, vehiclePosY, 0, true);
	local zoneName = getZoneName(destinationX, destinationY, 0);
	local cityName = getZoneName(destinationX, destinationY, 0, true);
	local disallowedZones = {
		["Unknown"] = true,


		["Los Santos"] = false,
		["Red County"] = false,

		["San Fierro"] = false,
		["San Fierro Bay"] = false,
		["Gant Bridge"] = false,
		["Flint County"] = false,
		["Whetstone"] = false,

		["Las Venturas"] = false,
		["Bone County"] = false,
		["Tierra Robada"] = false
	};

	if disallowedZones[currentZoneName] or disallowedZones[currentCityName] then

		setElementData(occupiedVehicle, "gpsDestination", false);
		return false;

	end

	if disallowedZones[zoneName] or disallowedZones[cityName] then

		--showInfobox("error", "Nenhuma rota encontrada para o destino selecionado.");
		iprint("Ninguna ruta fue encontrada para el destino seleccionado.")
		setElementData(occupiedVehicle, "gpsDestination", false);
		return false;

	end

	local routePath = calculateRoute(vehiclePosX, vehiclePosY, destinationX, destinationY);

	if not routePath then

		if not uTurned then

			--showInfobox("error", "Nenhuma rota encontrada para o destino selecionado.");
			iprint("Ninguna ruta fue encontrada para el destino seleccionado.")

		end

		setElementData(occupiedVehicle, "gpsDestination", false);

		return false;

	end

	gpsRoute = routePath;
	nextWp = 1;
	currentWaypoint = 0;
	currentNode = 1;
	checkForRerouteTimer = setTimer(checkForReroute, rerouteCheckRate, 1);

	local turns = {}

	for i, node in ipairs(gpsRoute) do

		local nextNode = gpsRoute[i + 1];
		local previousNode = gpsRoute[i - 1];

		if i > 1 and i < #gpsRoute then

			for k in pairs(node.neighbours) do

				if previousNode and nextNode and k ~= previousNode.id and k ~= nextNode.id then

					local angle = math.deg(getAngle(node.x - previousNode.x, node.y - previousNode.y, nextNode.x - node.x, nextNode.y - node.y));

					if angle > 10 then

						table.insert(turns, {i, "right"});
						break;

					end

					if angle < -10 then

						table.insert(turns, {i, "left"});

					end

					break;

				end

			end

		end

		waypointColShapes[i] = createColTube(node.x, node.y, node.z - 0.3, 8, 5);
		colShapes[waypointColShapes[i]] = i;
		addGPSLine(node.x, node.y);

	end

	local currentWaypoint = 1;

	for i = 1, #turns do

		local currentWaypointData = gpsRoute[currentWaypoint];
		local nodeId = tonumber(turns[i][1]);

		if not nodeId then

			nodeId = #gpsRoute;

		end

		local waypointDistance = 0;

		for j = currentWaypoint, nodeId do

			waypointDistance = waypointDistance + getDistanceBetweenPoints2D(gpsRoute[j].x, gpsRoute[j].y, currentWaypointData.x, currentWaypointData.y);
			currentWaypointData = gpsRoute[j];

		end

		currentWaypointData = gpsRoute[currentWaypoint];

		if waypointDistance > 600 then

			local nodeDistance = 0;

			for j = currentWaypoint, nodeId do

				nodeDistance = nodeDistance + getDistanceBetweenPoints2D(gpsRoute[j].x, gpsRoute[j].y, currentWaypointData.x, currentWaypointData.y);

				if waypointDistance - 500 < nodeDistance then

					table.insert(gpsWaypoints, {j, "forward"});
					break;

				end

			end

		end

		currentWaypoint = nodeId;
		table.insert(gpsWaypoints, turns[i]);

	end

	table.insert(gpsWaypoints, {"end", "end"});

	local firstWaypointDistance, prevWaypointData = 0, gpsRoute[1];

	for i = 1, tonumber(gpsWaypoints[nextWp][1]) or #gpsRoute do

		firstWaypointDistance = firstWaypointDistance + getDistanceBetweenPoints2D(gpsRoute[i].x, gpsRoute[i].y, prevWaypointData.x, prevWaypointData.y);
		prevWaypointData = gpsRoute[i];

	end

	gpsWaypoints[nextWp][3] = firstWaypointDistance / distanceDivider;

	local x, y = getPositionFromElementOffset(occupiedVehicle, -1, 0, 0);
	local angle = math.deg(getAngle(gpsRoute[2].x - gpsRoute[1].x, gpsRoute[2].y - gpsRoute[1].y, x - vehiclePosX, y - vehiclePosY));

	if angle > 0 then

		lastTurnAroundCheck = getTickCount();
		turnAround = true;

	end

	lastDestinationX = destinationX;
	lastDestinationY = destinationY;

	processGPSLines();

	if isElement(markedBlip) then

		destroyElement(markedBlip);

	end

	markedBlip = createBlip(destinationX, destinationY, 0, 41);
	setElementData(markedBlip, 'blipName', 'Destino');
	setElementData(occupiedVehicle, 'blip', markedBlip);

end

addEventHandler("onClientColShapeHit", getRootElement(),

	function (element)

		if colShapes[source] and element == localPlayer then

			local currentShape = colShapes[source];

			clearGPSRoute();

			if currentShape >= 2 then

				if isTimer(checkForRerouteTimer) then

					killTimer(checkForRerouteTimer);

				end

				checkForRerouteTimer = false;
				turnAround = false;

			end

			if currentShape == #gpsRoute then

				for i = 1, currentShape do

					if isElement(waypointColShapes[i]) then

						destroyElement(waypointColShapes[i]);

					end

					waypointColShapes[i] = nil;

				end

				nextWp = false;

				if isTimer(checkForRerouteTimer) then

					killTimer(checkForRerouteTimer);

				end

				checkForRerouteTimer = false;
				setElementData(getPedOccupiedVehicle(localPlayer), "gpsDestination", false);

				if isElement(markerdBlip) then

					destroyElement(markedBlip);

				end

				return;

			else

				for i = 1, currentShape do

					if isElement(waypointColShapes[i]) then

						destroyElement(waypointColShapes[i]);

					end

					waypointColShapes[i] = nil;

				end

				for i = currentShape, #gpsRoute do

					addGPSLine(gpsRoute[i].x, gpsRoute[i].y);

				end

				if isTimer(checkForRerouteTimer) then

					killTimer(checkForRerouteTimer);

				end

				currentNode = currentShape + 1;
				lastTurnAroundCheck = getTickCount();
				checkForRerouteTimer = setTimer(checkForReroute, rerouteCheckRate, 1);
				reRouting = false;
				processGPSLines();

			end

			if gpsWaypoints[nextWp] and gpsWaypoints[nextWp][1] ~= "end" then

				if currentShape >= gpsWaypoints[nextWp][1] then
					nextWp = nextWp + 1;

					local nextWaypointDistance, prevWaypointData = 0, gpsRoute[currentShape];

					for i = currentShape, tonumber(gpsWaypoints[nextWp][1]) or #gpsRoute do

						nextWaypointDistance = nextWaypointDistance + getDistanceBetweenPoints2D(gpsRoute[i].x, gpsRoute[i].y, prevWaypointData.x, prevWaypointData.y);
						prevWaypointData = gpsRoute[i];

					end

					gpsWaypoints[nextWp][3] = nextWaypointDistance / distanceDivider;

				else

					local nextWaypointDistance, prevWaypointData = 0, gpsRoute[currentShape];

					for i = currentShape, gpsWaypoints[nextWp][1] do

						nextWaypointDistance = nextWaypointDistance + getDistanceBetweenPoints2D(gpsRoute[i].x, gpsRoute[i].y, prevWaypointData.x, prevWaypointData.y);
						prevWaypointData = gpsRoute[i];

					end

					gpsWaypoints[nextWp][3] = nextWaypointDistance / distanceDivider;

					if gpsWaypoints[nextWp][2] == "forward"  and currentShape > 2 then

						if gpsWaypoints[nextWp - 1] and currentShape < 2 + gpsWaypoints[nextWp - 1][1] then

							return;

						end

						return;

					end

				end

			else

				local nextWaypointDistance, prevWaypointData = 0, gpsRoute[currentShape];

				for i = currentShape, #gpsRoute do

					nextWaypointDistance = nextWaypointDistance + getDistanceBetweenPoints2D(gpsRoute[i].x, gpsRoute[i].y, prevWaypointData.x, prevWaypointData.y);
					prevWaypointData = gpsRoute[i];

				end

				gpsWaypoints[nextWp][3] = nextWaypointDistance / distanceDivider;

			end

		end

	end

)


--[[ 

     Mais mods como este você encontra aqui: 
     
     https://discord.gg/UbJy4WJkx7
     https://discord.gg/UbJy4WJkx7

 ]]