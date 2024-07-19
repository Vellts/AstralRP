function RenderLock(parent)
    local screenX, screenY = dgsGetScreenSize()

    data["lockScreen"]["wallpaper"] = wallpaperComponent(screenX * 0.762, screenY * 0.92, screenX * 0.174, screenY * 0.6422, "assets/wallpaper.jpg")
    dgsMoveTo(data["lockScreen"]["wallpaper"], screenX * 0.765, screenY * 0.318, false, "InQuad", 500)
    
    setTimer(function()
        data["lockScreen"]["skeleton"] = dgsCreateImage(0, 0, screenX * 0.198, screenY * 0.7, "assets/skeleton.png", false, parent)
        dgsBringToFront(data["lockScreen"]["skeleton"])

        local dateLabel, hourLabel  = RenderDates(data["lockScreen"]["skeleton"])
        local linterna = dgsCreateImage(screenX * 0.023, screenY * 0.58, screenX * 0.025, screenY * 0.044, "assets/linterna_icon.png", false, data["lockScreen"]["skeleton"])
        local camera = dgsCreateImage(screenX * 0.154, screenY * 0.58, screenX * 0.025, screenY * 0.044, "assets/camera_lock_icon.png", false, data["lockScreen"]["skeleton"])
        local textLabel = dgsCreateLabel(screenX * 0.051, screenY * 0.592, screenX * 0.1, screenY * 0.022, "Presiona para desbloquear", false, data["lockScreen"]["skeleton"])
        local textSize = 0.45 * (screenX / 1920) * 1.2
        dgsSetProperties(textLabel, {
            ["textSize"] = {textSize, textSize},
            ["font"] = data["globalFonts"]["SemiBold"],
            ["alignment"] = {"center", "center"},
        })
        local backLine = BackLine(data["lockScreen"]["skeleton"], true, "lock")
    end, 500, 1)
    
    

    -- return dateLabel, hourLabel, linterna, camera
end
