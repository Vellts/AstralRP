function getScreenResolution(screenHeight)
    if screenHeight <= 600 then  
        return 0.50
    end
    return 0.70
end

panelConfig = {}
panelConfig.screenX, panelConfig.screenY = guiGetScreenSize()
panelConfig.screenScale = math.min(math.max(getScreenResolution(panelConfig.screenY), (panelConfig.screenY / 1080)), 2)

function getScreenStartPositionFromBox (width, height, offsetX, offsetY, startIndicationX, startIndicationY)
    local startX = offsetX 
    local startY = offsetY
    
    if startIndicationX == "right" then
        startX = panelConfig.screenX - (width + offsetX)
    elseif startIndicationX == "center" then
        startX = panelConfig.screenX / 2 - width / 2 + offsetX
    elseif startIndicationX == "left" then
        startX = panelConfig.screenX - panelConfig.screenX + offsetX
    end
    
    if startIndicationY == "bottom" then
        startY = panelConfig.screenY - (height + offsetY)
    elseif startIndicationY == "center" then
        startY = panelConfig.screenY / 2 - height / 2 + offsetY
    elseif startIndicationY == "top" then
        startY = panelConfig.screenY - panelConfig.screenY + offsetY
    end
    
    return startX, startY
end

function respc(data)
    return (data * panelConfig.screenScale)
end

_dxDrawText = dxDrawText
dxDrawText = function (label, absX, absY, width, height, color, scale, ...)
    return _dxDrawText(label, absX, absY, absX + width, absY + height, color, respc(scale), ...)
end

_tocolor = tocolor
function tocolor(r, g, b, a)
    return _tocolor(r, g, b, a and (a >= 255 and 255 or ((a*255)/100)) or 255)
end

function isMouseInPosition(x, y, w, h)
    if (not isCursorShowing()) then
        return false
    end
    local mx, my = getCursorPosition()
    local cursorx, cursory = mx*panelConfig.screenX, my*panelConfig.screenY
    if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
        return true
    else
        return false
    end
end

function createEditBox(x, y, w, h, color, fontType, typeBox)
    if (dxGetTextWidth((select == typeBox and guiGetText(edits[typeBox])..'|' or guiGetText(edits[typeBox])), respc(1.00), fontType) <= w - 10) then
        dxDrawText(select == typeBox and guiGetText(edits[typeBox])..'|' or guiGetText(edits[typeBox]), x + 5, y, w - 10, h, color, respc(1.00), fontType, "left", "center", true, false, false, false, false)
    else
        dxDrawText(select == typeBox and guiGetText(edits[typeBox])..'|' or guiGetText(edits[typeBox]), x + 5, y, w - 10, h, color, respc(1.00), fontType, "right", "center", true, false, false, false, false)
    end
end

function createEditBoxCenter(x, y, w, h, color, fontType, typeBox)
    if (dxGetTextWidth((select == typeBox and guiGetText(edits[typeBox])..'|' or guiGetText(edits[typeBox])), respc(1.00), fontType) <= w - 10) then
        dxDrawText(select == typeBox and guiGetText(edits[typeBox])..'|' or guiGetText(edits[typeBox]), x + 5, y, w - 10, h, color, respc(1.00), fontType, "center", "center", true, false, false, false, false)
    else
        dxDrawText(select == typeBox and guiGetText(edits[typeBox])..'|' or guiGetText(edits[typeBox]), x + 5, y, w - 10, h, color, respc(1.00), fontType, "right", "center", true, false, false, false, false)
    end
end