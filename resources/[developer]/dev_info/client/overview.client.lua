local dgs = exports.dgs
local screenW, screenH = guiGetScreenSize()
local boundingElements = false
local colorVehicle = tocolor(255, 255, 255)
local colorPlayer = tocolor(0, 255, 0)

function getPositionFromElementOffset(element,offX,offY,offZ)
    local m = getElementMatrix ( element )  -- Get the matrix
    local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
    local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
    local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
    return x, y, z                               -- Return the transformed point
end

function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
	local x, y, z = getElementPosition(TheElement)
	local x2, y2, z2 = getCameraMatrix()
	local distance = distance or 20
	local height = height or 1

	if (isLineOfSightClear(x, y, z+2, x2, y2, z2, ...)) then
		local sx, sy = getScreenFromWorldPosition(x, y, z+height)
		if(sx) and (sy) then
			local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
			if(distanceBetweenPoints < distance) then
				dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
			end
		end
	end
end

function drawElementLine(element)
    if (not isElement(element)) then return end
    local width = 2
    if (getElementType(element) == "vehicle") then
        drawVehicleContent(element)
    elseif (getElementType(element) == "player") then
        drawPlayerContent(element)
    end
end

function drawVehicleContent(element)
    local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(element)

    -- get all bounding box points and draw lines between them to create the box with getPositionFromElementOffset


    local x1, y1, z1 = getPositionFromElementOffset(element, minX, minY, minZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, maxX, minY, minZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorVehicle, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, minX, minY, minZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, minX, maxY, minZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorVehicle, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, minX, minY, minZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, minX, minY, maxZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorVehicle, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, maxX, maxY, maxZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, minX, maxY, maxZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorVehicle, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, maxX, maxY, maxZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, maxX, minY, maxZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorVehicle, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, maxX, maxY, maxZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, maxX, maxY, minZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorVehicle, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, minX, minY, maxZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, maxX, minY, maxZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorVehicle, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, minX, minY, maxZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, minX, maxY, maxZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorVehicle, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, minX, maxY, minZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, maxX, maxY, minZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorVehicle, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, minX, maxY, minZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, minX, maxY, maxZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorVehicle, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, maxX, minY, minZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, maxX, maxY, minZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorVehicle, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, maxX, minY, minZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, maxX, minY, maxZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorVehicle, width)

    local id = getElementModel(element)
    local name = getVehicleNameFromModel(id) or "Unknown"
    dxDrawTextOnElement(element, "["..id.."] "..name, 1, 40, 255, 255, 255, 255, 3, "default-bold")
end

function drawPlayerContent(element)
    local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(element)

    local x1, y1, z1 = getPositionFromElementOffset(element, minX, minY, minZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, maxX, maxY, maxZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorPlayer, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, minX, minY, minZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, maxX, minY, maxZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorPlayer, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, minX, minY, minZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, minX, maxY, maxZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorPlayer, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, maxX, maxY, maxZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, minX, maxY, minZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorPlayer, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, maxX, maxY, maxZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, maxX, minY, minZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorPlayer, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, maxX, maxY, maxZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, maxX, maxY, minZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorPlayer, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, minX, minY, maxZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, maxX, minY, minZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorPlayer, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, minX, minY, maxZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, minX, maxY, minZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorPlayer, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, minX, maxY, minZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, maxX, maxY, maxZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorPlayer, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, minX, maxY, minZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, minX, maxY, maxZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorPlayer, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, maxX, minY, minZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, maxX, maxY, maxZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorPlayer, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, maxX, minY, minZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, maxX, minY, maxZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorPlayer, width)

    -- draw the top
    local x1, y1, z1 = getPositionFromElementOffset(element, minX, minY, maxZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, maxX, maxY, maxZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorPlayer, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, minX, minY, maxZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, maxX, maxY, maxZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorPlayer, width)
    
    local x1, y1, z1 = getPositionFromElementOffset(element, minX, maxY, maxZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, maxX, minY, maxZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorPlayer, width)

    local x1, y1, z1 = getPositionFromElementOffset(element, minX, maxY, maxZ)
    local x2, y2, z2 = getPositionFromElementOffset(element, maxX, minY, maxZ)
    dxDrawLine3D(x1, y1, z1, x2, y2, z2, colorPlayer, width)

    local playerName = getElementData(element, "player::character_name") or "Unknown"
    dxDrawTextOnElement(element, playerName, 1, 40, 0, 255, 0, 255, 3, "default-bold")

end

function updateChartsDeveloper(state)
    iprint("State", state)
    boundingElements = state
    setDevelopmentMode(state)
    setDebugViewActive(state)
end
addEvent("developer::updateStatusCharts", true)
addEventHandler("developer::updateStatusCharts", localPlayer, updateChartsDeveloper)

addEventHandler("onClientRender", root, function()
    if (not boundingElements) then return end
    local x, y, z = getElementPosition(localPlayer)
    local elements = getElementsWithinRange(x, y, z, 40)
    for i, element in ipairs(elements) do
        drawElementLine(element)
    end
end)