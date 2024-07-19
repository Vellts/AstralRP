local dgs = exports.dgs
local state = false
local animationTime = 500
local isRendered = false
local updateElements = {}

function loadUpdates(parent)

    --- arrow

    local arrow = dgs:dgsCreateImage(0.89, 0.5, 0.02, 0.03, "assets/arrow.png", true, parent)
    animateArrow(arrow)

    --- label

    local label = dgs:dgsCreateLabel(0.92, 0.51, 0.06, 0.02, "NOVEDADES", true, parent)
    dgs:dgsSetProperties(label, {
        textColor = tocolor(141, 141, 141, 178),
        font = data.fonts.Poppins[12],
        alignment = {
            "left",
            "center"
        },
        changeOrder = false,
    })
    addEventHandler("onDgsMouseEnter", label, function()
        if (source ~= label) then return end
        dgs:dgsSetProperty(label, "textColor", tocolor(81, 73, 105, 160))
    end)
    addEventHandler("onDgsMouseLeave", label, function()
        if (source ~= label) then return end
        dgs:dgsSetProperty(label, "textColor", tocolor(141, 141, 141, 178))
    end)

    local elements = {
        arrow,
        label
    }

    addEventHandler("onDgsMouseClickDown", root, function()
        if (source == label) then
            local updatesData = drawUpdates(parent, {arrow, label})
            -- for _, v in ipairs(updatesData) do
            --     table.insert(updateElements, v)
            -- end
        else
            if (not isRendered) then return end
            drawUpdates(parent, {arrow, label}, label)
        end
    end)
    



    return elements
end

function drawUpdates(parent, dataElms, elmClicked)
    -- local elms = {}

    if (not state) then
        if (not isRendered) then
            -- iprint("rendering")
            if (#dataElms > 0) then
                for _, v in ipairs(dataElms) do
                    dgs:dgsSetVisible(v, false)
                    dgs:dgsAlphaTo(v, 0, "OutQuad", animationTime)
                end
            end
            local shader = dgs:dgsCreateRoundRect(6, false, tocolor(38, 38, 38, 160))
            local scrollPane = dgs:dgsCreateScrollPane(0.8, 0.12, 0.18, 0.8, true, parent)
            dgs:dgsSetProperties(scrollPane, {
                alpha = 0,
                bgColor = tocolor(38, 38, 38, 160),
                bgImage = shader,
                scrollBarState = { false, false }
            })
                
            dgs:dgsAlphaTo(scrollPane, 1, "OutQuad", animationTime)
            dgs:dgsAttachToAutoDestroy(scrollPane, shader)

            table.insert(updateElements, scrollPane)

            -- novedades label
            local label = dgs:dgsCreateLabel(0.12, 0.05, 0.8, 0.05, "NOVEDADES", true, scrollPane)
            dgs:dgsSetProperties(label, {
                textColor = tocolor(141, 141, 141, 178),
                font = data.fonts.Poppins[50],
                alignment = {
                    "center",
                    "center"
                },
                changeOrder = false,
                textSize = { 0.6, 0.6 }
            })
            table.insert(updateElements, label)

            -- datos

            local lastUpdateContent
            for i, v in ipairs(updatesJson) do
                local shader2 = dgs:dgsCreateRoundRect(6, false, tocolor(108, 109, 148, 160))
                local yDate, yTitle, yContent = 0.12, 0.115, 0.2

                if (lastUpdateContent) then
                    local x, y = dgs:dgsGetPosition(lastUpdateContent, true)
                    local w, h = dgs:dgsGetSize(lastUpdateContent, true)
                    yDate = y + h + 0.05
                    yTitle = yDate
                    yContent = yDate + 0.08
                end

                local image2 = dgs:dgsCreateImage(0.05, yDate, 0.3, 0.05, shader2, true, scrollPane)

                local dateLabel = dgs:dgsCreateLabel(0.08, 0.05, 0.9, 0.9, v.date, true, image2)
                dgs:dgsSetProperties(dateLabel, {
                    textColor = tocolor(141, 141, 141, 208),
                    font = data.fonts.Poppins[12],
                    alignment = {
                        "left",
                        "center"
                    },
                    textSize = { 0.95, 0.95 },
                    changeOrder = false,
                })

                local titleLabel = dgs:dgsCreateLabel(0.4, yTitle, 0.2, 0.06, v.title, true, scrollPane)
                dgs:dgsSetProperties(titleLabel, {
                    textColor = tocolor(141, 141, 141, 208),
                    font = data.fonts.Poppins[12],
                    alignment = {
                        "left",
                        "center"
                    },
                    changeOrder = false,
                })

                local h = string.len(v.content) * 0.001
                local content = dgs:dgsCreateLabel(0.08, yContent, 0.9, h, v.content, true, scrollPane)
                dgs:dgsSetProperties(content, {
                    textColor = tocolor(141, 141, 141, 208),
                    font = data.fonts.Poppins[12],
                    alignment = {
                        "left",
                        "center"
                    },
                    changeOrder = false,
                    wordBreak = true,
                })
                -- iprint(dgs:dgsGetPosition(content, true))
                lastUpdateContent = content
            end

            isRendered = true
            state = true

            return true
        else
            if (dataElms[2] == elmClicked) then return end
            for _, v in ipairs(updateElements) do
                dgs:dgsSetVisible(v, true)
                dgs:dgsAlphaTo(v, 1, "OutQuad", animationTime)
            end
            for _, v in ipairs(dataElms) do
                dgs:dgsSetVisible(v, false)
                dgs:dgsAlphaTo(v, 0, "OutQuad", animationTime)
            end
            state = true
        end
    else
        for _, v in ipairs(dataElms) do
            dgs:dgsSetVisible(v, true)
            dgs:dgsAlphaTo(v, 1, "OutQuad", animationTime)
        end
        for _, v in ipairs(updateElements) do
            dgs:dgsSetVisible(v, false)
            dgs:dgsAlphaTo(v, 0, "OutQuad", animationTime)
        end
        state = false
    end

    return true
end

function animateArrow(arrow)
    dgs:dgsMoveTo(arrow, 0.87, 0.5, true, "OutQuad", animationTime)
    local elm = arrow
    setTimer(function()
        if (not isElement(elm)) then return end
        if (dgs:dgsIsMoving(elm)) then return end

        local position = dgs:dgsGetPosition(arrow, true)
        if (position == 0.87) then
            dgs:dgsMoveTo(arrow, 0.89, 0.5, true, "OutQuad", animationTime)
        else
            dgs:dgsMoveTo(arrow, 0.87, 0.5, true, "OutQuad", animationTime)
        end
    end, 100, 0)
end