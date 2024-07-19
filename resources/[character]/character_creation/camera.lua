local sm = {moov = 0}

local function removeCamHandler()
    if (sm.moov == 1) then
        sm.moov = 0
        updateButtonStates()
    end
end

local start, animTime
local tempPos, tempPos2 = {{},{}}, {{},{}}

local function camRender()
    local now = getTickCount()
    if (sm.moov == 1) then
        local x1, y1, z1 = interpolateBetween(tempPos[1][1], tempPos[1][2], tempPos[1][3], tempPos2[1][1], tempPos2[1][2], tempPos2[1][3], (now-start) / animTime, "InOutQuad")
        local x2, y2, z2 = interpolateBetween(tempPos[2][1], tempPos[2][2], tempPos[2][3], tempPos2[2][1], tempPos2[2][2], tempPos2[2][3], (now-start) / animTime, "InOutQuad")
        setCameraMatrix(x1, y1, z1, x2, y2, z2)
    else
        removeEventHandler("onClientRender", root, camRender)
        fadeCamera(true)
    end
end

function smoothMoveCamera(x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time)
    if(sm.moov == 1) then
        killTimer(timer1)
        killTimer(timer2)
        removeEventHandler("onClientRender", root, camRender)
        fadeCamera(true)
    end
    fadeCamera(true)
    sm.moov = 1
    timer1 = setTimer(removeCamHandler, time, 1)
    timer2 = setTimer(fadeCamera, time - 1000, 1, false)
    start = getTickCount()
    animTime = time
    tempPos[1], tempPos[2] = {x1, y1, z1}, {x1t, y1t, z1t}
    tempPos2[1], tempPos2[2] = {x2, y2, z2}, {x2t, y2t, z2t}
    addEventHandler("onClientRender", root, camRender)
    return true
end

function stopMoveCamera()
    if(sm.moov == 1) then
        killTimer(timer1)
        killTimer(timer2)
        removeEventHandler("onClientRender", root, camRender)
        fadeCamera(true)
        sm.moov = 0
    end
end