function menuRectangle(x, y, w, h, parent)
    -- efecto blur
    local blur = dgsCreateBlurBox(x, y)
    dgsSetProperty(blur, "updateScreenSource", true) 

    local rectangleShader = dgsCreateRoundRect(10, false, tocolor(206, 206, 206, 200))

    -- configuraciones

    dgsBlurBoxSetFilter(blur, rectangleShader)
    dgsBlurBoxSetIntensity(blur, 15)
    dgsBlurBoxSetLevel(blur, 2)

    local menu = dgsCreateImage(x, y, w, h, blur, false, parent)
    dgsAttachToAutoDestroy(blur, menu)
    -- dgsAttachToAutoDestroy(blur, rectangleShader)

    return menu, blur
end