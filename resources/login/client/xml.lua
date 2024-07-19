function loadXml()
    local xml = xmlLoadFile("username.xml")
    if (not xml) then
        xml = xmlCreateFile("username.xml", "login")
    end
    local username = xmlFindChild(xml, "username", 0)
    local checkStatus = xmlFindChild(xml, "checkStatus", 0)
    -- iprint(checkStatus)
    local name = username and xmlNodeGetValue(username) or ""
    local status = checkStatus and xmlNodeGetValue(checkStatus) or false
    xmlUnloadFile(xml)
    return status, name
end

function saveXml(username, checkStatus)
    local xml = xmlLoadFile("username.xml")
    if (not xml) then
        xml = xmlCreateFile("username.xml", "login")
    end
    if (username ~= "") then
        local usernameNode = xmlFindChild(xml, "username", 0)
        if (usernameNode) then
            xmlNodeSetValue(usernameNode, username)
        else
            usernameNode = xmlCreateChild(xml, "username")
            xmlNodeSetValue(usernameNode, username)
        end

        local check = xmlFindChild(xml, "checkStatus", 0)
        -- iprint(check)
        iprint(tostring(checkStatus))
        if (check) then
            xmlNodeSetValue(check, tostring(checkStatus))
        else
            checkStatus = xmlCreateChild(xml, "checkStatus")
            xmlNodeSetValue(check, tostring(checkStatus))
        end
    end
    xmlSaveFile(xml)
    xmlUnloadFile(xml)
end