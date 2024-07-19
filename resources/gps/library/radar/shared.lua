
defaultTooltips = {
	["north.png"] = "Norte",
}

showInfobox = function(type, msg)
	--print(type, msg);
end



-- function dxMsg(element, typeinfo, msg) --|| Não renomear a função
--     exports.FR_DxMessages:addBox(element, typeinfo, msg)  
-- end



function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end