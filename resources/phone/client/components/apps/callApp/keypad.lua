---@diagnostic disable: undefined-global
local screenX, screenY = dgsGetScreenSize()

function DrawKeyPadScreen()
    
    -- BOTONES

    DrawKeypadButtons()

    -- ICONO LLAMADA

    CallData["appCallIcon"] = DrawAppCallIcon()
    CallData["appRemoveIcon"] = DrawAppRemoveIcon()


    -- NUMEROS

    CallData["number"] = dgsCreateLabel(screenX * 0.05, screenY * 0.08, screenX * 0.1, screenY * 0.06,
        CallData["text"], false, data["appScreen"]["callApp"]["skeleton"])

    local textSize = 1 * (screenX / 1920) * 1.2

    dgsSetProperties(CallData["number"], {
        ["textSize"] = { textSize, textSize },
        ["font"] = data["globalFonts"]["Bold"],
        ["textColor"] = tocolor(20, 20, 20, 255),
        ["alignment"] = { "center", "center" }
    })
    
end
