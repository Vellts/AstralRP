local dgs = exports.dgs
local states = {}

function loadRegister(parent)
    local ingresoText = dgs:dgsCreateLabel(0.4, 0.3, 0.2, 0.05, "REGISTRO", true, parent)
    dgs:dgsSetProperties(ingresoText, {
        textColor = tocolor(141, 141, 141, 178),
        font = data.fonts.Poppins[50],
        alignment = {
            "left",
            "center"
        },
        changeOrder = false,
        alpha = 0,
    })

    local descText = dgs:dgsCreateLabel(0.4, 0.35, 0.2, 0.02, "VIVE UNA EXPERIENCIA INMERSIVA", true, parent)
    dgs:dgsSetProperties(descText, {
        textColor = tocolor(141, 141, 141, 178),
        font = data.fonts.Poppins[12],
        alignment = {
            "left",
            "center"
        },
        alpha = 0,
    })

    local shader = dgs:dgsCreateRoundRect(4, false, tocolor(38, 38, 38, 178))
    local usernameInput = dgs:dgsCreateEdit(0.4, 0.4, 0.2, 0.05, "", true, parent)
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

    -- email

    local emailInput = dgs:dgsCreateEdit(0.4, 0.47, 0.2, 0.05, "", true, parent)
    dgs:dgsSetProperties(emailInput, {
        font = data.fonts.Poppins[12],
        textColor = tocolor(121, 121, 121, 255),
        placeHolder = "Ingresa el email",
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
    local emailIcon = dgs:dgsCreateImage(0.04, 0.25, 0.1, 0.5, "assets/email.png", true, emailInput)

    -- password

    local passwordInput = dgs:dgsCreateEdit(0.4, 0.54, 0.2, 0.05, "", true, parent)
    dgs:dgsSetProperties(passwordInput, {
        font = data.fonts.Poppins[12],
        textColor = tocolor(121, 121, 121, 255),
        placeHolder = "Ingresa la contraseña",
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

    -- register button
    local shader_2 = dgs:dgsCreateRoundRect(4, false, tocolor(81, 73, 105, 160))
    local registerButton = dgs:dgsCreateButton(0.4, 0.61, 0.2, 0.05, "REGISTRARSE", true, parent)
    dgs:dgsSetProperties(registerButton, {
        font = data.fonts.Poppins[50],
        image = {shader_2, shader, shader},
        textSize = {
            0.6, 0.6
        },
        alignment = {
            "center", "center"
        },
        textColor = tocolor(121, 121, 121, 255),
        alpha = 0,
    })
    dgs:dgsAttachToAutoDestroy(registerButton, shader_2)
    addEventHandler("onDgsMouseClickDown", registerButton, function()
        if (source ~= registerButton) then return end

        local username = dgs:dgsGetText(usernameInput)
        local email = dgs:dgsGetText(emailInput)
        local password = dgs:dgsGetText(passwordInput)

        if (username == "" or email == "" or password == "") then
            iprint("Faltan campos")
            return
        end

        triggerServerEvent("player::registerRequest", localPlayer, username, password, email)
    end)

    -- with account
    local shader_3 = dgs:dgsCreateRoundRect(4, false, tocolor(81, 73, 105, 160), _, true, true, 0.1, 0.1)
    local withAccountImage = dgs:dgsCreateImage(0.4, 0.685, 0.2, 0.05, shader_3, true, parent)
    dgs:dgsSetProperties(withAccountImage, {
        changeOrder = false,
        alpha = 0,
    })
    local withAccountText = dgs:dgsCreateLabel(0.45, 0.7, 0.1, 0.02, "¿Ya tienes una cuenta?", true, parent)
    dgs:dgsSetProperties(withAccountText, {
        textColor = tocolor(141, 141, 141, 178),
        font = data.fonts.Poppins[12],
        alignment = {
            "center",
            "center"
        },
        changeOrder = false,
        alpha = 0,
    })
    dgs:dgsAttachToAutoDestroy(withAccountImage, shader_3)
    addEventHandler("onDgsMouseClickDown", withAccountText, function()
        if (source ~= withAccountText) then return end
        switchWindow()
    end)


    local elements = {
        ingresoText,
        descText,
        usernameInput,
        usernameIcon,
        emailInput,
        emailIcon,
        passwordInput,
        passwordIcon,
        eyeIcon,
        registerButton,
        withAccountText,
        withAccountImage,
    }

    animateElementsAlpha(elements, 1)
    
    return elements
end