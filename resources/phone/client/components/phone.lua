function phoneComponent(x, y, w, h, image)
    local image = dgsCreateImage(x, y, w, h, image, false)

    -- iconos esenciales
    local icons = PhoneEsencial(image)

    return image
end
