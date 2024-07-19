
local monitorSize = { guiGetScreenSize() };
local screenX, screenY = guiGetScreenSize();
local resW, resH = 1366,768;
local hirosx,hirosy = (monitorSize[1]/resW), (monitorSize[2]/resH);
local screenSource = dxCreateScreenSource(monitorSize[1], monitorSize[2]);


local render = {};
local renderData = {};
local widgets = {};
local blipSelected = {1, false};

local blipsRendered = {};

local chatType = 0;
local countedFrames = 0;


addEventHandler("onClientResourceStart", getRootElement(),

	function (startedRes)

		if startedRes == getThisResource() then

			blipsRendered = {};
			local blips = getElementsByType("blip");
			for k , v in pairs(blips) do

				--print(k)
				if isElement(v) then

					local icon = getElementData(v, "blipIcon") or getBlipIcon(v);
					local tooltip = getElementData(v, "blipName");

					if (icon ~= 23) and (tooltip) then

						if getDuplicateBlip(tooltip) then

							blipsRendered[getDuplicateBlip(tooltip)].count = ((blipsRendered[getDuplicateBlip(tooltip)].count)+1);
							table.insert(blipsRendered[getDuplicateBlip(tooltip)].position, {getElementPosition(v)});

						else

							table.insert(blipsRendered, {

								count = 1,
								name = tooltip,
								position = {{getElementPosition(v)}},
								img = "assets/images/blips/"..icon .. ".png"

							});

						end

					end

				end

			end

			loadFonts();
			guiSetInputMode("no_binds_when_editing");

			renderData.hudVisibleNumber = 0;

			setPlayerHudComponentVisible("all", false);
			setPlayerHudComponentVisible("crosshair", true);

			shaderHUDMask = dxCreateShader('assets/shaders/hud_mask.fx');
			circleMaskTex = dxCreateTexture('assets/images/radar/circle_mask.png');
			mapPicture = dxCreateTexture("assets/images/radar/map.png");
			mapPicture2 = dxCreateTexture("assets/images/radar/map.png");
			dxSetTextureEdge(mapPicture, "border", tocolor(45, 45, 45, 0));

		end

	end

)


function isHudVisible()

	return renderData.hudVisibleNumber < 1;

end

function toggleHUD(state)

	if not state then

		renderData.hudVisibleNumber = renderData.hudVisibleNumber + 1;

	elseif renderData.hudVisibleNumber > 0 then

		renderData.hudVisibleNumber = renderData.hudVisibleNumber - 1;

	end

end


function loadFonts()

	Roboto = dxCreateFont("assets/fonts/Roboto-Regular.ttf", resp(12), false, "antialiased");

end

local _getZoneName = getZoneName;
function getZoneName(x, y, z, cities)

	local zoneName = _getZoneName(x, y, z, cities);
	local cityName = zoneName;

	if not cities then

		cityName = _getZoneName(x, y, z, true);

	end

	if zoneName == "Unknown" or cityName == "Unknown" then

		return "Desconhecido";

	end

	return zoneName;

end


function reMap(x, in_min, in_max, out_min, out_max)

	return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;

end

responsiveMultipler = reMap(monitorSize[1], 1024, 1920, 0.75, 1);

function resp(num)

	return num * responsiveMultipler;

end

function respc(num)

	return math.ceil(num * responsiveMultipler);

end

function getResponsiveMultipler()

	return responsiveMultipler;

end

local widgets = {

	minimap = {

		sizeX = hirosx*200,
		sizeY = hirosy*120,
		posX = hirosx*0,
		posY = hirosy*605

	}

};


local pictureSize = 1600;
local mapScaleFactor = 6000 / pictureSize;
local mapUnit = pictureSize / 6000;

local panelWidth = respc(184.03);
local panelHeight = respc(184.03);
local panelPosX = 0;
local panelPosY = 0;

local renderTargetSize = math.ceil((panelWidth));
local renderTarget = dxCreateRenderTarget(renderTargetSize, renderTargetSize, true);

local zoomValue = 1.3;
local zoom = zoomValue;

local blipPictures = {};

createdBlips = {};

local blipData = {};

carCanGPSVal = false;

local gpsLines = {};
local gpsRoutePicture = false;
local gpsRoutePos = {};
local gpsLineColor = tocolor(107, 106, 133);

function carCanGPS()

	carCanGPSVal = false;
	local occupiedVehicle = getPedOccupiedVehicle(localPlayer);
	if occupiedVehicle then

		local gpsVal = getElementData(occupiedVehicle, "vehicle.GPS") or 1;

		if tonumber(gpsVal) then

			carCanGPSVal = tonumber(gpsVal);

			if gpsVal == 2 then

				carCanGPSVal = "off";

			end

		else

			carCanGPSVal = false;

			if getElementData(occupiedVehicle, "gpsDestination") then

				setElementData(occupiedVehicle, "gpsDestination", false);

			end

		end

	end

	return carCanGPSVal;

end

function addGPSLine(x, y)

	table.insert(gpsLines, {remapTheFirstWay(x), remapTheFirstWay(y)});

end

function clearGPSRoute()

	gpsLines = {};

	if isElement(gpsRoutePicture) then

		destroyElement(gpsRoutePicture);

	end

	gpsRoutePicture = nil;

end

function processGPSLines()

	local minX, minY = 99999, 99999;
	local maxX, maxY = -99999, -99999;

	for k = 1, #gpsLines do

		local v = gpsLines[k];

		if v[1] < minX then

			minX = v[1];

		end

		if v[1] > maxX then

			maxX = v[1];

		end

		if v[2] < minY then

			minY = v[2];

		end

		if v[2] > maxY then

			maxY = v[2];

		end

	end

	local sx = maxX - minX + 16;
	local sy = maxY - minY + 16;

	gpsRoutePos = {minX - 4, minY - 4, sx, sy};

	if isElement(gpsRoutePicture) then

		destroyElement(gpsRoutePicture);

	end

	gpsRoutePicture = dxCreateRenderTarget(sx, sy, true);

	dxSetRenderTarget(gpsRoutePicture);

	for k = 2, #gpsLines do

		local k2 = k - 1;

		if gpsLines[k2] then

			-- color de ruta
			dxDrawLine(gpsLines[k][1] - minX + 4, gpsLines[k][2] - minY + 4, gpsLines[k2][1] - minX + 4, gpsLines[k2][2] - minY + 4, tocolor(255, 255, 255), 5);

		end

	end

	dxSetRenderTarget();

end

addEventHandler("onClientRestore", getRootElement(),

	function ()

		if gpsRoute then

			processGPSLines();

		end

	end

)

addEventHandler("onClientElementDataChange", getRootElement(),

	function (dataName, oldValue)

		local occupiedVehicle = getPedOccupiedVehicle(localPlayer);
		if (occupiedVehicle) then

			if source == occupiedVehicle then

				if dataName == "gpsDestination" then

					local value = getElementData(source, "gpsDestination");

					if value then

						gpsThread = coroutine.create(makeRoute);
						coroutine.resume(gpsThread, unpack(value));
						waypointInterpolation = false;

					else

						if isElement(getElementData(source, 'blip')) then

							destroyElement(getElementData(source, 'blip'));

						end

						endRoute();

					end

				end

			end

		end

	end

)

addEventHandler("onClientElementDestroy", getRootElement(),

	function ()

		if getElementType(source) == "blip" then

			blipData[source] = nil;

		end

	end

)

function remapTheFirstWay(x)

	return (-x + 3000) / mapScaleFactor;

end

function remapTheSecondWay(x)

	return (x + 3000) / mapScaleFactor;

end

function rotateAround(angle, x, y, x2, y2)

	local centerX, centerY = x, y;
	local targetX, targetY = x2 or 0, y2 or 0;

	local rotatedX = centerX + (targetX - centerX) * math.cos(angle) - (targetY - centerY) * math.sin(angle);
	local rotatedY = centerY + (targetX - centerX) * math.sin(angle) + (targetY - centerY) * math.cos(angle);

	return rotatedX, rotatedY;

end

local farBlips = {};

function renderBlip(icon, blipX, blipY, middleX, middleY, width, height, color, farShow, cameraRotZ, k)

	local x = 0 + renderTargetSize / 2 + (remapTheFirstWay(middleX) - remapTheFirstWay(blipX)) * zoom;
	local y = 0 + renderTargetSize / 2 - (remapTheFirstWay(middleY) - remapTheFirstWay(blipY)) * zoom;

	if not farShow and (x > renderTargetSize or x < 0 or y > renderTargetSize or y < 0) then

		return;

	end

	local render = true;

	if farShow then

		width = width / 0.6;
		height = height / 0.6;

		if icon == 0 then

			width = width / 1.5;
			height = height / 1.5;

		end

		if x > renderTargetSize then

			x = renderTargetSize;

		elseif x < 0 then

			x = 0;

		end

		if y > renderTargetSize then

			y = renderTargetSize;

		elseif y < 0 then

			y = 0;

		end

		local x2, y2 = rotateAround(math.rad(cameraRotZ), renderTargetSize / 2, renderTargetSize / 2, x, y);

		x2 = x2 + panelPosX - renderTargetSize / 2 + (panelWidth - width) / 2;
		y2 = y2 + panelPosY - renderTargetSize / 2 + (panelHeight - height) / 2;

		farBlips[k] = nil;

		if x2 < panelPosX then

			render = false;
			x2 = panelPosX;
		elseif x2 > panelPosX + panelWidth - width then

			render = false;
			x2 = panelPosX + panelWidth - width;

		end

		if y2 < panelPosY then

			render = false;
			y2 = panelPosY;
		elseif y2 > panelPosY + panelHeight - height then

			render = false;
			y2 = panelPosY + panelHeight - height;

		end

		if not render then

			farBlips[k] = {x2, y2, width, height, icon, color};

		end

	end

	if render then

		if blipPictures[icon] then

			dxDrawImage(x - width / 2, y - height / 2, width, height, blipPictures[icon], 360 - cameraRotZ, 0, 0, color);

		else

			dxDrawImage(x - width / 2, y - height / 2, width, height, "assets/images/blips/" .. icon, 360 - cameraRotZ, 0, 0, color);

		end

	end

end

local function sortFunc(t, a, b)

	return widgets[b].sizeY > widgets[a].sizeY;

end

addEventHandler("onClientRender", getRootElement(),

	function ()

		local theVehicle = getPedOccupiedVehicle ( localPlayer );
		if not theVehicle then return end;

		if isHudVisible() then

			local renderedElement = render['minimap'];
			if renderedElement then

				renderedElement = renderedElement(widgets['minimap'].posX, widgets['minimap'].posY);

			end

		end

	end

)

render.minimap = function (x, y)

	local theVehicle = getPedOccupiedVehicle ( localPlayer );
	if not theVehicle then

		return;

	end

	panelWidth, panelHeight = widgets.minimap.sizeX, widgets.minimap.sizeY - resp(3);
	local size = math.ceil((panelWidth + panelHeight) * 0.85);
	panelPosX, panelPosY = x, y;

	if getKeyState("num_add") and zoomValue < 1.5 then

		zoomValue = zoomValue + 0.01;

	elseif getKeyState("num_sub") and zoomValue > 0.5 then

		zoomValue = zoomValue - 0.01;

	end

	zoom = zoomValue

	local occupiedVehicle = getPedOccupiedVehicle(localPlayer);
	if isElement(occupiedVehicle) then

		local velocityX, velocityY, velocityZ = getElementVelocity(occupiedVehicle);
		local factor = getDistanceBetweenPoints3D(0, 0, 0, velocityX, velocityY, velocityZ) * 180 / 1300;

		if factor >= 0.4 then

			factor = 0.4;

		end

		zoom = zoom - factor;

	end

	local playerPosX, playerPosY, playerPosZ = getElementPosition(localPlayer);
	local playerRotX, playerRotY, playerRotZ = getElementRotation(localPlayer);
	local playerDimension = getElementDimension(localPlayer);

	if playerDimension == 0 and playerPosZ <= 10000 then

		local cameraRotX, cameraRotY, cameraRotZ = getElementRotation(getCamera());
		farBlips = {};

		dxUpdateScreenSource(screenSource, true);
		dxSetRenderTarget(renderTarget);
		dxSetBlendMode("modulate_add");

		-- color minimapa
		dxDrawRectangle(0, 0, renderTargetSize, renderTargetSize, tocolor(33, 33, 33, 255));
		-- mini mapa calles
		dxDrawImageSection(0, 0, renderTargetSize, renderTargetSize, remapTheSecondWay(playerPosX) - renderTargetSize / zoom / 2, remapTheFirstWay(playerPosY) - renderTargetSize / zoom / 2, renderTargetSize / zoom, renderTargetSize / zoom, 'assets/images/radar/map.png', 0, 0, 0, tocolor(255, 255, 255, 200));

		if gpsRoutePicture then

			dxDrawImage(

				renderTargetSize / 2 + (remapTheFirstWay(playerPosX) - (gpsRoutePos[1] + gpsRoutePos[3] / 2)) * zoom - gpsRoutePos[3] * zoom / 2,
				renderTargetSize / 2 - (remapTheFirstWay(playerPosY) - (gpsRoutePos[2] + gpsRoutePos[4] / 2)) * zoom + gpsRoutePos[4] * zoom / 2,
				gpsRoutePos[3] * zoom,
				-(gpsRoutePos[4] * zoom),
				gpsRoutePicture,
				180, 0, 0,
				gpsLineColor

			);

		end

		local blipCount = 0;
		local blips = getElementsByType("blip");
		for k = 1, #blips do

			local v = blips[k]
			if v then

				if not blipData[v] then

					blipData[v] = {};
					blipData[v].icon = getElementData(v, "blipIcon") or getBlipIcon(v);
					blipData[v].size = getElementData(v, "blipSize") or 15.5;
					bcR, bcG, bcB, bcA = 255,255,255, 255;

					local cor = getElementData(v, "bliColor");
					if cor then

						blipData[v].color = tocolor(cor[1],cor[2],cor[3],cor[4]);

					else

						bcR, bcG, bcB, bcA =  255,255,255, 255;
						blipData[v].color = tocolor(bcR, bcG, bcB, 255);

					end

					blipData[v].tooltip = getElementData(v, "blipName");
					blipData[v].farShow = getElementData(v, "blipFarShow") or false;
					blipCount = blipCount + 1;

				end

				local v2 = blipData[v];
				if v2 then

					local x, y = getElementPosition(v);
					if not v2.size then

						v2.size = 14.5;

					end

					local plaPos = {getElementPosition(localPlayer)};
					local bliPos = {getElementPosition(v)};
					local plDimension = getElementDimension(localPlayer);
					local plInterior = getElementInterior(localPlayer);
					local actualDist = getDistanceBetweenPoints2D(plaPos[1], plaPos[2], bliPos[1], bliPos[2]);

					if getElementDimension(v) == plDimension and getElementInterior(v) == plInterior then

						if v2.icon == 1 then

							local timeNow = getTickCount();
							local alpha = (timeNow % 510);
							if alpha > 255 then

								alpha = 255 - (alpha - 255);

							end

							bS = alpha * 0.15;
							renderBlip(v2.icon .. ".png", x, y, playerPosX, playerPosY, hirosx*bS, hirosy*bS, v2.color, false, cameraRotZ, blipCount);

						end

					end


					if actualDist <= getBlipVisibleDistance(v) and getElementDimension(v) == plDimension and getElementInterior(v) == plInterior then
						if v2.icon ~= 1 then

							renderBlip(v2.icon .. ".png", x, y, playerPosX, playerPosY, hirosx*v2.size, hirosy*v2.size, v2.color, v2.farShow, cameraRotZ, blipCount);

						end

					end

				end

			end

		end

		dxSetBlendMode("blend");
		dxSetRenderTarget();

		if (shaderHUDMask) and (mapPicture) and (circleMaskTex) then

			dxSetShaderValue(shaderHUDMask, 'sMaskTexture', circleMaskTex);
			dxSetShaderValue(shaderHUDMask, 'sPicTexture', renderTarget);

		end
		dxDrawImage(panelPosX - renderTargetSize / 2 + panelWidth / 2, panelPosY - renderTargetSize / 2 + panelHeight / 2, renderTargetSize, renderTargetSize, 'assets/images/radar/borda.png', cameraRotZ, 0, 0, tocolor(45, 55, 70, 255));
		dxDrawImage(panelPosX - renderTargetSize / 2 + panelWidth / 2, panelPosY - renderTargetSize / 2 + panelHeight / 2, renderTargetSize, renderTargetSize, shaderHUDMask, cameraRotZ, 0, 0, tocolor(255, 255, 255, 255));

		local size = 40 / (4 - zoom) + 3;
		dxDrawImage(panelPosX + (panelWidth - hirosx*size) / 2, panelPosY + (panelHeight - hirosy*size) / 2, hirosx*size, hirosy*size, "assets/images/radar/arrow.png", cameraRotZ + math.abs(360 - playerRotZ));

		local occupiedVehicle = getPedOccupiedVehicle(localPlayer);
		if occupiedVehicle and carCanGPS() then

			if getElementData(occupiedVehicle, "gpsDestination") then

				vx, vy, vz = getElementPosition ( occupiedVehicle );
				dx, dy = unpack(getElementData(occupiedVehicle, "gpsDestination"));

				local dist = math.floor((getDistanceBetweenPoints2D(vx, vy, dx, dy)));
				if dist >= 1000 then

					dist = dist / 1000 .. " km";

				else

					dist = dist .. " m";

				end

				local textWidth = dxGetTextWidth(dist, 0.75, Roboto);

				--dxDrawText(dist, hirosx*20, hirosy*700, hirosx*85+100, hirosy*700 + hirosy*50, tocolor(255, 255, 255, 255), 0.85, Roboto, "center", "center");

			end

		end

	end

end

local bigRadarState = false;

local panelWidth = monitorSize[1];
local panelHeight = monitorSize[2];
local panelPosX = 0;
local panelPosY = 0;

local zoom = 0.9;
local targetZoom = zoom;

local cursorX, cursorY = -1, -1;
local lastCursorPos = false;
local cursorMoveDiff = false;

local mapMoveDiff = false;
local lastMapMovePos = false;
local mapIsMoving = false;

local lastMapPosX, lastMapPosY = 0, 0;
local mapPlayerPosX, mapPlayerPosY = 0, 0;

local activeBlip = false;
local blurShader = false;
local showPlayers = false;

local mapBlipOffset = 0;
local mapBlipNum = 10;

function onBigmapClick(button, state)
	iprint(button, state)
	if button == "left" and state == "down" then

		local blips = getElementsByType("blip");
		for k , v in pairs(blips) do

			if isElement(v) then

				local icon = getElementData(v, "blipIcon") or getBlipIcon(v);
				local tooltip = getElementData(v, "blipName");

				if icon ~= 1 then

					for i,v in pairs(blipsRendered) do

						local size = dxGetTextWidth(v.name, 1.00, Roboto);
						if (cursorX) > (hirosx*1100) then

							if isMouseInPosition((hirosx*1268) - (hirosx*size), (hirosy*59) + ((i-1)*(hirosy*45)), hirosx*(size+53), hirosy*39) then

								local x,y,z = unpack(v.position[1]);
								blipSelected = {1, i};
								blipMarker = {x, y};
								mapMoveDiff = false;

							end

						end

					end

				end

			end

		end

	end

	if (state == "up" and button == "right") then

		local occupiedVehicle = getPedOccupiedVehicle(localPlayer);
		if occupiedVehicle and carCanGPS() then

			--if (blipMarker) then return end;

			if getElementData(occupiedVehicle, "gpsDestination") then

				setElementData(occupiedVehicle, "gpsDestination", false);

			else

				if not theLimitType then

					-- theLimitType = setTimer(function() theLimitType = nil end, 10000, 1);
					theLimitType = setTimer(function() theLimitType = nil end, 1000, 1);

					local x = reMap((cursorX - panelPosX) / zoom + (remapTheSecondWay(mapPlayerPosX) - panelWidth / zoom / 2), 0, pictureSize, -3000, 3000);
					local y = reMap((cursorY - panelPosY) / zoom + (remapTheFirstWay(mapPlayerPosY) - panelHeight / zoom / 2), 0, pictureSize, 3000, -3000);

					setElementData(occupiedVehicle, "gpsDestination", {x, y});

				else

					-- dxMsg('Aguarde 10 segundos,\npara marcar novamente.', 'error');
					return 

				end

			end

		end

		if (mapIsMoving) then

			mapIsMoving = false;
			--return

		end

	end

end

function renderBigBlip(icon, blipX, blipY, middleX, middleY, width, height, color, renderDistance, tooltip, k, v)

	if renderDistance and getDistanceBetweenPoints2D(middleX, middleY, blipX, blipY) > renderDistance then return end;
	local x = panelPosX + panelWidth / 2 + (remapTheFirstWay(middleX) - remapTheFirstWay(blipX)) * zoom;
	local y = panelPosY + panelHeight / 2 - (remapTheFirstWay(middleY) - remapTheFirstWay(blipY)) * zoom;

	width = width / (2 - zoom) + 8;
	height = height / (2 - zoom) + 8;

	if cursorX and cursorY and cursorY >= respc(70) and cursorY <= monitorSize[2] - respc(70) then

		if not activeBlip then

			if cursorX >= x - width / 2 and cursorY >= y - height / 2 and cursorX <= x + width / 2 and cursorY <= y + height / 2 then

				if isElement(v) and getElementType(v) == "player" then

					activeBlip = v

				elseif tooltip then

					activeBlip = tooltip

				elseif defaultTooltips[icon] then

					activeBlip = defaultTooltips[icon]

				end

				if activeBlip then

					width = width * 1.25
					height = height * 1.25

				end

			end

		end

	end

	if icon == "arrow.png" then

		local playerRotX, playerRotY, playerRotZ = getElementRotation(localPlayer);
		dxDrawImage(x - width / 2, y - height / 2, width, height, "assets/images/blips" .. icon, math.abs(360 - playerRotZ));

	elseif blipPictures[icon] then

		dxDrawImage(x - width / 2, y - height / 2, width, height, blipPictures[icon], 0, 0, 0, color);

	else

		dxDrawImage(x - width / 2, y - height / 2, width, height, "assets/images/blips/" .. icon, 0, 0, 0, color);

	end

end

local blipsCount = 0;

function renderTheBigmap()

	local playerPosX, playerPosY, playerPosZ = getElementPosition(localPlayer);
	local playerRotX, playerRotY, playerRotZ = getElementRotation(localPlayer);
	local playerDimension = getElementDimension(localPlayer);

	if playerDimension == 0 and playerPosZ <= 10000 then

		cursorX, cursorY = getCursorPosition();

		if cursorX and cursorY then

			cursorX, cursorY = cursorX * monitorSize[1], cursorY * monitorSize[2];

			if getKeyState("mouse1") then

				if not lastCursorPos then

					lastCursorPos = {cursorX, cursorY};

				end

				if not cursorMoveDiff then

					cursorMoveDiff = {0, 0};

				end

				cursorMoveDiff = {cursorMoveDiff[1] + cursorX - lastCursorPos[1], cursorMoveDiff[2] + cursorY - lastCursorPos[2]};

				if not lastMapMovePos then

					if not mapMoveDiff then

						lastMapMovePos = {0, 0};

					else

						lastMapMovePos = {mapMoveDiff[1], mapMoveDiff[2]};

					end

				end

				if not mapMoveDiff then

					if math.abs(cursorMoveDiff[1]) >= 3 or math.abs(cursorMoveDiff[2]) >= 3 then

						mapMoveDiff = {lastMapMovePos[1] - cursorMoveDiff[1] / zoom / mapUnit, lastMapMovePos[2] + cursorMoveDiff[2] / zoom / mapUnit};
						mapIsMoving = true;

					end

				elseif cursorMoveDiff[1] ~= 0 or cursorMoveDiff[2] ~= 0 then

					mapMoveDiff = {lastMapMovePos[1] - cursorMoveDiff[1] / zoom / mapUnit, lastMapMovePos[2] + cursorMoveDiff[2] / zoom / mapUnit};
					mapIsMoving = true;

				end

				lastCursorPos = {cursorX, cursorY};

			else

				if mapMoveDiff then

					lastMapMovePos = {mapMoveDiff[1], mapMoveDiff[2]};

				end

				lastCursorPos = false;
				cursorMoveDiff = false;

			end

		end

		mapPlayerPosX, mapPlayerPosY = lastMapPosX, lastMapPosY;

		if mapMoveDiff then


			if (blipMarker) then
	
				mapPlayerPosX = blipMarker[1] + mapMoveDiff[1];
				mapPlayerPosY = blipMarker[2] + mapMoveDiff[2];	

				blipSelected = {1, false};

			else

				mapPlayerPosX = mapPlayerPosX + mapMoveDiff[1];
				mapPlayerPosY = mapPlayerPosY + mapMoveDiff[2];	

			end

		else

			mapPlayerPosX, mapPlayerPosY = playerPosX, playerPosY;
			lastMapPosX, lastMapPosY = mapPlayerPosX, mapPlayerPosY;

			if (blipMarker) then
	
				mapPlayerPosX = blipMarker[1];
				mapPlayerPosY = blipMarker[2];

			end

		end

		dxDrawRectangle(panelPosX, panelPosY, panelWidth, panelHeight, tocolor(50, 49, 61, 240));
		dxDrawImage(panelPosX, panelPosY, panelWidth, panelHeight, "assets/images/radar/shadow.png");
		dxDrawImageSection(panelPosX, panelPosY, panelWidth, panelHeight, remapTheSecondWay(mapPlayerPosX) - panelWidth / zoom / 2, remapTheFirstWay(mapPlayerPosY) - panelHeight / zoom / 2, panelWidth / zoom, panelHeight / zoom, mapPicture, 0, 0, 0, tocolor(255, 255, 255, 235));

		if gpsRoutePicture then

			dxDrawImage(

				panelPosX + panelWidth / 2 + (remapTheFirstWay(mapPlayerPosX) - (gpsRoutePos[1] + gpsRoutePos[3] / 2)) * zoom - gpsRoutePos[3] * zoom / 2,
				panelPosY + panelHeight / 2 - (remapTheFirstWay(mapPlayerPosY) - (gpsRoutePos[2] + gpsRoutePos[4] / 2)) * zoom + gpsRoutePos[4] * zoom / 2,
				gpsRoutePos[3] * zoom,
				-(gpsRoutePos[4] * zoom),
				gpsRoutePicture,
				180, 0, 0,
				gpsLineColor

			);

		end


		local blipCount = 0;
		local blips = getElementsByType("blip");
		--blipsRendered = {};
		for k , v in pairs(blips) do

			if v then

				local icon = getElementData(v, "blipIcon") or getBlipIcon(v);
				local size = 15;
				local cor = getElementData(v, "bliColor");
				if cor then

					color = tocolor(cor[1],cor[2],cor[3],cor[4]);

				else

					bcR, bcG, bcB, bcA = getBlipColor(v) or 255,255,255, 255;
					color = tocolor(bcR, bcG, bcB, 255);

				end

				local tooltip = getElementData(v, "blipName");
				local farShow = getElementData(v, "blipFarShow") or true;
				local x, y = getElementPosition(v);

				if not size then

					size = 5;

				end

				if icon == 1 then

					local timeNow = getTickCount();
					local alpha = (timeNow % 510);

					if alpha > 255 then

						alpha = 255 - (alpha - 255);

					end

					bS = alpha * 0.2;
					renderBigBlip(icon .. ".png", x, y, mapPlayerPosX, mapPlayerPosY, bS, bS, color, renderDistance or 9999, tooltip, blipCount, v);

				else

					renderBigBlip(icon .. ".png", x, y, mapPlayerPosX, mapPlayerPosY, size, size, color, renderDistance or 9999, tooltip, blipCount, v);

				end



			end

		end

		renderBigBlip("2.png", playerPosX, playerPosY, mapPlayerPosX, mapPlayerPosY, 20, 20);
		dxDrawImage(monitorSize[1] / 2 - respc(128), monitorSize[2] / 2 - respc(128), respc(256), respc(256), "assets/images/blips/cross.png");
		dxDrawImage(panelPosX + 12, panelPosY + 12, respc(70) - 24, respc(70) - 24, "assets/images/radar/location.png");

		dxDrawText(getZoneName(playerPosX, playerPosY, playerPosZ), panelPosX + 12 + respc(70 - 12), panelPosY, panelPosX + panelWidth, panelPosY + respc(70), tocolor(255, 255, 255), 1, Roboto, "left", "center");

		if cursorX and cursorY then

			local x = reMap((cursorX - panelPosX) / zoom + (remapTheSecondWay(mapPlayerPosX) - panelWidth / zoom / 2), 0, pictureSize, -3000, 3000);
			local y = reMap((cursorY - panelPosY) / zoom + (remapTheFirstWay(mapPlayerPosY) - panelHeight / zoom / 2), 0, pictureSize, 3000, -3000);
			dxDrawText("#eaeaeaLocal: #ffffff" .. getZoneName(x, y, 0), panelPosX, panelPosY, panelPosX + panelWidth - respc(12), panelPosY + respc(70), tocolor(255, 255, 255), 1, Roboto, "right", "center", false, false, false, true);

		end

		if mapMoveDiff then

			if getKeyState("space") then

				mapMoveDiff = false;
				lastMapMovePos = false;
				blipMarker = false;
				blipSelected = {1, false};

			end

			dxDrawText("Centralize pressionando (ESPAÇO)", panelPosX + respc(12), panelPosY + panelHeight - respc(70), 0, panelPosY + panelHeight, tocolor(255, 255, 255), 1, Roboto, "left", "center");

		end

		for i,v in pairs(blipsRendered) do

			if blipSelected[2] == i then

				local text = v.count > 1 and (v.name..'  < '..blipSelected[1]..' / '..v.count..' >') or v.name;
				local size = hirosx*dxGetTextWidth(text, 1.00, Roboto);
				dxDrawRoundedRectangle((hirosx*1268) - (hirosx*size), (hirosy*59) + ((i-1)*(hirosy*45)), hirosx*(hirosx*size+53), hirosy*39, isMouseInPosition((hirosx*1268) - (hirosx*size), (hirosy*59) + ((i-1)*(hirosy*45)), hirosx*(hirosx*size+53), hirosy*39) and tocolor(76, 89, 109, 255) or tocolor(117, 180, 255, 255), hirosx*5);
				dxDrawImage((hirosx*1276) - (hirosx*size), (hirosy*67) + ((i-1)*(hirosy*45)), hirosx*23, hirosy*23, v.img);
				dxDrawText(text, (hirosx*1303) - (hirosx*size), (hirosy*59) + ((i-1)*(hirosy*45)), (hirosx*size) + ((hirosx*1303) - (hirosx*size)), (hirosy*39) + ((hirosy*59) + ((i-1)*(hirosy*45))), tocolor(255, 255, 255, 255), 1.00, Roboto, 'center', 'center')

			else

				local text = v.count > 1 and (v.name..'  < 1 / '..v.count..' >') or v.name;
				local size = dxGetTextWidth(text, 1.00, Roboto);
				dxDrawRoundedRectangle((hirosx*1268) - (hirosx*size), (hirosy*59) + ((i-1)*(hirosy*45)), hirosx*(size+53), hirosy*39, isMouseInPosition((hirosx*1268) - (hirosx*size), (hirosy*59) + ((i-1)*(hirosy*45)), hirosx*(size+53), hirosy*39) and tocolor(20, 20, 20, 255) or tocolor(30,30,30, 255), hirosx*5);
				dxDrawImage((hirosx*1276) - (hirosx*size), (hirosy*67) + ((i-1)*(hirosy*45)), hirosx*23, hirosy*23, v.img);
				dxDrawText(text, (hirosx*1303) - (hirosx*size), (hirosy*59) + ((i-1)*(hirosy*45)), (hirosx*size) + ((hirosx*1303) - (hirosx*size)), (hirosy*39) + ((hirosy*59) + ((i-1)*(hirosy*45))), tocolor(255, 255, 255, 255), 1.00, Roboto, 'center', 'center')

			end

		end

		if activeBlip then

			if cursorX and cursorY then

				local text = false;
				text = activeBlip;

				if text then

					tooltip_items(text);

				end

			end

			activeBlip = false;

		end

	end

end




function tooltip_items(text, text2, text3)

    local x, y = getCursorPosition();
    local x, y = x * monitorSize[1], y * monitorSize[2];

    text = tostring(text);
    if text2 then

        text2 = tostring(text2);

    end

    if text3 then

        text3 = tostring(text3);

    end


    if text == text2 then

        text2 = nil;

    end

    local width = dxGetTextWidth(text:gsub("#%x%x%x%x%x%x", ""), 1, "default-bold") + 20;
    if text2 then

        width = math.max(width, dxGetTextWidth(text2:gsub("#%x%x%x%x%x%x", ""), 1, "default-bold") + 20);
        text = text .. "\n" .. text2.."\n" .. (text3 or "");

    end

    local height = 10 * (text2 and 5 or 3);
    x = math.max(10, math.min(x, monitorSize[1] - width - 10));
    y = math.max(10, math.min(y, monitorSize[2] - height - 10));

    dxDrawRoundedRectangle(x+10, y, width, height, tocolor(30,30,30, 255), hirosx*5);
    dxDrawText(text, x + 10 + width / 2, y, x + 10 + width / 2, y + height, tocolor(255,255,255, 255), 1, 'default', "center", "center", false, false, true, true);

end

function getDuplicateBlip(name)

	for i,v in ipairs(blipsRendered) do

		if (v.name == name) then

			return i;

		end

	end

	return false;

end


function bigmapZoomHandler(timeSlice)

	zoom = zoom + (targetZoom - zoom) * timeSlice * 0.005;

end

addEventHandler("onClientKey", getRootElement(),

	function (key, state)

		if key == "F11" then

			if state then

				bigRadarState = not bigRadarState;
				if bigRadarState then

					toggleHUD(false);
					showChat(false);
					showCursor ( true );
					blipMarker = false;
					blipSelected = {1, false};

					blurShader = {

						screenSource = dxCreateScreenSource(panelWidth, panelHeight),
						shader = dxCreateShader("assets/shaders/blur.fx")

					};

					if isElement(blurShader.shader) then

						dxSetShaderValue(blurShader.shader, "screenSize", {monitorSize[1], monitorSize[2]});
						dxSetShaderValue(blurShader.shader, "blurStrength", 5);

					end

					addEventHandler("onClientPreRender", getRootElement(), bigmapZoomHandler);
					addEventHandler("onClientRender", getRootElement(), renderTheBigmap);
					addEventHandler("onClientClick", getRootElement(), onBigmapClick);

					setElementData(localPlayer,"show", true);

				else

					setElementData(localPlayer,"show", false);

					removeEventHandler("onClientPreRender", getRootElement(), bigmapZoomHandler);
					removeEventHandler("onClientRender", getRootElement(), renderTheBigmap);
					removeEventHandler("onClientClick", getRootElement(), onBigmapClick);

					if isElement(blurShader.shader) then

						destroyElement(blurShader.shader);

					end

					if isElement(blurShader.screenSource) then

						destroyElement(blurShader.screenSource);

					end

					blurShader = nil;
					toggleHUD(true);
					--showChat(true);
					showCursor (false);

				end

				setElementData(localPlayer, "bigmapIsVisible", bigRadarState, false);

			end

			cancelEvent();

		elseif key == "mouse_wheel_up" and bigRadarState then

			if targetZoom + 0.1 <= 1.2 then

				targetZoom = targetZoom + 0.1;

			end

		elseif key == "mouse_wheel_down" and bigRadarState then

			if targetZoom - 0.1 >= 0.5 then

				targetZoom = targetZoom - 0.3;

			end

		end

		if key == 'arrow_r' and bigRadarState and blipMarker then

			if state then

				if blipSelected[1] < blipsRendered[blipSelected[2]].count then

					local x,y,z = unpack( blipsRendered[blipSelected[2]].position[blipSelected[1]+1]);
					blipSelected[1] = blipSelected[1] + 1;
					blipMarker = {x, y};
					mapMoveDiff = false;

				end

			end

			cancelEvent();

		end

		if key == 'arrow_l' and bigRadarState and blipMarker then

			if state then

				if blipSelected[1] > 1 then

					local x,y,z = unpack( blipsRendered[blipSelected[2]].position[blipSelected[1]-1]);
					blipSelected[1] = blipSelected[1] - 1;
					blipMarker = {x, y};
					mapMoveDiff = false;

				end

			end

			cancelEvent();

		end

	end

)




function dxDrawRoundedRectangle(x, y, rx, ry, color, radius)
    rx = rx - radius * 2
    ry = ry - radius * 2
    x = x + radius
    y = y + radius

    if (rx >= 0) and (ry >= 0) then
        dxDrawRectangle(x, y, rx, ry, color)
        dxDrawRectangle(x, y - radius, rx, radius, color)
        dxDrawRectangle(x, y + ry, rx, radius, color)
        dxDrawRectangle(x - radius, y, radius, ry, color)
        dxDrawRectangle(x + rx, y, radius, ry, color)

        dxDrawCircle(x, y, radius, 180, 270, color, color, 7)
        dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 7)
        dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7)
        dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 7)
    end
end
--[[
local blipTEste = createBlip(-2610.7875976562,122.1139755249,4.3359375, 11);
setElementData(blipTEste, 'blipName', 'arara')


local blipTEste3 = createBlip(-2610.7875976562+200,122.1139755249,4.3359375, 11);
setElementData(blipTEste3, 'blipName', 'arara')


]]
--[[
local blipTEste2 = createBlip(-2530.3271484375,425.45401000977,24.626792907715, 12);
setElementData(blipTEste2, 'blipName', 'Homem aranha')

]]
local blipbarbearia1 = createBlip(823.78363, -1588.64172, 13.55445, 7);
setElementData(blipbarbearia1, 'blipName', 'Barberia')

local blipbarbearia2 = createBlip(2071.18091, -1793.85730, 13.55328, 7);
setElementData(blipbarbearia2, 'blipName', 'Barberia')






--[[ 

     Mais mods como este você encontra aqui: 
     
     https://discord.gg/UbJy4WJkx7
     https://discord.gg/UbJy4WJkx7

 ]]