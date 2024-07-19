local dgs = exports.dgs
cache_creation = {
    stepOne = {},
    formatter = {
        ["camisa"] = "camisa",
        ["cabello"] = "cabelo",
        ["pantalones"] = "perna",
        ["zapatos"] = "tenis",
        ["lentes"] = "oculos",
        ["piel"] = "body"
    },
    currentPrimary = 0,
    currentSecondary = 0,
    noNeedSecondOption = {
        ["piel"] = true
    },
    stepTwo = {},
    player_clothes = {},
    genre = 14
}
local screenX, screenY = dgs:dgsGetScreenSize()

function createCharacterStepOne()
    -- showCursor(true)
    data.parent_2 = dgs:dgsCreateImage(0, 0, screenX, screenY, _, false, _, tocolor(25, 23, 25, 100))
    cache_creation.stepOne.createLabel = dgs:dgsCreateLabel(0.75, 0.2, 0.2, 0.04, "Datos del personaje", true, data.parent_2)
    dgs:dgsSetProperties(cache_creation.stepOne.createLabel, {
        font = data.font,
        colorCoded = true,
        -- alpha = 0.6,
        alignment = { "left", "center" },
        -- textSize = { 0.7, 0.7 },
        textColor = tocolor(255, 240, 240, 160)
    })

    cache_creation.stepOne.name_1 = dgs:dgsCreateLabel(0.75, 0.25, 0.2, 0.04, "Nombre", true, data.parent_2)
    dgs:dgsSetProperties(cache_creation.stepOne.name_1, {
        font = data.font,
        colorCoded = true,
        -- alpha = 0.6,
        alignment = { "left", "center" },
        textSize = { 0.6, 0.6 },
        textColor = tocolor(255, 240, 240, 160)
    })
    
    cache_creation.stepOne.name_2 = dgs:dgsCreateEdit(0.75, 0.3, 0.2, 0.04, "", true, data.parent_2)
    dgs:dgsSetProperties(cache_creation.stepOne.name_2, {
        font = data.font,
        colorCoded = true,
        -- alpha = 0.6,
        alignment = { "left", "center" },
        textSize = { 0.5, 0.5 },
        textColor = tocolor(255, 240, 240, 160),
        bgColor = tocolor(0, 0, 0, 0),
        placeHolder = "Escribe el nombre",
        caretColor = tocolor(102, 102, 102, 160),
        caretWidth = {
            0.2,
            0.2,
            true
        }
    })
    dgs:dgsEditSetUnderlined(cache_creation.stepOne.name_2, true)

    -- apellido

    cache_creation.stepOne.surname_1 = dgs:dgsCreateLabel(0.75, 0.35, 0.2, 0.04, "Apellido", true, data.parent_2)
    dgs:dgsSetProperties(cache_creation.stepOne.surname_1, {
        font = data.font,
        colorCoded = true,
        -- alpha = 0.6,
        alignment = { "left", "center" },
        textSize = { 0.6, 0.6 },
        textColor = tocolor(255, 240, 240, 160)
    })

    cache_creation.stepOne.surname_2 = dgs:dgsCreateEdit(0.75, 0.4, 0.2, 0.04, "", true, data.parent_2)
    dgs:dgsSetProperties(cache_creation.stepOne.surname_2, {
        font = data.font,
        colorCoded = true,
        -- alpha = 0.6,
        alignment = { "left", "center" },
        textSize = { 0.5, 0.5 },
        textColor = tocolor(255, 240, 240, 160),
        bgColor = tocolor(0, 0, 0, 0),
        placeHolder = "Escribe el apellido",
        caretColor = tocolor(102, 102, 102, 160),
        caretWidth = {
            0.2,
            0.2,
            true
        }
    })
    dgs:dgsEditSetUnderlined(cache_creation.stepOne.surname_2, true)

    -- edad

    cache_creation.stepOne.age_1 = dgs:dgsCreateLabel(0.75, 0.45, 0.2, 0.04, "Edad", true, data.parent_2)
    dgs:dgsSetProperties(cache_creation.stepOne.age_1, {
        font = data.font,
        colorCoded = true,
        alignment = { "left", "center" },
        textSize = { 0.6, 0.6 },
        textColor = tocolor(255, 240, 240, 160)
    })

    cache_creation.stepOne.age_2 = dgs:dgsCreateEdit(0.75, 0.5, 0.2, 0.04, "", true, data.parent_2)
    dgs:dgsSetProperties(cache_creation.stepOne.age_2, {
        font = data.font,
        colorCoded = true,
        alignment = { "left", "center" },
        textSize = { 0.5, 0.5 },
        textColor = tocolor(255, 240, 240, 160),
        bgColor = tocolor(0, 0, 0, 0),
        placeHolder = "Escribe la edad",
        caretColor = tocolor(102, 102, 102, 160),
        caretWidth = {
            0.2,
            0.2,
            true
        },
        maxLength = 2
    })
    dgs:dgsEditSetUnderlined(cache_creation.stepOne.age_2, true)
    dgs:dgsEditSetTextFilter(cache_creation.stepOne.age_2, "[^0-9$]")

    -- generos

    cache_creation.stepOne.genre_1 = dgs:dgsCreateLabel(0.75, 0.55, 0.2, 0.04, "Genero", true, data.parent_2)
    dgs:dgsSetProperties(cache_creation.stepOne.genre_1, {
        font = data.font,
        colorCoded = true,
        alignment = { "left", "center" },
        textSize = { 0.6, 0.6 },
        textColor = tocolor(255, 240, 240, 160)
    })

    local shader_male = dgs:dgsCreateRoundRect(4, false, tocolor(104, 146, 228, 160))
    local shader_female = dgs:dgsCreateRoundRect(4, false, tocolor(223, 183, 255, 160))
    local normal_shader = dgs:dgsCreateRoundRect(4, false, tocolor(23, 23, 23, 160))
    local male_texture = dxCreateTexture("assets/male.png")
    local female_texture = dxCreateTexture("assets/female.png")

    cache_creation.stepOne.maleButton = dgs:dgsCreateButton(0.75, 0.6, 0.1, 0.04, "", true, data.parent_2)
    dgs:dgsSetProperties(cache_creation.stepOne.maleButton, {
        image = {
            normal_shader,
            shader_male,
            normal_shader
        },
        iconImage = male_texture
    })
    addEventHandler("onDgsMouseClickDown", cache_creation.stepOne.maleButton, function()
        if (source ~= cache_creation.stepOne.maleButton) then return end
        cache_creation.genre = 14
        dgs:dgsSetProperty(cache_creation.stepOne.maleButton, "image", {
            shader_male,
            normal_shader,
            shader_male
        })

        dgs:dgsSetProperty(cache_creation.stepOne.femaleButton, "image", {
            normal_shader,
            female_shader,
            female_shader
        })
    end)

    cache_creation.stepOne.femaleButton = dgs:dgsCreateButton(0.85, 0.6, 0.1, 0.04, "", true, data.parent_2)
    dgs:dgsSetProperties(cache_creation.stepOne.femaleButton, {
        image = {
            normal_shader,
            shader_female,
            shader_female
        },
        iconImage = female_texture
    })
    addEventHandler("onDgsMouseClickDown", cache_creation.stepOne.femaleButton, function()
        if (source ~= cache_creation.stepOne.femaleButton) then return end
        cache_creation.genre = 15
        dgs:dgsSetProperty(cache_creation.stepOne.femaleButton, "image", {
            shader_female,
            shader_female,
            normal_shader
        })

        dgs:dgsSetProperties(cache_creation.stepOne.maleButton, {
            image = {
                normal_shader,
                shader_male,
                normal_shader
            },
        })
    end)

    -- salir 

    cache_creation.stepOne.exit = dgs:dgsCreateButton(0.75, 0.7, 0.08, 0.04, "Salir", true, data.parent_2)
    -- iprint(data.shaders[1], data.shaders[2], data.shaders[3])
    dgs:dgsSetProperties(cache_creation.stepOne.exit, {
        font = data.font,
        alignment = { "center", "center" },
        textSize = { 0.6, 0.6 },
        textColor = tocolor(255, 240, 240, 160),
        image = {
            data.shaders[1],
            data.shaders[3],
            data.shaders[1]
        },
        enabled = true
    })
    addEventHandler("onDgsMouseClickDown", cache_creation.stepOne.exit, function()
        if (source ~= cache_creation.stepOne.exit) then return end
        switchWindow("all")
    end)

    -- --continuar

    cache_creation.stepOne.continue = dgs:dgsCreateButton(0.84, 0.7, 0.08, 0.04, "Continuar", true, data.parent_2)
    dgs:dgsSetProperties(cache_creation.stepOne.continue, {
        font = data.font,
        alignment = { "center", "center" },
        textSize = { 0.6, 0.6 },
        textColor = tocolor(255, 240, 240, 160),
        image = {
            data.shaders[1],
            data.shaders[3],
            data.shaders[1]
        },
        -- enabled=false
    })

    addEventHandler("onDgsMouseClickDown", cache_creation.stepOne.continue, function()
        if (source ~= cache_creation.stepOne.continue) then return end
        if (dgs:dgsGetText(cache_creation.stepOne.name_2) == "") or (dgs:dgsGetText(cache_creation.stepOne.surname_2) == "") or (dgs:dgsGetText(cache_creation.stepOne.age_2) == "") then
            iprint("Faltan datos")
            return
        end


        switchCreationStep("custom")
    end)
end


function createCharacterStepTwo()
    -- showCursor(true)

    ----------- TOOLTIPS ------------

    local circle_hair = dgs:dgsCreateImage(0.44, 0.32, 0.01, 0.015, "assets/circle.png", true, data.parent_2)
    local tooltip_hair = dgs:dgsCreateToolTip()
    dgs:dgsTooltipApplyTo(tooltip_hair, circle_hair, "CABELLO")

    local circle_glasses = dgs:dgsCreateImage(0.43, 0.34, 0.01, 0.015, "assets/circle.png", true, data.parent_2)
    local tooltip_glasses = dgs:dgsCreateToolTip()
    dgs:dgsTooltipApplyTo(tooltip_glasses, circle_glasses, "LENTES")

    local circle_camisa = dgs:dgsCreateImage(0.45, 0.42, 0.01, 0.015, "assets/circle.png", true, data.parent_2)
    local tooltip_camisa = dgs:dgsCreateToolTip()
    dgs:dgsTooltipApplyTo(tooltip_camisa, circle_camisa, "CAMISA")

    local circle_pantalon = dgs:dgsCreateImage(0.46, 0.58, 0.01, 0.015, "assets/circle.png", true, data.parent_2)
    local tooltip_pantalon = dgs:dgsCreateToolTip()
    dgs:dgsTooltipApplyTo(tooltip_pantalon, circle_pantalon, "PANTALON")
    
    local circle_zapatos = dgs:dgsCreateImage(0.47, 0.78, 0.01, 0.015, "assets/circle.png", true, data.parent_2)
    local tooltip_zapatos = dgs:dgsCreateToolTip()
    dgs:dgsTooltipApplyTo(tooltip_zapatos, circle_zapatos, "ZAPATOS")

    local circle_piel = dgs:dgsCreateImage(0.405, 0.5, 0.01, 0.015, "assets/circle.png", true, data.parent_2)
    local tooltip_piel = dgs:dgsCreateToolTip()
    dgs:dgsTooltipApplyTo(tooltip_piel, circle_piel, "PIEL")

    ----------- ESCOGER ------------
    addEventHandler("onDgsMouseClickDown", circle_hair, function()
        if (source ~= circle_hair) then return end
        chooseTypeClothes("cabello")
    end)

    addEventHandler("onDgsMouseClickDown", circle_piel, function()
        if (source ~= circle_piel) then return end
        chooseTypeClothes("piel")
    end)

    addEventHandler("onDgsMouseClickDown", circle_glasses, function()
        if (source ~= circle_glasses) then return end
        chooseTypeClothes("lentes")
    end)

    addEventHandler("onDgsMouseClickDown", circle_camisa, function()
        if (source ~= circle_camisa) then return end
        chooseTypeClothes("camisa")
    end)

    addEventHandler("onDgsMouseClickDown", circle_pantalon, function()
        if (source ~= circle_pantalon) then return end
        chooseTypeClothes("pantalones")
    end)

    addEventHandler("onDgsMouseClickDown", circle_zapatos, function()
        if (source ~= circle_zapatos) then return end
        chooseTypeClothes("zapatos")
    end)

    cache_creation.stepTwo.buttonBack = dgs:dgsCreateButton(0.75, 0.55, 0.08, 0.04, "Atras", true, data.parent_2)
    dgs:dgsSetProperties(cache_creation.stepTwo.buttonBack, {
        font = data.font,
        -- alpha = 0.6,
        alignment = { "center", "center" },
        textSize = { 0.6, 0.6 },
        textColor = tocolor(255, 240, 240, 160),
        image = {
            data.shaders[1],
            data.shaders[2],
            data.shaders[1]
        },
    })
    addEventHandler("onDgsMouseClickDown", cache_creation.stepTwo.buttonBack, function()
        if (source ~= cache_creation.stepTwo.buttonBack) then return end
        switchCreationStep("info")
    end)

    cache_creation.stepTwo.buttonContinue = dgs:dgsCreateButton(0.84, 0.55, 0.08, 0.04, "Continuar", true, data.parent_2)
    dgs:dgsSetProperties(cache_creation.stepTwo.buttonContinue, {
        font = data.font,
        -- alpha = 0.6,
        alignment = { "center", "center" },
        textSize = { 0.6, 0.6 },
        textColor = tocolor(255, 240, 240, 160),
        image = {
            data.shaders[1],
            data.shaders[2],
            data.shaders[1]
        },
    })

    addEventHandler("onDgsMouseClickDown", cache_creation.stepTwo.buttonContinue, function()
        if (source ~= cache_creation.stepTwo.buttonContinue) then return end
        local character_data = {
            character_name = dgs:dgsGetText(cache_creation.stepOne.name_2).." "..dgs:dgsGetText(cache_creation.stepOne.surname_2),
            age = tonumber(dgs:dgsGetText(cache_creation.stepOne.age_2)),
            gender = 14,
        }

        local clothes_data = {
            skin = getElementModel(localPlayer),
            hair = cache_creation.player_clothes.cabelo,
            shirt = cache_creation.player_clothes.camisa,
            pants = cache_creation.player_clothes.perna,
            tenis = cache_creation.player_clothes.tenis,
            glasses = cache_creation.player_clothes.oculos,
            body = cache_creation.player_clothes.body,
            pectoral = cache_creation.player_clothes.pec,
            feets = cache_creation.player_clothes.coxa,
            face = cache_creation.player_clothes.face,
        }
        switchWindow()
        setTimer(function()
            triggerServerEvent("system::createCharacter", localPlayer, character_data, clothes_data)
        end, 2100, 1)
    end)
    
end
-- addEventHandler("onClientResourceStart", resourceRoot, createCharacterStepTwo)

function chooseTypeClothes(type)
    if (cache_creation.stepTwo.typeLabel) then
        for key, v in pairs(cache_creation.stepTwo) do
            if (isElement(v)) and (dgs:dgsGetType(v) ~= "dgs-dxbutton") then
                destroyElement(v)
                cache_creation.stepTwo[key] = nil
            end
        end
    end
    cache_creation.stepTwo.typeLabel = dgs:dgsCreateLabel(0.75, 0.2, 0.2, 0.04, string.upper(type), true, data.parent_2)
    dgs:dgsSetProperties(cache_creation.stepTwo.typeLabel, {
        font = data.font,
        colorCoded = true,
        -- alpha = 0.6,
        alignment = { "left", "center" },
        -- textSize = { 0.7, 0.7 },
        textColor = tocolor(255, 240, 240, 160)
    })

    cache_creation.stepTwo.chooseTypeLabel = dgs:dgsCreateLabel(0.75, 0.25, 0.2, 0.04, "Escoge el tipo de " .. type.." ["..cache_creation.currentPrimary.."]", true, data.parent_2)
    dgs:dgsSetProperties(cache_creation.stepTwo.chooseTypeLabel, {
        font = data.font,
        colorCoded = true,
        -- alpha = 0.6,
        alignment = { "left", "center" },
        textSize = { 0.5, 0.5 },
        textColor = tocolor(255, 240, 240, 160)
    })

    local circle = dgs:dgsCreateCircle(0.5, 0.0001, 360, tocolor(223, 183, 255, 160))
    local shader = dgs:dgsCreateRoundRect(4, false, tocolor(23, 23, 23, 160))
    -- local shader_2 = dgs:dgsCreateRoundRect(4, false, tocolor(255, 240, 240, 120))
    cache_creation.stepTwo.scrollBar = dgs:dgsCreateScrollBar(0.75, 0.3, 0.2, 0.02, true, true, data.parent_2)
    local mapSize = (type == "pantalones") and 1 or 0
    dgs:dgsSetProperties(cache_creation.stepTwo.scrollBar, {
        arrowWidth = { 0, true },
        cursorWidth = { 1, true},
        -- cursorImage = shader
        image = {
            _,
            circle,
            shader
        },
        map = {
            mapSize, table.size(clothes[cache_creation.formatter[type]]) - 1
        }
    })
    dgs:dgsAttachToAutoDestroy(cache_creation.stepTwo.scrollBar, circle)
    dgs:dgsAttachToAutoDestroy(cache_creation.stepTwo.scrollBar, shader)

    addEventHandler("onDgsElementScroll", cache_creation.stepTwo.scrollBar, function(scrollbar, to, from)
        -- iprint("from: "..math.floor(from).." to: "..math.floor(to))
        dgs:dgsSetText(cache_creation.stepTwo.chooseTypeLabel, "Escoge el tipo de " .. type.." ["..math.floor(to).."]")
        local clothe = clothes[cache_creation.formatter[type]][math.floor(to)]
        exports.playerManager:setPlayerClothe(localPlayer, 14, clothe)
        for key, v in pairs(clothe) do
            cache_creation.player_clothes[key] = v
        end
        -- iprint(cache_creation.player_clothes)
        cache_creation.currentPrimary = math.floor(to)

        if (cache_creation.stepTwo.scrollBar2) and (math.floor(from) ~= math.floor(to)) then
            -- iprint("Current: "..)
            -- iprint(cache_creation.stepTwo.scrollBar2)
            dgs:dgsSetProperty(cache_creation.stepTwo.scrollBar2, "map", {0, #clothes[cache_creation.formatter[type].."_color"][cache_creation.currentPrimary]})
        end
    end)

    if (cache_creation.noNeedSecondOption[type]) then
        return
    end

    cache_creation.stepTwo.chooseColorLabel = dgs:dgsCreateLabel(0.75, 0.35, 0.2, 0.04, "Escoge el color de " .. type.." ["..cache_creation.currentSecondary.."]", true, data.parent_2)
    dgs:dgsSetProperties(cache_creation.stepTwo.chooseColorLabel, {
        font = data.font,
        colorCoded = true,
        -- alpha = 0.6,
        alignment = { "left", "center" },
        textSize = { 0.5, 0.5 },
        textColor = tocolor(255, 240, 240, 160)
    })
    cache_creation.stepTwo.scrollBar2 = dgs:dgsCreateScrollBar(0.75, 0.4, 0.2, 0.02, true, true, data.parent_2)
    -- iprint(clothes[cache_creation.formatter[type].."_color"][data.currentSecondary])
    dgs:dgsSetProperties(cache_creation.stepTwo.scrollBar2, {
        arrowWidth = { 0, true },
        cursorWidth = { 1, true},
        image = {
            _,
            circle,
            shader
        },
        map = {
            0, #(clothes[cache_creation.formatter[type].."_color"][cache_creation.currentPrimary])
        }
    })
    addEventHandler("onDgsElementScroll", cache_creation.stepTwo.scrollBar2, function(scrollbar, to, from)
        -- iprint("from: "..math.floor(from).." to: "..math.floor(to))
        dgs:dgsSetText(cache_creation.stepTwo.chooseColorLabel, "Escoge el color de " .. type.." ["..math.floor(to).."]")
        local clothe = clothes[cache_creation.formatter[type].."_color"][cache_creation.currentPrimary][(math.floor(to) == 0) and 1 or math.floor(to)]
        -- iprint(clothe)
        exports.playerManager:setPlayerClothe(localPlayer, 14, {
            [cache_creation.formatter[type]] = clothe
        })
        cache_creation.player_clothes[cache_creation.formatter[type]] = clothe
        cache_creation.currentSecondary = math.floor(to)
        -- iprint(cache_creation.player_clothes)
    end)
end

function switchCreationStep(to)
    if (to == "custom") then
        for key, v in pairs(cache_creation.stepOne) do
            if (isElement(v)) then
                dgs:dgsSetVisible(v, false)
                dgs:dgsAlphaTo(v, 0, "OutQuad", 1000)
            end
        end
        if (cache_creation.stepTwo.typeLabel) then
            for key, v in pairs(cache_creation.stepTwo) do
                if (isElement(v)) then
                    dgs:dgsSetVisible(v, true)
                    dgs:dgsAlphaTo(v, 1, "OutQuad", 1000)
                end
            end
        else
            createCharacterStepTwo()
        end
    elseif (to == "info") then
        for key, v in pairs(cache_creation.stepTwo) do
            if (isElement(v)) then
                dgs:dgsSetVisible(v, false)
                dgs:dgsAlphaTo(v, 0, "OutQuad", 1000)
            end
        end
        for key, v in pairs(cache_creation.stepOne) do
            if (isElement(v)) then
                dgs:dgsSetVisible(v, true)
                dgs:dgsAlphaTo(v, 1, "OutQuad", 1000)
            end
        end
    end
end