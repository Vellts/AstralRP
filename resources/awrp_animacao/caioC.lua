local screenW, screenH = guiGetScreenSize ( )
local scale = math.min (math.max (0.75, (screenH / 768)), 2)
local parentW, parentH = 238 * scale, 252 * scale;
local parentX, parentY = 19, (screenH - parentH) / 2;

local animation = {initial = -300, initial2 = 0, finish2 = 0; finish = 0; time = 650; tick = 0; current = -300; current2 = 0; easing = 'Linear'}

function setScreenPosition (x, y, w, h)
    return parentX + (x * scale) + animation.current, parentY + (y * scale), w * scale, h * scale
end

_dxDrawRectangle = dxDrawRectangle
function dxDrawRectangle (x, y, w, h, ...)
    local x, y, w, h = setScreenPosition(x, y, w, h)
    return _dxDrawRectangle(x, y, w, h, ...)
end

_dxDrawImage = dxDrawImage
function dxDrawImage (x, y, w, h, ...)
    local x, y, w, h = setScreenPosition(x, y, w, h)
    return _dxDrawImage(x, y, w, h, ...)
end

_dxDrawText = dxDrawText
function dxDrawText (text, x, y, w, h, ...)
    local x, y, w, h = setScreenPosition(x, y, w, h)
    return _dxDrawText(text, x, y, (x + w), (y + h), ...)
end

_svgCreate = svgCreate
function svgCreate (w, h, ...)
    return _svgCreate(w * 2, h * 2, ...)
end

local font = {}
function getFont (name, size)
    if not font[name] then
        font[name] = {}
    end
    if not font[name][size] then
        font[name][size] = dxCreateFont('assets/fonts/'..name..'.ttf', size)
    end
    return font[name][size]
end

function isMouseInPosition (x, y, w, h)
    if isCursorShowing() and (x and y and w and h) then
        local x, y, w, h = setScreenPosition (x, y, w, h)
        local sx, sy = guiGetScreenSize()
        local cx, cy = getCursorPosition()
        local cx, cy = (cx * sx), (cy * sy)
        return ((cx >= x and cx <= x + w) and (cy >= y and cy <= y + h))
    end
end

svg = {
	
	['background'] = svgCreate(238, 252, 
		[[
			<svg width="238" height="252" viewBox="0 0 238 252" fill="none" xmlns="http://www.w3.org/2000/svg">
			<path d="M0.5 5C0.5 2.51472 2.51472 0.5 5 0.5H233C235.485 0.5 237.5 2.51472 237.5 5V247C237.5 249.485 235.485 251.5 233 251.5H5.00001C2.51472 251.5 0.5 249.485 0.5 247V5Z" fill="#151517" stroke="url(#paint0_linear_6350_374)"/>
			<rect x="6" y="74" width="223" height="2" rx="1" fill="#1E1F23"/>
			<path d="M196 40C196 38.3431 197.343 37 199 37H226C227.657 37 229 38.3431 229 40V67C229 68.6569 227.657 70 226 70H199C197.343 70 196 68.6569 196 67V40Z" fill="#1E1F23"/>
			<path d="M158 40C158 38.3431 159.343 37 161 37H188C189.657 37 191 38.3431 191 40V67C191 68.6569 189.657 70 188 70H161C159.343 70 158 68.6569 158 67V40Z" fill="#1E1F23"/>
			<path d="M120 40C120 38.3431 121.343 37 123 37H150C151.657 37 153 38.3431 153 40V67C153 68.6569 151.657 70 150 70H123C121.343 70 120 68.6569 120 67V40Z" fill="#1E1F23"/>
			<path d="M82 40C82 38.3431 83.3431 37 85 37H112C113.657 37 115 38.3431 115 40V67C115 68.6569 113.657 70 112 70H85C83.3431 70 82 68.6569 82 67V40Z" fill="#1E1F23"/>
			<path d="M44 40C44 38.3431 45.3431 37 47 37H74C75.6569 37 77 38.3431 77 40V67C77 68.6569 75.6569 70 74 70H47C45.3431 70 44 68.6569 44 67V40Z" fill="#1E1F23"/>
			<path d="M6 40C6 38.3431 7.34315 37 9 37H36C37.6569 37 39 38.3431 39 40V67C39 68.6569 37.6569 70 36 70H9C7.34314 70 6 68.6569 6 67V40Z" fill="#1E1F23"/>
			<defs>
			<linearGradient id="paint0_linear_6350_374" x1="119" y1="252" x2="119" y2="2.45248e-06" gradientUnits="userSpaceOnUse">
			<stop stop-color="#923232"/>
			<stop offset="0.604167" stop-opacity="0"/>
			</linearGradient>
			</defs>
			</svg>
			
		]]
	),

}

proxPag = 0
select = ANIMATIONS[1].Name
cores = {22, 23, 22, 23, 22, 23, 22}

function painel ()
	animation.current = interpolateBetween (animation.initial, 0, 0, animation.finish, 0, 0, (getTickCount() - animation.tick) / animation.time, animation.easing)
    animation.current2 = interpolateBetween (animation.initial2, 0, 0, animation.finish2, 0, 0, (getTickCount() - animation.tick) / animation.time, animation.easing)
	local alpha = animation.current2
	dxDrawImage(0, 0, 238, 252, svg['background'], 0, 0, 0, tocolor(255, 255, 255, alpha))
	dxDrawText('PAINEL #923232ANIMAÇÕES', 46, 14, 140, 13, tocolor(255, 255, 255, alpha * 0.8), 1, getFont('medium', 11), 'center', 'center', false, false, false, true)
	for i, v in ipairs(ANIMATIONS) do
		local px = 13 + ((18 + 20) * (i - 1))
		dxDrawImage(px, 44, 20, 20, 'assets/images/'..i..'.png', 0, 0, 0, (isMouseInPosition(px-7, 37, 33, 33) or (select == v.Name)) and tocolor(146, 50, 50, alpha) or tocolor(255, 255, 255, alpha))
	end
	for i, v in ipairs(ANIMATIONS) do
		if select == v.Name then
			if v.WalkStyles then
				tab = v.WalkStyles
			else
				tab = v.Animations
			end
			linha = 0
			for k, anin in ipairs(tab) do
				if (k > proxPag and linha < 5) then
					linha = linha + 1
					local py = 80+(34*(linha-1))
					if isMouseInPosition(6, py, 223, 30) then
						dxDrawRectangle(6, py, 223, 30, tocolor(146, 50, 50, alpha), false)
						dxDrawText(anin.Name, 6+12, py, 47, 30, tocolor(23, 23, 23, alpha), 1, getFont('regular', 11), 'left', 'center')
						dxDrawImage(198, py+7, 15, 15, 'assets/images/convite.png', 0, 0, 0, tocolor(23, 23, 23, alpha))
					else
						dxDrawText(anin.Name, 6+12, py, 47, 30, tocolor(196, 196, 196, alpha), 1, getFont('regular', 11), 'left', 'center')
						dxDrawImage(198, py+7, 15, 15, 'assets/images/convite.png', 0, 0, 0, tocolor(255, 255, 255, alpha))
					end
				end
			end
		end
	end
end

function getTable ()
	tabless = false
	for i, v in ipairs(ANIMATIONS) do
		if (select == v.Name) then
			if v.WalkStyles then
				tabless = v.WalkStyles
			else
				tabless = v.Animations
			end
		end
	end
	return tabless
end

addEventHandler('onClientClick', root, function (button, state)
	if button ==  'left' and state == 'down' and visible then
		for i, v in ipairs(ANIMATIONS) do
			local px = 13 + ((18 + 20) * (i - 1))
			if isMouseInPosition(px-7, 37, 33, 33) then
				select = v.Name
				proxPag = 0
			end
		end
		for i, v in ipairs(ANIMATIONS) do
			if select == v.Name then
				linha = 0
				for k, anin in ipairs(getTable()) do
					if (k > proxPag and linha < 5) then
						linha = linha + 1
						local py = 80+(34*(linha-1))
						if isMouseInPosition(198, py+7, 15, 15) then
							triggerServerEvent('Caio.ConviteCommand', localPlayer, anin.Command)
						elseif isMouseInPosition(6, py, 223, 30) then
							triggerServerEvent('Caio.onExecuteCommand', localPlayer, anin.Command)
						end
					end
				end
			end
		end
	end
end)

addEventHandler('onClientKey', root, function (button, press)
	if visible then
		if button == 'space' and press then
			triggerServerEvent('Caio.onPararAnimation', localPlayer)
		elseif isMouseInPosition(0, 0, 210, 324) then
			if button == 'mouse_wheel_up' and press then
				if select then
					if (proxPag > 0) then
						proxPag = proxPag - 1
					end
				end
			elseif button == 'mouse_wheel_down' and press then
				if select then
					local tabless = getTable()
					proxPag = proxPag + 1
					if (proxPag > #tabless - 5) then
						proxPag = #tabless - 5
					end
				end
			end
		end
	end
end)

onRenderManager = function ()
    if visible then
        method = 'close'
    else
        method = 'open'
    end
    if (method == 'open' and not visible) then
        visible = true
        animation.initial = animation.current
        animation.initial2 = animation.current2
        animation.finish = 0
        animation.finish2 = 255
        animation.tick = getTickCount()
        showCursor (visible)
        addEventHandler('onClientRender', root, painel)
    elseif (method == 'close' and visible) then
        if not closing then
            closing = true
            animation.initial = animation.current
            animation.initial2 = animation.current2
            animation.finish = -300
            animation.finish2 = 0
            animation.tick = getTickCount()
            showCursor (false)
            setTimer (function ()
                removeEventHandler('onClientRender', root, painel)
                visible = false
                closing = false
            end, animation.time + 50, 1)
        end
    end
end
bindKey('F2', 'down', onRenderManager)


ossos = {}
addEvent('Caio.onPararAnimationsClient', true)
addEventHandler('Caio.onPararAnimationsClient', root, function(player)
	if ossos then
		for i, v in pairs(ossos) do 
			if isElement(v[5]) then
				if v[5] == player then
					table.remove(ossos, i)
					updateElementRpHAnim(player)
				end
			else
				table.remove(ossos, i)
			end
		end
	end
end)

addEventHandler('onClientPedsProcessed', root, function()
	if ossos then
		for i, v in pairs(ossos) do
			if isElement(v[5]) then
				setElementBoneRotation(v[5], v[1], v[2], v[3], v[4])		
				updateElementRpHAnim(v[5])
			else
				table.remove(ossos, i)
			end
		end
	end
end)

addEvent('Caio.onSetBonePosition', true)
addEventHandler('Caio.onSetBonePosition', root, function (player, position)
	for i, v in pairs(position) do
		setElementBoneRotation(player, i, v[1], v[2], v[3])
		table.insert(ossos, {i, v[1], v[2], v[3], player})
	end
end)

ifp = {}

setTimer(function()
	for i, v in ipairs(IFPS) do
		ifp[i] = engineLoadIFP('ifp/'..v..'.ifp', v)
	end
end, 1000, 1)

addEvent('Caio.onSetAnimation', true)
addEventHandler('Caio.onSetAnimation', root, function (player, animation)
	setPedAnimation(player, unpack(animation))
end)

txd = engineLoadTXD("objetos/camera.txd", 367 )
engineImportTXD(txd, 367)
dff = engineLoadDFF("objetos/camera.dff", 367 )
engineReplaceModel(dff, 367)

txd = engineLoadTXD("objetos/umbrella.txd", 14864 )
engineImportTXD(txd, 14864)
dff = engineLoadDFF("objetos/umbrella.dff", 14864 )
engineReplaceModel(dff, 14864)

txd = engineLoadTXD("objetos/maleta.txd", 1934)
engineImportTXD(txd, 1934)
dff = engineLoadDFF("objetos/maleta.dff", 1934)
engineReplaceModel(dff, 1934)

txd = engineLoadTXD("objetos/prancheta.txd", 1933)
engineImportTXD(txd, 1933)
dff = engineLoadDFF("objetos/prancheta.dff", 1933)
engineReplaceModel(dff, 1933)