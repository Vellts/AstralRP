function musicIconComponent(parent)
    local screenX, screenY = guiGetScreenSize()
    -- iprint(screenX, screenY, screenX * 0.05, screenY * 0.05)
    local image = dgsCreateImage(screenX * 0.041, screenY * 0.0026, screenX * 0.03, screenY * 0.06, "assets/music_icon.png", false, parent)

    addEventHandler("onDgsMouseEnter", image, function()
        dgsMoveTo(image, screenX * 0.041, 0, false, "Linear", 100)
        removeEventHandler("onDgsMouseLeave", image, function() end)
    end, false)

    addEventHandler("onDgsMouseLeave", image, function()
        dgsMoveTo(image, screenX * 0.041, screenY * 0.0026, false, "Linear", 100)
        removeEventHandler("onDgsMouseEnter", image, function() end)
    end, false)

    return image
end