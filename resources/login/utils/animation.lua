function animateBorderColor(engine, element, shader, color, durationToZero, durationToOne)
    -- local dgs = engine
    -- -- iprint(dgs:dgsIsAniming(element))
    -- -- if (dgs:dgsIsAniming(element)) then return end
    -- dgs:dgsAlphaTo(element, 0, "OutQuad", durationToZero)
    -- setTimer(function()
    --     dgs:dgsRoundRectSetColor(shader, color)
    -- end, durationToOne, 1)
    -- dgs:dgsAlphaTo(element, 1, "OutQuad", durationToOne)
end

function animateElementsAlpha(dgsElements, to)
    local dgs = exports.dgs
    for _, v in ipairs(dgsElements) do
        dgs:dgsAlphaTo(v, to, "OutQuad", data.animationTime)
    end
end