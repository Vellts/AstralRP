function wallpaperComponent(x, y, w, h, image)
    local image = dgsCreateImage(x, y, w, h, image, false)
    
    -- mueve la imagen al fondo
    dgsMoveToBack(image)

    return image
end