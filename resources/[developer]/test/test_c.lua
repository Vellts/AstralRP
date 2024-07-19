-- loadstring(exports.dgs:dgsImportFunction())()-- load functions

-- local senderA = dgsCreateButton(200,200,200,200,"SenderA",false)
-- local receiver = dgsCreateButton(500,500,200,200,"Receiver",false)

-- addEventHandler("onDgsDrag",senderA,function(data)
-- 	dgsSendDragNDropData({"From SenderA",getTickCount()}, nil, tocolor(0, 0, 0, 255))
-- end,false)


-- addEventHandler("onDgsDrop",receiver,function(data)
-- 	iprint("Receive Data: "..inspect(data))
-- end,false)

-- local MouseBind = false

-- bindKey("m", "down", function()
--     MouseBind = not MouseBind
--     showCursor(MouseBind)
-- end)

-- local coef = 0.01
-- function test(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement, startX, startY, startZ)
-- 	if source ~= localPlayer then return end
-- 	setCameraTarget(hitX, hitY, hitZ - coef)
-- 	local rot = 360 - getPedCameraRotation(localPlayer)
-- 	setPedCameraRotation ( localPlayer, rot - 0.5 )
-- end
-- addEventHandler("onClientPlayerWeaponFire", root, test)

local dgs = exports.dgs

local window = dgs:dgsCreateWindow(600, 300, 400, 400, "DGS Example", false)
local image1 = dgs:dgsCreateImage(0, 0, 300, 400, nil, false, window, tocolor(237, 76, 76, 255))
local image2 = dgs:dgsCreateImage(0, 0, 150, 150, nil, false, window, tocolor(255, 255, 255, 255))
dgs:dgsSetProperty(image1, "changeOrder", false)
showCursor(true)
