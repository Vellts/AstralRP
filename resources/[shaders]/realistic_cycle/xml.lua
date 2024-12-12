--[[
    Carga el archivo XML con la configuración de los shaders.
]]
---@return integer|nil, integer|nil, integer|nil
function LoadXml()
    local xml = xmlLoadFile("time_cycle.xml")
    if (not xml) then
        xml = xmlCreateFile("time_cycle.xml", "timecycle")
    end
    local timeChild = xmlFindChild(xml, "hour", 0)
    local minuteChild = xmlFindChild(xml, "minute", 0)
    local event_cycleChild = xmlFindChild(xml, "event_cycle", 0)

    local time = timeChild and xmlNodeGetValue(timeChild) or 6
    local minute = minuteChild and xmlNodeGetValue(minuteChild) or 0
    local event_cycle = event_cycleChild and xmlNodeGetValue(event_cycleChild) or 0

    xmlUnloadFile(xml)

    return tonumber(time), tonumber(minute), tonumber(event_cycle)
end


--[[
    Guarda el archivo XML con la configuración de los shaders.
]]
---@param time integer
---@param minute integer
---@param event_cycle integer
---@return nil
function SaveXml(time, minute, event_cycle)
    if (not time) or (not minute) or (not event_cycle) then return end
    local xml = xmlLoadFile("time_cycle.xml")
    if (not xml) then
        xml = xmlCreateFile("time_cycle.xml", "timecycle")
    end
    local timeNode = xmlFindChild(xml, "hour", 0)
    if (timeNode) then
        xmlNodeSetValue(timeNode, time)
    else
        timeNode = xmlCreateChild(xml, "hour")
        xmlNodeSetValue(timeNode, time)
    end

    local minuteNode = xmlFindChild(xml, "minute", 0)
    if (minuteNode) then
        xmlNodeSetValue(minuteNode, minute)
    else
        minuteNode = xmlCreateChild(xml, "minute")
        xmlNodeSetValue(minuteNode, minute)
    end

    local eventNode = xmlFindChild(xml, "event_cycle", 0)
    if (eventNode) then
        xmlNodeSetValue(eventNode, event_cycle)
    else
        eventNode = xmlCreateChild(xml, "event_cycle")
        xmlNodeSetValue(eventNode, event_cycle)
    end

    xmlSaveFile(xml)
    xmlUnloadFile(xml)
end
