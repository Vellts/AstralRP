local dgs = exports.dgs
cache = {}

-- addEventHandler("onClientResourceStart", resourceRoot, viewPlayer)

function characterInfo(character)
    -- iprint(character)

    if (cache.whois) then
        for _, v in pairs(cache) do
            if (isElement(v)) then
                destroyElement(v)
            end
        end
    end

    ---- DATOS PERSONAJE ----

    cache.whois = dgs:dgsCreateLabel(0.75, 0.2, 0.2, 0.04, "Datos del personaje", true, data.parent)
    dgs:dgsSetProperties(cache.whois, {
        font = data.font,
        colorCoded = true,
        alpha = 0.6,
        alignment = { "left", "center" },
        -- textSize = { 0.7, 0.7 },
        textColor = tocolor(255, 240, 240, 255)
    })

    ---- NOMBRE DEL PERSONAJE ----

    cache.name_1 = dgs:dgsCreateLabel(0.75, 0.25, 0.2, 0.04, "Nombre completo", true, data.parent)
    dgs:dgsSetProperties(cache.name_1, {
        font = data.font,
        colorCoded = true,
        alpha = 0.6,
        alignment = { "left", "center" },
        textSize = { 0.6, 0.6 },
        textColor = tocolor(255, 240, 240, 255)
    })

    cache.name_2 = dgs:dgsCreateLabel(0.75, 0.29, 0.2, 0.02, character.character_name, true, data.parent)
    dgs:dgsSetProperties(cache.name_2, {
        font = data.font,
        colorCoded = true,
        alpha = 0.6,
        alignment = { "left", "center" },
        textSize = { 0.5, 0.5 },
        textColor = tocolor(255, 240, 240, 160)
    })

    ---- EDAD DEL PERSONAJE ----

    cache.age_1 = dgs:dgsCreateLabel(0.75, 0.33, 0.2, 0.04, "Edad", true, data.parent)
    dgs:dgsSetProperties(cache.age_1, {
        font = data.font,
        colorCoded = true,
        alpha = 0.6,
        alignment = { "left", "center" },
        textSize = { 0.6, 0.6 },
        textColor = tocolor(255, 240, 240, 255)
    })

    cache.age_2 = dgs:dgsCreateLabel(0.75, 0.37, 0.2, 0.02, character.age.." años", true, data.parent)
    dgs:dgsSetProperties(cache.age_2, {
        font = data.font,
        colorCoded = true,
        alpha = 0.6,
        alignment = { "left", "center" },
        textSize = { 0.5, 0.5 },
        textColor = tocolor(255, 240, 240, 160)
    })

    ---- DINERO EN EL BANCO ----

    cache.bank_1 = dgs:dgsCreateLabel(0.75, 0.41, 0.2, 0.04, "Dinero en el banco", true, data.parent)
    dgs:dgsSetProperties(cache.bank_1, {
        font = data.font,
        colorCoded = true,
        alpha = 0.6,
        alignment = { "left", "center" },
        textSize = { 0.6, 0.6 },
        textColor = tocolor(255, 240, 240, 255)
    })

    cache.bank_2 = dgs:dgsCreateLabel(0.75, 0.45, 0.2, 0.02, "$"..character.money_bank, true, data.parent)
    dgs:dgsSetProperties(cache.bank_2, {
        font = data.font,
        colorCoded = true,
        alpha = 0.6,
        alignment = { "left", "center" },
        textSize = { 0.5, 0.5 },
        textColor = tocolor(255, 240, 240, 160)
    })

    ---- UBICACIÓN DEL PERSONAJE ----

    cache.location_1 = dgs:dgsCreateLabel(0.75, 0.49, 0.2, 0.04, "Ubicación", true, data.parent)
    dgs:dgsSetProperties(cache.location_1, {
        font = data.font,
        colorCoded = true,
        alpha = 0.6,
        alignment = { "left", "center" },
        textSize = { 0.6, 0.6 },
        textColor = tocolor(255, 240, 240, 255)
    })

    local position = fromJSON(character.positions)
    -- iprint(position)
    local location = getZoneName(position[1], position[2], position[3])
    local city = getZoneName(position[1], position[2], position[3], true)
    cache.location_2 = dgs:dgsCreateLabel(0.75, 0.53, 0.2, 0.02, location..", "..city, true, data.parent)
    dgs:dgsSetProperties(cache.location_2, {
        font = data.font,
        colorCoded = true,
        alpha = 0.6,
        alignment = { "left", "center" },
        textSize = { 0.5, 0.5 },
        textColor = tocolor(255, 240, 240, 160)
    })

    ---- BOTÓN DE JUGAR ----

    cache.play = dgs:dgsCreateButton(0.75, 0.6, 0.08, 0.04, "Jugar", true, data.parent)
    dgs:dgsSetProperties(cache.play, {
        font = data.font,
        alpha = 0.6,
        alignment = { "center", "center" },
        textSize = { 0.6, 0.6 },
        textColor = tocolor(255, 240, 240, 255),
        image = {
            data.shaders[1],
            data.shaders[2],
            data.shaders[1]
        },
        -- enabled=false
    })

    addEventHandler("onDgsMouseClickDown", cache.play, function()
        if (source ~= cache.play) then return end
        iprint("Wanna play? Let's play!")
        switchWindow()
        triggerServerEvent("system::characterSelected", localPlayer, character.character_id)
    end)
end
-- addEventHandler("onClientResourceStart", root, characterInfo)
