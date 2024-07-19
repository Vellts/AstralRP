---@diagnostic disable: undefined-global, lowercase-global
normalizeMonths = {
    [1] = "Enero",
    [2] = "Febrero",
    [3] = "Marzo",
    [4] = "Abril",
    [5] = "Mayo",
    [6] = "Junio",
    [7] = "Julio",
    [8] = "Agosto",
    [9] = "Septiembre",
    [10] = "Octubre",
    [11] = "Noviembre",
    [0] = "Diciembre",
}

normalizeWeeks = {
    [1] = "Lunes",
    [2] = "Martes",
    [3] = "Miércoles",
    [4] = "Jueves",
    [5] = "Viernes",
    [6] = "Sábado",
    [0] = "Domingo",
}

function getHours()
    local time = getRealTime()
    local hours = time.hour
    local minutes = time.minute

    local stringHours = string.format("%02d:%02d", hours, minutes)

    return stringHours
end

-- check if table has values
function table.hasValues(t)
    for _, _ in pairs(t) do
        -- iprint(_, _)
        return true
    end
    return false
end

function table.hasValue(t, v)
    for _, _v in pairs(t) do
        -- iprint(_v == v)
        if _v == v then
            return true
        end
    end
    return false
end

screensAvailable = {
    ["lock"] = "lockScreen",
    ["home"] = "homeScreen",
    ["app"] = "appScreen"
}

function getNameApp(table)
    local nameApp = nil
    for i, v in pairs(table) do
        if (type(i) == "string") then
            nameApp = i
            break
        end
    end
    return nameApp
end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

function string.splitText(str, sep, plain)
    local magic = "([%%%.%(%)%+%*%?%[%]%^%$])"
    if plain then sep = string.gsub(sep, magic, "%%%1") end
    
    local N = '\255'
    str = N..str..N
    str = string.gsub(str, sep, N..N)

    local result = {}
    for word in string.gmatch(str, N.."(.-)"..N) do
        if word ~= "" then
            table.insert(result, word)
        end
    end
    return result
end

function GetNearContacts(name)
    -- obtener los contactos de FakeContactsData que coincidan un 50% con el nombre
    local contacts = {}
    for i = 1, #FakeContactsData do
        local contact = FakeContactsData[i]
        local contactName = contact["name"]
        local contactNumber = contact["number"]
        local contactImage = contact["image"]
        local contactId = contact["id"]

        local nameLength = string.len(name)
        local contactNameLength = string.len(contactName)

        -- local nameSub = string.sub(name, 1, nameLength / 2)
        -- local contactNameSub = string.sub(contactName, 1, contactNameLength / 2)
        local nameSub = string.splitText(name, " ", "")
        local contactNameSub = string.splitText(contactName, " ", "")

        if (nameSub[1] == contactNameSub[1]) then
            table.insert(contacts, {
                ["name"] = contactName,
                ["number"] = contactNumber,
                ["image"] = contactImage,
                ["id"] = contactId
            })
        end
    end

    return contacts
end

function DgsGetChildByElementType(parent, childType)
    local children = dgsGetChildren(parent)
    local childs = {}
    for i = 1, #children do
        local childElement = children[i]
        if (getElementType(childElement) == childType) then
            table.insert(childs, childElement)
        end
    end
    return childs
end

function addManyEventHandler(event, elements, func)

    if (type(elements) ~= "table") then
        elements = {elements}
    end

    for i = 1, #elements do
        local element = elements[i]
        if (not isEventHandlerAdded(event, element, func)) then
            addEventHandler(event, element, func)
        else
            outputDebugString("event "..event.." already added to "..tostring(element))
        end
    end
end

function DgsCreateBlurRectangle(w, h, color)
    local blur = dgsCreateBlurBox(w, h)
    dgsSetProperty(blur, "updateScreenSource", true)
    local rectangleShader = dgsCreateRoundRect(10, false, color)
    dgsBlurBoxSetFilter(blur, rectangleShader)
    dgsBlurBoxSetIntensity(blur, 30)
    dgsBlurBoxSetLevel(blur, 30)
    -- dgsAttachToAutoDestroy(blur, parent)
    dgsAttachToAutoDestroy(rectangleShader, blur)

    return blur
end
