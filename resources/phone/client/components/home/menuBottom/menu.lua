function menuComponent(parent, x, y, w, h)
    local menuRect, blur = menuRectangle(x, y, w, h, parent)

    -- draw apps menu

    local callApp = callIconComponent(menuRect, parent)
    local musicApp = musicIconComponent(menuRect)
    local whatsappApp = whatsAppIconComponent(menuRect)
    local cameraApp = cameraIconComponent(menuRect)

    return menuRect, blur
end