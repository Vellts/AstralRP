local dgs = exports.dgs
local state = false
local isCheckBoxEnabled = false

function loadLogin(parent, username, checkStatus)
    local ingresoText = dgs:dgsCreateLabel(0.4, 0.3, 0.2, 0.05, "INGRESO", true, parent)
    dgs:dgsSetProperties(ingresoText, {
        textColor = tocolor(141, 141, 141, 178),
        font = data.fonts.Poppins[50],
        alignment = {
            "left",
            "center"
        },
        alpha = 0,
    })

    local descText = dgs:dgsCreateLabel(0.4, 0.35, 0.2, 0.02, "INGRESA A TU CUENTA DE GLOBAL ROLEPLAY", true, parent)
    dgs:dgsSetProperties(descText, {
        textColor = tocolor(141, 141, 141, 178),
        font = data.fonts.Poppins[12],
        alignment = {
            "left",
            "center"
        },
        alpha = 0,
    })

    -- username

    local shader = dgs:dgsCreateRoundRect(4, false, tocolor(38, 38, 38, 178))
    local usernameInput = dgs:dgsCreateEdit(0.4, 0.4, 0.2, 0.05, username, true, parent)
    dgs:dgsSetProperties(usernameInput, {
        font = data.fonts.Poppins[12],
        textColor = tocolor(121, 121, 121, 255),
        placeHolder = "Ingrese el usuario",
        placeHolderColor = tocolor(121, 121, 121, 178),
        maxLength = 20,
        enableTabSwitch = true,
        bgImage = shader,
        caretHeight = 0.5,
        caretColor = tocolor(121, 121, 121, 178),
        padding = {
            60,
            0
        },
        selectBlur = 0.2,
        selectColor = tocolor(121, 121, 121, 178),
        alpha = 0,
    })
    dgs:dgsAttachToAutoDestroy(usernameInput, shader)

    local usernameIcon = dgs:dgsCreateImage(0.04, 0.25, 0.1, 0.5, "assets/user.png", true, usernameInput)

    -- password

    local passwordInput = dgs:dgsCreateEdit(0.4, 0.48, 0.2, 0.05, "", true, parent)
    dgs:dgsSetProperties(passwordInput, {
        font = data.fonts.Poppins[12],
        textColor = tocolor(121, 121, 121, 255),
        placeHolder = "Ingrese la contraseña",
        placeHolderColor = tocolor(121, 121, 121, 178),
        maxLength = 20,
        enableTabSwitch = true,
        bgImage = shader,
        caretHeight = 0.5,
        caretColor = tocolor(121, 121, 121, 178),
        padding = {
            60,
            0
        },
        selectBlur = 0.2,
        selectColor = tocolor(121, 121, 121, 178),
        masked = true,
        alpha = 0,
    })

    local passwordIcon = dgs:dgsCreateImage(0.04, 0.25, 0.1, 0.5, "assets/lock.png", true, passwordInput)
    local eyeIcon = dgs:dgsCreateImage(0.85, 0.25, 0.1, 0.5, "assets/eyeOff.png", true, passwordInput)
    addEventHandler("onDgsMouseClickDown", eyeIcon, function()
        if (source ~= eyeIcon) then return end
        local masked = dgs:dgsEditGetMasked(passwordInput)
        dgs:dgsEditSetMasked(passwordInput, not masked)
        dgs:dgsImageSetImage(eyeIcon, masked and "assets/eyeOn.png" or "assets/eyeOff.png")
    end)

    -- checkbox
    local shader_checkbox = dgs:dgsCreateRoundRect(4, false, tocolor(102, 102, 102, 160))
    local shader_checkbox2 = dgs:dgsCreateRoundRect(4, false, tocolor(81, 73, 105, 160))
    local check = (checkStatus == "true") and true or false
    
    local checkBox = dgs:dgsCreateCheckBox(0.4, 0.55, 0.02, 0.02, "", check, true, parent)
    dgs:dgsSetProperties(checkBox, {
        imageChecked = {
            shader_checkbox, 
            shader_checkbox,
            shader_checkbox2,
        },
        imageUnchecked = {
            shader_checkbox2,
            shader_checkbox2,
            shader_checkbox
        },
        text = "Recordar usuario",
        font = data.fonts.Poppins[12],
        textColor = tocolor(121, 121, 121, 255),
    })
    dgs:dgsAttachToAutoDestroy(checkBox, shader_checkbox)
    dgs:dgsAttachToAutoDestroy(checkBox, shader_checkbox2)
    
    -- login button
    local shader_2 = dgs:dgsCreateRoundRect(4, false, tocolor(81, 73, 105, 160))
    local loginButton = dgs:dgsCreateButton(0.4, 0.58, 0.2, 0.05, "INGRESAR", true, parent)
    dgs:dgsSetProperties(loginButton, {
        font = data.fonts.Poppins[50],
        image = shader_2,
        textSize = {
            0.6, 0.6
        },
        alignment = {
            "center", "center"
        },
        textColor = tocolor(121, 121, 121, 255),
        alpha = 0,
    })
    dgs:dgsAttachToAutoDestroy(loginButton, shader_2)
    addEventHandler("onDgsMouseHover", loginButton, function()
        if (source ~= loginButton) then return end
        dgs:dgsRoundRectSetColor(shader_2, tocolor(38, 38, 38, 255))
    end, false)
    addEventHandler("onDgsMouseLeave", loginButton, function()
        if (source ~= loginButton) then return end
        dgs:dgsRoundRectSetColor(shader_2, tocolor(81, 73, 105, 160))
    end, false)
    addEventHandler("onDgsMouseClickDown", loginButton, function()
        if (source ~= loginButton) then return end
        local username = dgs:dgsGetText(usernameInput)
        local password = dgs:dgsGetText(passwordInput)
        triggerServerEvent("player::loginRequest", localPlayer, username, password, dgs:dgsCheckBoxGetSelected(checkBox))
    end)

    -- without account

    local shader_3 = dgs:dgsCreateRoundRect(4, false, tocolor(81, 73, 105, 160), _, true, true, 0.1, 0.1)

    local withoutAccountImage = dgs:dgsCreateImage(0.4, 0.72, 0.2, 0.08, shader_3, true, parent)
    dgs:dgsSetProperty(withoutAccountImage, "changeOrder", false)
    dgs:dgsSetProperty(withoutAccountImage, "alpha", 0)
    local withoutAccountLabel = dgs:dgsCreateLabel(0.42, 0.75, 0.15, 0.02, "¿No tienes cuenta? Registrate", true, parent)
    dgs:dgsSetProperties(withoutAccountLabel, {
        textColor = tocolor(141, 141, 141, 178),
        font = data.fonts.Poppins[12],
        alignment = {
            "center",
            "center"
        },
        changeOrder = false,
        alpha = 0,
    })
    addEventHandler("onDgsMouseClickDown", withoutAccountLabel, function()
        if (source ~= withoutAccountLabel) then return end
        switchWindow()
    end)
    addEventHandler("onDgsMouseHover", withoutAccountImage, function()
        if (source ~= withoutAccountImage) then return end
        -- animateBorderColor(dgs, withoutAccountImage, shader_3, tocolor(121, 121, 121, 255), 2000, 2000)
        dgs:dgsRoundRectSetColor(shader_3, tocolor(38, 38, 38, 255))
    end, false)
    addEventHandler("onDgsMouseHover", withoutAccountLabel, function()
        if (source ~= withoutAccountLabel) then return end
        dgs:dgsRoundRectSetColor(shader_3, tocolor(38, 38, 38, 255))
    end)
    addEventHandler("onDgsMouseLeave", withoutAccountImage, function()
        if (source ~= withoutAccountImage) then return end
        dgs:dgsRoundRectSetColor(shader_3, tocolor(81, 73, 105, 160))
    end, false)
    addEventHandler("onDgsMouseLeave", withoutAccountLabel, function()
        if (source ~= withoutAccountLabel) then return end
        dgs:dgsRoundRectSetColor(shader_3, tocolor(81, 73, 105, 160))
    end)

    local elements = {
        ingresoText,
        descText,
        usernameInput,
        usernameIcon,
        passwordInput,
        passwordIcon,
        eyeIcon,
        loginButton,
        withoutAccountLabel,
        withoutAccountImage,
        checkBox
    }

    animateElementsAlpha(elements, 1)

    return elements
end


