local resolutionConfig = {1366, 760}
local screen = Vector2 (guiGetScreenSize ())
local screenScale = math.min(math.max(0.80, screen.y / resolutionConfig[2]), 2)

function setScreenPosition (resolution, x, y, w, h)
    return (
        screen.x/resolution[1]*x),
        (screen.y/resolution[2]*y),
        (screen.x/resolution[1]*w),
        (screen.y/resolution[2]*h
    )
end

local textures = {
    image = {},
    font = {}
}

_dxDrawImage = dxDrawImage
_dxDrawRectangle = dxDrawRectangle
_dxDrawImageSection = dxDrawImageSection
_dxDrawText = dxDrawText
_dxCreateFont = dxCreateFont

function dxDrawImage (x, y, w, h, path, ...)
    local x, y, w, h = setScreenPosition(resolutionConfig, x, y, w, h)

    if type(path) == 'string' then
        if not textures.image[path] then
            textures.image[path] = dxCreateTexture(
                path,
                'dxt5',
                true,
                'clamp'
            )
        end
        path = textures.image[path]
    end

    return _dxDrawImage(x, y, w, h, path, ...)
end

function dxDrawImageSection(x, y, w, h, ...)
    local x, y, w, h = setScreenPosition(resolutionConfig, x, y, w, h)
    return _dxDrawImageSection (x, y, w, h, ...)
end

function dxDrawRectangle (x, y, w, h, ...)
    local x, y, w, h = setScreenPosition(resolutionConfig, x, y, w, h)

    return _dxDrawRectangle(x, y, w, h, ...)
end

function dxCreateFont (path, size, ...)

    if not textures.font[path] then
        textures.font[path] = {}
    end

    if not textures.font[path][size] then
        textures.font[path][size] = _dxCreateFont(
            path,
            (size * screenScale),
            ...
        )
    end

    return textures.font[path][size]
end

function dxDrawText (text, x, y, w, h, ...)
    local x, y, w, h = setScreenPosition(resolutionConfig, x, y, w, h)
    
    return _dxDrawText(tostring(text), x, y, (x + w), (y + h), ...)
end

function isCursorOnElement (x, y, w, h)
    local x, y, w, h = screen.x/resolutionConfig[1]*x, screen.y/resolutionConfig[2]*y, screen.x/resolutionConfig[1]*w, screen.y/resolutionConfig[2]*h  

    local mouse = Vector2(getCursorPosition())
    local cx, cy = (mouse.x * screen.x), (mouse.y * screen.y) 

    return (cx > x and cx < x + w and cy > y and cy < y + h)
end

local client = {
    visible = false;
    visible_test_drive = false;
    visible_my_vehicles = false;
    visible_offer = false;
    radius = {0, 255};
    radius_ = {0, 255};
    tick = nil;
    tick_ = nil;
    pag = 0;
    pag_ = 0;
    max = 4;
    select = 1;
    garagem = {};
    pag_categorys = 0;
    pag_colors = 0;
    category = nil;

    edits = {
        {false, guiCreateEdit(9999, 9999, 0, 0, "", false)};
        {false, guiCreateEdit(9999, 9999, 0, 0, "", false)};
    };

    fonts = { 
        [1] = dxCreateFont ("assets/fonts/Akrobat-SemiBold.ttf", 11);
        [2] = dxCreateFont ("assets/fonts/Akrobat-Regular.ttf", 10);
        [3] = dxCreateFont ("assets/fonts/Akrobat-Light.ttf", 10);
        [4] = dxCreateFont ("assets/fonts/Akrobat-Bold.ttf", 12);
        [5] = dxCreateFont ("assets/fonts/Akrobat-SemiBold.ttf", 12);
        [6] = dxCreateFont ("assets/fonts/Akrobat-Regular.ttf", 11);
        [7] = dxCreateFont ("assets/fonts/Akrobat-Regular.ttf", 13);
        [8] = dxCreateFont ("assets/fonts/Akrobat-Regular.ttf", 12);
        [9] = dxCreateFont ("assets/fonts/Akrobat-Bold.ttf", 17);
        [10] = dxCreateFont ("assets/fonts/Akrobat-Regular.ttf", 17);
        [11] = dxCreateFont ("assets/fonts/Akrobat-Regular.ttf", 15);
        [12] = dxCreateFont ("assets/fonts/Akrobat-Bold.ttf", 15);
        [13] = dxCreateFont ("assets/fonts/Akrobat-Bold.ttf", 14);
    };
}

local categoryVehicles = {}

local function onClientRenderDealership()
    local alpha = interpolateBetween(client["radius"][1], 0, 0, client["radius"][2], 0, 0, (getTickCount() - client["tick"])/300, "Linear")

    if window == "dealership" then 
        dxDrawImage(1190, 36, 138.49, 83, "assets/gfx/logo.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
        dxDrawImage(31, 20, 142, 27, "assets/gfx/bg_infos.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
        dxDrawImage(180, 20, 142, 27, "assets/gfx/bg_infos.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)

        dxDrawText("Dinheiro:", 37, 26, 43, 16, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][1], "left", "top", false, false, true, false, false)
        dxDrawText("aPoints:", 186, 26, 39, 16, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][1], "left", "top", false, false, true, false, false)
        dxDrawText(convertNumber(getPlayerMoney(localPlayer)), 120, 24, 43, 16, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][5], "right", "top", false, false, true, false, false)
        dxDrawText(convertNumber((getElementData(localPlayer, "aPoints") or 0)), 272, 24, 39, 16, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][5], "right", "top", false, false, true, false, false)

        dxDrawText("CATEGORIAS DISPONÍVEIS", 31, 190, 135, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][5], "left", "top", false, false, true, false, false)
        dxDrawRectangle(28, 214, 207, 1, tocolor(144, 144, 144, alpha), true)

		line = 0 
		for i, category in ipairs(config["categorys"]) do 
			if i > client["pag_categorys"] and line < 4 then 
				if category then 
					line = line + 1
					local count = (222 + (278 - 222) * line - (278 - 222))

                    dxDrawImage(31, count, 47, 45, "assets/gfx/bg_category.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
                    dxDrawImage(category.size[1], count + category.count, category.size[2], category.size[3], category.icon, 0, 0, 0, tocolor(255, 255, 255, alpha), true)
                    dxDrawText(category.tittle, 95, count+5, 44, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][5], "left", "top", false, false, true, false, false)
                    dxDrawText(category.desc, 95, count+26, 44, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)
				
                    if isCursorOnElement(25, (218 + (273 - 218) * line - (273 - 218)), 213, 54) or selectCategory == i then 
                        dxDrawImage(25, (217 + (273 - 217) * line - (273 - 217)), 213, 54, "assets/gfx/bg_gridlist-category.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
                    end
                end
			end
        end

        dxDrawImage(31, 447, 207, 4, "assets/gfx/bar.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
        dxDrawText("Cores disponíveis", 31, 462, 90, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)

        local c, r = 0, 0
        for i = 1, 10 do 
            local colors = config["colors"][(i + client["pag_colors"])]
            if i > client["pag_colors"] and c < 10 then 
                c = c + 1

                local countX = (33 + (73 - 33) * c - (73 - 33))
                local countY = (491 + (528 - 491) * r)

                if colors then
                    dxDrawImage(countX, countY, 29, 29, "assets/gfx/eclipse.png", 0, 0, 0, tocolor(colors[1], colors[2], colors[3], alpha), true)

                    if isCursorOnElement(countX, countY, 29, 29) or colorSelect == i then 
                        dxDrawImage(countX, countY, 31, 31, "assets/gfx/eclipse_select.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
                    end
                    
                    if (c >= 5) then 
                        c = 0
                        r = r + 1
                    end
                end
            end
        end

        if selectCategory then 
            dxDrawText("VEÍCULOS DISPONÍVEIS", 262, 589, 145, 21, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][7], "left", "top", false, false, true, false, false)
            dxDrawText("Nossos veículos dividido por categorias.", 262, 612, 173, 14, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)

            local categoryVehicles = config["veiculos"][client["category"]]
            line = 0
            if categoryVehicles then 
                for i, v in ipairs(categoryVehicles) do 
                    if i > client["pag"] and line < client["max"] then
                        line = line + 1

                        local count = (262 + (473 - 262) * line - (473 - 262))
                        if v then 
                            if isCursorOnElement(count, 650, 207, 85) or selectVehicle == i then
                                dxDrawImage(count, 641, 207, 85, "assets/gfx/bg_gridlist-select.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
                                dxDrawText(v[1], count+12, 653, 141, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][4], "left", "top", true, false, true, false, false)
                                dxDrawText("x"..(estoques[v[2]] or "Erro").."", count+161, 653, 32, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][7], "right", "top", false, false, true, false, false)
                                dxDrawText("R$ "..convertNumber(v[3]).."", count+12, 683, 63, 17, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][8], "left", "top", false, false, true, false, false)
                                dxDrawText("ap$ "..convertNumber(v[4]).."", count+124, 683, 69, 17, tocolor(240, 168, 84, alpha), 1.0, client["fonts"][8], "right", "top", false, false, true, false, false)
                            else
                                dxDrawImage(count, 648, 207, 85, "assets/gfx/bg_gridlist.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
                                dxDrawText(v[1], count+12, 660, 141, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][4], "left", "top", true, false, true, false, false)
                                dxDrawText("x"..(estoques[v[2]] or "Erro").."", count+161, 660, 32, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][7], "right", "top", false, false, true, false, false)
                                dxDrawText("R$ "..convertNumber(v[3]).."", count+12, 690, 63, 17, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][8], "left", "top", false, false, true, false, false)
                                dxDrawText("ap$ "..convertNumber(v[4]).."", count+124, 690, 69, 17, tocolor(240, 168, 84, alpha), 1.0, client["fonts"][8], "right", "top", false, false, true, false, false)
                            end
                        end
                    end
                end
            end
        end

        if selectVehicle then 
            dxDrawText(selectVehicleInfos["name"], 621, 546, 124, 25, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][9], "center", "top", false, false, true, false, false)
            dxDrawText("R$ "..convertNumber(selectVehicleInfos["price"]..""), 638, 571, 90, 25, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][10], "center", "top", false, false, true, false, false)
        
            dxDrawText("INFORMAÇÕES DO VEÍCULO", 1177, 177, 171, 22, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][11], "right", "top", false, false, true, false, false)
            dxDrawText("Especificação de performance", 1216, 199, 132, 15, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][2], "right", "top", false, false, true, false, false)
            
            dxDrawText("Velocidade", 1147, 227, 192, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)
            dxDrawText("Aceleração", 1147, 283, 62, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)
            dxDrawText("Freio", 1147, 340, 28, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)
            dxDrawText("Tração", 1147, 396, 37, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)

            dxDrawText(""..selectVehicleInfos["speed"].." km/h", 1147, 227, 192, 19, tocolor(212, 212, 212, alpha), 1.0, client["fonts"][3], "right", "center", false, false, true, false, false)
            dxDrawText(""..selectVehicleInfos["aceleration"].." km/s", 1147, 283, 192, 19, tocolor(212, 212, 212, alpha), 1.0, client["fonts"][3], "right", "center", false, false, true, false, false)
            dxDrawText(""..selectVehicleInfos["brake"].." km/s", 1147, 340, 192, 19, tocolor(212, 212, 212, alpha), 1.0, client["fonts"][3], "right", "center", false, false, true, false, false)
            dxDrawText(""..selectVehicleInfos["traction"].." km/s", 1147, 396, 192, 19, tocolor(212, 212, 212, alpha), 1.0, client["fonts"][3], "right", "center", false, false, true, false, false)

            dxDrawImage(1147, 249, 197, 4, "assets/gfx/bar_statics.png", 0, 0, 0, tocolor(107, 106, 107, alpha), true)
            dxDrawImage(1147, 305, 197, 4, "assets/gfx/bar_statics.png", 0, 0, 0, tocolor(107, 106, 107, alpha), true)
            dxDrawImage(1147, 362, 197, 4, "assets/gfx/bar_statics.png", 0, 0, 0, tocolor(107, 106, 107, alpha), true)
            dxDrawImage(1147, 418, 197, 4, "assets/gfx/bar_statics.png", 0, 0, 0, tocolor(107, 106, 107, alpha), true)

            dxDrawImageSection(1147, 249, 197 * selectVehicleInfos["speed"] / 400, 4, 0, 0, 197 * selectVehicleInfos["speed"] / 400, 4, "assets/gfx/bar_statics.png", 0, 0, 0, tocolor(14, 158, 247, alpha), true)
            dxDrawImageSection(1147, 305, 197 * selectVehicleInfos["aceleration"] / 100, 4, 0, 0, 197 * selectVehicleInfos["aceleration"] / 100, 4, "assets/gfx/bar_statics.png", 0, 0, 0, tocolor(14, 158, 247, alpha), true)
            dxDrawImageSection(1147, 362, 197 * selectVehicleInfos["brake"] / 100, 4, 0, 0, 197 * selectVehicleInfos["brake"] / 100, 4, "assets/gfx/bar_statics.png", 0, 0, 0, tocolor(14, 158, 247, alpha), true)
            dxDrawImageSection(1147, 418, 197 * selectVehicleInfos["traction"] / 100, 4, 0, 0, 197 * selectVehicleInfos["traction"] / 100, 4, "assets/gfx/bar_statics.png", 0, 0, 0, tocolor(14, 158, 247, alpha), true)

            dxDrawImage((1147 + (197 * selectVehicleInfos["speed"] / 400)), 245, 12, 12, "assets/gfx/eclipse_statics.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            dxDrawImage((1147 + (197 * selectVehicleInfos["aceleration"] / 100)), 301, 12, 12, "assets/gfx/eclipse_statics.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            dxDrawImage((1147 + (197 * selectVehicleInfos["brake"] / 100)), 358, 12, 12, "assets/gfx/eclipse_statics.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            dxDrawImage((1147 + (197 * selectVehicleInfos["traction"] / 100)), 414, 12, 12, "assets/gfx/eclipse_statics.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)

            dxDrawImage(1147, 451, 207, 34, "assets/gfx/button2.png", 0, 0, 0, (isCursorOnElement(1147, 451, 207, 34) and tocolor(14, 158, 247, alpha) or tocolor(42, 147, 212, alpha)), true)
            dxDrawImage(1147, 495, 207, 34, "assets/gfx/button2.png", 0, 0, 0, (isCursorOnElement(1147, 495, 207, 34) and tocolor(14, 158, 247, alpha) or tocolor(42, 147, 212, alpha)), true)
            dxDrawText("TESTE DRIVE", 1212, 458, 78, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][8], "center", "top", false, false, true, false, false)
            dxDrawText("COMPRAR", 1223, 502, 55, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][8], "center", "top", false, false, true, false, false)
        
            dxDrawText("Forma de pagamento", 1147, 552, 140, 22, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][11], "left", "top", false, false, true, false, false)
            dxDrawText("Escolha a melhor maneira de pagar.", 1147, 574, 157, 15, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][2], "left", "top", false, false, true, false, false)
        
            if isCursorOnElement(1147, 597, 102, 31) or selectPayment == "Dinheiro" then 
                dxDrawImage(1147, 597, 102, 31, "assets/gfx/button-select.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            else
                dxDrawImage(1147, 597, 102, 31, "assets/gfx/button.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            end
            if isCursorOnElement(1252, 597, 102, 31) or selectPayment == "aPoints" then 
                dxDrawImage(1252, 597, 102, 31, "assets/gfx/button-select.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            else
                dxDrawImage(1252, 597, 102, 31, "assets/gfx/button.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            end

            dxDrawText("Dinheiro", 1175, 603, 46, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "center", "top", false, false, true, false, false)
            dxDrawText("aPoints", 1283, 603, 41, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "center", "top", false, false, true, false, false)
        end

        if confirmPurchase then
            dxDrawImage(492, 280, 382, 148, "assets/gfx/bg_confirm.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            dxDrawText("Você está comprando\num veículo por:", 513, 299, 163, 50, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][9], "left", "top", false, false, true, false, false)
            if selectPayment == "aPoints" then 
                dxDrawText("AP$ "..convertNumber(confirmBuy["aPoints"]).."", 746, 324, 100, 25, tocolor(124, 212, 120, alpha), 1.0, client["fonts"][9], "right", "top", false, false, true, false, false)
            elseif selectPayment == "Dinheiro" then
                dxDrawText("R$ "..convertNumber(confirmBuy["Dinheiro"]).."", 746, 324, 100, 25, tocolor(124, 212, 120, alpha), 1.0, client["fonts"][9], "right", "top", false, false, true, false, false)
            end
    
            if isCursorOnElement(512, 377, 102, 31) then 
                dxDrawImage(512, 377, 102, 31, "assets/gfx/button-confirm2.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            else
                dxDrawImage(512, 377, 102, 31, "assets/gfx/button-confirm1.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            end
    
            if isCursorOnElement(617, 377, 102, 31) then 
                dxDrawImage(617, 377, 102, 31, "assets/gfx/button-confirm2.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            else
                dxDrawImage(617, 377, 102, 31, "assets/gfx/button-confirm1.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            end
    
            dxDrawText("CONFIRMAR", 532, 384, 64, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)
            dxDrawText("CANCELAR", 642, 384, 57, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)
        end

    elseif window == "garage" then 
        dxDrawImage(641, 17, 85, 51, "assets/gfx/logo.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)

        dxDrawText("GARAGEM", 29, 164, 62, 22, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][7], "left", "top", false, false, true, false, false)
        dxDrawText("Capacidade da garagem:", 29, 186, 108, 15, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][2], "left", "top", false, false, true, false, false)
        _slots = slots or "Erro"
        dxDrawText("".._slots.." slots", 202, 186, 36, 15, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][2], "right", "top", false, false, true, false, false)

        dxDrawRectangle(31, 212, 207, 1, tocolor(144, 144, 144, alpha), true)

        dxDrawImage(31, 511, 207, 4, "assets/gfx/bar.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
        dxDrawImage(31, 533, 207, 34, "assets/gfx/button2.png", 0, 0, 0, (isCursorOnElement(31, 533, 207, 34) and tocolor(14, 158, 247, alpha) or tocolor(42, 147, 212, alpha)), true)
        dxDrawText("COMPRAR SLOT", 91, 540, 86, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][8], "center", "top", false, false, true, false, false)

        if garagem and #garagem > 0 then
            line = 0 
            for i, v in ipairs(garagem) do 
                if i > client["pag"] and line < 5 then 
                    if v then 
                        line = line + 1
                        local count = (222 + (278 - 222) * line - (278 - 222))

                        dxDrawImage(31, count, 47, 45, "assets/gfx/bg_category.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
                        dxDrawImage(42, count+13, 26, 17, "assets/gfx/icon_car.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
                        dxDrawText(v[2] or "Erro", 95, count+5, 130, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][5], "left", "top", true, false, true, false, false)
                        
                        if v[3] == "guardado" then 
                            stateVehicle = "Guardado"
                        elseif v[3] == "spawnado" then 
                            stateVehicle = "Spawnado"
                        elseif v[3] == "recuperar" then 
                            stateVehicle = "Recuperar"
                        end

                        dxDrawText(stateVehicle or "Erro", 95, count+26, 44, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)
                    
                        if isCursorOnElement(25, (218 + (273 - 218) * line - (273 - 218)), 213, 54) or selectVehicleGarage == i then 
                            dxDrawImage(25, (217 + (273 - 217) * line - (273 - 217)), 213, 54, "assets/gfx/bg_gridlist-category.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
                        end
                    end
                end
            end
        end

        if selectVehicleGarage then 
            dxDrawText("INFORMAÇÕES DO VEÍCULO", 1177, 177, 171, 22, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][11], "right", "top", false, false, true, false, false)
            dxDrawText("Informações gerais", 1216, 199, 132, 15, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][2], "right", "top", false, false, true, false, false)
            
            dxDrawText("Motor", 1147, 227, 192, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)
            dxDrawText("Gasolina", 1147, 283, 62, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)

            dxDrawText(""..selectVehicleGarageInfos["motor"].." %", 1147, 227, 192, 19, tocolor(212, 212, 212, alpha), 1.0, client["fonts"][3], "right", "center", false, false, true, false, false)
            dxDrawText(""..selectVehicleGarageInfos["gasolina"].." %", 1147, 283, 192, 19, tocolor(212, 212, 212, alpha), 1.0, client["fonts"][3], "right", "center", false, false, true, false, false)

            dxDrawImage(1147, 249, 197, 4, "assets/gfx/bar_statics.png", 0, 0, 0, tocolor(107, 106, 107, alpha), true)
            dxDrawImage(1147, 305, 197, 4, "assets/gfx/bar_statics.png", 0, 0, 0, tocolor(107, 106, 107, alpha), true)

            dxDrawImageSection(1147, 249, 197 * selectVehicleGarageInfos["motor"] / 1000, 4, 0, 0, 197 * selectVehicleGarageInfos["motor"] / 1000, 4, "assets/gfx/bar_statics.png", 0, 0, 0, tocolor(14, 158, 247, alpha), true)
            dxDrawImageSection(1147, 305, 197 * selectVehicleGarageInfos["gasolina"] / 100, 4, 0, 0, 197 * selectVehicleGarageInfos["gasolina"] / 100, 4, "assets/gfx/bar_statics.png", 0, 0, 0, tocolor(14, 158, 247, alpha), true)

            dxDrawImage((1147 + (190 * selectVehicleGarageInfos["motor"] / 1000)), 245, 12, 12, "assets/gfx/eclipse_statics.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            dxDrawImage((1147 + (190 * selectVehicleGarageInfos["gasolina"] / 100)), 301, 12, 12, "assets/gfx/eclipse_statics.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
        
            dxDrawImage(1147, 451, 207, 34, "assets/gfx/button2.png", 0, 0, 0, (isCursorOnElement(1147, 451, 207, 34) and tocolor(14, 158, 247, alpha) or tocolor(42, 147, 212, alpha)), true)
            
            if selectVehicleGarageInfos["state"] == "guardado" then 
                stateVehicle2 = "SPAWNAR"
            elseif selectVehicleGarageInfos["state"] == "spawnado" then
                stateVehicle2 = "GUARDAR"
            elseif selectVehicleGarageInfos["state"] == "recuperar" then 
                stateVehicle2 = "SPAWNAR"
            end
            
            dxDrawText(stateVehicle2, 1212, 458, 78, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][8], "center", "top", false, false, true, false, false)
        end

        if buySlot then 
            dxDrawImage(492, 280, 382, 155, "assets/gfx/bg_confirm.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)

            dxDrawText("Compre +1 slot para sua garagem e\ntenha mais um espaço disponível.", 512, 298, 234, 40, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][12], "left", "top", false, false, true, false, false)
            dxDrawText("Sua capacidade atual:     ".._slots.."", 513, 360, 95, 15, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][2], "left", "top", false, false, true, false, false)

            dxDrawImage(512, 390, 131, 31, "assets/gfx/button-confirm1.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)

            if isCursorOnElement(651, 390, 102, 31) then 
                dxDrawImage(651, 390, 102, 31, "assets/gfx/button-confirm2.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            else
                dxDrawImage(651, 390, 102, 31, "assets/gfx/button-confirm1.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            end
    
            if isCursorOnElement(760, 390, 102, 31) then 
                dxDrawImage(760, 390, 102, 31, "assets/gfx/button-confirm2.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            else
                dxDrawImage(760, 390, 102, 31, "assets/gfx/button-confirm1.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            end

            dxDrawText("VALOR:", 522, 398, 35, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)
            dxDrawText("ap$ "..convertNumber(config["gerais"]["price.slot"]..""), 593, 398, 43, 19, tocolor(115, 174, 112, alpha), 1.0, client["fonts"][6], "right", "top", false, false, true, false, false)
        
            dxDrawText("COMPRAR", 675, 398, 54, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "center", "top", false, false, true, false, false)
            dxDrawText("CANCELAR", 784, 398, 54, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "center", "top", false, false, true, false, false)
        end
        
    elseif window == "detran" then 
        dxDrawImage(641, 17, 85, 51, "assets/gfx/logo.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)

        dxDrawText("DETRAN", 29, 164, 62, 22, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][7], "left", "top", false, false, true, false, false)
        dxDrawText("Escolha seu veículo:", 29, 186, 108, 15, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][2], "left", "top", false, false, true, false, false)

        dxDrawRectangle(31, 210, 207, 1, tocolor(144, 144, 144, alpha), true)

        dxDrawImage(31, 510, 207, 4, "assets/gfx/bar.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
        
        if cars_detran and #cars_detran > 0 then
            line = 0 
            for i, v in ipairs(cars_detran) do 
                if i > client["pag"] and line < 5 then 
                    if v then 
                        line = line + 1
                        local count = (222 + (278 - 222) * line - (278 - 222))

                        dxDrawImage(31, count, 47, 45, "assets/gfx/bg_category.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
                        dxDrawImage(42, count+13, 26, 17, "assets/gfx/icon_car.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
                        dxDrawText(v[2] or "Erro", 95, count+5, 130, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][5], "left", "top", true, false, true, false, false)
                        
                        if v[4] == "guardado" then 
                            stateVehicle = "Guardado"
                        elseif v[4] == "spawnado" then 
                            stateVehicle = "Spawnado"
                        elseif v[4] == "recuperar" then 
                            stateVehicle = "Recuperar"
                        end

                        dxDrawText(stateVehicle or "Erro", 95, count+26, 44, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)
                    
                        if isCursorOnElement(25, (218 + (273 - 218) * line - (273 - 218)), 213, 54) or selectVehicleDetran == i then 
                            dxDrawImage(25, (217 + (273 - 217) * line - (273 - 217)), 213, 54, "assets/gfx/bg_gridlist-category.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
                        end
                    end
                end
            end
        else
            dxDrawRectangle(31, 218, 208, 284, tocolor(217, 217, 218, 11), true)
            dxDrawText("VOCÊ NÃO POSSUI", 105, 330, 62, 22, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][5], "center", "top", false, false, true, false, false)
            dxDrawText("VEÍCULOS COMPRADOS", 106, 347, 62, 22, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "center", "top", false, false, true, false, false)
        end

        if selectVehicleDetran then 
            dxDrawText("INFORMAÇÕES DO VEÍCULO", 1177, 177, 171, 22, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][11], "right", "top", false, false, true, false, false)
            dxDrawText("Informações gerais", 1216, 199, 132, 15, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][2], "right", "top", false, false, true, false, false)
            
            dxDrawText("Apreendido", 1147, 227, 192, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)
            dxDrawText("Emplacado", 1147, 283, 62, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)
            dxDrawText("Impostos", 1147, 340, 28, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)

            if selectVehicleDetranInfos["state"] == "recuperar" then 
                state_seized = "Sim"
            else
                state_seized = "Não"
            end

            if selectVehicleDetranInfos["plate"] ~= "" then 
                state_plate = "Sim"
            else
                state_plate = "Não"
            end

            price_imposts = ((selectVehicleDetranInfos and selectVehicleDetranInfos["id"] and findPriceByModelVehicle(tonumber (selectVehicleDetranInfos["id"]))/100) or 0) * 4

            dxDrawText(state_seized or "Erro", 1147, 227, 192, 19, tocolor(212, 212, 212, alpha), 1.0, client["fonts"][3], "right", "center", false, false, true, false, false)
            dxDrawText(state_plate or "Erro", 1147, 283, 192, 19, tocolor(212, 212, 212, alpha), 1.0, client["fonts"][3], "right", "center", false, false, true, false, false)
            dxDrawText("R$ "..convertNumber(price_imposts).."", 1147, 340, 192, 19, tocolor(212, 212, 212, alpha), 1.0, client["fonts"][3], "right", "center", false, false, true, false, false)

            dxDrawImage(1147, 249, 197, 4, "assets/gfx/bar_statics.png", 0, 0, 0, tocolor(14, 158, 247, alpha), true)
            dxDrawImage(1147, 305, 197, 4, "assets/gfx/bar_statics.png", 0, 0, 0, tocolor(14, 158, 247, alpha), true)
            dxDrawImage(1147, 362, 197, 4, "assets/gfx/bar_statics.png", 0, 0, 0, tocolor(14, 158, 247, alpha), true)

            dxDrawImage(1144, 375, 207, 34, "assets/gfx/button2.png", 0, 0, 0, (isCursorOnElement(1144, 375, 207, 34) and tocolor(14, 158, 247, alpha) or tocolor(111, 111, 112, alpha)), true)
            dxDrawImage(1144, 418, 207, 34, "assets/gfx/button2.png", 0, 0, 0, (isCursorOnElement(1144, 418, 207, 34) and tocolor(14, 158, 247, alpha) or tocolor(111, 111, 112, alpha)), true)
            dxDrawImage(1144, 460, 207, 34, "assets/gfx/button2.png", 0, 0, 0, (isCursorOnElement(1144, 460, 207, 34) and tocolor(14, 158, 247, alpha) or tocolor(111, 111, 112, alpha)), true)

            dxDrawText("RECUPERAR", 1212, 381, 78, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][8], "center", "top", false, false, true, false, false)
            dxDrawText("EMPLACAR", 1212, 424, 78, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][8], "center", "top", false, false, true, false, false)
            dxDrawText("PAGAR IMPOSTOS", 1212, 466, 78, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][8], "center", "top", false, false, true, false, false)
        end

        if recovery then 
            dxDrawImage(492, 280, 382, 155, "assets/gfx/bg_confirm.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)

            dxDrawText("Você deseja recuperar este veículo\nabaixo?", 512, 298, 234, 40, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][12], "left", "top", false, false, true, false, false)
            
            recovery_model = ((selectVehicleDetranInfos and selectVehicleDetranInfos["id"] and findPriceByModelVehicle(tonumber (selectVehicleDetranInfos["id"])) or 0))

            dxDrawText(recovery_model, 513, 360, 95, 15, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][5], "left", "top", false, false, true, false, false)

            dxDrawImage(512, 390, 131, 31, "assets/gfx/button-confirm1.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)

            if isCursorOnElement(651, 390, 102, 31) then 
                dxDrawImage(651, 390, 102, 31, "assets/gfx/button-confirm2.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            else
                dxDrawImage(651, 390, 102, 31, "assets/gfx/button-confirm1.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            end

            if isCursorOnElement(760, 390, 102, 31) then 
                dxDrawImage(760, 390, 102, 31, "assets/gfx/button-confirm2.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            else
                dxDrawImage(760, 390, 102, 31, "assets/gfx/button-confirm1.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            end

            recovery_price = (findPriceByModelVehicle(selectVehicleDetranInfos["id"])/100)*4

            dxDrawText("VALOR:", 522, 398, 35, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)
            dxDrawText("R$ "..convertNumber(recovery_price).."", 593, 398, 43, 19, tocolor(115, 174, 112, alpha), 1.0, client["fonts"][6], "right", "top", false, false, true, false, false)
        
            dxDrawText("RECUPERAR", 675, 398, 54, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "center", "top", false, false, true, false, false)
            dxDrawText("CANCELAR", 784, 398, 54, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "center", "top", false, false, true, false, false)
        end

        if registration then 
            dxDrawImage(492, 280, 382, 155, "assets/gfx/bg_confirm.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)

            dxDrawText("Você deseja emplacar este veículo\nabaixo?", 512, 298, 234, 40, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][12], "left", "top", false, false, true, false, false)
            
            registration_model = (findNameByModelVehicle(selectVehicleDetranInfos["id"]))

            dxDrawText(registration_model, 513, 360, 95, 15, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][5], "left", "top", false, false, true, false, false)

            dxDrawImage(512, 390, 131, 31, "assets/gfx/button-confirm1.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)

            if isCursorOnElement(651, 390, 102, 31) then 
                dxDrawImage(651, 390, 102, 31, "assets/gfx/button-confirm2.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            else
                dxDrawImage(651, 390, 102, 31, "assets/gfx/button-confirm1.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            end

            if isCursorOnElement(760, 390, 102, 31) then 
                dxDrawImage(760, 390, 102, 31, "assets/gfx/button-confirm2.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            else
                dxDrawImage(760, 390, 102, 31, "assets/gfx/button-confirm1.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            end

            registration_price = (findPriceByModelVehicle(selectVehicleDetranInfos["id"])/100)*4

            dxDrawText("VALOR:", 522, 398, 35, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)
            dxDrawText("R$ "..convertNumber(registration_price).."", 593, 398, 43, 19, tocolor(115, 174, 112, alpha), 1.0, client["fonts"][6], "right", "top", false, false, true, false, false)
        
            dxDrawText("EMPLACAR", 675, 398, 54, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "center", "top", false, false, true, false, false)
            dxDrawText("CANCELAR", 784, 398, 54, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "center", "top", false, false, true, false, false)
        end

        if payImposts then 
            dxDrawImage(492, 280, 382, 155, "assets/gfx/bg_confirm.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)

            dxDrawText("Você deseja pagar os impostos do\nveículo abaixo?", 512, 298, 234, 40, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][12], "left", "top", false, false, true, false, false)
            
            payImposts_model = (findNameByModelVehicle(selectVehicleDetranInfos["id"]))

            dxDrawText(payImposts_model, 513, 360, 95, 15, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][5], "left", "top", false, false, true, false, false)

            dxDrawImage(512, 390, 131, 31, "assets/gfx/button-confirm1.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)

            if isCursorOnElement(651, 390, 102, 31) then 
                dxDrawImage(651, 390, 102, 31, "assets/gfx/button-confirm2.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            else
                dxDrawImage(651, 390, 102, 31, "assets/gfx/button-confirm1.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            end

            if isCursorOnElement(760, 390, 102, 31) then 
                dxDrawImage(760, 390, 102, 31, "assets/gfx/button-confirm2.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            else
                dxDrawImage(760, 390, 102, 31, "assets/gfx/button-confirm1.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
            end

            payImposts_price = (findPriceByModelVehicle(selectVehicleDetranInfos["id"])/100)*4

            dxDrawText("VALOR:", 522, 398, 35, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)
            dxDrawText("R$ "..convertNumber(payImposts_price).."", 593, 398, 43, 19, tocolor(115, 174, 112, alpha), 1.0, client["fonts"][6], "right", "top", false, false, true, false, false)
        
            dxDrawText("PAGAR", 675, 398, 54, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "center", "top", false, false, true, false, false)
            dxDrawText("CANCELAR", 784, 398, 54, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "center", "top", false, false, true, false, false)
        end
    end
end

local function onClientRenderMyVehicles()
    local alpha_ = interpolateBetween(client["radius_"][1], 0, 0, client["radius_"][2], 0, 0, (getTickCount() - client["tick_"])/300, "Linear")
    dxDrawImage(510, 189, 356, 383, "assets/gfx/bg.png", 0, 0, 0, tocolor(255, 255, 255, alpha_), true)
    dxDrawImage(825, 212, 13, 13, "assets/gfx/icon_close.png", 0, 0, 0, (isCursorOnElement(825, 212, 13, 13) and tocolor(255, 121, 121, alpha_) or tocolor(174, 174, 174, alpha_)), true)
    dxDrawText("Meus veículos", 523, 200, 80, 20, tocolor(255, 255, 255, alpha_), 1.0, client["fonts"][13], "left", "top", false, false, true, false, false)
    dxDrawText("Escolha seu veículo para gerencia-lo.", 523, 224, 154, 15, tocolor(255, 255, 255, alpha_), 1.0, client["fonts"][2], "left", "top", false, false, true, false, false)

    if garagem and #garagem > 0 then 
        line = 0
        for i, v in ipairs(garagem) do 
            if i > client["pag_"] and line < 5 then 
                if v then 
                    line = line + 1
                    local count = (249 + (285 - 249) * line - (285 - 249))

                    if isCursorOnElement(523, count, 330, 34) or selectVehicleMyVehicles == i then 
                        dxDrawImage(523, count, 330, 34, "assets/gfx/gridlist_my_vehicles.png", 0, 0, 0, tocolor(14, 158, 247, alpha_), true)
                    else
                        dxDrawImage(523, count, 330, 34, "assets/gfx/gridlist_my_vehicles.png", 0, 0, 0, tocolor(50, 50, 51, alpha_), true)
                    end
                    
                    dxDrawText(v[2] or "Erro", 534, count+8, 85, 19, tocolor(255, 255, 255, alpha_), 1.0, client["fonts"][1], "left", "top", false, false, true, false, false)
                
                    if v[3] == "guardado" then 
                        stateVehicle_ = "Guardado"
                    elseif v[3] == "spawnado" then 
                        stateVehicle_ = "Na rua"
                    elseif v[3] == "recuperar" then 
                        stateVehicle_ = "Recuperar"
                    end

                    dxDrawText(stateVehicle_ or "Erro", 787, count+8, 54, 19, tocolor(255, 255, 255, alpha_), 1.0, client["fonts"][1], "right", "top", false, false, true, false, false)
                end
            end
        end
    end

    dxDrawImage(523, 451, 330, 31, "assets/gfx/bg_button_my_vehicles.png", 0, 0, 0, (isCursorOnElement(523, 451, 330, 31) and tocolor(14, 158, 247, alpha_) or tocolor(50, 50, 51, alpha_)), true)
    dxDrawImage(523, 484, 330, 31, "assets/gfx/bg_button_my_vehicles.png", 0, 0, 0, (isCursorOnElement(523, 484, 330, 31) and tocolor(14, 158, 247, alpha_) or tocolor(50, 50, 51, alpha_)), true)
    dxDrawImage(523, 518, 330, 31, "assets/gfx/bg_button_my_vehicles.png", 0, 0, 0, (isCursorOnElement(523, 518, 330, 31) and tocolor(14, 158, 247, alpha_) or tocolor(50, 50, 51, alpha_)), true)

    dxDrawText("Localizar veículo", 641, 457, 93, 19, tocolor(255, 255, 255, alpha_), 1.0, client["fonts"][1], "center", "top", false, false, true, false, false)
    dxDrawText("Vender veículo", 641, 490, 93, 19, tocolor(255, 255, 255, alpha_), 1.0, client["fonts"][1], "center", "top", false, false, true, false, false)
    dxDrawText("Trancar veículo", 641, 524, 93, 19, tocolor(255, 255, 255, alpha_), 1.0, client["fonts"][1], "center", "top", false, false, true, false, false)

    if selectSell then 
        dxDrawImage(510, 189, 356, 382, "assets/gfx/bg_select.png", 0, 0, 0, tocolor(255, 255, 255, alpha_), true)        
        dxDrawImage(591, 304, 194, 124, "assets/gfx/bg_select-sell.png", 0, 0, 0, tocolor(255, 255, 255, alpha_), true)
        dxDrawText("Escolha a forma de venda", 603, 315, 124, 15, tocolor(255, 255, 255, alpha_), 1.0, client["fonts"][2], "left", "top", false, false, true, false, false)
        dxDrawImage(763, 317, 9, 9, "assets/gfx/icon_close.png", 0, 0, 0, (isCursorOnElement(763, 317, 9, 9) and tocolor(255, 121, 121, alpha_) or tocolor(174, 174, 174, alpha_)), true)

        dxDrawText("Concessionaria", 621, 351, 79, 17, tocolor(255, 255, 255, alpha_), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)
        dxDrawText("Jogador", 731, 351, 41, 17, tocolor(255, 255, 255, alpha_), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)

        if sellType == "loja" then 
            dxDrawImage(606, 356, 7, 7, "assets/gfx/eclipse_selected.png", 0, 0, 0, tocolor(14, 158, 247, alpha_), true)
            dxDrawImage(603, 353, 13, 13, "assets/gfx/eclipse_not-select.png", 0, 0, 0, tocolor(14, 158, 247, alpha_), true)
        else
            dxDrawImage(603, 353, 13, 13, "assets/gfx/eclipse_not-select.png", 0, 0, 0, tocolor(101, 98, 98, alpha_), true)
        end

        if sellType == "player" then 
            dxDrawImage(715, 356, 7, 7, "assets/gfx/eclipse_selected.png", 0, 0, 0, tocolor(14, 158, 247, alpha_), true)
            dxDrawImage(712, 353, 13, 13, "assets/gfx/eclipse_not-select.png", 0, 0, 0, tocolor(14, 158, 247, alpha_), true)
        else
            dxDrawImage(712, 353, 13, 13, "assets/gfx/eclipse_not-select.png", 0, 0, 0, tocolor(101, 98, 98, alpha_), true)
        end

        dxDrawImage(599, 394, 177, 25, "assets/gfx/button_sell.png", 0, 0, 0, (isCursorOnElement(599, 394, 177, 25) and tocolor(14, 158, 247, alpha_) or tocolor(63, 60, 60, alpha_)), true)
        dxDrawText("CONTINUAR", 664, 399, 50, 15, tocolor(255, 255, 255, alpha_), 1.0, client["fonts"][2], "center", "top", false, false, true, false, false)
    end

    if sellFinish then 
        dxDrawImage(510, 189, 356, 382, "assets/gfx/bg_select.png", 0, 0, 0, tocolor(255, 255, 255, alpha_), true)        
        dxDrawImage(591, 304, 194, 124, "assets/gfx/bg_select-sell.png", 0, 0, 0, tocolor(255, 255, 255, alpha_), true)
        dxDrawText("Você está vendendo o veículo", 603, 315, 124, 15, tocolor(255, 255, 255, alpha_), 1.0, client["fonts"][2], "left", "top", false, false, true, false, false)
        vehicleSell_name = (findNameByModelVehicle(selectVehicleMyVehiclesInfos["id"]))
        dxDrawText(vehicleSell_name, 603, 330, 124, 15, tocolor(14, 158, 247, alpha_), 1.0, client["fonts"][2], "left", "top", false, false, true, false, false)
        dxDrawImage(763, 317, 9, 9, "assets/gfx/icon_close.png", 0, 0, 0, (isCursorOnElement(763, 317, 9, 9) and tocolor(255, 121, 121, alpha_) or tocolor(174, 174, 174, alpha_)), true)

        dxDrawRectangle(600, 362, 94, 25, tocolor(63, 60, 60, alpha_), true)
        dxDrawRectangle(696, 362, 80, 25, tocolor(63, 60, 60, alpha_), true)

        if client["edits"][1][1] and isElement(client["edits"][1][2]) then
            dxDrawText((guiGetText(client["edits"][1][2]) or "").. "|", 625, 368, 50, 15, tocolor(150, 150, 150, alpha_), 1.0, client["fonts"][2], "center", "top", false, false, true, false, false)
            
        elseif (#guiGetText(client["edits"][1][2]) >= 1) then 
            dxDrawText((guiGetText(client["edits"][1][2]) or ""), 625, 368, 50, 15, tocolor(150, 150, 150, alpha_), 1.0, client["fonts"][2], "center", "top", false, false, true, false, false)
        else
            dxDrawText("Valor", 625, 368, 50, 15, tocolor(150, 150, 150, alpha_), 1.0, client["fonts"][2], "center", "top", false, false, true, false, false)
        end

        if client["edits"][2][1] and isElement(client["edits"][2][2]) then
            dxDrawText((guiGetText(client["edits"][2][2]) or "").. "|", 711, 368, 50, 15, tocolor(150, 150, 150, alpha_), 1.0, client["fonts"][2], "center", "top", false, false, true, false, false)
            
        elseif (#guiGetText(client["edits"][2][2]) >= 1) then 
            dxDrawText((guiGetText(client["edits"][2][2]) or ""), 711, 368, 50, 15, tocolor(150, 150, 150, alpha_), 1.0, client["fonts"][2], "center", "top", false, false, true, false, false)
        else
            dxDrawText("ID", 711, 368, 50, 15, tocolor(150, 150, 150, alpha_), 1.0, client["fonts"][2], "center", "top", false, false, true, false, false)
        end

        dxDrawImage(599, 394, 177, 25, "assets/gfx/button_sell.png", 0, 0, 0, (isCursorOnElement(599, 394, 177, 25) and tocolor(14, 158, 247, alpha_) or tocolor(63, 60, 60, alpha_)), true)
        dxDrawText("VENDER", 664, 399, 50, 15, tocolor(255, 255, 255, alpha_), 1.0, client["fonts"][2], "center", "top", false, false, true, false, false)
    end
end

local function onClientRenderTestDrive()
    local timer = interpolateBetween(config["gerais"]["time.teste-drive"], 0, 0, 0, 0, 0, ((getTickCount() - tickDrive) / config["gerais"]["time.teste-drive"]), "Linear")
    local minutes, seconds = convertTime(timer)
    dxDrawImage(1147, 540, 207, 49, "assets/gfx/bg_test-drive.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
    dxDrawText("Tempo restante", 1159, 554, 91, 19, tocolor(210, 210, 210, alpha), 1.0, client["fonts"][4], "left", "top", false, false, true, false, false)
    dxDrawText("0:"..seconds.."", 1312, 554, 26, 19, tocolor(210, 210, 210, alpha), 1.0, client["fonts"][4], "right", "top", false, false, true, false, false)
end

local function onClientRenderOffer()
    dxDrawImage(492, 280, 382, 155, "assets/gfx/bg_confirm.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)

    dxDrawText(""..seller_name.." lhe ofereceu este veículo\nabaixo.", 512, 298, 234, 40, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][12], "left", "top", false, false, true, false, false)
    
    dxDrawText(vehicle_name, 513, 360, 95, 15, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][5], "left", "top", false, false, true, false, false)

    dxDrawImage(512, 390, 131, 31, "assets/gfx/button-confirm1.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)

    if isCursorOnElement(651, 390, 102, 31) then 
        dxDrawImage(651, 390, 102, 31, "assets/gfx/button-confirm2.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
    else
        dxDrawImage(651, 390, 102, 31, "assets/gfx/button-confirm1.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
    end

    if isCursorOnElement(760, 390, 102, 31) then 
        dxDrawImage(760, 390, 102, 31, "assets/gfx/button-confirm2.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
    else
        dxDrawImage(760, 390, 102, 31, "assets/gfx/button-confirm1.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
    end

    dxDrawText("VALOR:", 522, 398, 35, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "left", "top", false, false, true, false, false)
    dxDrawText("R$ "..convertNumber(price_vehicle).."", 593, 398, 43, 19, tocolor(115, 174, 112, alpha), 1.0, client["fonts"][6], "right", "top", false, false, true, false, false)

    dxDrawText("ACEITAR", 675, 398, 54, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "center", "top", false, false, true, false, false)
    dxDrawText("CANCELAR", 784, 398, 54, 19, tocolor(255, 255, 255, alpha), 1.0, client["fonts"][6], "center", "top", false, false, true, false, false)
end

addEvent("squady.openConce", true)
addEventHandler("squady.openConce", getRootElement(), function()
    if not client["visible"] and not client["tick"] then 
        client["visible"] = true;
        client["radius"] = {0, 255};
        client["tick"] = getTickCount();
        client["category"] = nil
        window = "dealership"
        selectCategory = nil
        colorSelect = nil
        selectVehicle = nil
        selectPayment = nil
        confirmPurchase = false
        estoques = {}
        triggerServerEvent("squady.insertEstoque-s", localPlayer)
        setCameraMatrix(1551.5720214844, -1236.8828125, 21.968200683594, 1551.556640625, -1237.8262939453, 21.637256622314, 0, 70)
        setElementFrozen(localPlayer, true)
        addEventHandler("onClientRender", getRootElement(), onClientRenderDealership)
        showCursor(true)
        showChat(false)
        setElementData(localPlayer, "BloqHud", true)
    elseif client["visible"] and client["tick"] then 
        client["visible"] = false;
        client["radius"] = {255, 0};
        client["tick"] = getTickCount();
        setTimer(function()
            client["tick"] = nil 
            removeEventHandler("onClientRender", getRootElement(), onClientRenderDealership)
            showCursor(false)
            showChat(true)
            setElementData(localPlayer, "BloqHud", false)
            setElementFrozen(localPlayer, false)
        	if isTimer(rotCar) and killTimer(rotCar) then end
        	if isElement(car) and destroyElement(car) then end
        	setCameraTarget(localPlayer, localPlayer)
        end, 300, 1)
    end
end)

addEvent("squady.closeConce", true)
addEventHandler("squady.closeConce", getRootElement(), function()
    if client["visible"] and client["tick"] then
        client["visible"] = false;
        client["radius"] = {255, 0};
        client["pag"] = 0;
        client["tick"] = getTickCount();
        setTimer(function()
            client["tick"] = nil 
            removeEventHandler("onClientRender", getRootElement(), onClientRenderDealership)
            showCursor(false)
            showChat(true)
            setElementData(localPlayer, "BloqHud", false)
            if window == "dealership" then
                setElementFrozen(localPlayer, false)
                if isTimer(rotCar) and killTimer(rotCar) then end
                if isElement(car) and destroyElement(car) then end
                setCameraTarget(localPlayer, localPlayer)
            end
        end, 300, 1)
    end
end)

addEvent("squady.onTestDrive", true)
addEventHandler("squady.onTestDrive", getRootElement(), function(type)
    if type == "add" then 
        if not client["visible_test_drive"] then 
            client["visible_test_drive"] = true;
            tickDrive = getTickCount();
            addEventHandler("onClientRender", getRootElement(), onClientRenderTestDrive)
        end
    else
        if client["visible_test_drive"] then 
            client["visible_test_drive"] = false;
            removeEventHandler("onClientRender", getRootElement(), onClientRenderTestDrive)
        end
    end
end)

addEvent("squady.openGarage", true)
addEventHandler("squady.openGarage", getRootElement(), function()
    if not client["visible"] and not client["tick"] then 
        client["visible"] = true;
        client["radius"] = {0, 255};
        client["pag"] = 0;
        client["tick"] = getTickCount();
        garagem = {}
        buySlot = false;
        selectVehicleGarage = nil;
        window = "garage";
        showCursor(true)
        showChat(false)
        setElementData(localPlayer, "BloqHud", true)
        triggerServerEvent("squady.insertGaragem-s", localPlayer)
        addEventHandler("onClientRender", getRootElement(), onClientRenderDealership)
    elseif client["visible"] and client["tick"] then
        setTimer(function()
            client["tick"] = nil 
            removeEventHandler("onClientRender", getRootElement(), onClientRenderDealership)
            showCursor(false)
            showChat(true)
            setElementData(localPlayer, "BloqHud", false)
        end, 300, 1)
    end
end)

addEvent("squady.openDetran", true)
addEventHandler("squady.openDetran", getRootElement(), function(tabela, time)
    if not client["visible"] and not client["tick"] then 
        client["visible"] = true;
        client["radius"] = {0, 255};
        client["pag"] = 0;
        client["tick"] = getTickCount();
        selectVehicleDetran = nil;
        window = "detran";
        showCursor(true)
        showChat(false)
        setElementData(localPlayer, "BloqHud", true)
        cars_detran = {}
        for i, v in ipairs(tabela) do 
            local info = fromJSON(v.infos)
            table.insert(cars_detran, {v.model, info[1], v.seguro, v.state, v.plate})
        end
        addEventHandler("onClientRender", getRootElement(), onClientRenderDealership)
    elseif client["visible"] and client["tick"] then
        setTimer(function()
            client["tick"] = nil 
            removeEventHandler("onClientRender", getRootElement(), onClientRenderDealership)
            showCursor(false)
            showChat(true)
            setElementData(localPlayer, "BloqHud", false)
        end, 300, 1)
    end
end)

addEvent("squady.openDrawOffer", true)
addEventHandler("squady.openDrawOffer", getRootElement(), function(seller, vehicle, price)
    seller_name = seller
    vehicle_name = vehicle 
    price_vehicle = price 
    client["visible_offer"] = true
    addEventHandler("onClientRender", getRootElement(), onClientRenderOffer)
    showCursor(true)
    timer_expire = setTimer(function()
        if client["visible_offer"] then 
            client["visible_offer"] = false
            removeEventHandler("onClientRender", getRootElement(), onClientRenderOffer)
            showCursor(false)
        end
    end, 1 * 60000, 1)
end)

bindKey(config["gerais"]["bind.open"], "down", function()
    if not client["visible_my_vehicles"] and not client["tick_"] then 
        client["visible_my_vehicles"] = true;
        client["radius_"] = {0, 255};
        client["pag_"] = 0;
        client["tick_"] = getTickCount();
        garagem = {}
        selectVehicleMyVehicles = nil;
        selectSell = false
        showCursor(true)
        showChat(false)
        triggerServerEvent("squady.insertGaragem-s", localPlayer)
        addEventHandler("onClientRender", getRootElement(), onClientRenderMyVehicles)
    elseif client["visible_my_vehicles"] and client["tick_"] then
        client["visible_my_vehicles"] = false;
        client["radius_"] = {255, 0};
        client["tick_"] = getTickCount();
        setTimer(function()
            client["tick_"] = nil 
            removeEventHandler("onClientRender", getRootElement(), onClientRenderMyVehicles)
            showCursor(false)
            showChat(true)
        end, 300, 1)
    end
end)

bindKey("backspace", "down", function()
    if client["visible"] and client["tick"] then
        client["visible"] = false;
        client["radius"] = {255, 0};
        client["tick"] = getTickCount();
        setTimer(function()
            client["tick"] = nil 
            removeEventHandler("onClientRender", getRootElement(), onClientRenderDealership)
            showCursor(false)
            showChat(true)
            setElementData(localPlayer, "BloqHud", false)
            if window == "dealership" then
                setElementFrozen(localPlayer, false)
                if isTimer(rotCar) and killTimer(rotCar) then end
                if isElement(car) and destroyElement(car) then end
                setCameraTarget(localPlayer, localPlayer)
            end
        end, 300, 1)
    end
end)

addEventHandler ("onClientClick", getRootElement(), function(button, state)
    if client["visible_my_vehicles"] and button == "left" and state == "down" then
        client["edits"][1][1] = false
        client["edits"][2][1] = false

        if sellFinish and sellType == "player" then
            if isCursorOnElement(600, 362, 94, 25) then 
                if (guiEditSetCaretIndex(client["edits"][1][2], (string.len(guiGetText(client["edits"][1][2]))))) then 
                    guiSetProperty(client["edits"][1][2], "ValidationString", "^[0-9]*")
                    guiEditSetMaxLength(client["edits"][1][2], 9)
                    guiBringToFront(client["edits"][1][2])
                    guiSetInputMode("no_binds_when_editing")
                    client["edits"][1][1] = true
                end

            elseif isCursorOnElement(696, 362, 80, 25) then
                if (guiEditSetCaretIndex(client["edits"][2][2], (string.len(guiGetText(client["edits"][2][2]))))) then 
                    guiSetProperty(client["edits"][2][2], "ValidationString", "^[0-9]*")
                    guiEditSetMaxLength(client["edits"][2][2], 6)
                    guiBringToFront(client["edits"][2][2])
                    guiSetInputMode("no_binds_when_editing")
                    client["edits"][2][1] = true
                end
            end
        end

        if isCursorOnElement(825, 212, 13, 13) then 
            if client["visible_my_vehicles"] and client["tick_"] then
                client["visible_my_vehicles"] = false;
                client["radius_"] = {255, 0};
                client["tick_"] = getTickCount();
                setTimer(function()
                    client["tick_"] = nil 
                    removeEventHandler("onClientRender", getRootElement(), onClientRenderMyVehicles)
                    showCursor(false)
                    showChat(true)
                end, 300, 1)
            end
        end

        if garagem and #garagem > 0 then 
            line = 0
            for i, v in ipairs(garagem) do 
                if i > client["pag_"] and line < 5 then 
                    if v then 
                        line = line + 1
                        local count = (249 + (285 - 249) * line - (285 - 249))
    
                        if isCursorOnElement(523, count, 330, 34) and not selectSell and not sellFinish then 
                            selectVehicleMyVehicles = i
                            selectVehicleMyVehiclesInfos = {
                                id = v[1];
                                state = v[3];
                            }
                        end
                    end
                end
            end
        end

        if isCursorOnElement(523, 451, 330, 31) and not selectSell and not sellFinish then 
            if selectVehicleMyVehicles then
                if selectVehicleMyVehiclesInfos["state"] == "spawnado" then
                    triggerServerEvent("onPlayerTrackVehicle", localPlayer, localPlayer, selectVehicleMyVehiclesInfos["id"])
                else
                    sendMessage("client", localPlayer, "O veículo "..findNameByModelVehicle(selectVehicleMyVehiclesInfos["id"]).." não está spawnado.", "error")
                end
            else
                sendMessage("client", localPlayer, "Você precisa selecionar um veículo", "error")
            end
            
        elseif isCursorOnElement(523, 518, 330, 31) and not selectSell and not sellFinish then 
            if selectVehicleMyVehicles then
                if selectVehicleMyVehiclesInfos["state"] == "spawnado" then 
                    triggerServerEvent("squady.lockVehicle", localPlayer, localPlayer, selectVehicleMyVehiclesInfos["id"]) 
                else
                    sendMessage("client", localPlayer, "O veículo "..findNameByModelVehicle(selectVehicleMyVehiclesInfos["id"]).." não está spawnado.", "error")
                end
            else
                sendMessage("client", localPlayer, "Você precisa selecionar um veículo", "error")
            end

        elseif isCursorOnElement(523, 484, 330, 31) and not selectSell and not sellFinish then 
            if selectVehicleMyVehicles then
                if not selectSell then 
                    selectSell = true
                    sellType = nil
                end
            else
                sendMessage("client", localPlayer, "Você precisa selecionar um veículo", "error")
            end

        elseif isCursorOnElement(763, 317, 9, 9) then 
            if selectSell then 
                selectSell = false
                sellType = nil
            end

        elseif isCursorOnElement(603, 353, 13, 13) then 
            if selectVehicleMyVehicles and selectSell and not sellFinish then
                sellType = "loja"
            end

        elseif isCursorOnElement(712, 353, 13, 13) then
            if selectVehicleMyVehicles and selectSell and not sellFinish then
                sellType = "player"
            end

        elseif isCursorOnElement(599, 394, 177, 25) then 
            if selectVehicleMyVehicles and selectSell and not sellFinish then
                if sellType == "player" then 
                    sellFinish = true
                    selectSell = false
                    setTimer(function()
                        if not sellFinish_ then
                            sellFinish_ = true
                        end
                    end, 1, 1)

                elseif sellType == "loja" then
                    triggerServerEvent("squady.sellVehicle", localPlayer, selectVehicleMyVehiclesInfos["id"], "loja")
                    sellFinish = false
                    selectSell = false
                    sellType = nil
                end
            end
        end

        if isCursorOnElement(763, 317, 9, 9) then
            if sellFinish then 
                sellFinish = false
            end
        end

        if sellFinish then 
            if sellFinish_ then
                if isCursorOnElement(599, 394, 177, 25) then 
                    local valor = guiGetText(client["edits"][1][2])
                    local id = guiGetText(client["edits"][2][2])
                
                    if not (valor == "" or valor == "Valor") and not (id == "" or id == "ID") then
                        triggerServerEvent("squady.sellVehicle", localPlayer, selectVehicleMyVehiclesInfos["id"], "player", id, valor)
                    else
                        sendMessage("client", localPlayer, "Você precisa preencher ambos os campos: Valor e ID do jogador para vender o veículo.", "error")
                    end
                end
            end
        end 

	elseif client["visible"] and button == "left" and state == "down" then

        if window == "dealership" then 
            line = 0 
            for i, category in ipairs(config["categorys"]) do 
                if i > client["pag_categorys"] and line < 4 then 
                    if category then 
                        line = line + 1
                        local count = (222 + (278 - 222) * line - (278 - 222))
    
                        if isCursorOnElement(25, (218 + (273 - 218) * line - (273 - 218)), 213, 54) and not confirmPurchase then
                            selectCategory = i
                            colorSelect = nil
                            selectVehicle = nil
                            purchaseType = nil
                            client["pag"] = 0
                            client["pag_category"] = 0
                            client["category"] = category.tittle
                            categoryVehicles = config["veiculos"][client["category"]] or {}
                        end
                    end
                end
            end

            local c, r = 0, 0
            for i = 1, 10 do 
                local color = config["colors"][(i + client["pag_colors"])]
                if i > client["pag_colors"] and c < 10 then 
                    c = c + 1
                    local countX = (33 + (73 - 33) * c - (73 - 33))
                    local countY = (491 + (528 - 491) * r)
    
                    if color then
                        if isCursorOnElement(countX, countY, 29, 29) and not confirmPurchase and selectVehicle then 
                            colorSelect = i
                            if colorSelect then
                                local color = config["colors"][(colorSelect + client["pag_colors"])]
                                if color then
                                    setVehicleColor(car, color[1], color[2], color[3])
                                end
                            end
                        end
                        
                        if (c >= 5) then 
                            c = 0
                            r = r + 1
                        end
                    end
                end
            end

            local categoryVehicles = config["veiculos"][client["category"]]
            linha = 0
            if categoryVehicles then 
                for i, v in ipairs(categoryVehicles) do 
                    if i > client["pag"] and linha < client["max"] then
                        linha = linha + 1

                        local count = (262 + (473 - 262) * linha - (473 - 262))
                        if v then 
                            if isCursorOnElement(count, 650, 207, 85) and not confirmPurchase then
                                selectVehicle = i 
                                selectVehicleInfos = {
                                    name = v[1];
                                    id = v[2];
                                    price = v[3];
                                    aPoints = v[4];
                                    speed = v["statics"]["speed"];
                                    aceleration = v["statics"]["aceleration"];
                                    brake = v["statics"]["brake"];
                                    traction = v["statics"]["traction"];
                                }

                                if isElement(car) then
                                    destroyElement(car)
                                    car = nil
                                
                                    if isTimer(rotCar) then
                                        killTimer(rotCar)
                                    end
                                end
                                
                                if not isElement(car) then
                                    car = createVehicle(selectVehicleInfos["id"], 1550.137, -1250.966, 17.406)
                                    rotCar = setTimer(function()
                                        local rx, ry, rz = getElementRotation(car)
                                        setElementRotation(car, rx, ry, rz + 0.8)
                                    end, 0, 0)
                                end
                            end
                        end
                    end
                end
            end

            if isCursorOnElement(1147, 597, 102, 31) and not confirmPurchase then 
                selectPayment = "Dinheiro"
            end
            if isCursorOnElement(1252, 597, 102, 31) and not confirmPurchase then 
                selectPayment = "aPoints"
            end

            if isCursorOnElement(1147, 495, 207, 34) then
                if colorSelect ~= nil then
                    if selectPayment ~= nil then 
                        confirmPurchase = true
                        confirmBuy = {
                            Dinheiro = selectVehicleInfos["price"];
                            aPoints = selectVehicleInfos["aPoints"];
                        }
                    else
                        sendMessage("client", localPlayer, "Você precisa selecionar a forma de pagamento.", "error")
                    end
                else
                    sendMessage("client", localPlayer, "Você precisa selecionar a cor do veículo.", "error")
                end
            end

            if isCursorOnElement(1147, 451, 207, 34) then 
                color = {getVehicleColor(car, true)}
                triggerServerEvent("squady.testDrive", localPlayer, selectVehicleInfos["id"], color)
            end

            if confirmPurchase then 
                if isCursorOnElement(617, 377, 102, 31) then 
                    confirmPurchase = false
                end

                if isCursorOnElement(512, 377, 102, 31) then
                    if selectPayment == "Dinheiro" then 
                        color = {getVehicleColor(car, true)}
                        triggerServerEvent("squady.buyVehicle", localPlayer, localPlayer, selectVehicleInfos["id"], selectVehicleInfos["name"], confirmBuy["Dinheiro"], color, "Dinheiro")
                        confirmPurchase = false
                    elseif selectPayment == "aPoints" then
                        color = {getVehicleColor(car, true)}
                        triggerServerEvent("squady.buyVehicle", localPlayer, localPlayer, selectVehicleInfos["id"], selectVehicleInfos["name"], confirmBuy["aPoints"], color, "aPoints")
                        confirmPurchase = false
                    end
                end
            end

        elseif window == "garage" then 
            if isCursorOnElement(31, 533, 207, 34) then 
                if not buySlot then 
                    buySlot = true 
                end
            end

            if buySlot then 
                if isCursorOnElement(760, 390, 102, 31) then 
                    buySlot = false

                elseif isCursorOnElement(651, 390, 102, 31) then 
                    triggerServerEvent("squady.buySlot", resourceRoot, localPlayer)
                    triggerServerEvent("squady.insertGaragem-s", localPlayer)
                    buySlot = false
                end
            end

            if garagem and #garagem > 0 then
                line = 0 
                for i, v in ipairs(garagem) do 
                    if i > client["pag"] and line < 5 then 
                        if v then 
                            line = line + 1
                            local count = (222 + (278 - 222) * line - (278 - 222))
                        
                            if isCursorOnElement(25, (218 + (273 - 218) * line - (273 - 218)), 213, 54) then 
                                selectVehicleGarage = i
                                selectVehicleGarageInfos = {
                                    id = v[1];
                                    state = v[3];
                                    motor = v[4];
                                    gasolina = v[5];
                                }
                            end
                        end
                    end
                end
            end

            if isCursorOnElement(1147, 451, 207, 34) then
                local pos = {getElementPosition(localPlayer)}
                if selectVehicleGarage then 
                    if selectVehicleGarageInfos["state"] == "guardado" or selectVehicleGarageInfos["state"] == "recuperar" then
                        triggerServerEvent("squady.spawnVehicle", localPlayer, selectVehicleGarageInfos["id"], {pos[1], pos[2] + 2, pos[3]})
                    elseif selectVehicleGarageInfos["state"] == "spawnado" then
                        triggerServerEvent("squady.saveVehicle", localPlayer, selectVehicleGarageInfos["id"])
                    end
                end
            end
            
        elseif window == "detran" then 
            if cars_detran and #cars_detran > 0 then
                line = 0 
                for i, v in ipairs(cars_detran) do 
                    if i > client["pag"] and line < 5 then 
                        if v then 
                            line = line + 1
                            local count = (222 + (278 - 222) * line - (278 - 222))
                            if isCursorOnElement(25, (218 + (273 - 218) * line - (273 - 218)), 213, 54) then
                                selectVehicleDetran = i
                                selectVehicleDetranInfos = {
                                    id = v[1];
                                    imposts = v[3];                             
                                    state = v[4];
                                    plate = v[5];
                                }
                            end
                        end
                    end
                end
            end

            if isCursorOnElement(1144, 375, 207, 34) then 
                if selectVehicleDetran then 
                    if not recovery and not registration and not payImposts then 
                        recovery = true
                    end
                end

            elseif isCursorOnElement(1144, 418, 207, 34) then 
                if selectVehicleDetran then 
                    if not registration and not recovery and not payImposts then 
                        registration = true
                    end
                end

            elseif isCursorOnElement(1144, 460, 207, 34) then 
                if selectVehicleDetran then 
                    if not payImposts and not recovery and not registration then 
                        payImposts = true
                    end
                end
            end

            if isCursorOnElement(651, 390, 102, 31) then 
                if recovery then 
                    triggerServerEvent("squady.recoverVehicle", localPlayer, localPlayer, selectVehicleDetranInfos["id"])
                    triggerServerEvent("squady.insertDetran-s", localPlayer)
                    recovery = false
                end
            elseif isCursorOnElement(760, 390, 102, 31) then
                if recovery then 
                    recovery = false
                end
            end

            if isCursorOnElement(651, 390, 102, 31) then 
                if registration then 
                    triggerServerEvent("squady.licenseVehicle", localPlayer, localPlayer, selectVehicleDetranInfos["id"])
                    triggerServerEvent("squady.insertDetran-s", localPlayer)
                    registration = false
                end
            elseif isCursorOnElement(760, 390, 102, 31) then
                if registration then 
                    registration = false
                end
            end
            
            if isCursorOnElement(651, 390, 102, 31) then 
                if payImposts then 
                    triggerServerEvent("squady.payImpost", localPlayer, localPlayer, selectVehicleDetranInfos["id"])
                    triggerServerEvent("squady.insertDetran-s", localPlayer)
                    payImposts = false
                end
            elseif isCursorOnElement(760, 390, 102, 31) then
                if payImposts then 
                    payImposts = false
                end
            end            
        end

    elseif client["visible_offer"] and button == "left" and state == "down" then 
        if isCursorOnElement(651, 390, 102, 31) then 
            triggerServerEvent("squady.responseOffer", localPlayer, "aceitar")
            removeEventHandler("onClientRender", getRootElement(), onClientRenderOffer)
            showCursor(false)
            if isTimer(timer_expire) then 
                killTimer(timer_expire)
            end

        elseif isCursorOnElement(760, 390, 102, 31) then 
            triggerServerEvent("squady.responseOffer", localPlayer, "recusar")
            removeEventHandler("onClientRender", getRootElement(), onClientRenderOffer)
            showCursor(false)
            if isTimer(timer_expire) then 
                killTimer(timer_expire)
            end  
        end
    end
end)

addEvent("squady.insertEstoque-c", true)
addEventHandler("squady.insertEstoque-c", getRootElement(), function(table)
    estoques = {}
    for _, v in ipairs(table) do
        estoques[v.model] = v.value  
    end
end)

addEvent("squady.insertGaragem-c", true)
addEventHandler("squady.insertGaragem-c", getRootElement(), function(tabela, slots_)
    garagem = {}
    for i, v in ipairs(tabela) do 
        local info = fromJSON(v.infos)
        local dados = fromJSON(v.dados)
        table.insert(garagem, {v.model, info[1], v.state, dados[1].vida, dados[1].gasolina})
    end
    slots = slots_
end)

addEvent("squady.insertDetran-c", true)
addEventHandler("squady.insertDetran-c", getRootElement(), function(tabela)
    cars_detran = {}
    for i, v in ipairs(tabela) do 
        local info = fromJSON(v.infos)
        table.insert(cars_detran, {v.model, info[1], v.seguro, v.state, v.plate})
    end
end)

function scrollBar(button)
    if client["visible_my_vehicles"] then 
        if isCursorOnElement(523, 244, 330, 196) then 
            if button == "mouse_wheel_up" and client["pag_"] > 0 then
                client["pag_"] = client["pag_"] - 1
            elseif button == "mouse_wheel_down" and (#garagem - 5 > 0) then
                client["pag_"] = client["pag_"] + 1
                if client["pag_"] > #garagem - 5 then
                    client["pag_"] = #garagem - 5
                end
            end
        end
    elseif client["visible"] then
		if window == "dealership" then
			if isCursorOnElement(262, 589, 842, 144) then
				if button == "mouse_wheel_up" and client["pag"] > 0 then
					client["pag"] = client["pag"] - 1
				elseif button == "mouse_wheel_down" and (#categoryVehicles - client["max"] > 0) then
					client["pag"] = client["pag"] + 1
					if client["pag"] > #categoryVehicles - client["max"] then
						client["pag"] = #categoryVehicles - client["max"]
					end
				end
            elseif isCursorOnElement(25, 215, 213, 228) then
                if button == "mouse_wheel_up" and client["pag_categorys"] > 0 then
                    client["pag_categorys"] = client["pag_categorys"] - 1
                elseif button == "mouse_wheel_down" and (#config["categorys"] - 4 > 0) then
                    client["pag_categorys"] = client["pag_categorys"] + 1
                    if client["pag_categorys"] > #config["categorys"] - 4 then
                        client["pag_categorys"] = #config["categorys"] - 4
                    end
                end
			end
        elseif window == "garage" then 
            if isCursorOnElement(25, 211, 213, 295) then 
                if button == "mouse_wheel_up" and client["pag"] > 0 then
                    client["pag"] = client["pag"] - 1
                elseif button == "mouse_wheel_down" and (#garagem - 5 > 0) then
                    client["pag"] = client["pag"] + 1
                    if client["pag"] > #garagem - 5 then
                        client["pag"] = #garagem - 5
                    end
                end
            end
        elseif window == "detran" then 
            if isCursorOnElement(25, 211, 213, 295) then 
                if button == "mouse_wheel_up" and client["pag"] > 0 then
                    client["pag"] = client["pag"] - 1
                elseif button == "mouse_wheel_down" and (#cars_detran - 5 > 0) then
                    client["pag"] = client["pag"] + 1
                    if client["pag"] > #cars_detran - 5 then
                        client["pag"] = #cars_detran - 5
                    end
                end
            end
        end
    end
end
bindKey("mouse_wheel_up", "down", scrollBar)
bindKey("mouse_wheel_down", "down", scrollBar)