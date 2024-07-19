function RenderHome()
    local screenX, screenY = dgsGetScreenSize()
    
    data["homeScreen"]["skeleton"] = dgsCreateImage(0, 0, screenX * 0.198, screenY * 0.7, "assets/skeleton.png", false, data["phoneImage"])
    data["homeScreen"]["wallpaper"] = wallpaperComponent(screenX * 0.765, screenY * 0.318, screenX * 0.174, screenY * 0.6422, "assets/wallpaper_2.jpg")

    menuComponent(data["homeScreen"]["skeleton"], screenX * 0.026, screenY * 0.58, screenX * 0.15, screenY * 0.065)
end

addCommandHandler("testt", function()
    local window = dgsCreateWindow(0.5, 0.5, 0.5, 0.5, "test", true)
    local x, y, z = getElementPosition(localPlayer)
    local vehicle = createVehicle(411, x, y, z)
    dgsAttachToAutoDestroy(vehicle, window)

    setTimer(function()
        destroyElement(window)
    end, 5000, 1)
end)
