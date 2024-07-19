local timer = nil

addEvent("pedanim", true)
addEventHandler("pedanim", root, function()
    -- setPedWalkingStyle (source ,137)
    -- setPedAnimation(source, "ped", "phone_in", -1, false, false, false, false)
    iprint(source)
    local player = source
    setPedAnimation ( player, "ped","phone_in", 500, false, false, false, true)
    -- setPedAnimationSpeed ( player, "phone_in", 1)
    timer = setTimer(function()
        setPedAnimationProgress ( player, "phone_in", 0.8)
    end, 500, 0)
end)

addEvent("stoppedanim", true)
addEventHandler("stoppedanim", root, function()
    setPedWalkingStyle (source, 0)
    setPedAnimation(source, "ped", "phone_out", -1, false, false, false, false)
    killTimer(timer)
end)
