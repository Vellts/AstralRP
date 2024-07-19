lastInteractionElement = nil

function table.size(tab)
    if not tab then return 0 end
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

function getYOfElement(table, element, engine)
    for i, v in ipairs(table) do
        if (v.notification == element) then
            local _, y engine:dgsGetPosition(v.notification, true)
            return y
        end
    end
    return false
end

function getNotificationIndex(table, element)
    for i, v in ipairs(table) do
        if (v.dgsDataElm == element) then
            return i
        end
    end
    return false
end

function getNearestElement(player, type, distance)
    local result = false
    local dist = nil
    if player and isElement(player) then
        local elements = getElementsWithinRange(Vector3(getElementPosition(player)), distance, type, getElementInterior(player), getElementDimension(player))
        for i = 1, #elements do
            local element = elements[i]
            if not dist then
                result = element
                dist = getDistanceBetweenPoints3D(Vector3(getElementPosition(player)), Vector3(getElementPosition(element)))
            else
                local newDist = getDistanceBetweenPoints3D(Vector3(getElementPosition(player)), Vector3(getElementPosition(element)))
                if newDist <= dist then
                    result = element
                    dist = newDist
                end
            end
        end
    end
    return result
end

function generateUUID()
    local random = math.random
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end