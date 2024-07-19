---[[
    --» sᴄʀɪᴘᴛ ғᴇɪᴛᴏ ᴘᴏʀ » Pedro Developer
---]]

local screenW, screenH = guiGetScreenSize();
local screenScale = math.min(math.max(screenH / 768, 0.70), 2); -- Caso o painel seja muito grande, retirar o limite e deixar apenas o (screenH / 768).

parentW, parentH = (556 * screenScale), (286 * screenScale); -- Comprimento e Largura do painel.
parentX, parentY = ((screenW - parentW) / 2), ((screenH - parentH) / 2); -- Posição X e Y do painel.

------------------------------------------------
function respX (x)
    return (parentX + (x * screenScale));
end
    
function respY (y)
    return (parentY + (y * screenScale));
end
    
function respC (scale)
    return (scale * screenScale);
end

local _dxDrawText = dxDrawText;
function dxDrawText(text, x, y, width, height, ...)
    return _dxDrawText(text, respX(x), respY(y+(animationY or 0)), (respX(x) + respC(width)), (respY(y+(animationY or 0)) + respC(height)), ...);
end

local _dxDrawRectangle = dxDrawRectangle;
function dxDrawRectangle(x, y, width, height, ...)
    return _dxDrawRectangle(respX(x), respY(y+(animationY or 0)), respC(width), respC(height), ...);
end

local _dxDrawImage = dxDrawImage;
function dxDrawImage(x, y, width, height, ...)
    return _dxDrawImage(respX(x), respY(y+(animationY or 0)), respC(width), respC(height), ...);
end

local cursor = {}
function isMouseInPosition (x, y, width, height)
    if (not cursor.state) then
        return false
    end
    if not (cursor.x and cursor.y) then
        return false;
    end
    x, y, width, height = respX(x), respY(y), respC(width), respC(height);
    return ((cursor.x >= x and cursor.x <= x + width) and (cursor.y >= y and cursor.y <= y + height));
end

size = {}
function drawBorder ( radius, x, y, width, height, color, colorStroke, sizeStroke, postGUI )

    colorStroke = tostring(colorStroke)
    sizeStroke = tostring(sizeStroke)
    if (not size[height..':'..width]) then
        local raw = string.format([[
            <svg width='%s' height='%s' fill='none' xmlns='http://www.w3.org/2000/svg'>
                <mask id='path_inside' fill='#FFFFFF' >
                    <rect width='%s' height='%s' rx='%s' />
                </mask>
                <rect opacity='1' width='%s' height='%s' rx='%s' fill='#FFFFFF' stroke='%s' stroke-width='%s' mask='url(#path_inside)'/>
            </svg>
        ]], width, height, width, height, radius, width, height, radius, colorStroke, sizeStroke)
        size[height..':'..width] = svgCreate(width, height, raw)
    end

    if (size[height..':'..width]) then
        dxDrawImage(x, y, width, height, size[height..':'..width], 0, 0, 0, color, postGUI)
    end

end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

function formatNumber(number, sep)
	assert(type(tonumber(number))=="number", "Bad argument @'formatNumber' [Expected number at argument 1 got "..type(number).."]")
	assert(not sep or type(sep)=="string", "Bad argument @'formatNumber' [Expected string at argument 2 got "..type(sep).."]")
	local money = number
	for i = 1, tostring(money):len()/3 do
		money = string.gsub(money, "^(-?%d+)(%d%d%d)", "%1"..sep.."%2")
	end
	return money
end
------------------------------------------------       

local effects = {}
local fonts = {

    dxCreateFont('assets/fonts/sbold.ttf', respC(12/1.25));
    dxCreateFont('assets/fonts/regular.ttf', respC(10/1.25));
    dxCreateFont('assets/fonts/sbold.ttf', respC(10/1.25));

}

local rewardsPositions = {

    {18, 63, 100, 100};
    {123, 63, 100, 100};
    {228, 63, 100, 100};
    {333, 63, 100, 100};
    {438, 63, 100, 100};

    {18, 173, 100, 100};
    {123, 173, 100, 100};
    {228, 173, 100, 100};
    {333, 173, 100, 100};
    {438, 173, 100, 100};

}

function drawDayRewards()

    local alpha = interpolateBetween(interpolate[1], 0, 0, interpolate[2], 0, 0, ((getTickCount() - tick) / 500), 'Linear')

    cursor.state = isCursorShowing ();
    if (cursor.state) then
        local cursorX, cursorY = getCursorPosition ();
        cursor.x, cursor.y = cursorX * screenW, cursorY * screenH;
    end

    
    drawBorder(10, 0, 0, 556, 286, tocolor(31, 31, 31, alpha))
    dxDrawImage(18, 13, 20, 20, 'assets/images/title.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
    dxDrawText('Recompensas diárias', 43, 15, 109, 15, tocolor(255, 255, 255, alpha * 0.85), 1, fonts[1])
    dxDrawText('Entre todo dia na cidade para receber recompensas gratuitas.', 18, 40, 256, 13, tocolor(255, 255, 255, alpha * 0.6), 1, fonts[2])

    dxDrawImage(524, 16, 14, 14, 'assets/images/exit.png', 0, 0, 0, tocolor(255, 255, 255, alpha * 0.2))

    if (isMouseInPosition(524, 16, 14, 14)) then 

        if not (exitTick) then exitTick = getTickCount() end 
        local animation = interpolateBetween(0, 0, 0, 255, 0, 0, ((getTickCount() - exitTick) / 500), 'Linear')
        dxDrawImage(524, 16, 14, 14, 'assets/images/exit.png', 0, 0, 0, tocolor(14, 158, 247, animation))

    else

        exitTick = nil 

    end

    local line = 0 
    for i, v in ipairs(config.rewards) do 

        if (i > pages[1] and line < 10) then 

            line = line + 1

            local startX, startY = rewardsPositions[line][1], rewardsPositions[line][2]
            
            drawBorder(10, startX, startY, 100, 100, tocolor(26, 26, 26, alpha))

            if (isMouseInPosition(startX + 10, startY + 71, 80, 20)) then 

                dxDrawText('R$'..formatNumber(v[1], '.')..',00', startX + 7, startY + 6, 53, 13, tocolor(14, 158, 247, alpha), 1, fonts[3])
                dxDrawImage(startX + 27, startY + 23, 45, 45, 'assets/images/'..v[2]..'.png', 0, 0, 0, tocolor(14, 158, 247, alpha))
                drawBorder(5, startX + 10, startY + 71, 80, 20, tocolor(19, 19, 19, alpha))
                dxDrawText( rewards >= i and 'COLETADO' or (((rewards + 1) == i and timestamp < getRealTime().timestamp) and 'COLETAR' or 'AGUARDE'), startX + 10, startY + 71, 80, 20, tocolor(14, 158, 247, alpha), 1, fonts[2], 'center', 'center')

            else 

                dxDrawText('R$'..formatNumber(v[1], '.')..',00', startX + 7, startY + 6, 53, 13, tocolor(255, 255, 255, alpha * 0.6), 1, fonts[3])
                dxDrawImage(startX + 27, startY + 23, 45, 45, 'assets/images/'..v[2]..'.png', 0, 0, 0, tocolor(255, 255, 255, alpha * 0.6))
                drawBorder(5, startX + 10, startY + 71, 80, 20, tocolor(19, 19, 19, alpha))
                dxDrawText( rewards >= i and 'COLETADO' or (((rewards + 1) == i and timestamp < getRealTime().timestamp) and 'COLETAR' or 'AGUARDE'), startX + 10, startY + 71, 80, 20, tocolor(255, 255, 255, alpha * 0.6), 1, fonts[2], 'center', 'center')

            end
            

        end

    end

    if (pages[3] > 0) then 

		drawBorder(1, 543, 63, 3, 210, tocolor(255, 255, 255, alpha * 0.1))
		drawBorder(1, 543, 63 + ((210 - 45) * (pages[2] / pages[3])), 3, 45, tocolor(255, 255, 255, alpha * 0.6))

		if (moving) then 
            
            local start, finish = parentY + (63 * screenScale), parentY + (272 * screenScale)
            local cx, cy = getCursorPosition()
            local mx, my = (cx * screenW), (cy * screenH)
            
            if (my < start) then 
            
                pages[1], pages[2] = 0, 0 
            
            elseif (my > finish) then 
            
                pages[1], pages[2] = pages[3], pages[3] 
            
            else 

                local progress = my - start
                local height = screenScale * 210
                local percentage  = (progress / height) * 100
                local new_page = (pages[3] / 100) * percentage 
                pages[1], pages[2] = math.floor(new_page), new_page 

            end

            if not (getKeyState('mouse1')) then 

                moving = nil 

            end 

        end

	end
    
end

addEventHandler('onClientKey', root, 
    function(key, press)

        if (isEventHandlerAdded('onClientRender', root, drawDayRewards) and press) then 
			
			if (key == 'mouse_wheel_down') then 

				if (pages[1] < pages[3]) then 

					pages[1] = (pages[1] + 1)
					pages[2] = pages[1]

				end 

			elseif (key == 'mouse_wheel_up') then 

			    if (pages[1] > 0) then 
					
					pages[1] = pages[1] - 1 
					pages[2] = pages[1]

				end

			end

        end

    end
)

addEventHandler('onClientClick', root, 
    
    function(b, s)
        
        if (b == 'left' and s == 'down') then 
        
            if (isEventHandlerAdded('onClientRender', root, drawDayRewards)) then 
                
                if (isMouseInPosition(524, 16, 14, 14)) then 

                    removeDayRewards()

                elseif (isMouseInPosition(543, 63, 3, 210)) then 

                    moving = true 

                else 

                    local line = 0 
                    for i, v in ipairs(config.rewards) do 
                
                        if (i > pages[1] and line < 10) then 
                
                            line = line + 1
                
                            local startX, startY = rewardsPositions[line][1], rewardsPositions[line][2]
                            
                            drawBorder(10, startX, startY, 100, 100, tocolor(26, 26, 26, alpha))
                
                            if (isMouseInPosition(startX + 10, startY + 71, 80, 20)) then 
                             
                                if ((rewards + 1) == i and timestamp < getRealTime().timestamp) then 

                                    triggerServerEvent('onPlayerColectDayGiftFromPanel', localPlayer, localPlayer)

                                end
                
                            end
                            
                
                        end
                
                    end

                end

            end
            
        end
        
    end


)

addEvent('onClientDrawDayRewards', true)
addEventHandler('onClientDrawDayRewards', root, 
    
    function(rewards_, timestamp_)

        if not (isEventHandlerAdded('onClientRender', root, drawDayRewards)) then 
        
            tick, interpolate, data, pages, rewards, timestamp = getTickCount(), {0, 255}, data_, {0, 0, #config.rewards - 10}, rewards_, timestamp_
            addEventHandler('onClientRender', root, drawDayRewards)
            showCursor(true)
            showChat(false)

        end
        
    end 
    
)

function removeDayRewards()

    if (isEventHandlerAdded('onClientRender', root, drawDayRewards)) then 
       
        if (interpolate[1] == 0) then 
        
            tick, interpolate = getTickCount(), {255, 0}
            showCursor(false)
            setTimer(function()

                removeEventHandler('onClientRender', root, drawDayRewards)
                showChat(true)

            end, 500, 1)
            
        end
        
    end

end
bindKey('backspace', 'down', removeDayRewards)

addEvent('onClientReceiveDayRewardsInfos', true)
addEventHandler('onClientReceiveDayRewardsInfos', root, 

    function(rewards_, timestamp_)

        rewards, timestamp = rewards_, timestamp_

    end

)