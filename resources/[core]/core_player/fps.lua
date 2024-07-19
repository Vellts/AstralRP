local dgs = exports.dgs
local sW, sH = dgs:dgsGetScreenSize()
fps = 0
local nextTick = 0
function getCurrentFPS() -- Setup the useful function
    return fps
end

local function updateFPS(msSinceLastFrame)
    -- FPS are the frames per second, so count the frames rendered per milisecond using frame delta time and then convert that to frames per second.
    local now = getTickCount()
    if (now >= nextTick) then
        fps = (1 / msSinceLastFrame) * 1000
        nextTick = now + 1000
    end
end
addEventHandler("onClientPreRender", root, updateFPS)

function drawFps()
    local fps = math.floor(getCurrentFPS()) or 0
    -- local font = dgs:dgsCreateFont("assets/fonts/Poppins-SemiBold.ttf", 16)
    -- draw fps
    local x, y = (sW * 0.015), (sH * 0.025)
    local w, h = (sW * 0.06), (sH * 0.018)
    local draw_fps = dgs:dgsCreateLabel(x, y, w, h, fps.." fps", false)
    dgs:dgsSetProperties(draw_fps, {
        font = hud.fontSemiBold,
        textColor = tocolor(255, 255, 255, 255),
        alpha = 0.60,
    })
    setTimer(updateLabelFPS, 500, 0, draw_fps)
    return draw_fps
end