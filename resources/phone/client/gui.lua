loadstring(exports.dgs:dgsImportFunction())()

local status = false
local screenX, screenY = dgsGetScreenSize()

-- data = {
--     ["phoneSkeleton"] = nil,
--     ["phoneImage"] = nil,
--     ["phoneWallpaper"] = nil,
--     ["menuBottom"] = {
--         ["menuBottomItems"] = {
--             ["callPhoneItem"] = {
--                 ["element"] = nil,
--                 ["isHovered"] = false
--             },
--             ["messageItem"] = nil,
--             ["contactItem"] = nil,
--             ["settingItem"] = nil,
--         },
--         ["menuBottomImage"] = nil,
--         ["menuBottomBlurBox"] = nil
--     },
--     ["status"] = false
-- }

-- local function drawPhone()

--     data["status"] = not status

--     -- data["phoneSkeleton"] = dgsCreateCanvas()

--     -- esqueleto del iphone
--     data["phoneImage"] = phoneComponent(screenX * 0.75, screenY * 0.9, screenX * 0.2, screenY * 0.7, "assets/iphone.png")

--     -- -- wallpaper
--     -- data["phoneWallpaper"] = wallpaperComponent(screenX * 0.792, screenY * 0.92, screenX * 0.165, screenY * 0.55, "assets/wallpaper.jpg", data["phoneImage"])

--     -- -- animate phone

--     dgsMoveTo(data["phoneImage"], screenX * 0.75, screenY * 0.3, false, "InQuad", 500)

--     -- -- animate wallpaper

    -- dgsMoveTo(data["phoneWallpaper"], screenX * 0.795, screenY * 0.415, false, "InQuad", 500)

--     -- -- draw rounded rectangle menu
    
--     -- data["menuBottom"]["menuBottomImage"], data["menuBottom"]["menuBottomBlurBox"] = menuComponent(data["phoneImage"], screenX * 0.052, screenY * 0.48, screenX * 0.15, screenY * 0.065)

-- end

local function drawPhone()
    data["status"] = not data["status"]
    if (not data["globalFonts"]["SemiBold"]) then data["globalFonts"]["SemiBold"] = dgsCreateFont("assets/Poppins-SemiBold.ttf", 24) end
    if (not data["globalFonts"]["Bold"]) then data["globalFonts"]["Bold"] = dgsCreateFont("assets/Poppins-Bold.ttf", 30) end

    -- esqueleto del telefono
    data["phoneImage"] = phoneComponent(screenX * 0.75, screenY * 0.9, screenX * 0.2, screenY * 0.7, "assets/iphone.png")

    -- animacion
    dgsMoveTo(data["phoneImage"], screenX * 0.75, screenY * 0.3, false, "InQuad", 530)

    -- wallpaper

    -- data["phoneWallpaper"] = wallpaperComponent(screenX * 0.75, screenY * 0.9, screenX * 0.18, screenY * 0.7, "assets/wallpaper.jpg", data["phoneImage"])
    -- data["lockScreen"]["wallpaper"] = wallpaperComponent(screenX * 0.762, screenY * 0.92, screenX * 0.174, screenY * 0.6422, "assets/wallpaper.jpg")


    -- -- animacion

    -- dgsMoveTo(data["lockScreen"]["wallpaper"], screenX * 0.765, screenY * 0.318, false, "InQuad", 500)
    
    -- draw lock screen
    RenderLock(data["phoneImage"])
    triggerServerEvent("pedanim", localPlayer)
    -- local date, hour, linterna, camara = RenderLock(data["lockScreen"]["wallpaper"])

    -- data["lockScreen"]["date"] = date
    -- data["lockScreen"]["hour"] = hour
    -- data["lockScreen"]["linterna"] = linterna
    -- data["lockScreen"]["camara"] = camara
    -- iprint(data["lockScreen"])
end

local function openPhone()
    if data["status"] then
        destroyPhone(data["actualScreen"])
        triggerServerEvent("stoppedanim", localPlayer)

        setTimer(function()
            iprint(data)
        end, 500, 1)
    else
        -- open phone
        drawPhone()
        showCursor(true)
    end
end


bindKey("F2", "down", openPhone)
