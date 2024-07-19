---@diagnostic disable: undefined-global
local screenX, screenY = dgsGetScreenSize()
local text = ""

function DrawContactsScreen()
    
    -- cuadrado de busqueda
    if not (CallData["contactSearchStatus"]) then
        
        local roundRect = dgsCreateRoundRect(10, false, tocolor(124, 124, 124, 255))
        CallData["searchRectangle"] = dgsCreateImage(screenX * 0.032, screenY * 0.08, screenX * 0.14, screenY * 0.035, roundRect,
            false, data["appScreen"]["callApp"]["skeleton"])
    
        -- editlbael de busqueda
    
        CallData["searchLabel"] = dgsCreateEdit(0.04, 0, 1, 1, "", true, CallData["searchRectangle"])
    
        local textSize = 0.6 * (screenX / 1920) * 1.5
    
        dgsSetProperties(CallData["searchLabel"], {
            ["textColor"] = tocolor(40, 40, 40, 255),
            ["caretColor"] = tocolor(40, 40, 40, 255),
            ["font"] = data["globalFonts"]["SemiBold"],
            ["textSize"] = { textSize, textSize },
            ["alignment"] = { "left", "center" },
            ["padding"] = { 0, 0, 0, 0.1 },
            ["placeHolder"] = "Buscar",
            ["placeHolderColor"] = tocolor(40, 40, 40, 255),
            ["placeHolderFont"] = data["globalFonts"]["SemiBold"],
            ["placeHolderTextSize"] = { textSize, textSize },
            ["bgColor"] = tocolor(0, 0, 0, 0)
        })
    
        addEventHandler("onDgsEditAccepted", CallData["searchLabel"], function()
    
            if (source ~= CallData["searchLabel"]) then return end
    
            text = dgsGetText(source)
            CallData["contactSearchStatus"] = true
    
            DrawContactsScreen()
        end)
    
        -- create a scrollpane
    
        CallData["scrollpane"] = dgsCreateScrollPane(screenX * 0.032, screenY * 0.12, screenX * 0.14, screenY * 0.45, false,
            data["appScreen"]["callApp"]["skeleton"])
        
        dgsSetProperties(CallData["scrollpane"], {
            ["scrollBarThick"] = 0,
            ["padding"] = { 0, 0, 0},
            ["changeOrder"] = false,
        })
    end

    -- delete all childrens
    if (getUserdataType(CallData["scrollpane"]) ~= 'userdata') then
        local childrens = dgsGetChildren(CallData["scrollpane"])
        
        if (table.hasValues(childrens)) then
            for i = 1, #childrens do
                if (isElement) then
                    destroyElement(childrens[i])
                end
            end
        end
        -- iprint(childrens)
    end
    
    -- label contactos

    local labelContact = dgsCreateLabel(0, 0, 1, 0.05, "Contactos", true, CallData["scrollpane"])
    dgsSetProperties(labelContact, {
        ["textColor"] = tocolor(20, 20, 20, 255),
        ["font"] = data["globalFonts"]["Bold"],
        ["textSize"] = { 0.6 * (screenX / 1920) * 1.3, 0.6 * (screenX / 1920) * 1.3 },
        ["alignment"] = { "left", "center" },
    })

    -- Popup()
    
    -- add data
    if (CallData["contactSearchStatus"] and (string.len(text) ~= 0)) then
        
        local contacts = GetNearContacts(text)

        -- draw new contacts

        for i = 1, #contacts do
            local name = contacts[i]["name"]

            -- label

            local label = dgsCreateLabel(0, (i * 0.12), 1, 0.05, name, true, CallData["scrollpane"])
            local textSize = 0.6 * (screenX / 1920) * 1.5

            dgsSetProperties(label, {
                ["textColor"] = tocolor(20, 20, 20, 255),
                ["font"] = data["globalFonts"]["SemiBold"],
                ["textSize"] = { textSize, textSize },
                ["alignment"] = { "left", "center" },
                ["changeOrder"] = false,
            })

            -- add break line

            -- breakline

            dgsCreateImage(-0.08, (i * 0.12) + 0.08, 1, 0.005, round, true, CallData["scrollpane"])

            -- events to change label color

            addEventHandler("onDgsMouseEnter", label, function()

                if (source ~= label) then return end

                dgsSetProperties(label, {
                    ["textColor"] = tocolor(0, 121, 254, 255),
                })
            end)

            addEventHandler("onDgsMouseLeave", label, function()

                if (source ~= label) then return end

                dgsSetProperties(label, {
                    ["textColor"] = tocolor(20, 20, 20, 255),
                })
            end)

            ClickEvent(label, contacts[i])
        end

        return
    else
        local round = dgsCreateRoundRect(5, false, tocolor(124, 124, 124, 255))
        
        for i = 1, #FakeContactsData do
            local name = FakeContactsData[i]["name"]
            local number = FakeContactsData[i]["number"]
    
            -- label
    
            local label = dgsCreateLabel(0, (i * 0.12), 1, 0.05, name, true, CallData["scrollpane"])
            local textSize = 0.6 * (screenX / 1920) * 1.5
    
            dgsSetProperties(label, {
                ["textColor"] = tocolor(20, 20, 20, 255),
                ["font"] = data["globalFonts"]["SemiBold"],
                ["textSize"] = { textSize, textSize },
                ["alignment"] = { "left", "center" },
                ["changeOrder"] = false,
            })
    
            -- breakline
    
            if (i ~= #FakeContactsData) then
                dgsCreateImage(0, (i * 0.12) + 0.08, 1, 0.005, round, true, CallData["scrollpane"])
            end
            -- events to change label color
    
            addEventHandler("onDgsMouseEnter", label, function()
    
                if (source ~= label) then return end
    
                dgsSetProperties(label, {
                    ["textColor"] = tocolor(0, 121, 254, 255),
                })
            end)
    
            addEventHandler("onDgsMouseLeave", label, function()
    
                if (source ~= label) then return end
    
                dgsSetProperties(label, {
                    ["textColor"] = tocolor(20, 20, 20, 255),
                })
            end)

            ClickEvent(label, FakeContactsData[i])
        end
    end
end

local function PopupOptions(parent)
    local textPopup = dgsCreateLabel(0, 0.08, 1, 0.05, "Agregar a favoritos", true, parent)

    local textSize = 0.6 * (screenX / 1920) * 1

    dgsSetProperties(textPopup, {
        ["font"] = data["globalFonts"]["SemiBold"],
        ["textSize"] = { textSize, textSize },
        ["alignment"] = { "center", "center" },
        ["textColor"] = tocolor(60, 60, 60, 255),
        ["changeOrder"] = false,
    })

    DgsAnimateTextColor(textPopup, tocolor(60, 60, 60, 255), tocolor(0, 121, 254, 255))

    -- message

    local round = dgsCreateRoundRect(5, false, tocolor(124, 124, 124, 0))
    local round2 = dgsCreateRoundRect(5, false, tocolor(0, 121, 254, 100))
    local messageOption = dgsCreateImage(0, 0.3, 1, 0.2, round, true, parent)
    dgsAttachToAutoDestroy(round, messageOption)

    -- icon
    dgsCreateImage(0.08, 0.2, 0.10, 0.6, "assets/callapp/message_contact_icon.png", true, messageOption)

    -- text

    local msgText = dgsCreateLabel(0.3, 0.3, 0.8, 0.5, "Enviar mensaje", true, messageOption)

    dgsSetProperties(msgText, {
        ["font"] = data["globalFonts"]["SemiBold"],
        ["textSize"] = { textSize + 0.1, textSize + 0.1 },
        ["alignment"] = { "left", "center" },
        ["textColor"] = tocolor(60, 60, 60, 255),
        ["changeOrder"] = false,
    })
    DgsAnimateChildAndParentColor(messageOption, round, round2)

    -- call

    local callOption = dgsCreateImage(0, 0.5, 1, 0.2, round, true, parent)
    dgsAttachToAutoDestroy(round, callOption)

    -- icon
    dgsCreateImage(0.08, 0.2, 0.10, 0.6, "assets/callapp/call_contact_icon.png", true, callOption)

    -- text
    local callText = dgsCreateLabel(0.3, 0.3, 0.8, 0.5, "Llamar", true, callOption)

    dgsSetProperties(callText, {
        ["font"] = data["globalFonts"]["SemiBold"],
        ["textSize"] = { textSize + 0.1, textSize + 0.1 },
        ["alignment"] = { "left", "center" },
        ["textColor"] = tocolor(60, 60, 60, 255),
        ["changeOrder"] = false,
    })

    DgsAnimateChildAndParentColor(callOption, round, round2)

    -- remove

    local removeOption = dgsCreateImage(0, 0.7, 1, 0.2, round, true, parent)

    -- icon
    dgsCreateImage(0.08, 0.2, 0.10, 0.6, "assets/callapp/remove_contact_icon.png", true, removeOption)

    -- text

    local removeText = dgsCreateLabel(0.3, 0.3, 0.8, 0.5, "Eliminar", true, removeOption)

    dgsSetProperties(removeText, {
        ["font"] = data["globalFonts"]["SemiBold"],
        ["textSize"] = { textSize + 0.1, textSize + 0.1 },
        ["alignment"] = { "left", "center" },
        ["textColor"] = tocolor(60, 60, 60, 255),
        ["changeOrder"] = false,
    })

    DgsAnimateChildAndParentColor(removeOption, round, round2)
end

function Popup()
    if (CallData["onPopUp"]) then return end

    CallData["onPopUp"] = true

    -- local blur = dgsCreateBlurBox(screenX * 0.14, screenY * 0.25)
    -- dgsSetProperty(blur, "updateScreenSource", true)
    -- dgsBlurBoxSetFilter(blur, rectangleShader)
    -- dgsBlurBoxSetIntensity(blur, 2)
    -- dgsBlurBoxSetLevel(blur, 10)

    -- options
    local blur = DgsCreateBlurRectangle(screenX * 0.14, screenY * 0.18, tocolor(200, 200, 200, 255))
    
    CallData["contactPopup"] = dgsCreateImage(screenX * 0.032, screenY * 0.34, screenX * 0.14, screenY * 0.18, blur,
    false, data["appScreen"]["callApp"]["skeleton"])
    dgsBringToFront(CallData["contactPopup"])
    dgsFocus(CallData["contactPopup"])
    dgsSetProperty(CallData["contactPopup"], "changeOrder", false)
    dgsAttachToAutoDestroy(blur, CallData["contactPopup"])
    
    PopupOptions(CallData["contactPopup"])

    -- close menu
    
    local blur2 = DgsCreateBlurRectangle(screenX * 0.14, screenY * 0.04, tocolor(200, 200, 200, 255))
    CallData["ContactCloseMenu"] = dgsCreateImage(screenX * 0.032, screenY * 0.528, screenX * 0.14, screenY * 0.04, blur2,
    false, data["appScreen"]["callApp"]["skeleton"])
    dgsSetProperty(CallData["ContactCloseMenu"], "changeOrder", false)
    dgsBringToFront(CallData["ContactCloseMenu"])
    dgsFocus(CallData["ContactCloseMenu"])
    dgsAttachToAutoDestroy(blur2, CallData["ContactCloseMenu"])
    
    local closeText = dgsCreateLabel(0, 0, 1, 1, "Cerrar", true, CallData["ContactCloseMenu"])
    local textSize = 0.6 * (screenY / 1080) * 1.5
    
    dgsSetProperties(closeText, {
        ["font"] = data["globalFonts"]["SemiBold"],
        ["textSize"] = { textSize, textSize},
        ["alignment"] = { "center", "center" },
        ["textColor"] = tocolor(60, 60, 60, 255),
        ["changeOrder"] = false,
    })

    DgsAnimateChildAndParentColor(CallData["ContactCloseMenu"], tocolor(60, 60, 60, 255), tocolor(0, 121, 254, 100), true)

    addManyEventHandler("onDgsMouseClickDown", { CallData["ContactCloseMenu"] }, function ()
        if (isElement(CallData["ContactCloseMenu"])) then destroyElement(CallData["ContactCloseMenu"]) end
        if (isElement(CallData["contactPopup"])) then destroyElement(CallData["contactPopup"]) end

        CallData["onPopUp"] = false
    end)

    -- setTimer(function()
    --     destroyElement(CallData["contactPopup"])
    --     CallData["onPopUp"] = false
    -- end, 5000, 1)
end

function ClickEvent(element, data)
    -- iprint(element, data)
    -- if (CallData["onPopUp"]) then return end
    if (element) then
        addEventHandler("onDgsMouseClickDown", element, function()
            if (source ~= element) then return end

            -- create a popup
            Popup()
        end)
    end
end


local components = { "weapon", "ammo", "health", "clock", "money", "breath", "armour", "wanted" }

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function ()
	for _, component in ipairs( components ) do
		setPlayerHudComponentVisible( component, false )
	end
end)

