local screenW, screenH = guiGetScreenSize();
local screenScale = math.min(math.max(screenH / 768, 0.70), 2); -- Caso o painel seja muito grande, retirar o limite e deixar apenas o (screenH / 768).

parentW, parentH = ((171.92+20) * screenScale), (80.13 * screenScale); -- Comprimento e Largura do painel.
parentX, parentY = ((screenW - parentW)), ((screenH - parentH) / 2); -- Posição X e Y do painel.

local function respX (x)
    return (parentX + (x * screenScale));
end
    
local function respY (y)
    return (parentY + (y * screenScale));
end
    
local function respC (scale)
    return (scale * screenScale);
end

local _dxDrawText = dxDrawText;
local function dxDrawText(text, x, y, width, height, ...)
    return _dxDrawText(text, respX(x), respY(y+(animationY or 0)), (respX(x) + respC(width)), (respY(y+(animationY or 0)) + respC(height)), ...);
end

local _dxDrawRectangle = dxDrawRectangle;
local function dxDrawRectangle(x, y, width, height, ...)
    if y == 46 then
        return _dxDrawRectangle(respX(x), respY(y+(animationY or 0)), width, respC(height), ...);
    else
        return _dxDrawRectangle(respX(x), respY(y+(animationY or 0)), respC(width), respC(height), ...);
    end
end

local _dxDrawImage = dxDrawImage;
local function dxDrawImage(x, y, width, height, ...)
    return _dxDrawImage(respX(x), respY(y+(animationY or 0)), respC(width), respC(height), ...);
end

size = {}
local function dxDrawRounded (x, y, w, h, radius, ...)
    if not size[w..'.'..h..':'..radius] then
        local svg = string.format([[ <svg width='%s' height='%s' fill='none' xmlns='http://www.w3.org/2000/svg'> <mask id='path_inside' fill='#FFFFFF' > <rect width='%s' height='%s' rx='%s' /> </mask> <rect opacity='1' width='%s' height='%s' rx='%s' fill='#FFFFFF' stroke='%s' stroke-width='%s' mask='url(#path_inside)'/> </svg> ]], w, h, w, h, radius, w, h, radius, tostring(''), tostring(''))
        size[w..'.'..h..':'..radius] = svgCreate(w, h, svg)
    else
        dxDrawImage(x, y, w, h, size[w..'.'..h..':'..radius], 0, 0, 0, ...)
    end
end

local cursor = {}
local function isMouseInPosition (x, y, width, height)
    if (not cursor.state) then
        return false
    end
    if not (cursor.x and cursor.y) then
        return false;
    end
    x, y, width, height = respX(x), respY(y), respC(width), respC(height);
    return ((cursor.x >= x and cursor.x <= x + width) and (cursor.y >= y and cursor.y <= y + height));
end

local font = {}
local function getFont (name, size)
    if not font[name] then
        font[name] = {}
    end
    if not font[name][size] then
        font[name][size] = dxCreateFont('assets/fonts/'..name..'.ttf', respC(size/1.25))
    end
    return font[name][size]
end

local _svgCreate = svgCreate;
local function svgCreate (width, height, ...)
    return _svgCreate((width*2), (height*2), ...)
end

local vectors = {}
function createVector(w,h,raw)
    local svgElm = svgCreate(w,h,raw)
    local svgXML = svgGetDocumentXML(svgElm)
    local rect = xmlFindChild(svgXML,"rect",0)
    return {
        svg = svgElm;
        xml = svgXML;
        rect = rect;
    }
end

function createCircleStroke(id, width, height, size)
    if (not id) then return end
    if not vectors[id] then
        size = size or 2
        local radius = math.min(width,height)/2
        local radiusLength = (2*math.pi)*radius
        local nw,nh = width+(size*2),height+(size*2)
        local raw = string.format([[
            <svg width = "%s" height = "%s">
                <rect x = "%s" y = "%s" rx = "%s" width = "%s" height = "%s" fill = "#FFFFFF" fill-opacity = "0" stroke = "#FFFFFF" stroke-width = "%s" stroke-dasharray = "%s" stroke-dashoffset = "%s" stroke-linecap = "round" stroke-linejoin = "round" />
            </svg>
        ]], nw, nh, size, size, radius, width, height, size, radiusLength, 0)
        local svg = createVector(width, height, raw)
        local atributes = {
            type = "circle-stroke";
            svgDetails = svg;
            width = width;
            height = height;
            radiusLength = radiusLength;
        }
        vectors[id] = atributes
    end
    return vectors[id]
end

function setSVGOffset(id,value)
    if not vectors[id] then return end
    local svg = vectors[id]
    local rect = svg.svgDetails.rect
    local newValue = svg.radiusLength - (svg.radiusLength/100) * value
    xmlNodeSetAttribute(rect,"stroke-dashoffset",newValue)
    svgSetDocumentXML(svg.svgDetails.svg,svg.svgDetails.xml)
end

function drawItem(id,x,y,color,postGui)
    if not vectors[id] then return end
    local svg = vectors[id]
    color = color or 0xFFFFFF
    local width,height = svg.width,svg.height
    dxSetBlendMode("add")
    dxDrawImage(x,y,width,height,svg.svgDetails.svg,0,0,0,color)
    dxSetBlendMode("blend")
end

function destroyVector(id)
    if vectors[id] then 
        destroyElement(vectors[id]["svgDetails"]["svg"])
        vectors[id] = nil
    end
end

infobox = {}

function addBox (text, type)
    if text and type and config.types[type] then
        inserted = false
        for i,v in ipairs(infobox) do
            if v.mensagem == text and v.tipo == type then
                if not v.count then
                    v.count = 1
                end
                v.count = v.count + 1
                inserted = true
            end
        end
        if inserted == false then
            table.insert(infobox, {
                mensagem = text,
                tipo = type,
            })
            createCircleStroke('infobox: '..text..':'..type, 16, 16, 1.5)
            playSound(config.types[type].sound)
        end
    end
end
addEvent('addBox', true)
addEventHandler('addBox', root, addBox)

function render ()
    for index, v in ipairs(infobox) do
        if index <= 3 then
            if not v.tick then
                v.tick = getTickCount()
            end
            local animation = interpolateBetween(171.92+20, 0, 0, 0, 0, 0, ((getTickCount()-v.tick)/600), 'Linear')
            local percentage = interpolateBetween(100, 0, 0, 0, 0, 0, ((getTickCount()-v.tick)/5600), 'Linear')
            local py = 0 - ((5 + 80.13) * (index - 1))            
            if percentage <= 1 then
                if not v.tick2 then
                    v.tick2 = getTickCount()
                end
                animation, percentage = interpolateBetween(0, 100, 0, 171.92+20, 0, 0, ((getTickCount()-v.tick2)/600), 'Linear')
                if percentage <= 1 then
                    destroyVector('infobox: '..v.mensagem..':'..v.tipo)
                    table.remove(infobox, index)
                end
            end
            dxDrawImage(animation, py, 171.92, 80.13, 'assets/images/bar.png', 0, 0, 0, tocolor(255, 255, 255, 255))
            dxDrawImage(animation, py, 171.92, 80.13, 'assets/images/bar2.png', 0, 0, 0, tocolor(config.types[v.tipo].color[1], config.types[v.tipo].color[2], config.types[v.tipo].color[3], 255))
            dxDrawImage(animation+95.12, py+20.37, 65, 39, 'assets/images/logo.png', 0, 0, 0, tocolor(255, 255, 255, 255 * 0.05))
            dxDrawText(config.types[v.tipo].title, animation+9.05, py+10.56, 37, 14, tocolor(255, 255, 255, 255), 1, getFont('medium', 12), 'left', 'center')
            dxDrawText(v.mensagem, animation+9.05, py+24, 135, 48, tocolor(123, 123, 123, 255), 1, getFont('regular', 10), 'left', 'top', true, true)
            if v.count then
                dxDrawText(v.count..'x', animation+150, py+8, 9, 12, tocolor(123, 123, 123, 255), 1, getFont('regular', 12), 'left', 'center')
            end
            if not v.tick2 then
                drawItem('infobox: '..v.mensagem..':'..v.tipo, animation+147, py+33, tocolor(config.types[v.tipo].color[1], config.types[v.tipo].color[2], config.types[v.tipo].color[3], 255))
                setSVGOffset('infobox: '..v.mensagem..':'..v.tipo, (100/5600*(getTickCount()-v.tick)))
            end
        end
    end
end
addEventHandler('onClientRender', root, render)