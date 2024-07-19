local dgs = exports.dgs
data = {
    shaders = {},
    lastIndex = 0,
    character_selected = false,
    create_account_selected = false,
    last_selected = "",
    font = dgs:dgsCreateFont("assets/Poppins-Bold.ttf", 32),
    cache_username = nil,
    cache_characters = nil
}

function viewPlayer()
    setCameraMatrix(1724.0239257812,-1648.9959716797,24.11315536499, 1730.2072753906,-1641.2884521484,23.743183135986)
end

function changeViewPoint()
    -- setTimer(function()
    --     -- setElementFrozen(localPlayer, false)
    --     -- setCameraTarget(localPlayer)
    --     -- showCursor(false)
    --     if (isElement(data.parent)) then
    --         destroyElement(data.parent)
    --     end
    -- end, 20000, 1)
    if (data.character_selected) then
        -- iprint("aqui 1")
        if (data.create_account_selected) then
            setElementPosition(localPlayer, 1721.5897216797,-1653.8099365234,20.96875)
            smoothMoveCamera(1727.9051513672,-1664.939453125,23.404634475708, 1727.0144042969,-1670.5103759766,22.615093231201, 1717.4248046875,-1646.7498779297,21.874059677124, 1721.5897216797,-1653.8099365234,20.96875, 10000)
            data.create_account_selected = false
        elseif (data.last_selected == "character") then
            local randomAnim = math.random(1, #animations)
            setPedAnimation(localPlayer, animations[randomAnim].block, animations[randomAnim].anim, -1, false)
            -- updateButtonStates()
            return
        else
            setElementPosition(localPlayer, 1721.5897216797,-1653.8099365234,20.96875)
            setElementRotation(localPlayer, -0, -0, 40)
            smoothMoveCamera(1724.0239257812,-1648.9959716797,24.11315536499, 1730.2072753906,-1641.2884521484,23.743183135986, 1717.4248046875,-1646.7498779297,21.874059677124, 1721.5897216797,-1653.8099365234,20.96875, 10000)
        end
        local randomAnim = math.random(1, #animations)
        setPedAnimation(localPlayer, animations[randomAnim].block, animations[randomAnim].anim, -1, false)
        data.last_selected = "character"
    else
        if (data.last_selected == "create") then
            return
        elseif (data.last_selected == "character") then
            setElementRotation(localPlayer, -0, -0, 10)
            setElementPosition(localPlayer, 1727.5435791016,-1669.5061035156,22.615093231201)
            smoothMoveCamera(1717.4248046875,-1646.7498779297,21.874059677124, 1721.5897216797,-1653.8099365234,20.96875, 1727.9051513672,-1664.939453125,23.404634475708, 1727.0144042969,-1670.5103759766,22.615093231201, 10000)
            data.character_selected = false
        else
            setElementRotation(localPlayer, -0, -0, 10)
            setElementPosition(localPlayer, 1727.5435791016,-1669.5061035156,22.615093231201)
            smoothMoveCamera(1724.0239257812,-1648.9959716797,24.11315536499, 1730.2072753906,-1641.2884521484,23.743183135986, 1727.9051513672,-1664.939453125,23.404634475708, 1727.0144042969,-1670.5103759766,22.615093231201, 10000)
        end
        data.last_selected = "create"
    end
end

function main(username, args)
    data.cache_username = data.cache_username or username
    data.cache_characters = data.cache_characters or args

    viewPlayer()
    showCursor(true)
    local screenX, screenY = dgs:dgsGetScreenSize()

    --- blur
    local blur = dgs:dgsCreateBlurBox(screenX, screenY)
    dgs:dgsBlurBoxSetIntensity(blur, 1)
    dgs:dgsBlurBoxSetLevel(blur, 5)
    data.blur = dgs:dgsCreateImage(0, 0, screenX, screenY, blur, false)
    data.parent = dgs:dgsCreateImage(0, 0, screenX, screenY, _, false, _, tocolor(25, 23, 25, 160))
    dgs:dgsAttachToAutoDestroy(blur, data.blur)

    -- label
    local text = math.random(1, table.size(messages))
    local name = messages[text]

    data.label = dgs:dgsCreateLabel(0.03, 0.2, 0.4, 0.04, name(username), true, data.parent)
    dgs:dgsSetProperties(data.label, {
        font = data.font,
        colorCoded = true,
        alpha = 0.6,
        alignment = { "left", "center" }
    })

    local coins = args.coins
    data.coinIcon = dgs:dgsCreateImage(0.03, 0.25, 0.02, 0.03, "assets/coin.png", true, data.parent)
    data.coinLabel = dgs:dgsCreateLabel(0.055, 0.256, 0.05, 0.02, coins.." gc", true, data.parent)
    dgs:dgsSetProperties(data.coinLabel, {
        font = data.font,
        alpha = 0.6,
        alignment = { "left", "center" },
        textSize = { 0.6, 0.6 },
        textColor = tocolor(255, 240, 240, 255)
    })

    -- characters

    data.accLabel = dgs:dgsCreateLabel(0.03, 0.3, 0.4, 0.04, "Tus personajes:", true, data.parent)
    dgs:dgsSetProperties(data.accLabel, {
        font = data.font,
        colorCoded = true,
        alpha = 0.6,
        alignment = { "left", "center" },
        textSize = { 0.7, 0.7 },
        textColor = tocolor(255, 240, 240, 255)
    })

    table.insert(data.shaders, dgs:dgsCreateRoundRect(6, false, tocolor(20, 20, 20, 200)))
    table.insert(data.shaders, dgs:dgsCreateRoundRect(6, false, tocolor(20, 20, 20, 200)))
    table.insert(data.shaders, dgs:dgsCreateRoundRect(6, false, tocolor(20, 20, 20, 200)))
    local lastElement
    if (#args.accounts > 0) then
        local character = args.accounts
        for i = 1, 3 do
            local yImage = i * 0.35

            if (lastElement) then
                local x, y = dgs:dgsGetPosition(lastElement, true)
                local w, h = dgs:dgsGetSize(lastElement, true)
                yImage = y + h + 0.035
            end

            local img = dgs:dgsCreateImage(0.03, yImage, 0.12, 0.06, data.shaders[i], true, data.parent)
            if (character[i]) then
                local icon = dgs:dgsCreateImage(0.03, 0.3, 0.2, 0.4, "assets/user.png", true, img)
                local username = dgs:dgsCreateLabel(0.25, 0.32, 0.5, 0.2, character[i].character_name, true, img)
                dgs:dgsSetProperties(username, {
                    font = data.font,
                    colorCoded = true,
                    alpha = 0.6,
                    alignment = { "left", "center" },
                    textSize = { 0.4, 0.4 },
                    textColor = tocolor(255, 240, 240, 255)
                })
                local pos = fromJSON(character[i].positions)
                local zone = getZoneName(pos[1], pos[2], pos[3])
                local city = getZoneName(pos[1], pos[2], pos[3], true)
                local position = dgs:dgsCreateLabel(0.25, 0.5, 0.5, 0.2, zone..", "..city, true, img)
                dgs:dgsSetProperties(position, {
                    font = data.font,
                    colorCoded = true,
                    alpha = 0.4,
                    alignment = { "left", "center" },
                    textSize = { 0.3, 0.3 },
                    textColor = tocolor(255, 240, 240, 255)
                })
                addEventHandler("onDgsMouseClickDown", img, function()
                    if (source ~= img) then return end
                    if (isElement(data.blur)) then
                        destroyElement(data.blur)
                    end
                    if (data.lastIndex ~= 0) then
                        -- iprint("aquisito")
                        dgs:dgsRoundRectSetColor(data.shaders[data.lastIndex], tocolor(20, 20, 20, 200))
                    end
                    dgs:dgsSetProperty(data.parent, "color", tocolor(25, 23, 25, 120))
                    dgs:dgsRoundRectSetColor(data.shaders[i], tocolor(223, 183, 255, 80))
                    characterInfo(character[i])
                    triggerServerEvent("system::getCharacterSkin", localPlayer, character[i].character_id)
                    data.character_selected = true
                    changeViewPoint()
                    data.lastIndex = i
                end)
            else
                local icon = dgs:dgsCreateImage(0.05, 0.3, 0.15, 0.4, "assets/user_create.png", true, img)
                local username = dgs:dgsCreateLabel(0.25, 0.32, 0.5, 0.2, "Crear personaje", true, img)
                dgs:dgsSetProperties(username, {
                    font = data.font,
                    colorCoded = true,
                    alpha = 0.6,
                    alignment = { "left", "center" },
                    textSize = { 0.4, 0.4 },
                    textColor = tocolor(255, 240, 240, 255)
                })
                local position = dgs:dgsCreateLabel(0.25, 0.5, 0.5, 0.2, "Crea tu personaje", true, img)
                dgs:dgsSetProperties(position, {
                    font = data.font,
                    colorCoded = true,
                    alpha = 0.4,
                    alignment = { "left", "center" },
                    textSize = { 0.3, 0.3 },
                    textColor = tocolor(255, 240, 240, 255)
                })
                addEventHandler("onDgsMouseClickDown", img, function()
                    if (source ~= img) then return end
                    if (isElement(data.blur)) then
                        destroyElement(data.blur)
                    end
                    if (data.lastIndex ~= 0) then
                        dgs:dgsRoundRectSetColor(data.shaders[data.lastIndex], tocolor(20, 20, 20, 200))
                    end
                    dgs:dgsSetProperty(data.parent, "color", tocolor(25, 23, 25, 120))
                    dgs:dgsRoundRectSetColor(data.shaders[i], tocolor(223, 183, 255, 80))
                    data.create_account_selected = true
                    data.character_selected = false
                    changeViewPoint()
                    switchWindow("create")
                    data.lastIndex = i
                end)
            end

            -------------- events --------------


            addEventHandler("onDgsMouseEnter", img, function()
                if (source ~= img) then return end
                dgs:dgsRoundRectSetColor(data.shaders[i], tocolor(223, 183, 255, 80)) 
            end)

            addEventHandler("onDgsMouseLeave", img, function()
                if (source ~= img) then return end
                if (data.lastIndex == i) then return end
                dgs:dgsRoundRectSetColor(data.shaders[i], tocolor(20, 20, 20, 200))
            end)
            lastElement = img
        end
    end
end
addEvent("system::characterSelect", true)
addEventHandler("system::characterSelect", root, main)

function switchWindow(typeWindow)
    if (typeWindow == "create") then
        dgs:dgsAlphaTo(data.parent, 0, "OutQuad", 1000)
        setTimer(function()
            dgs:dgsSetVisible(data.parent, false)
            setElementModel(localPlayer, 14)
            exports.playerManager:setPlayerClothe(localPlayer, 14, {
                ["perna"] = { 1, 1}
            })
            createCharacterStepOne()
        end, 1000, 1)
    elseif (typeWindow == "selection") then
        dgs:dgsAlphaTo(data.parent_2, 0, "OutQuad", 1000)
        setTimer(function()
            dgs:dgsSetVisible(data.parent, false)
            main()
        end, 1000, 1)
        -- triggerServerEvent("system::getCharacters", localPlayer)
    elseif (typeWindow == "all") then
        if (isElement(data.parent)) then
            dgs:dgsAlphaTo(data.parent, 0, "OutQuad", 1000)
            setTimer(function()
                destroyElement(data.parent)
            end, 1000, 1)
        end
        if (isElement(data.parent_2)) then
            dgs:dgsAlphaTo(data.parent_2, 0, "OutQuad", 1000)
            setTimer(function()
                destroyElement(data.parent_2)
            end, 1000, 1)
        end
        showCursor(true)
        -- setTimer(function()
        --     main()
        -- end, 1000, 1)
        iprint("aquisito")
        stopMoveCamera()
    else
        if (isElement(data.parent)) then
            dgs:dgsAlphaTo(data.parent, 0, "OutQuad", 1000)
            setTimer(function()
                destroyElement(data.parent)
            end, 1000, 1)
        end
        if (isElement(data.parent_2)) then
            dgs:dgsAlphaTo(data.parent_2, 0, "OutQuad", 1000)
            setTimer(function()
                destroyElement(data.parent_2)
            end, 1000, 1)
        end
        showCursor(false)
        data.character_selected = false
        data.create_account_selected = false
        stopMoveCamera()
    end
end
addEvent("system::switchWindow", true)
addEventHandler("system::switchWindow", root, switchWindow)

function updateButtonStates()
    -- if (isElement(cache.play)) then
    --     dgs:dgsSetEnabled(cache.play, true)
    -- end
    -- if (isElement(cache_creation.stepOne.continue)) then
    --     dgs:dgsSetEnabled(cache_creation.stepOne.continue, true)
    -- end
    -- if (isElement(cache_creation.stepOne.exit)) then
    --     dgs:dgsSetEnabled(cache_creation.stepOne.exit, true)
    -- end
end