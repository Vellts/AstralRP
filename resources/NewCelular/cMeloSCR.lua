--[[
███╗░░░███╗███████╗██╗░░░░░░█████╗░  ░██████╗░█████╗░██████╗░
████╗░████║██╔════╝██║░░░░░██╔══██╗  ██╔════╝██╔══██╗██╔══██╗
██╔████╔██║█████╗░░██║░░░░░██║░░██║  ╚█████╗░██║░░╚═╝██████╔╝
██║╚██╔╝██║██╔══╝░░██║░░░░░██║░░██║  ░╚═══██╗██║░░██╗██╔══██╗
██║░╚═╝░██║███████╗███████╗╚█████╔╝  ██████╔╝╚█████╔╝██║░░██║
╚═╝░░░░░╚═╝╚══════╝╚══════╝░╚════╝░  ╚═════╝░░╚════╝░╚═╝░░╚═╝
]]

screenW, screenH = guiGetScreenSize()
local x, y = (screenW / 1366), (screenH / 768)
local edits = {}

renderTarget = dxCreateRenderTarget(x * 247, y * 534, true)
lastResultsCrash = {}
lastResultsDouble = {}

local proximaPagina = 0
local posY = 0
local maxY = {}
local tableLogBanco = {}
local animNumero = {}
local tableCategorias = {}
local tableContatos = {}
local tickAnimacao = {}
local tableVehicles = {}
local Texturas = {}
local imagemSpotifyCount = {}
local TexturasTwo = {}
local LocAtiva = {}

local calculoRender = {1085, 181}

local fonts = {
    [1] = dxCreateFont("files/Fontes/Roboto-Medium.ttf", x * 40, false, "cleartype"),
    [2] = dxCreateFont("files/Fontes/Roboto-Medium.ttf", x * 11, false, "cleartype"),
    [3] = dxCreateFont("files/Fontes/Inter-ExtraBold.ttf", x * 7, false, "cleartype"),
    [4] = dxCreateFont("files/Fontes/Roboto-Regular.ttf", x * 7, false, "cleartype"),
    [5] = dxCreateFont("files/Fontes/Roboto-Black.ttf", x * 15, false, "cleartype"),
    [6] = dxCreateFont("files/Fontes/Inter-Medium.ttf", x * 7, false, "cleartype"),
    [7] = dxCreateFont("files/Fontes/Roboto-Black.ttf", x * 13, false, "cleartype"),
    [8] = dxCreateFont("files/Fontes/Roboto-Medium.ttf", x * 9, false, "cleartype"),
    [9] = dxCreateFont("files/Fontes/Roboto-Regular.ttf", x * 17, false, "cleartype"),
    [10] = dxCreateFont("files/Fontes/Roboto-Regular.ttf", x * 30, false, "cleartype"),
    [11] = dxCreateFont("files/Fontes/Roboto-Bold.ttf", x * 17, false, "cleartype"),
    [12] = dxCreateFont("files/Fontes/Roboto-Regular.ttf", x * 10, false, "cleartype"),
    [13] = dxCreateFont("files/Fontes/Inter-Medium.ttf", x * 10, false, "cleartype"),
    [14] = dxCreateFont("files/Fontes/Inter-Light.ttf", x * 8, false, "cleartype"),
    [15] = dxCreateFont("files/Fontes/Roboto-Bold.ttf", x * 14, false, "cleartype"),
    [16] = dxCreateFont("files/Fontes/Roboto-Bold.ttf", x * 7, false, "cleartype"),
    [17] = dxCreateFont("files/Fontes/Inter-Bold.ttf", x * 9, false, "cleartype"),
    [18] = dxCreateFont("files/Fontes/Inter-Regular.ttf", x * 9, false, "cleartype"),
    [19] = dxCreateFont("files/Fontes/Inter-Black.ttf", x * 14, false, "cleartype"),
    [20] = dxCreateFont("files/Fontes/Inter-Black.ttf", x * 13, false, "cleartype"),
    [21] = dxCreateFont("files/Fontes/Roboto-Medium.ttf", x * 25, false, "cleartype"),
    [22] = dxCreateFont("files/Fontes/Inter-Black.ttf", x * 12, false, "cleartype"),
    [23] = dxCreateFont("files/Fontes/Inter-Bold.ttf", x * 8, false, "cleartype"),
    [24] = dxCreateFont("files/Fontes/Inter-Black.ttf", x * 8, false, "cleartype"),
    [25] = dxCreateFont("files/Fontes/Roboto-Medium.ttf", x * 7, false, "cleartype"),
    [26] = dxCreateFont("files/Fontes/Inter-Light.ttf", x * 9, false, "cleartype"),
    [27] = dxCreateFont("files/Fontes/Inter-ExtraBold.ttf", x * 13, false, "cleartype"),
    [28] = dxCreateFont("files/Fontes/Inter-ExtraBold.ttf", x * 9, false, "cleartype"),
    [29] = dxCreateFont("files/Fontes/Roboto-Bold.ttf", x * 9, false, "cleartype"),
    [30] = dxCreateFont("files/Fontes/Roboto-Regular.ttf", x * 8, false, "cleartype"),
    [31] = dxCreateFont("files/Fontes/Inter-ExtraBold.ttf", x * 8, false, "cleartype"),
    [32] = dxCreateFont("files/Fontes/Inter-SemiBold.ttf", x * 17, false, "cleartype"),
    [33] = dxCreateFont("files/Fontes/Inter-Regular.ttf", x * 12, false, "cleartype"),
    [34] = dxCreateFont("files/Fontes/Inter-Regular.ttf", x * 7, false, "cleartype"),
    [35] = dxCreateFont("files/Fontes/Inter-Bold.ttf", x * 7, false, "cleartype"),
    [36] = dxCreateFont("files/Fontes/Inter-Bold.ttf", x * 13, false, "cleartype"),
    [37] = dxCreateFont("files/Fontes/Hacker-Argot.ttf", x * 11, false, "cleartype"),
    [38] = dxCreateFont("files/Fontes/Inter-Black.ttf", x * 10, false, "cleartype"),
    [39] = dxCreateFont("files/Fontes/Inter-Light.ttf", x * 6, false, "cleartype"),
    [40] = dxCreateFont("files/Fontes/Roboto-Bold.ttf", x * 10, false, "cleartype"),
    [41] = dxCreateFont("files/Fontes/Roboto-Regular.ttf", x * 14, false, "cleartype"),
    [42] = dxCreateFont("files/Fontes/Roboto-Regular.ttf", x * 12, false, "cleartype"),
    [43] = dxCreateFont("files/Fontes/Roboto-Black.ttf", x * 10, false, "cleartype"),
    [44] = dxCreateFont("files/Fontes/Roboto-Black.ttf", x * 9, false, "cleartype"),
}

local posIconesHome = {
    {32 , y * 229, x * 46, y * 46},
    {89 , y * 229, x * 46, y * 46},
    {146, y * 229, x * 46, y * 46},
    {203, y * 229, x * 46, y * 46},

    {32, y * 286, x * 46, y * 46},
    {89, y * 286, x * 46, y * 46},
    {146, y * 286, x * 46, y * 46},
    {203, y * 286, x * 46, y * 46},

    {32, y * 342, x * 46, y * 46},
    {89, y * 342, x * 46, y * 46},
    {146, y * 342, x * 46, y * 46},
    {203, y * 342, x * 46, y * 46},

    {32, y * 400, x * 46, y * 46},
    {89, y * 400, x * 46, y * 46},
    {146, y * 400, x * 46, y * 46},
    {203, y * 400, x * 46, y * 46},

    {32, y * 456, x * 46, y * 46},
    {89, y * 456, x * 46, y * 46},
    {146, y * 456, x * 46, y * 46},
    {203, y * 456, x * 46, y * 46},

    {32, y * 512, x * 46, y * 46},
    {89, y * 512, x * 46, y * 46},
    {146, y * 512, x * 46, y * 46},
    {203, y * 512, x * 46, y * 46},

    {32, y * 568, x * 46, y * 46},
    {89, y * 568, x * 46, y * 46},
    {146, y * 568, x * 46, y * 46},
    {203, y * 568, x * 46, y * 46},
}

local posIconesFavoritosHome = {
    {34, y * 660, x * 42, y * 42},
    {91, y * 660, x * 42, y * 42},
    {148, y * 660, x * 42, y * 42},
    {205, y * 660, x * 42, y * 42},
}

local botoesCalculadora = {
    {27, y * 394, x * 49, y * 49, "files/Calculadora/botao.png", 0, 0, 0, tocolor(176, 176, 176), "AC", number = false, tipoAnim = "Dígito"},
    {87, y * 394, x * 49, y * 49, "files/Calculadora/botao.png", 0, 0, 0, tocolor(176, 176, 176), "+/-", number = false, tipoAnim = "Dígito"},
    {147, y * 394, x * 49, y * 49, "files/Calculadora/botao.png", 0, 0, 0, tocolor(176, 176, 176), "%", number = false, tipoAnim = "Dígito"},
    {207, y * 394, x * 49, y * 49, "files/Calculadora/botao.png", 0, 0, 0, tocolor(132, 47, 172), "/", number = false, tipoAnim = "Especial"},

    {27, y * 449, x * 49, y * 49, "files/Calculadora/botao.png", 0, 0, 0, tocolor(43, 43, 43), "7", number = true, tipoAnim = "Dígito"},
    {87, y * 449, x * 49, y * 49, "files/Calculadora/botao.png", 0, 0, 0, tocolor(43, 43, 43), "8", number = true, tipoAnim = "Dígito"},
    {147, y * 449, x * 49, y * 49, "files/Calculadora/botao.png", 0, 0, 0, tocolor(43, 43, 43), "9", number = true, tipoAnim = "Dígito"},
    {207, y * 449, x * 49, y * 49, "files/Calculadora/botao.png", 0, 0, 0, tocolor(132, 47, 172), "x", number = false, tipoAnim = "Especial"},

    {27, y * 505, x * 49, y * 49, "files/Calculadora/botao.png", 0, 0, 0, tocolor(43, 43, 43), "4", number = true, tipoAnim = "Dígito"},
    {87, y * 505, x * 49, y * 49, "files/Calculadora/botao.png", 0, 0, 0, tocolor(43, 43, 43), "5", number = true, tipoAnim = "Dígito"},
    {147, y * 505, x * 49, y * 49, "files/Calculadora/botao.png", 0, 0, 0, tocolor(43, 43, 43), "6", number = true, tipoAnim = "Dígito"},
    {207, y * 505, x * 49, y * 49, "files/Calculadora/botao.png", 0, 0, 0, tocolor(132, 47, 172), "-", number = false, tipoAnim = "Especial"},

    {27, y * 560, x * 49, y * 49, "files/Calculadora/botao.png", 0, 0, 0, tocolor(43, 43, 43), "1", number = true, tipoAnim = "Dígito"},
    {87, y * 560, x * 49, y * 49, "files/Calculadora/botao.png", 0, 0, 0, tocolor(43, 43, 43), "2", number = true, tipoAnim = "Dígito"},
    {147, y * 560, x * 49, y * 49, "files/Calculadora/botao.png", 0, 0, 0, tocolor(43, 43, 43), "3", number = true, tipoAnim = "Dígito"},
    {207, y * 560, x * 49, y * 49, "files/Calculadora/botao.png", 0, 0, 0, tocolor(132, 47, 172), "+", number = false, tipoAnim = "Especial"},

    {27, y * 622, x * 108, y * 38, "files/Calculadora/botao2.png", 0, 0, 0,  tocolor(43, 43, 43), "0", number = true, tipoAnim = "Dígito"},
    {147, y * 622, x * 49, y * 49, "files/Calculadora/botao.png", 0, 0, 0, tocolor(43, 43, 43), ".", number = true, tipoAnim = "Dígito"},
    {207, y * 622, x * 49, y * 49, "files/Calculadora/botao.png", 0, 0, 0, tocolor(132, 47, 172), "=", number = false, tipoAnim = "Especial"},
}

local botoesTelefone = {
    {x * 1109, y * 336, x * 55, y * 55, "1"},
    {x * 1180, y * 336, x * 55, y * 55, "2"},
    {x * 1250, y * 336, x * 55, y * 55, "3"},

    {x * 1109, y * 406, x * 55, y * 55, "4"},
    {x * 1180, y * 406, x * 55, y * 55, "5"},
    {x * 1250, y * 406, x * 55, y * 55, "6"},

    {x * 1109, y * 476, x * 55, y * 55, "7"},
    {x * 1180, y * 476, x * 55, y * 55, "8"},
    {x * 1250, y * 476, x * 55, y * 55, "9"},

    {x * 1109, y * 546, x * 55, y * 55, "*"},
    {x * 1180, y * 546, x * 55, y * 55, "0"},
    {x * 1250, y * 546, x * 55, y * 55, "#"},

}

local animacoesConfig = {
    ["Ligações Desconhecidas"] = true, 
    ["Mensagens Desconhecidas"] = true,
    ["Ligações"] = true,
    ["Mensagens"] = true,
}

local posML = {
    {x * 1093, y * 609, x * 14, y * 13, "Imóvel"},
    {x * 1093, y * 629, x * 14, y * 13, "Item"},
    {x * 1093, y * 649, x * 14, y * 13, "Acessório"},
    {x * 1243, y * 609, x * 14, y * 13, "Veículo"},
    {x * 1243, y * 629, x * 14, y * 13, "Outro"},
}

function dxDraw()
    if voltando then 
        posCel = interpolateBetween(1066, 0, 0, 1366, 0, 0, (getTickCount() - tick) / 500, "Linear")
    else 
        posCel = interpolateBetween(1366, 0, 0, 1066, 0, 0, (getTickCount() - tick) / 500, "Linear")
    end 
    if Aba == "Bloqueio" then 
        if not theWallpaper then 
            dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, "files/Wallpaper/1.png")
        else 
            dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, theWallpaper)
        end 
        dxDrawImage(x * posCel, y * 165, x * 282, y * 566, "files/base.png")
        dxDrawImage(x * (posCel+217), y * 186, x * 34, y * 8, "files/infos.png")
        local time = getRealTime()
        if time.monthday < 10 then time.monthday = "0"..time.monthday end 
        local formattedTime = ((time.hour < 10 and "0"..(time.hour) or time.hour)..":"..(time.minute < 10 and "0"..(time.minute) or time.minute))
        dxDrawText(formattedTime, x * (65 + posCel), y * 256, x * 153, y * 71, tocolor(255, 255, 255), 1, fonts[1])
        dxDrawText(gWeekDays[(time.weekday)+1]..", "..time.monthday.." de "..gMonthNames[(time.month)+1], x * (64 + posCel), (y * 248)+dxGetFontHeight(1, fonts[1]), x * 153, y * 71, tocolor(255, 255, 255), 1, fonts[2])
        if isMouseInPosition(x * (117 + posCel), y * 622, x * 48, y * 48) then 
            dxDrawImage(x * (117 + posCel), y * 622, x * 48, y * 48, "files/LockScreen/digital.png", 0, 0, 0, tocolor(173, 0, 255))
        else 
            dxDrawImage(x * (117 + posCel), y * 622, x * 48, y * 48, "files/LockScreen/digital.png")
        end 
        
        for i,v in ipairs(tabelaNotificacoes) do 
            if #v == 3 then 
                local timeNotification = getRealTime(v[3])
                local formatTimeNotification = ((timeNotification.hour < 10 and "0"..(timeNotification.hour) or timeNotification.hour)..":"..(timeNotification.minute < 10 and "0"..(timeNotification.minute) or timeNotification.minute))
                dxDrawImage(x * (posCel + 21), y * (303 + i * 47), x * 240, y * 50, "files/LockScreen/notify.png")
                if isMouseInPosition(x * (posCel + 21), y * (303 + i * 47), x * 240, y * 50) then 
                    dxDrawImage(x * (posCel + 21), y * (303 + i * 47), x * 240, y * 50, "files/LockScreen/notify.png")
                end 
                dxDrawImage(x * (posCel + 31), y * (315 + i * 47), x * 28, y * 28, v[1])
                dxDrawText(v[2], x * (posCel + 64), y * (315 + i * 47), x * (posCel + 246), y * (342 + i * 47), tocolor(255, 255, 255, 255), 1.00, fonts[6], "left", "top", true, true, false, false, false)
                dxDrawText(formatTimeNotification, x * (posCel + 231), y * (309 + i * 47), x * (posCel + 246), y * (342 + i * 47), tocolor(255, 255, 255, 255), 1.00, fonts[39], "left", "top")
            elseif #v == 4 then 
                local timeNotification = getRealTime(v[3])
                local formatTimeNotification = ((timeNotification.hour < 10 and "0"..(timeNotification.hour) or timeNotification.hour)..":"..(timeNotification.minute < 10 and "0"..(timeNotification.minute) or timeNotification.minute))
                dxDrawImage(x * (posCel + 21), y * (303 + i * 47), x * 240, y * 50, "files/LockScreen/notify.png")
                if isMouseInPosition(x * (posCel + 21), y * (303 + i * 47), x * 240, y * 50) then 
                    dxDrawImage(x * (posCel + 21), y * (303 + i * 47), x * 240, y * 50, "files/LockScreen/notify.png")
                end 
                dxDrawImage(x * (posCel + 31), y * (315 + i * 47), x * 28, y * 28, v[1])
                dxDrawText(v[2], x * (posCel + 64), y * (315 + i * 47), x * (posCel + 246), y * (342 + i * 47), tocolor(255, 255, 255, 255), 1.00, fonts[31], "left", "top", true, true, false, false, false)
                dxDrawText(v[4], x * (posCel + 64), y * (330 + i * 47), x * (posCel + 246), y * (342 + i * 47), tocolor(255, 255, 255, 255), 1.00, fonts[6], "left", "top", true, true, false, false, false)
                dxDrawText(formatTimeNotification, x * (posCel + 231), y * (309 + i * 47), x * (posCel + 246), y * (342 + i * 47), tocolor(255, 255, 255, 255), 1.00, fonts[39], "left", "top")
            end 
        end
        if #tabelaNotificacoes > 0 then 
            dxDrawRectangle(x * (41 + posCel), y * 508, x * 200, y * 1, tocolor(255, 255, 255, 100))    
        end 
    elseif Aba == "Home" then 
        if not theWallpaper then 
            dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, "files/Wallpaper/1.png")
        else 
            dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, theWallpaper)
        end 
        dxDrawRoundedRectangle(x * (posCel+14), y * 645, x * 252, y * 77, tocolor(255, 255, 255, 48), 5)
        dxDrawImage(x * posCel, y * 165, x * 282, y * 566, "files/base.png")
        dxDrawImage(x * (posCel+217), y * 186, x * 34, y * 8, "files/infos.png")
        local time = getRealTime()
        local formattedTime = ((time.hour < 10 and "0"..(time.hour) or time.hour)..":"..(time.minute < 10 and "0"..(time.minute) or time.minute))
        dxDrawText(formattedTime, x * (34 + posCel), y * 184, x * 153, y * 71, tocolor(255, 255, 255), 1, fonts[3])
        for i,v in ipairs(tabelaApps) do 
            if v.Baixado and v.Slot and v.Slot <= 28 then 
                if appSelected == i then 
                    if isCursorShowing() then
                        local cx, cy = getCursorPosition()
                        local mx, my = cx * screenW, cy * screenH
                        dxDrawImage(mx-25, my-25, posIconesHome[v.Slot][3], posIconesHome[v.Slot][4], v["2"], 0, 0, 0, tocolor(255, 255, 255, 255), true)
                    end
                else 
                    if isMouseInPosition(x * (posCel+posIconesHome[v.Slot][1]), posIconesHome[v.Slot][2], posIconesHome[v.Slot][3], posIconesHome[v.Slot][4]) then 
                        dxDrawImage(x * (posCel+posIconesHome[v.Slot][1])-1, posIconesHome[v.Slot][2]-1, posIconesHome[v.Slot][3]+2, posIconesHome[v.Slot][4]+2, v["2"])
                    else 
                        dxDrawImage(x * (posCel+posIconesHome[v.Slot][1]), posIconesHome[v.Slot][2], posIconesHome[v.Slot][3], posIconesHome[v.Slot][4], v["2"])
                    end 
                end 
            end 
            if v.Favorito then 
                if appSelected == i then 
                    if isCursorShowing() then
                        local cx, cy = getCursorPosition()
                        local mx, my = cx * screenW, cy * screenH
                        dxDrawImage(mx-25, my-25, posIconesFavoritosHome[v.Favorito][3], posIconesFavoritosHome[v.Favorito][4], v["2"], 0, 0, 0, tocolor(255, 255, 255, 255), true)
                    end
                else 
                    if isMouseInPosition(x * (posCel+posIconesFavoritosHome[v.Favorito][1]), posIconesFavoritosHome[v.Favorito][2], posIconesFavoritosHome[v.Favorito][3], posIconesFavoritosHome[v.Favorito][4]) then 
                        dxDrawImage(x * (posCel+posIconesFavoritosHome[v.Favorito][1])-1, posIconesFavoritosHome[v.Favorito][2]-1, posIconesFavoritosHome[v.Favorito][3]+2, posIconesFavoritosHome[v.Favorito][4]+2, v["2"])
                    else 
                        dxDrawImage(x * (posCel+posIconesFavoritosHome[v.Favorito][1]), posIconesFavoritosHome[v.Favorito][2], posIconesFavoritosHome[v.Favorito][3], posIconesFavoritosHome[v.Favorito][4], v["2"])
                    end 
                end 
            end 
        end
    elseif Aba == "Appstore" then 
        if not theWallpaper then 
            dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, "files/Wallpaper/1.png")
        else 
            dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, theWallpaper)
        end 
        dxDrawRectangle(x * (posCel+17), y * 181, x * 247, y * 534, tocolor(239, 239, 239))
        
        dxSetRenderTarget(renderTarget, true)
        dxSetBlendMode("modulate_add")  -- Set 'modulate_add' when drawing stuff on the render target

        local time = getRealTime()
        local formattedTime = ((time.hour < 10 and "0"..(time.hour) or time.hour)..":"..(time.minute < 10 and "0"..(time.minute) or time.minute))
        if time.monthday < 10 then time.monthday = "0"..time.monthday end 
        dxDrawText(string.upper(gWeekDays[(time.weekday)+1]..", "..time.monthday.." de "..gMonthNames[(time.month)+1]), x * (1093 - calculoRender[1]), (y * (213 - calculoRender[2])- posY), x * 153, y * 71, tocolor(0, 0, 0), 1, fonts[4])
        dxDrawText("Hoje", x * (1093 - calculoRender[1]), y * (230 - calculoRender[2])- posY, x * 153, y * 71, tocolor(0, 0, 0), 1, fonts[5])
        dxDrawImage(x * ((1093 - calculoRender[1])), y * (261 - calculoRender[2])- posY, x * 229, y * 278, "files/Appstore/destaque.png")
        dxDrawRoundedRectangle(x * (1097 - calculoRender[1]), y * (550 - calculoRender[2]) - posY, x * 225, y * (48 + (totalApps * 50)), tocolor(255, 255, 255), 10)
        dxDrawText("NOSSOS FAVORITOS", x * (1105 - calculoRender[1]), y * (561 - calculoRender[2]) - posY, x * 0, y * 0, tocolor(138, 138, 141), 1, fonts[6])
        dxDrawText("Top apps do mês", x * (1105 - calculoRender[1]), y * (575 - calculoRender[2]) - posY, x * 0, y * 0, tocolor(0, 0, 0), 1, fonts[7])
        local linha = 0
        for i,v in ipairs(tabelaApps) do 
            linha = linha + 1
            dxDrawImage(x * (1105 - calculoRender[1]), y * ((560 + linha * 46) - calculoRender[2]) - posY, x * 30, y * 30, v["2"])
            dxDrawText(v["1"], x * (1139 - calculoRender[1]), y * ((560 + linha * 46) - calculoRender[2]) - posY, x * 0, y * 0, tocolor(0, 0, 0), 1, fonts[8])
            dxDrawText(v["3"], x * (1139 - calculoRender[1]), y * ((573 + linha * 46) - calculoRender[2]) - posY, x * 0, y * 0, tocolor(129, 129, 129), 1, fonts[4])
            dxDrawRectangle(x * (1106 - calculoRender[1]), y * ((600 + linha * 46) - calculoRender[2]) - posY, x * 207, y * 1, tocolor(217, 217, 217))
            if v.Baixado then 
                dxDrawRoundedRectangle(x * (1285 - calculoRender[1]), y * ((565 + linha * 46) - calculoRender[2]) - posY, x * 20, y * 20, tocolor(217, 217, 217), 10)
                dxDrawImage(x * (1289 - calculoRender[1]), y * ((569 + linha * 46) - calculoRender[2]) - posY, x * 11, y * 12, "files/Appstore/lixeira.png")
            else 
                if animBaixando and appBaixando == i then 
                    local progresso = interpolateBetween(0, 0, 0, 100, 0, 0, (getTickCount() - tickAnim) / 5000, "Linear")
                    dxDrawRoundedRectangle(x * (1285 - calculoRender[1]), y * ((565 + linha * 46) - calculoRender[2]) - posY, x * 20, y * 20, tocolor(217, 217, 217), 10)
                    dxDrawImage(x * (1289 - calculoRender[1]), y * ((569 + linha * 46) - calculoRender[2]) - posY, x * 11, y * 12, "files/Appstore/x.png")
                    hou_circle(x * (1294 - calculoRender[1]), y * ((575 + linha * 46) - calculoRender[2]) - posY, x * 22, y * 22,      tocolor(2, 117, 255, 255), 0, 360 *  (progresso / 100),3)
                else 
                    dxDrawImage(x * (1265 - calculoRender[1]), y * ((569 + linha * 46) - calculoRender[2]) - posY, x * 49, y * 18, "files/Appstore/baixar.png")
                end 
            end 
        end 

        dxSetBlendMode("blend")  -- Restore default blending
        dxSetRenderTarget()      -- Restore default render target
        
        dxDrawImage(x * (posCel + 17) , y * 181, x * 247, y * 534, renderTarget)
        --dxDrawRectangle(x * (posCel + 19), y * 179, x * 244, y * 20, tocolor(285, 285, 285))
        dxDrawText(formattedTime, x * (34 + posCel), y * 184, x * 153, y * 71, tocolor(0, 0, 0), 1, fonts[3])
        dxDrawImage(x * (posCel), y * 165, x * 282, y * 566, "files/base.png")
        dxDrawImage(x * (posCel+217), y * 186, x * 34, y * 8, "files/infos.png", 0, 0, 0, tocolor(0, 0, 0))
        if isMouseInPosition(x * (posCel+86), y * 701, x * 111, y * 5) then 
            dxDrawRoundedRectangle(x * (posCel+86)-1, y * 701-1, x * 111+1, y * 5+1, tocolor(32, 32, 32), 2)
        else 
            dxDrawRoundedRectangle(x * (posCel+86), y * 701, x * 111, y * 5, tocolor(32, 32, 32), 2)
        end 
    elseif Aba == "Calculadora" then 
        if not theWallpaper then 
            dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, "files/Wallpaper/1.png")
        else 
            dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, theWallpaper)
        end 
        dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, "files/Calculadora/base.png")

        for i,v in ipairs(botoesCalculadora) do 
            if animNumero[i] then 
                anim = interpolateBetween(255, 0, 0, 0, 0, 0, (getTickCount() - tickAnimacao[i]) / 800, "Linear")
                dxDrawImage(x * (posCel+v[1]), v[2], v[3], v[4], v[5], v[6], v[7], v[8], v[9])
                dxDrawImage(x * (posCel+v[1]), v[2], v[3], v[4], v[5], v[6], v[7], v[8], tocolor(255, 255, 255, anim))
                if typeAnim == "Dígito" then 
                    if string.len(v[10]) == 1 then 
                        if v[10] == "0" then 
                            dxDrawText(v[10], x * (posCel+(v[1]+18)), (y * 5) + v[2], v[3], v[4], tocolor(255, 255, 255), 1, fonts[9])
                        else 
                            dxDrawText(v[10], x * (posCel+(v[1]+18)), (y * 10) + v[2], v[3], v[4], tocolor(255, 255, 255), 1, fonts[9])
                        end 
                    else 
                        dxDrawText(v[10], x * (posCel+(v[1]+8)), (y * 10) + v[2], v[3], v[4], tocolor(255, 255, 255), 1, fonts[9])
                    end 
                elseif typeAnim == "Especial" then 
                    if string.len(v[10]) == 1 then 
                        
                        dxDrawText(v[10], x * (posCel+(v[1]+18)), (y * 10) + v[2], v[3], v[4], tocolor(132, 47, 172), 1, fonts[9])
                    else 
                        dxDrawText(v[10], x * (posCel+(v[1]+8)), (y * 10) + v[2], v[3], v[4], tocolor(132, 47, 172), 1, fonts[9])
                    end 
                end 
            else 
                dxDrawImage(x * (posCel+v[1]), v[2], v[3], v[4], v[5], v[6], v[7], v[8], v[9])
                if string.len(v[10]) == 1 then 
                    if v[10] == "0" then 
                        dxDrawText(v[10], x * (posCel+(v[1]+18)), (y * 5) + v[2], v[3], v[4], tocolor(255, 255, 255), 1, fonts[9])
                    else 
                        dxDrawText(v[10], x * (posCel+(v[1]+18)), (y * 10) + v[2], v[3], v[4], tocolor(255, 255, 255), 1, fonts[9])
                    end 
                else 
                    dxDrawText(v[10], x * (posCel+(v[1]+8)), (y * 10) + v[2], v[3], v[4], tocolor(255, 255, 255), 1, fonts[9])
                end 
            end 
        end 
        dxDrawText(formatNumber((string.len(numeroCalculadora) > 7 and string.sub(numeroCalculadora, 1, 7) or numeroCalculadora)), x * 1085, y * 290, x * 1328, y * 353, tocolor(255, 255, 255, 255), 1.00, fonts[10], "right", "center")
        local time = getRealTime()
        local formattedTime = ((time.hour < 10 and "0"..(time.hour) or time.hour)..":"..(time.minute < 10 and "0"..(time.minute) or time.minute))
        dxDrawText(formattedTime, x * (34 + posCel), y * 184, x * 153, y * 71, tocolor(255, 255, 255), 1, fonts[3])
        dxDrawImage(x * (posCel), y * 165, x * 282, y * 566, "files/base.png")
        dxDrawImage(x * (posCel+217), y * 186, x * 34, y * 8, "files/infos.png")
        if isMouseInPosition(x * (posCel+86), y * 701, x * 111, y * 5) then 
            dxDrawRoundedRectangle(x * (posCel+86)-1, y * 701-1, x * 111+1, y * 5+1, tocolor(32, 32, 32), 2)
        else 
            dxDrawRoundedRectangle(x * (posCel+86), y * 701, x * 111, y * 5, tocolor(32, 32, 32), 2)
        end 
        if textoCopiado then 
            alpha = interpolateBetween(255, 0, 0, 0, 0, 0, (getTickCount() - tickTexto) / 5000, "Linear")
            dxDrawText("Número copiado com sucesso!", x * 1083, y * 257, x * 1329, y * 288, tocolor(139, 0, 255, alpha), 1.00, fonts[2], "center", "center")
        end
    elseif Aba == "Câmera" then  
        if not theWallpaper then 
            dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, "files/Wallpaper/1.png")
        else 
            dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, theWallpaper)
        end 
        dxDrawRectangle(x * (posCel+18), y * 180, x * 246, y * 535, tocolor(0, 0, 0))
        dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, "files/Camera/base.png")
        
        if myScreenSource then
            dxUpdateScreenSource(myScreenSource)   
            dxDrawImageSection(x * (posCel+18), y * 234, x * 246, y * 363, x * (posCel+18), y * (234/2), x * 130, y * 363, myScreenSource)
        end

        if animacaoFoto then 
            animFoto, animFoto2 = interpolateBetween(0, 0, 0, 1, 2, 0, (getTickCount() - tickAnim) / 800, "SineCurve") 
            animCamera = interpolateBetween(255, 0, 0, 0, 0, 0, (getTickCount() - tickAnim) / 800, "Linear") 
            dxDrawImage(x * (posCel+116)+animFoto, y * 631+animFoto, x * 50-animFoto2, y * 50-animFoto2, "files/Camera/botao_camera_dentro.png")
            dxDrawRectangle(x * (posCel+18), y * 234, x * 246, y * 363, tocolor(0, 0, 0, animCamera))
        else 
            dxDrawImage(x * (posCel+116), y * 631, x * 50, y * 50, "files/Camera/botao_camera_dentro.png")
        end 
        dxDrawImage(x * (posCel+112), y * 627, x * 58, y * 58, "files/Camera/botao_camera_fora.png")
        dxDrawImage(x * (posCel+221), y * 641, x * 29, y * 29, "files/Camera/botao_virar.png")

        if photosRecente and #photosRecente >= 1 then
            dxDrawImage(x * 1093, y * 638, x * 35, y * 35, photosRecente[1][1])
        else
            dxDrawRectangle(x * 1093, y * 638, x * 35, y * 35, tocolor(196, 196, 196, 255))
        end
        local time = getRealTime()
        local formattedTime = ((time.hour < 10 and "0"..(time.hour) or time.hour)..":"..(time.minute < 10 and "0"..(time.minute) or time.minute))
        dxDrawText(formattedTime, x * (34 + posCel), y * 184, x * 153, y * 71, tocolor(255, 255, 255), 1, fonts[3])
        dxDrawImage(x * (posCel), y * 165, x * 282, y * 566, "files/base.png")
        dxDrawImage(x * (posCel+217), y * 186, x * 34, y * 8, "files/infos.png")
        if isMouseInPosition(x * (posCel+86), y * 701, x * 111, y * 5) then 
            dxDrawRoundedRectangle(x * (posCel+86)-1, y * 701-1, x * 111+1, y * 5+1, tocolor(32, 32, 32), 2)
        else 
            dxDrawRoundedRectangle(x * (posCel+86), y * 701, x * 111, y * 5, tocolor(32, 32, 32), 2)
        end 
    elseif Aba == "Galeria" then  
        if not theWallpaper then 
            dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, "files/Wallpaper/1.png")
        else 
            dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, theWallpaper)
        end 
        dxDrawRectangle(x * (posCel+17), y * 181, x * 247, y * 534, tocolor(239, 239, 239))
        
        dxSetRenderTarget(renderTarget, true)
        dxSetBlendMode("modulate_add")  -- Set 'modulate_add' when drawing stuff on the render target

        local time = getRealTime()
        local formattedTime = ((time.hour < 10 and "0"..(time.hour) or time.hour)..":"..(time.minute < 10 and "0"..(time.minute) or time.minute))
        if time.monthday < 10 then time.monthday = "0"..time.monthday end 
        dxDrawText("Galeria de Fotos", x * (1096 - calculoRender[1]), y * (217 - calculoRender[2])- posY, x * 153, y * 71, tocolor(0, 0, 0), 1, fonts[11])
        dxDrawImage(x * ((1094 - calculoRender[1])), y * (251 - calculoRender[2])- posY, x * 229, y * 2, "files/Galeria/separador.png")
        if #Texturas > 0 then 
            tableOrganizacaoX = {}
            tableOrganizacaoY = {}
            local linha = 0
            for i, v in ipairs(Texturas) do
                linha = linha + 1
                table.insert(tableOrganizacaoX, linha)
                table.insert(tableOrganizacaoY, linha)
                dxDrawImage(x * ((1025 + #tableOrganizacaoX * 75) - calculoRender[1]), y * ((192 + #tableOrganizacaoY * 75) - calculoRender[2]) - posY, x * 64, y * 63, v[1])
                if #tableOrganizacaoX == 3 then
                    tableOrganizacaoX = {}
                else 
                    tableOrganizacaoY[#tableOrganizacaoY] = nil
                end 
            end
        end 

        if #TexturasTwo > #Texturas then
            tableOrganizacaoX2 = {}
            tableOrganizacaoY2 = {}
            local linha = 0
            for i, v in ipairs(TexturasTwo) do
                linha = linha + 1
                table.insert(tableOrganizacaoX2, linha)
                table.insert(tableOrganizacaoY2, linha)
                progress = interpolateBetween(0, 0, 0, 8000, 0, 0, (getTickCount() - tickAnim) / 80000, "Linear")
                dxDrawRectangle(x * ((1025 + #tableOrganizacaoX2 * 75) - calculoRender[1]), y * ((192 + #tableOrganizacaoY2 * 75) - calculoRender[2]), x * 64, y * 63, tocolor(217, 217, 217))
                dxDrawImage(x * ((1032 + #tableOrganizacaoX2 * 75) - calculoRender[1]), y * ((199 + #tableOrganizacaoY2 * 75) - calculoRender[2]), x * 50, y * 50, "files/Galeria/loading.png", progress, 0, 0)
                if #tableOrganizacaoX2 == 3 then
                    tableOrganizacaoX2 = {}
                else 
                    table.remove(tableOrganizacaoY2, #tableOrganizacaoY2)
                end 
            end
        end

        dxSetBlendMode("blend")  -- Restore default blending
        dxSetRenderTarget()      -- Restore default render target
        
        dxDrawImage(x * (posCel + 17) , y * 181, x * 247, y * 534, renderTarget)
        dxDrawText(#TexturasTwo.." de ".."50".." Fotos", x * (95 + posCel), y * 675, x * 153, y * 71, tocolor(2, 117, 255), 1, fonts[12])
        dxDrawText(formattedTime, x * (34 + posCel), y * 184, x * 153, y * 71, tocolor(0, 0, 0), 1, fonts[3])
        dxDrawImage(x * (posCel), y * 165, x * 282, y * 566, "files/base.png")
        
        dxDrawImage(x * (posCel+217), y * 186, x * 34, y * 8, "files/infos.png", 0, 0, 0, tocolor(0,0,0))
        if isMouseInPosition(x * (posCel+86), y * 701, x * 111, y * 5) then 
            dxDrawRoundedRectangle(x * (posCel+86)-1, y * 701-1, x * 111+1, y * 5+1, tocolor(32, 32, 32), 2)
        else 
            dxDrawRoundedRectangle(x * (posCel+86), y * 701, x * 111, y * 5, tocolor(32, 32, 32), 2)
        end 
    elseif Aba == "Ver Foto" then 
        if not theWallpaper then 
            dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, "files/Wallpaper/1.png")
        else 
            dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, theWallpaper)
        end 
        dxDrawRectangle(x * (posCel+18), y * 180, x * 246, y * 535, tocolor(0, 0, 0))
        
        if imageView then 
            dxDrawImageSection(x * (posCel + 18), y * 180, x * 246, y * 542, 65, 520, 150, 480, imageView[1])
        end 
        if isMouseInPosition(x * (posCel + 235), y * 216, x * 16, y * 18) then 
            dxDrawImage(x * (posCel + 235)-1, y * 216-1, x * 16+2, y * 18+2, "files/Galeria/lixeira.png")
        else 
            dxDrawImage(x * (posCel + 235), y * 216, x * 16, y * 18, "files/Galeria/lixeira.png")
        end 
        

        local time = getRealTime()
        local formattedTime = ((time.hour < 10 and "0"..(time.hour) or time.hour)..":"..(time.minute < 10 and "0"..(time.minute) or time.minute))
        dxDrawText(formattedTime, x * (34 + posCel), y * 184, x * 153, y * 71, tocolor(255, 255, 255), 1, fonts[3])
        dxDrawImage(x * (posCel), y * 165, x * 282, y * 566, "files/base.png")
        dxDrawImage(x * (posCel+217), y * 186, x * 34, y * 8, "files/infos.png")
        if isMouseInPosition(x * (posCel+86), y * 701, x * 111, y * 5) then 
            dxDrawRoundedRectangle(x * (posCel+86)-1, y * 701-1, x * 111+1, y * 5+1, tocolor(32, 32, 32), 2)
        else 
            dxDrawRoundedRectangle(x * (posCel+86), y * 701, x * 111, y * 5, tocolor(32, 32, 32), 2)
        end 
        if confirmacaoExcluir then 
            dxDrawRoundedRectangle(x * (posCel + 35), y * 374, x * 212, y * 84, tocolor(255, 255, 255), 10)
            dxDrawText("Tem certeza que deseja excluir esta foto ?", x * (posCel + 35), y * 388, x * (posCel + 246), y * 408, tocolor(0, 0, 0, 255), 1.00, fonts[12], "center", "center", false, true, true, false, false)
            if isMouseInPosition(x * (posCel + 50), y * 432, x * 82, y * 16) then 
                dxDrawImage(x * (posCel + 50), y * 432, x * 82, y * 16, "files/Galeria/botao_selected.png")
            else 
                dxDrawImage(x * (posCel + 50), y * 432, x * 82, y * 16, "files/Galeria/botao_normal.png")
            end 
            if isMouseInPosition(x * (posCel + 150), y * 432, x * 82, y * 16) then 
                dxDrawImage(x * (posCel + 150), y * 432, x * 82, y * 16, "files/Galeria/botao_selected.png")
            else 
                dxDrawImage(x * (posCel + 150), y * 432, x * 82, y * 16, "files/Galeria/botao_normal.png")
            end 
            dxDrawText("Cancelar", x * (posCel + 51), y * 432, x * (posCel + 131), y * 447, tocolor(128, 128, 128, 255), 1.00, fonts[8], "center", "center", false, false, true, false, false)
            dxDrawText("Excluir", x * (posCel + 151), y * 432, x * (posCel + 231), y * 447, tocolor(128, 128, 128, 255), 1.00, fonts[8], "center", "center", false, false, true, false, false)
        end
    elseif Aba == "Banco" then  
        dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, "files/Banco/base.png")
        dxSetRenderTarget(renderTarget, true)
        dxSetBlendMode("modulate_add")  -- Set 'modulate_add' when drawing stuff on the render target

        if escolhendoAlguem then 
            local linha = 0
            local indxTotal = 0
            if voltandoBanco then 
                ycal, ycal2  = interpolateBetween(539, 611, 0, 788, 860, 0, (getTickCount() - tickAnim)/1000, "Linear")
            else 
                ycal, ycal2  = interpolateBetween(788, 860, 0, 539, 611, 0, (getTickCount() - tickAnim)/1000, "Linear")
            end 
            dxDrawRectangle(x * (1086 - calculoRender[1]), y * (180 - calculoRender[2]), x * 246, y * 535, tocolor(0, 0, 0, 76))
            dxDrawImage(x * (1086 - calculoRender[1]), y * (ycal - calculoRender[2]), x * 246, y * 179, "files/Banco/aba_selecionando.png")
            for i,v in ipairs(tableCategorias) do
                if v.NomeCategoria ~= "Emergência" and escolhendoAlguem then 
                    for indx,conteudo in ipairs(tableContatos[v.NomeCategoria]) do
                        indxTotal = indxTotal + 1
                        if indxTotal > proximaPagina and linha < 4 then  
                            linha = linha + 1
                            if isMouseInPosition(x * 1083, y * (582 + linha * 25), x * 245, y * 25) or theSelected == indxTotal  then 
                                dxDrawText((string.len(conteudo.Nome) > 15 and string.sub(conteudo.Nome, 1, 15).."." or conteudo.Nome), x * (1083 - calculoRender[1]), y * ((ycal2 + (linha - 1) * 20) - calculoRender[2]), x * (1329 - calculoRender[1]), y * (((ycal2 + 18) + (linha - 1) * 20) - calculoRender[2]), tocolor(169, 61, 255, 255), 1.00, fonts[18], "center", "center")                
                            else 
                                dxDrawText((string.len(conteudo.Nome) > 15 and string.sub(conteudo.Nome, 1, 15).."." or conteudo.Nome), x * (1083 - calculoRender[1]), y * ((ycal2 + (linha - 1) * 20) - calculoRender[2]), x * (1329 - calculoRender[1]), y * (((ycal2 + 18) + (linha - 1) * 20) - calculoRender[2]), tocolor(255, 255, 255, 255), 1.00, fonts[18], "center", "center")                
                            end 
                        end 
                    end 
                end 
            end 
        end 
        if registrandoPix then 
            if voltandoBanco then 
                ycal, ycal2, ycal3  = interpolateBetween(569, 624, 594, 715, 770, 730, (getTickCount() - tickAnim)/1000, "Linear")
            else 
                ycal, ycal2, ycal3  = interpolateBetween(715, 770, 730, 569, 624, 594, (getTickCount() - tickAnim)/1000, "Linear")
            end 
            dxDrawRectangle(x * ((posCel + 20) - calculoRender[1]), y * (180 - calculoRender[2]), x * 246, y * 535, tocolor(0, 0, 0, 166))
            dxDrawImage(x * (1086 - calculoRender[1]), y * (ycal - calculoRender[2]), x * 246, y * 146, "files/Banco/registrarpix.png")
            dxDrawText(guiGetText(edits[9]), x * (1126 - calculoRender[1]), y * (ycal2 - calculoRender[2]), x * 87, y * 14, tocolor(96, 85, 104), 1, fonts[12])
            dxDrawText(guiGetText(edits[10]), x * (1126 - calculoRender[1]), y * ((ycal2+25) - calculoRender[2]), x * 87, y * 14, tocolor(96, 85, 104), 1, fonts[12])
            dxDrawText("Adicionar", x * (1181 - calculoRender[1]), y * ((ycal + 107) - calculoRender[2]), x * 97, y * 17, tocolor(96, 85, 104), 1, fonts[17])
        end 

        dxSetBlendMode("blend")  -- Restore default blending
        dxSetRenderTarget()      -- Restore default render target
        dxDrawImage(x * (posCel + 17) , y * 181, x * 247, y * 534, renderTarget)
      
        dxDrawText("Olá, "..removeHex(getPlayerName(localPlayer)), x * (29 + posCel), y * 219, x * 153, y * 71, tocolor(255, 255, 255), 1, fonts[13])
        dxDrawText("Bem vindo(a) de volta !", x * (29 + posCel), y * 236, x * 153, y * 71, tocolor(255, 255, 255), 1, fonts[14])
        dxDrawImage(x * 1274, y * 214, x * 42, y * 42, ':characters/files/imgs/avatars/'..(getElementData(localPlayer, 'Avatar') or 0)..'.png')
        if vendoValor then 
            dxDrawImage(x * (posCel + 101), y * 313, x * 23, y * 17, "files/Banco/olho_vendo.png")
            dxDrawText("R$ "..formatNumber((getElementData(localPlayer, "moneybank") or 0)), x * (52 + posCel), y * 288, x * 153, y * 71, tocolor(255, 255, 255), 1, fonts[15])
        else 
            dxDrawImage(x * (posCel + 105), y * 311, x * 15, y * 13, "files/Banco/olho_cego.png")
            dxDrawText("R$ **.***.***", x * (52 + posCel), y * 288, x * 153, y * 71, tocolor(255, 255, 255), 1, fonts[15])
        end 
        
        dxDrawText(removeHex(getPlayerName(localPlayer)), x * (52 + posCel), y * 333, x * 153, y * 71, tocolor(255, 255, 255), 1, fonts[16])
        dxDrawText("Carteira: "..formatNumber(getPlayerMoney(localPlayer)), x * (52 + posCel), y * 343, x * 153, y * 71, tocolor(255, 255, 255), 1, fonts[4])
        dxDrawText("05/07", x * (199 + posCel), y * 313, x * 153, y * 71, tocolor(255, 255, 255), 1, fonts[17])
    
        local linha = 0
        local abertoAtual = 0
        linha = linha + 1
        dxDrawImage(x * (1060 + linha * 35), y * 444, x * 45, y * 45, "files/Banco/selecione_alguem.png")
        if isMouseInPosition(x * (1060 + linha * 35), y * 444, x * 45, y * 45) then 
            if abertoAtual ~= 0 and abertoAtual ~= linha then 
            else 
                abertoAtual = linha
                dxDrawImage(x * (1056 + linha * 35), y * 491, x * 71, y * 20, "files/Banco/nametag.png")
                dxDrawText((string.len("Selecione Alguém") > 8 and string.sub("Selecione Alguém", 1, 8).."." or "Selecione Alguém"), x * 1094, y * 496, x * 1159, y * 510, tocolor(255, 255, 255, 255), 1.00, fonts[23], "center", "center", false, false, true, false, false)
            end 
        end 
        for i,v in ipairs(tableCategorias) do
            if v.NomeCategoria ~= "Emergência" and linha < 5 then 
                for indx,conteudo in ipairs(tableContatos[v.NomeCategoria]) do 
                    linha = linha + 1
                    if conteudo.Avatar then 
                        dxDrawImage(x * (1060 + linha * 35), y * 444, x * 45, y * 45, ":characters/files/imgs/avatars/"..(conteudo.Avatar or 0)..".png")
                    else 
                        dxDrawImage(x * (1060 + linha * 35), y * 444, x * 45, y * 45, "files/Banco/bola_semavatar.png")
                        if string.find(conteudo.Nome, " ") then 
                            dxDrawText(string.upper(string.sub(conteudo.Nome, 1, 1))..string.upper(string.sub(conteudo.Nome, string.find(conteudo.Nome, " ")+1, string.find(conteudo.Nome, " ")+1)), (1060 + linha * 35), y * 444, x * (1105 + linha * 35), y * 490, tocolor(255, 255, 255, 255), 1.00, fonts[33], "center", "center")                
                        else 
                            dxDrawText(string.upper(string.sub(conteudo.Nome, 1, 1)), (1060 + linha * 35), y * 444, x * (1105 + linha * 35), y * 490, tocolor(255, 255, 255, 255), 1.00, fonts[33], "center", "center")                
                        end 
                    end 
                    if isMouseInPosition(x * (1060 + linha * 35), y * 444, x * 45, y * 45) then 
                        if abertoAtual ~= 0 and abertoAtual ~= linha then 
                        else
                            abertoAtual = linha 
                            dxDrawImage(x * (1056 + linha * 35), y * 491, x * 71, y * 20, "files/Banco/nametag.png")
                            dxDrawText((string.len(conteudo.Nome) > 8 and string.sub(conteudo.Nome, 1, 8).."." or conteudo.Nome), x * (1060 + linha * 35), y * 496, x * (1125 + linha * 35), y * 510, tocolor(255, 255, 255, 255), 1.00, fonts[23], "center", "center", false, false, true, false, false)
                        end 
                    end 
                end
            end 
        end 
        if not escolhendoAlguem and not registrandoPix then 
            local abertoAtual_2 = 0 
            dxDrawImage(x * (1060 + 1 * 35), y * 603, x * 45, y * 45, "files/Banco/detalhes.png")
            if isMouseInPosition(x * (1060 + 1 * 35), y * 603, x * 45, y * 45) then 
                if abertoAtual_2 ~= 0 and abertoAtual_2 ~= 1 then 
                else 
                    abertoAtual_2 = 1
                    dxDrawImage(x * (1056 + 1 * 35), y * 650, x * 71, y * 20, "files/Banco/nametag.png")
                    dxDrawText((string.len("Mais Detalhes") > 8 and string.sub("Mais Detalhes", 1, 8).."." or "Mais Detalhes"), x * 1094, y * 655, x * 1159, y * 669, tocolor(255, 255, 255, 255), 1.00, fonts[23], "center", "center", false, false, true, false, false)
                end 
            end 
            for linha,conteudo in ipairs(tableLogBanco) do 
                if linha < 5 then 
                    if conteudo.Avatar and tonumber(conteudo.Avatar) then 
                        dxDrawImage(x * (1060 + (linha+1) * 35), y * 603, x * 45, y * 45, ':characters/files/imgs/avatars/'..(conteudo.Avatar)..'.png')
                    else 
                        dxDrawImage(x * (1060 + (linha+1) * 35), y * 603, x * 45, y * 45, "files/Banco/bola_semavatar.png")
                        if string.find(conteudo.Nome, " ") then 
                            dxDrawText(string.upper(string.sub(conteudo.Nome, 1, 1))..string.upper(string.sub(conteudo.Nome, string.find(conteudo.Nome, " ")+1, string.find(conteudo.Nome, " ")+1)), (1060 + (linha+1) * 35), y * 603, x * (1105 + (linha+1) * 35), y * 649, tocolor(255, 255, 255, 255), 1.00, fonts[33], "center", "center")                
                        else 
                            dxDrawText(string.upper(string.sub(conteudo.Nome, 1, 1)), (1060 + (linha+1) * 35), y * 603, x * (1105 + (linha+1) * 35), y * 649, tocolor(255, 255, 255, 255), 1.00, fonts[33], "center", "center")                
                        end 
                    end 
                    if isMouseInPosition(x * (1060 + (linha+1) * 35), y * 603, x * 45, y * 45) then 
                        if abertoAtual_2 ~= 0 and abertoAtual_2 ~= (linha+1) then 
                        else
                            abertoAtual_2 = (linha+1) 
                            dxDrawImage(x * (1056 + (linha+1) * 35), y * 650, x * 71, y * 20, "files/Banco/nametag.png")
                            dxDrawText((string.len(conteudo.Nome) > 8 and string.sub(conteudo.Nome, 1, 8).."." or conteudo.Nome), x * (1060 + (linha+1) * 35), y * 655, x * (1125 + (linha+1) * 35), y * 669, tocolor(255, 255, 255, 255), 1.00, fonts[23], "center", "center", false, false, true, false, false)
                        end 
                    end 
                end 
            end 
        end 
        
        
        
        if not escolhendoAlguem then 
            dxDrawText(formatNumber(guiGetText(edits[1])), x * 1119, y * 531, x * 1272, y * 553, tocolor(70, 61, 76, 255), 1.00, fonts[18], "center", "center")
        end 

        if tableSelected then 
            dxDrawText("Número Selecionado: "..tableSelected.Numero, x * 1082, y * 514, x * 1328, y * 530, tocolor(255, 255, 255, 255), 1.00, fonts[4], "center", "center")
        end 
        
        local time = getRealTime()
        local formattedTime = ((time.hour < 10 and "0"..(time.hour) or time.hour)..":"..(time.minute < 10 and "0"..(time.minute) or time.minute))
        dxDrawText(formattedTime, x * (34 + posCel), y * 184, x * 153, y * 71, tocolor(255, 255, 255), 1, fonts[3])
        dxDrawImage(x * (posCel), y * 165, x * 282, y * 566, "files/base.png")
        dxDrawImage(x * (posCel+217), y * 186, x * 34, y * 8, "files/infos.png")
        if isMouseInPosition(x * (posCel+86), y * 701, x * 111, y * 5) then 
            dxDrawRoundedRectangle(x * (posCel+86)-1, y * 701-1, x * 111+1, y * 5+1, tocolor(255, 255, 255), 2)
        else 
            dxDrawRoundedRectangle(x * (posCel+86), y * 701, x * 111, y * 5, tocolor(255, 255, 255), 2)
        end 
    elseif Aba == "Historico Banco" then 
        dxDrawImage(x * (posCel+13), y * 180, x * 262, y * 535, "files/Banco/base_historico.png")
        if getKeyState("mouse1") and isCursorShowing() and (isMouseInPosition(x * (posCel + 258), cursorY, x * 1, y * 68) or rolandobarra) then
            cursorY, proximaPagina = exports["[MELO]BarraUtil"]:BarraUtil(#tableLogBanco, 6, 456, 621, "y")
            rolandobarra = true
        elseif not cursorY then 
            cursorY = y * 456
        end 
        dxDrawImage(x * (posCel + 258), cursorY, x * 1, y * 68, "files/Banco/barrinha.png")
        local linha = 0
        for indx,conteudo in ipairs(tableLogBanco) do 
            if indx > proximaPagina and linha < 6 then 
                linha = linha + 1
                dxDrawImage(x * 1086, y * (408 + linha * 48), x * 234, y * 43, "files/Banco/fundo_historico.png")
                if conteudo.Avatar and tonumber(conteudo.Avatar) then 
                    dxDrawImage(x * 1092, y * (416 + linha * 48), x * 28, y * 28, ':characters/files/imgs/avatars/'..(conteudo.Avatar)..'.png')
                else 
                    dxDrawImage(x * 1092, y * (416 + linha * 48), x * 28, y * 28, "files/Banco/bola_semavatar.png")
                    if string.find(conteudo.Nome, " ") then 
                        dxDrawText(string.upper(string.sub(conteudo.Nome, 1, 1))..string.upper(string.sub(conteudo.Nome, string.find(conteudo.Nome, " ")+1, string.find(conteudo.Nome, " ")+1)), x * 1092, y * (414 + linha * 48), x * 1121, y * (445 + linha * 48), tocolor(255, 255, 255, 255), 1.00, fonts[18], "center", "center")                
                    else 
                        dxDrawText(string.upper(string.sub(conteudo.Nome, 1, 1)), x * 1092, y * (414 + linha * 48), x * 1121, y * (445 + linha * 48), tocolor(255, 255, 255, 255), 1.00, fonts[18], "center", "center")                
                    end 
                end 
                dxDrawText(conteudo.Nome, x * 1128, y * (417 + linha * 48), x * 108, y * 13, tocolor(255, 255, 255), 1, fonts[17])
                if conteudo.Tipo == "Recebeu" then 
                    dxDrawText("R$ "..formatNumber(conteudo.Valor)..",00 recebido", x * 1128, y * (433 + linha * 48), x * 108, y * 13, tocolor(93, 240, 107), 1, fonts[34])
                else 
                    dxDrawText("R$ "..formatNumber(conteudo.Valor)..",00 enviado", x * 1128, y * (433 + linha * 48), x * 108, y * 13, tocolor(240, 93, 93), 1, fonts[34])
                end 
                dxDrawText(conteudo.Numero, x * 1260, y * (428 + linha * 48), x * 25, y * 10, tocolor(255, 255, 255), 1, fonts[35])
            end 
        end 

        local time = getRealTime()
        local formattedTime = ((time.hour < 10 and "0"..(time.hour) or time.hour)..":"..(time.minute < 10 and "0"..(time.minute) or time.minute))
        dxDrawText(formattedTime, x * (34 + posCel), y * 184, x * 153, y * 71, tocolor(255, 255, 255), 1, fonts[3])
        dxDrawImage(x * (posCel), y * 165, x * 282, y * 566, "files/base.png")
        dxDrawImage(x * (posCel+217), y * 186, x * 34, y * 8, "files/infos.png")
        if isMouseInPosition(x * (posCel+86), y * 701, x * 111, y * 5) then 
            dxDrawRoundedRectangle(x * (posCel+86)-1, y * 701-1, x * 111+1, y * 5+1, tocolor(255, 255, 255), 2)
        else 
            dxDrawRoundedRectangle(x * (posCel+86), y * 701, x * 111, y * 5, tocolor(255, 255, 255), 2)
        end 
    elseif Aba == "Telefone" then  
        dxDrawImage(x * (posCel + 18), y * 180, x * 246, y * 535, "files/Telefone/base.png", 0, 0, 0, tocolor(255, 255, 255))
        if isMouseInPosition(x * (posCel + 114), y * 616, x * 54, y * 55) then 
            dxDrawImage(x * (posCel + 114)-1, y * 616-1, x * 54+2, y * 55+2, "files/Telefone/botao_chamar.png", 0, 0, 0, tocolor(255, 255, 255))
        else 
            dxDrawImage(x * (posCel + 114), y * 616, x * 54, y * 55, "files/Telefone/botao_chamar.png", 0, 0, 0, tocolor(255, 255, 255))
        end 

        for i,v in ipairs(botoesTelefone) do 
            if animNumero[i] then 
                anim = interpolateBetween(150, 0, 0, 0, 0, 0, (getTickCount() - tickAnimacao[i]) / 800, "Linear")
                dxDrawImage(v[1], v[2], v[3], v[4], "files/Telefone/base_botao.png", 0, 0, 0, tocolor(187, 187, 187, anim))
            end 
        end 
        dxDrawText(numeroCelular, x * 1084, y * 254, x * 1329, y * 302, tocolor(0, 0, 0, 255), 1.00, fonts[21], "center", "center")
        local time = getRealTime()
        local formattedTime = ((time.hour < 10 and "0"..(time.hour) or time.hour)..":"..(time.minute < 10 and "0"..(time.minute) or time.minute))
        dxDrawText(formattedTime, x * (34 + posCel), y * 184, x * 153, y * 71, tocolor(0, 0, 0), 1, fonts[3])
        dxDrawImage(x * (posCel), y * 165, x * 282, y * 566, "files/base.png")
        dxDrawImage(x * (posCel+217), y * 186, x * 34, y * 8, "files/infos.png", 0 ,0 ,0, tocolor(0, 0, 0))
        if isMouseInPosition(x * (posCel+86), y * 701, x * 111, y * 5) then 
            dxDrawRoundedRectangle(x * (posCel+86)-1, y * 701-1, x * 111+1, y * 5+1, tocolor(32, 32, 32), 2)
        else 
            dxDrawRoundedRectangle(x * (posCel+86), y * 701, x * 111, y * 5, tocolor(32, 32, 32), 2)
        end 
    elseif Aba == "Configuração" then 
        
        local time = getRealTime()
        local formattedTime = ((time.hour < 10 and "0"..(time.hour) or time.hour)..":"..(time.minute < 10 and "0"..(time.minute) or time.minute))
        
        dxDrawRectangle(x * (posCel + 18), y * 180, x * 246, y * 535, tocolor(255, 255, 255))
        dxSetRenderTarget(renderTarget, true)
        dxSetBlendMode("modulate_add")  -- Set 'modulate_add' when drawing stuff on the render target

        dxDrawText("Configurações", x * (1096 - calculoRender[1]), y * (217 - calculoRender[2])- posY, x * 153, y * 71, tocolor(0, 0, 0), 1, fonts[19])
        dxDrawText("Aparência", x * (1099 - calculoRender[1]), y * (250 - calculoRender[2])- posY, x * 153, y * 71, tocolor(0, 0, 0), 1, fonts[20])
        dxDrawRectangle(x * (1087 - calculoRender[1]), y * (278 - calculoRender[2])- posY, x * 240, y * 1, tocolor(225, 225, 225))
        dxDrawText("Wallpaper", x * (1091 - calculoRender[1]), y * (286 - calculoRender[2])- posY, x * 153, y * 71, tocolor(0, 0, 0), 1, fonts[17])
        dxDrawRectangle(x * (1087 - calculoRender[1]), y * (310 - calculoRender[2])- posY, x * 240, y * 1, tocolor(225, 225, 225))
        dxDrawText("Notificações", x * (1099 - calculoRender[1]), y * (315 - calculoRender[2])- posY, x * 153, y * 71, tocolor(0, 0, 0), 1, fonts[20])
        dxDrawRectangle(x * (1087 - calculoRender[1]), y * (343 - calculoRender[2])- posY, x * 240, y * 1, tocolor(225, 225, 225))
        dxDrawText("Ligações Desconhecidas", x * (1091 - calculoRender[1]), y * (351 - calculoRender[2])- posY, x * 153, y * 71, tocolor(0, 0, 0), 1, fonts[17])
        local linha = 0
        for i,v in pairs(animacoesConfig) do 
            linha = linha + 1
            if Anim[i] then 
                if Configs[i] then 
                    animCor1, animCor2, animCor3 = interpolateBetween(173, 0, 255, 84, 80, 88, (getTickCount() - tickAnim) / 500, "Linear")
                    animPos, animCorB = interpolateBetween(1297, 255, 0, 1277, 220, 0, (getTickCount() - tickAnim) / 500, "Linear")
                    dxDrawImage(x * (1276 - calculoRender[1]), y * (((318+linha*32) - calculoRender[2]) - posY), x * 39, y * 18, "files/Configuracoes/base_circulo.png", 0, 0, 0, tocolor(animCor1, animCor2, animCor3))
                    dxDrawImage(x * (animPos - calculoRender[1]), y * (((318.5+linha*32) - calculoRender[2]) - posY), x * 17, y * 17, "files/Configuracoes/circulo.png", 0, 0, 0, tocolor(animCorB, animCorB, animCorB))
                else 
                    animCor1, animCor2, animCor3 = interpolateBetween(84, 80, 88, 173, 0, 255, (getTickCount() - tickAnim) / 500, "Linear")
                    animPos, animCorB = interpolateBetween(1277, 220, 0, 1297, 255, 0, (getTickCount() - tickAnim) / 500, "Linear")
                    dxDrawImage(x * (1276 - calculoRender[1]), y * (((318+linha*32) - calculoRender[2]) - posY), x * 39, y * 18, "files/Configuracoes/base_circulo.png", 0, 0, 0, tocolor(animCor1, animCor2, animCor3))
                    dxDrawImage(x * (animPos - calculoRender[1]), y * (((318.5+linha*32) - calculoRender[2]) - posY), x * 17, y * 17, "files/Configuracoes/circulo.png", 0, 0, 0, tocolor(animCorB, animCorB, animCorB))
                end 
                
            elseif Configs[i] then 
                dxDrawImage(x * (1276 - calculoRender[1]), y * (((318+linha*32) - calculoRender[2]) - posY), x * 39, y * 18, "files/Configuracoes/base_circulo.png", 0, 0, 0, tocolor(173, 0, 255))
                dxDrawImage(x * (1297 - calculoRender[1]), y * (((318.5+linha*32) - calculoRender[2]) - posY), x * 17, y * 17, "files/Configuracoes/circulo.png", 0, 0, 0, tocolor(255, 255, 255))
            else 
                dxDrawImage(x * (1276 - calculoRender[1]), y * (((318+linha*32) - calculoRender[2]) - posY), x * 39, y * 18, "files/Configuracoes/base_circulo.png", 0, 0, 0, tocolor(84, 80, 88))
                dxDrawImage(x * (1277 - calculoRender[1]), y * (((318.5+linha*32) - calculoRender[2]) - posY), x * 17, y * 17, "files/Configuracoes/circulo.png", 0, 0, 0, tocolor(220, 220, 220))
            end 
        end 
        
        dxDrawRectangle(x * (1087 - calculoRender[1]), y * (375 - calculoRender[2])- posY, x * 240, y * 1, tocolor(225, 225, 225))
        dxDrawText("Mensagens Desconhecidas", x * (1091 - calculoRender[1]), y * (383 - calculoRender[2])- posY, x * 153, y * 71, tocolor(0, 0, 0), 1, fonts[17])
        dxDrawRectangle(x * (1087 - calculoRender[1]), y * (407 - calculoRender[2])- posY, x * 240, y * 1, tocolor(225, 225, 225))
        dxDrawText("Ligações", x * (1091 - calculoRender[1]), y * (415 - calculoRender[2])- posY, x * 153, y * 71, tocolor(0, 0, 0), 1, fonts[17])
        dxDrawRectangle(x * (1087 - calculoRender[1]), y * (439 - calculoRender[2])- posY, x * 240, y * 1, tocolor(225, 225, 225))
        dxDrawText("Mensagens", x * (1091 - calculoRender[1]), y * (447 - calculoRender[2])- posY, x * 153, y * 71, tocolor(0, 0, 0), 1, fonts[17])
        dxDrawRectangle(x * (1087 - calculoRender[1]), y * (471 - calculoRender[2])- posY, x * 240, y * 1, tocolor(225, 225, 225))
        if escolhendoWallpaper then 
            if voltandoWPP then 
                ycal, ycal2  = interpolateBetween(605, 649, 0, 719, 764, 0, (getTickCount() - tickAnim)/1000, "Linear")
            else 
                ycal, ycal2  = interpolateBetween(719, 764, 0, 605, 649, 0, (getTickCount() - tickAnim)/1000, "Linear")
            end 
            dxDrawRectangle(x * (1086 - calculoRender[1]), y * (180 - calculoRender[2]), x * 246, y * 535, tocolor(0, 0, 0, 76))
            dxDrawImage(x * (1086 - calculoRender[1]), y * (ycal - calculoRender[2]), x * 246, y * 110, "files/Configuracoes/base_wallpaper.png")
            dxDrawText(guiGetText(edits[2]), x * (1126 - calculoRender[1]), y * (ycal2 - calculoRender[2]), x * 87, y * 14, tocolor(175, 175, 175), 1, fonts[12])
            if isMouseInPosition(x * (posCel+100), y * (ycal+72), x * 82, y * 16) then 
                dxDrawRoundedRectangle(x * (posCel+100) - calculoRender[1]-1, y * (ycal+72) - calculoRender[2]-1, x * 82+1, y * 16+1, tocolor(180, 57, 255), 2)
            else 
                dxDrawRoundedRectangle(x * (posCel+100) - calculoRender[1], y * (ycal+72) - calculoRender[2], x * 82, y * 16, tocolor(205, 205, 205), 2)
            end 
            dxDrawText("Adicionar", x * (posCel+114 ) - calculoRender[1], y * (ycal+72) - calculoRender[2], x * 87, y * 14, tocolor(255, 255, 255), 1, fonts[17])
        end 
        

        dxSetBlendMode("blend")  -- Restore default blending
        dxSetRenderTarget()      -- Restore default render target
        
        dxDrawImage(x * (posCel + 17) , y * 181, x * 247, y * 534, renderTarget)
        dxDrawText(formattedTime, x * (34 + posCel), y * 184, x * 153, y * 71, tocolor(0, 0,0), 1, fonts[3])
        dxDrawImage(x * (posCel), y * 165, x * 282, y * 566, "files/base.png")
        dxDrawImage(x * (posCel+217), y * 186, x * 34, y * 8, "files/infos.png", 0, 0, 0, tocolor(0, 0, 0))
        if isMouseInPosition(x * (posCel+86), y * 701, x * 111, y * 5) then 
            dxDrawRoundedRectangle(x * (posCel+86)-1, y * 701-1, x * 111+1, y * 5+1, tocolor(32, 32, 32), 2)
        else 
            dxDrawRoundedRectangle(x * (posCel+86), y * 701, x * 111, y * 5, tocolor(32, 32, 32), 2)
        end 
    elseif Aba == "Notas" then  
        if not theWallpaper then 
            dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, "files/Wallpaper/1.png")
        else 
            dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, theWallpaper)
        end 
        dxDrawRectangle(x * (posCel+17), y * 181, x * 247, y * 534, tocolor(239, 239, 239))
        
        if subAba == "Home" then 
            dxDrawImage(x * (posCel + 18), y * 180, x * 246, y * 535, "files/Notas/base_home.png")
            dxDrawText((string.len(guiGetText(edits[3])) > 15 and string.sub(guiGetText(edits[3]), 1, 15) or guiGetText(edits[3])), x * (posCel + 61), y * (246), x * 87, y * 14, tocolor(175, 175, 175), 1, fonts[12])
            if tableNotas then 
                if getKeyState("mouse1") and isCursorShowing() and (isMouseInPosition(x * (posCel + 257), cursorY, x * 2, y * 368) or rolandobarra) then
                    cursorY, proximaPagina = exports["[MELO]BarraUtil"]:BarraUtil(#tableNotas, 10, 272, 557, "y")
                    rolandobarra = true
                end 
                local linha = 0
                for i,v in pairs(tableNotas) do 
                    if guiGetText(edits[3]) ~= "" and guiGetText(edits[3]) ~= "Pesquise sua nota..." then 
                        if string.find(v.titulo, guiGetText(edits[3])) then 
                            if i > proximaPagina and linha < 10 then 
                                linha = linha + 1
                                dxDrawImage(x * (posCel + 23), y * (233+linha*39), x * 228, y * 34, "files/Notas/base_notas.png")
                                dxDrawText(v.titulo, x * (posCel + 33), y * (236+linha*39), x * 100, y * 12, tocolor(255, 255, 255), 1, fonts[24])
                                dxDrawText((string.len(v.texto) > 35 and string.sub(v.texto, 1, 35).."..." or v.texto), x * (posCel + 33), y * (250+linha*39), x * 100, y * 12, tocolor(120, 120, 120), 1, fonts[25])
                            end 
                        end 
                    else 
                        if i > proximaPagina and linha < 10 then 
                            linha = linha + 1
                            dxDrawImage(x * (posCel + 23), y * (233+linha*39), x * 228, y * 34, "files/Notas/base_notas.png")
                            dxDrawText(v.titulo, x * (posCel + 33), y * (236+linha*39), x * 100, y * 12, tocolor(255, 255, 255), 1, fonts[24])
                            dxDrawText((string.len(v.texto) > 35 and string.sub(v.texto, 1, 35).."..." or v.texto), x * (posCel + 33), y * (250+linha*39), x * 100, y * 12, tocolor(120, 120, 120), 1, fonts[25])
                        end 
                    end
                    
                end 
            end 
            dxDrawImage(x * (posCel + 257), y * cursorY, x * 2, y * 83, "files/Notas/barra.png")
        elseif subAba == "Criar" then 
            dxDrawImage(x * (posCel + 18), y * 180, x * 246, y * 535, "files/Notas/base_criar.png")
            dxDrawText(guiGetText(edits[4]), x * (posCel+55), y * 223, x * 147, y * 19, tocolor(255, 255, 255), 1, fonts[22], "left", "top")
            dxDrawText(guiGetText(edits[5]), x * (posCel + 28), y * 259, x * (posCel + 255), y * 648, tocolor(140, 140, 140, 255), 1.00, fonts[23], "left", "top", false, true, false, false, false)
            dxDrawText("10.000 Caracteres", x * (posCel+90), y * 673, x * 147, y * 19, tocolor(255, 255, 255), 1, fonts[14], "left", "top")
        elseif subAba == "Ver" then 
            dxDrawImage(x * (posCel + 18), y * 180, x * 246, y * 535, "files/Notas/base_ver.png")
            dxDrawText(NotaVer.titulo, x * (posCel+55), y * 223, x * 147, y * 19, tocolor(255, 255, 255), 1, fonts[22], "left", "top")
            dxDrawText(NotaVer.texto, x * (posCel + 28), y * 259, x * (posCel + 255), y * 648, tocolor(140, 140, 140, 255), 1.00, fonts[23], "left", "top", false, true, false, false, false)
        elseif subAba == "Editar" then 
            dxDrawImage(x * (posCel + 18), y * 180, x * 246, y * 535, "files/Notas/base_criar.png")
            dxDrawText(guiGetText(edits[4]), x * (posCel+55), y * 223, x * 147, y * 19, tocolor(255, 255, 255), 1, fonts[22], "left", "top")
            dxDrawText(guiGetText(edits[5]), x * (posCel + 28), y * 259, x * (posCel + 255), y * 648, tocolor(140, 140, 140, 255), 1.00, fonts[23], "left", "top", false, true, false, false, false)
            dxDrawText("10.000 Caracteres", x * (posCel+90), y * 673, x * 147, y * 19, tocolor(255, 255, 255), 1, fonts[14], "left", "top")
        elseif subAba == "Excluir" then 
            dxDrawImage(x * (posCel + 18), y * 180, x * 246, y * 535, "files/Notas/base_confirmacao.png")
            if isMouseInPosition(x * 1116, y * 432, x * 82, y * 16) then 
                dxDrawImage(x * 1116, y * 432, x * 82, y * 16, "files/Notas/base_botao.png", 0, 0, 0, tocolor(255, 57, 57))
            else 
                dxDrawImage(x * 1116, y * 432, x * 82, y * 16, "files/Notas/base_botao.png", 0, 0, 0, tocolor(55, 55, 55))
            end 
            if isMouseInPosition(x * 1216, y * 432, x * 82, y * 16) then 
                dxDrawImage(x * 1216, y * 432, x * 82, y * 16, "files/Notas/base_botao.png", 0, 0, 0, tocolor(255, 57, 57))
            else 
                dxDrawImage(x * 1216, y * 432, x * 82, y * 16, "files/Notas/base_botao.png", 0, 0, 0, tocolor(55, 55, 55))
            end 
            dxDrawText("Tem certeza que irá excluir este arquivo ?", x * 1101, y * 385, x * 1312, y * 428, tocolor(255, 255, 255, 255), 1.00, fonts[26], "center", "center", false, true, false, false, false)
        dxDrawText("Cancelar", x * 1115, y * 432, x * 1198, y * 448, tocolor(255, 255, 255, 255), 1.00, fonts[23], "center", "center")
        dxDrawText("Excluir", x * 1214, y * 432, x * 1297, y * 448, tocolor(255, 255, 255, 255), 1.00, fonts[23], "center", "center")
        end 
        
        local time = getRealTime()
        local formattedTime = ((time.hour < 10 and "0"..(time.hour) or time.hour)..":"..(time.minute < 10 and "0"..(time.minute) or time.minute))
        dxDrawText(formattedTime, x * (34 + posCel), y * 184, x * 153, y * 71, tocolor(255, 255, 255), 1, fonts[3])
        dxDrawImage(x * (posCel), y * 165, x * 282, y * 566, "files/base.png")
        
        dxDrawImage(x * (posCel+217), y * 186, x * 34, y * 8, "files/infos.png", 0, 0, 0, tocolor(255,255,255))
        if isMouseInPosition(x * (posCel+86), y * 701, x * 111, y * 5) then 
            dxDrawRoundedRectangle(x * (posCel+86)-1, y * 701-1, x * 111+1, y * 5+1, tocolor(255, 255, 255), 2)
        else 
            dxDrawRoundedRectangle(x * (posCel+86), y * 701, x * 111, y * 5, tocolor(255, 255, 255), 2)
        end 
    elseif Aba == "Spotify" then 
        dxDrawImage(x * (posCel + 18), y * 180, x * 246, y * 535, "files/Spotify/base.png")
        
        dxDrawText((string.len(guiGetText(edits[6])) > 15 and string.sub(guiGetText(edits[6]), 1, 15) or guiGetText(edits[6])), x * (posCel + 62), y * (260), x * 87, y * 14, tocolor(175, 175, 175), 1, fonts[12])

        if imagemSpotifyCount and #imagemSpotifyCount > 0 then 
            if getKeyState("mouse1") and isCursorShowing() and (isMouseInPosition(x * (posCel + 257), cursorY, x * 2, y * 305) or rolandobarra) then
                cursorY, proximaPagina = exports["[MELO]BarraUtil"]:BarraUtil(#imagemSpotifyCount, 7, 290, 526, "y")
                rolandobarra = true
            end 
            local linha = 0
            for i,v in ipairs(imagemSpotifyCount) do 
                if i > proximaPagina and linha < 7 then 
                    linha = linha + 1
                    if tocandoMusica == i then 
                        if isMouseInPosition(x * (posCel + 23), y * (246 + linha * 46), x * 228, y * 34) then 
                            dxDrawImage(x * (posCel + 23)-1, y * (246 + linha * 46)-1, x * 228+2, y * 34+2, "files/Spotify/base_selecionada.png")
                        else 
                            dxDrawImage(x * (posCel + 23), y * (246 + linha * 46), x * 228, y * 34, "files/Spotify/base_selecionada.png")
                        end
                    else 
                        if isMouseInPosition(x * (posCel + 23), y * (246 + linha * 46), x * 228, y * 34) then 
                            dxDrawImage(x * (posCel + 23)-1, y * (246 + linha * 46)-1, x * 228+2, y * 34+2, "files/Spotify/base_musica.png")
                        else 
                            dxDrawImage(x * (posCel + 23), y * (246 + linha * 46), x * 228, y * 34, "files/Spotify/base_musica.png")
                        end
                    end  
                    dxDrawText((string.len(v[2]) > 30 and string.sub(v[2], 1, 30).."..." or v[2]), x * (posCel + 33), y * (252 + linha * 46), x * 63, y * 11, tocolor(255, 255, 255), 1, fonts[25])
                    dxDrawText((string.len(v[5]) > 30 and string.sub(v[5], 1, 30).."..." or v[5]), x * (posCel + 33), y * (266 + linha * 46), x * 63, y * 11, tocolor(255, 255, 255), 1, fonts[25])
                    local min, sec = convertTime(v[10])
                    dxDrawText(min..":"..sec, x * (posCel + 222), y * (257 + linha * 46), x * 63, y * 11, tocolor(255, 255, 255), 1, fonts[25])
                end 
            end 
        end 
        dxDrawImage(x * (posCel + 257), y * cursorY, x * 2, y * 69, "files/Spotify/barra.png")

        if tocandoMusica and sound and isElement(sound) then 
            dxDrawImage(x * (posCel + 25), y * 613, x * 234, y * 34, "files/Spotify/base_tocando.png")
            if not pontoinicial  then 
                pontoinicial = 0
            end 
            if not isSoundPaused(sound) then 
                barra = interpolateBetween(pontoinicial, 0, 0, tocandoMusica[10], 0, 0, ((getTickCount() - tickSomTocando) / tocandoMusica[10]), 'Linear')
            else 
                tickSomTocando = getTickCount()
            end 
            dxDrawImageSection(x * (posCel + 37), y * 645, x * (214 / tocandoMusica[10] * barra), y * 1, tocandoMusica[10], 1, (214 / tocandoMusica[10] * barra), 1, "files/Spotify/barrinha.png")
            dxDrawText((string.len(tocandoMusica[2]) > 30 and string.sub(tocandoMusica[2], 1, 30).."..." or tocandoMusica[2]), x * (posCel + 37), y * 618, x * 63, y * 11, tocolor(255, 255, 255), 1, fonts[25])
            dxDrawText((string.len(tocandoMusica[5]) > 20 and string.sub(tocandoMusica[5], 1, 20).."..." or tocandoMusica[5]), x * (posCel + 37), y * 631, x * 63, y * 11, tocolor(103, 103, 103), 1, fonts[25])
            local min, sec = convertTime(barra)
            local min2, sec2 = convertTime(tocandoMusica[10])
            dxDrawText(min..":"..sec.."/"..min2..":"..sec2, x * 1228, y * 629, x * 1258, y * 646, tocolor(103, 103, 103, 255), 1.00, fonts[25], "right", "center")
            if isSoundPaused(sound) then 
                if isMouseInPosition(x * (posCel + 196), y * 624, x * 9, y * 11) then 
                    dxDrawImage(x * (posCel + 196)-1, y * 624-1, x * 9+2, y * 11+2, "files/Spotify/play.png")
                else 
                    dxDrawImage(x * (posCel + 196), y * 624, x * 9, y * 11, "files/Spotify/play.png")
                end 
            else 
                if isMouseInPosition(x * (posCel + 196), y * 624, x * 9, y * 11) then 
                    dxDrawImage(x * (posCel + 196)-1, y * 624-1, x * 9+2, y * 11+2, "files/Spotify/pause.png")
                else 
                    dxDrawImage(x * (posCel + 196), y * 624, x * 9, y * 11, "files/Spotify/pause.png")
                end 
            end 
            
            if isMouseInPosition(x * (posCel + 213), y * 623, x * 13, y * 12) then 
                dxDrawImage(x * (posCel + 213)-1, y * 623-1, x * 13+2, y * 12+2, "files/Spotify/menos.png")
            else 
                dxDrawImage(x * (posCel + 213), y * 623, x * 13, y * 12, "files/Spotify/menos.png")
            end 
            if isMouseInPosition(x * (posCel + 234), y * 623, x * 13, y * 12) then 
                dxDrawImage(x * (posCel + 234)-1, y * 623-1, x * 13+2, y * 12+2, "files/Spotify/mais.png")
            else 
                dxDrawImage(x * (posCel + 234), y * 623, x * 13, y * 12, "files/Spotify/mais.png")
            end 
        end 

        local time = getRealTime()
        local formattedTime = ((time.hour < 10 and "0"..(time.hour) or time.hour)..":"..(time.minute < 10 and "0"..(time.minute) or time.minute))
        dxDrawText(formattedTime, x * (34 + posCel), y * 184, x * 153, y * 71, tocolor(255, 255, 255), 1, fonts[3])
        dxDrawImage(x * (posCel), y * 165, x * 282, y * 566, "files/base.png")
        
        dxDrawImage(x * (posCel+217), y * 186, x * 34, y * 8, "files/infos.png", 0, 0, 0, tocolor(255,255,255))
        if isMouseInPosition(x * (posCel+86), y * 701, x * 111, y * 5) then 
            dxDrawRoundedRectangle(x * (posCel+86)-1, y * 701-1, x * 111+1, y * 5+1, tocolor(255, 255, 255), 2)
        else 
            dxDrawRoundedRectangle(x * (posCel+86), y * 701, x * 111, y * 5, tocolor(255, 255, 255), 2)
        end 
    elseif Aba == "Minhas Informações" then 
        dxDrawRectangle(x * (posCel + 18), y * 180, x * 246, y * 535, tocolor(255, 255, 255))
        dxSetRenderTarget(renderTarget, true)
        dxSetBlendMode("modulate_add")  -- Set 'modulate_add' when drawing stuff on the render target

        dxDrawImage(x * (1084 - calculoRender[1]), y * ((180 - calculoRender[2]) - posY),  x * 246, y * 535, "files/Infos/base.png")
        dxDrawText((getElementData(localPlayer, "ID") or "N/A"), x * (1109 - calculoRender[1]), y * ((258 - calculoRender[2]) - posY), x * 25, y * 16, tocolor(32, 32, 32), 1, fonts[29])
        dxDrawText(removeHex(getPlayerName(localPlayer)), x * (1134 - calculoRender[1]), y * ((274 - calculoRender[2]) - posY), x * 25, y * 16, tocolor(32, 32, 32), 1, fonts[29])
        dxDrawText("Los Santos", x * (1177 - calculoRender[1]), y * ((290 - calculoRender[2]) - posY), x * 25, y * 16, tocolor(32, 32, 32), 1, fonts[29])
        dxDrawText(tabelaInfos.Numero, x * (1152 - calculoRender[1]), y * ((306 - calculoRender[2]) - posY), x * 25, y * 16, tocolor(32, 32, 32), 1, fonts[29])
        dxDrawText((getElementData(localPlayer, "Level") or "0"), x * (1130 - calculoRender[1]), y * ((322 - calculoRender[2]) - posY), x * 25, y * 16, tocolor(32, 32, 32), 1, fonts[29])
        dxDrawText((getElementData(localPlayer, "Emprego") or "Desempregado"), x * (1153 - calculoRender[1]), y * ((338 - calculoRender[2]) - posY), x * 25, y * 16, tocolor(32, 32, 32), 1, fonts[29])
        dxDrawText( math.ceil(getElementHealth(localPlayer)), x * (1136 - calculoRender[1]), y * ((354 - calculoRender[2]) - posY), x * 25, y * 16, tocolor(32, 32, 32), 1, fonts[29])
        dxDrawText( math.ceil(getPedArmor(localPlayer)), x * (1136 - calculoRender[1]), y * ((370 - calculoRender[2]) - posY), x * 25, y * 16, tocolor(32, 32, 32), 1, fonts[29])
        dxDrawText((getElementData(localPlayer, "fome") or "100"), x * (1132 - calculoRender[1]), y * ((386 - calculoRender[2]) - posY), x * 25, y * 16, tocolor(32, 32, 32), 1, fonts[29])
        dxDrawText((getElementData(localPlayer, "sede") or "100"), x * (1128 - calculoRender[1]), y * ((402 - calculoRender[2]) - posY), x * 25, y * 16, tocolor(32, 32, 32), 1, fonts[29])
        dxDrawText("R$ "..formatNumber((getElementData(localPlayer, "moneybank") or "0")), x * (1190 - calculoRender[1]), y * ((418 - calculoRender[2]) - posY), x * 25, y * 16, tocolor(32, 32, 32), 1, fonts[29])
        dxDrawText("R$ "..formatNumber((getElementData(localPlayer, "moneycoins") or "0")), x * (1144 - calculoRender[1]), y * ((434 - calculoRender[2]) - posY), x * 25, y * 16, tocolor(32, 32, 32), 1, fonts[29])

        dxSetBlendMode("blend")  -- Restore default blending
        dxSetRenderTarget()      -- Restore default render target
        
        dxDrawImage(x * (posCel + 17) , y * 181, x * 247, y * 534, renderTarget)
        local time = getRealTime()
        local formattedTime = ((time.hour < 10 and "0"..(time.hour) or time.hour)..":"..(time.minute < 10 and "0"..(time.minute) or time.minute))
        dxDrawText(formattedTime, x * (34 + posCel), y * 184, x * 153, y * 71, tocolor(0, 0, 0), 1, fonts[3])
        dxDrawImage(x * (posCel), y * 165, x * 282, y * 566, "files/base.png")
        
        dxDrawImage(x * (posCel+217), y * 186, x * 34, y * 8, "files/infos.png", 0, 0, 0, tocolor(0,0,0))
        if isMouseInPosition(x * (posCel+86), y * 701, x * 111, y * 5) then 
            dxDrawRoundedRectangle(x * (posCel+86)-1, y * 701-1, x * 111+1, y * 5+1, tocolor(32, 32, 32), 2)
        else 
            dxDrawRoundedRectangle(x * (posCel+86), y * 701, x * 111, y * 5, tocolor(32, 32, 32), 2)
        end 
    elseif Aba == "Contatos" then 
        dxDrawRectangle(x * (posCel + 18), y * 180, x * 246, y * 535, tocolor(255, 255, 255))
        dxSetRenderTarget(renderTarget, true)
        dxSetBlendMode("modulate_add")  -- Set 'modulate_add' when drawing stuff on the render target

        dxDrawImage(x * (1084 - calculoRender[1]), y * ((180 - calculoRender[2]) - posY),  x * 246, y * 535, "files/Contatos/base.png")
        
    
        
        dxDrawText(guiGetText(edits[8]), x * (1126 - calculoRender[1]), y * ((249 - calculoRender[2]) - posY), x * 54, y * 14, tocolor(175, 175, 175), 1, fonts[30])
        additionalY = 0
        for i,v in ipairs(tableCategorias) do
            additionalY = additionalY + 25 
            dxDrawText(v.NomeCategoria, x * (1091 - calculoRender[1]), y * ((250 + additionalY) - calculoRender[2]) - posY, x * 71, y * 15, tocolor(191, 191, 191), 1, fonts[28])
            for indx,conteudo in ipairs(tableContatos[v.NomeCategoria]) do 
                if guiGetText(edits[8]) == "Pesquisar" or guiGetText(edits[8]) == "" or string.find(conteudo.Nome, guiGetText(edits[8])) then 
                    additionalY = additionalY + 25
                    dxDrawText(conteudo.Nome, x * (1091 - calculoRender[1]), y * ((250 + additionalY) - calculoRender[2]) - posY, x * 71, y * 15, tocolor(0, 0, 0), 1, fonts[31])
                    dxDrawRectangle(x * (1087 - calculoRender[1]), y * (((296 + additionalY) - calculoRender[2]) - 27) - posY, x * 240, y * 1, tocolor(225, 225, 225))
                    if selectedContact and selectedContact == additionalY then
                        if v.NomeCategoria ~= "Emergência" then 
                            if isMouseInPosition(x * (1255), y * ((250 + additionalY)) - posY, x * 13, y * 13) then 
                                dxDrawImage(x * (1255 - calculoRender[1]) -1, y * ((250 + additionalY) - calculoRender[2]) - posY -1 , x * 13 + 2, y * 13 + 2, "files/Contatos/excluir.png")
                            else 
                                dxDrawImage(x * (1255 - calculoRender[1]), y * ((250 + additionalY) - calculoRender[2]) - posY, x * 13, y * 13, "files/Contatos/excluir.png")
                            end 
                            if isMouseInPosition(x * (1273), y * ((250 + additionalY)) - posY, x * 13, y * 13) then 
                                dxDrawImage(x * (1273 - calculoRender[1]) -1, y * ((250 + additionalY) - calculoRender[2]) - posY -1 , x * 13 + 2, y * 13 + 2, "files/Contatos/editar.png")
                            else 
                                dxDrawImage(x * (1273 - calculoRender[1]), y * ((250 + additionalY) - calculoRender[2]) - posY, x * 13, y * 13, "files/Contatos/editar.png")
                            end 
                            if isMouseInPosition(x * (1291), y * ((250 + additionalY)) - posY, x * 13, y * 13) then 
                                dxDrawImage(x * (1291 - calculoRender[1]) -1, y * ((250 + additionalY) - calculoRender[2]) - posY -1 , x * 13 + 2, y * 13 + 2, "files/Contatos/mensagem.png")
                            else 
                                dxDrawImage(x * (1291 - calculoRender[1]), y * ((250 + additionalY) - calculoRender[2]) - posY, x * 13, y * 13, "files/Contatos/mensagem.png")
                            end 
                        end 
                        if isMouseInPosition(x * (1309), y * ((250 + additionalY)) - posY, x * 13, y * 13) then 
                            dxDrawImage(x * (1309 - calculoRender[1]) -1, y * ((250 + additionalY) - calculoRender[2]) - posY -1 , x * 13 + 2, y * 13 + 2, "files/Contatos/ligar.png")
                        else 
                            dxDrawImage(x * (1309 - calculoRender[1]), y * ((250 + additionalY) - calculoRender[2]) - posY, x * 13, y * 13, "files/Contatos/ligar.png")
                        end 
                    end 
                end 
            end 
        end 
        
        if editandoContato then 
            if voltandoCTT then 
                ycal, ycal2, ycal3  = interpolateBetween(583, 624, 594, 719, 760, 730, (getTickCount() - tickAnim)/1000, "Linear")
            else 
                ycal, ycal2, ycal3  = interpolateBetween(719, 760, 730, 583, 624, 594, (getTickCount() - tickAnim)/1000, "Linear")
            end 
            dxDrawRectangle(x * ((posCel + 20) - calculoRender[1]), y * (180 - calculoRender[2]), x * 246, y * 535, tocolor(0, 0, 0, 166))
            dxDrawImage(x * (1086 - calculoRender[1]), y * (ycal - calculoRender[2]), x * 246, y * 132, "files/Contatos/base_contato.png")
            dxDrawText(guiGetText(edits[9]), x * (1126 - calculoRender[1]), y * (ycal2 - calculoRender[2]), x * 87, y * 14, tocolor(175, 175, 175), 1, fonts[12])
            dxDrawText(guiGetText(edits[10]), x * (1126 - calculoRender[1]), y * ((ycal2+25) - calculoRender[2]), x * 87, y * 14, tocolor(175, 175, 175), 1, fonts[12])
            if isMouseInPosition(x * (1166), y * 676, x * 82, y * 16) then 
                dxDrawImage(x * ((1166) - calculoRender[1]), y * ((ycal + 93) - calculoRender[2]), x * 82, y * 16, "files/Contatos/botao_base.png", 0, 0, 0, tocolor(180, 57, 255))
                dxDrawText("Editar", x * (1192 - calculoRender[1]), y * ((ycal + 93) - calculoRender[2]), x * 97, y * 17, tocolor(255, 255, 255), 1, fonts[17])
            else 
                dxDrawImage(x * (1166 - calculoRender[1]), y * ((ycal + 93) - calculoRender[2]), x * 82, y * 16, "files/Contatos/botao_base.png", 0, 0, 0, tocolor(234, 234, 234))
                dxDrawText("Editar", x * (1192 - calculoRender[1]), y * ((ycal + 93) - calculoRender[2]), x * 97, y * 17, tocolor(179, 179, 179), 1, fonts[17])
            end 
            dxDrawText("Editar Contato", x * (1158 - calculoRender[1]), y * (ycal3 - calculoRender[2]), x * 97, y * 17, tocolor(0, 0, 0), 1, fonts[13])
            
        end 
        if adicionandoContato then 
            if voltandoCTT then 
                ycal, ycal2, ycal3  = interpolateBetween(583, 624, 594, 719, 760, 730, (getTickCount() - tickAnim)/1000, "Linear")
            else 
                ycal, ycal2, ycal3  = interpolateBetween(719, 760, 730, 583, 624, 594, (getTickCount() - tickAnim)/1000, "Linear")
            end 
            dxDrawRectangle(x * ((posCel + 20) - calculoRender[1]), y * (180 - calculoRender[2]), x * 246, y * 535, tocolor(0, 0, 0, 166))
            dxDrawImage(x * (1086 - calculoRender[1]), y * (ycal - calculoRender[2]), x * 246, y * 132, "files/Contatos/base_contato.png")
            dxDrawText(guiGetText(edits[9]), x * (1126 - calculoRender[1]), y * (ycal2 - calculoRender[2]), x * 87, y * 14, tocolor(175, 175, 175), 1, fonts[12])
            dxDrawText(guiGetText(edits[10]), x * (1126 - calculoRender[1]), y * ((ycal2+25) - calculoRender[2]), x * 87, y * 14, tocolor(175, 175, 175), 1, fonts[12])
            if isMouseInPosition(x * (1166), y * 676, x * 82, y * 16) then 
                dxDrawImage(x * ((1166) - calculoRender[1]), y * ((ycal + 93) - calculoRender[2]), x * 82, y * 16, "files/Contatos/botao_base.png", 0, 0, 0, tocolor(180, 57, 255))
                dxDrawText("Adicionar", x * (1181 - calculoRender[1]), y * ((ycal + 93) - calculoRender[2]), x * 97, y * 17, tocolor(255, 255, 255), 1, fonts[17])
            else 
                dxDrawImage(x * (1166 - calculoRender[1]), y * ((ycal + 93) - calculoRender[2]), x * 82, y * 16, "files/Contatos/botao_base.png", 0, 0, 0, tocolor(234, 234, 234))
                dxDrawText("Adicionar", x * (1181 - calculoRender[1]), y * ((ycal + 93) - calculoRender[2]), x * 97, y * 17, tocolor(179, 179, 179), 1, fonts[17])
            end 
            dxDrawText("Adicionar Contato", x * (1158 - calculoRender[1]), y * (ycal3 - calculoRender[2]), x * 97, y * 17, tocolor(0, 0, 0), 1, fonts[13])
            
        end 
        if isMouseInPosition(x * 1240, y * (216 - posY), x * 77, y * 14) then 
            dxDrawImage(x * (1240 - calculoRender[1]), y * ((216 - calculoRender[2]) - posY), x * 77, y * 14, "files/Contatos/botton_select.png")
        else 
            dxDrawImage(x * (1303 - calculoRender[1]), y * ((216 - calculoRender[2]) - posY), x * 14, y * 14, "files/Contatos/botton.png")
        end 
        dxSetBlendMode("blend")  -- Restore default blending
        dxSetRenderTarget()      -- Restore default render target
        
        dxDrawImage(x * (posCel + 17) , y * 181, x * 247, y * 534, renderTarget)
        local time = getRealTime()
        local formattedTime = ((time.hour < 10 and "0"..(time.hour) or time.hour)..":"..(time.minute < 10 and "0"..(time.minute) or time.minute))
        dxDrawText(formattedTime, x * (34 + posCel), y * 184, x * 153, y * 71, tocolor(0, 0, 0), 1, fonts[3])
        dxDrawImage(x * (posCel), y * 165, x * 282, y * 566, "files/base.png")
        
        dxDrawImage(x * (posCel+217), y * 186, x * 34, y * 8, "files/infos.png", 0, 0, 0, tocolor(0,0,0))
        if isMouseInPosition(x * (posCel+86), y * 701, x * 111, y * 5) then 
            dxDrawRoundedRectangle(x * (posCel+86)-1, y * 701-1, x * 111+1, y * 5+1, tocolor(32, 32, 32), 2)
        else 
            dxDrawRoundedRectangle(x * (posCel+86), y * 701, x * 111, y * 5, tocolor(32, 32, 32), 2)
        end 
        if confirmacaoExcluir then 
            dxDrawRectangle(x * (posCel + 18), y * 180, x * 246, y * 535, tocolor(0, 0, 0, 166))
            dxDrawRoundedRectangle(x * (posCel + 35), y * 374, x * 212, y * 84, tocolor(255, 255, 255), 14)
            dxDrawText("Tem certeza que deseja excluir o contato '"..contatoExcluir.Nome.."' ?", x * (posCel + 35), y * 388, x * (posCel + 246), y * 408, tocolor(0, 0, 0, 255), 1.00, fonts[14], "center", "center", false, true, true, false, false)
            if isMouseInPosition(x * (posCel + 50), y * 432, x * 82, y * 16) then 
                dxDrawImage(x * (posCel + 50), y * 432, x * 82, y * 16, "files/Galeria/botao_selected.png")
            else 
                dxDrawImage(x * (posCel + 50), y * 432, x * 82, y * 16, "files/Galeria/botao_normal.png")
            end 
            if isMouseInPosition(x * (posCel + 150), y * 432, x * 82, y * 16) then 
                dxDrawImage(x * (posCel + 150), y * 432, x * 82, y * 16, "files/Galeria/botao_selected.png")
            else 
                dxDrawImage(x * (posCel + 150), y * 432, x * 82, y * 16, "files/Galeria/botao_normal.png")
            end 
            dxDrawText("Cancelar", x * (posCel + 51), y * 432, x * (posCel + 131), y * 447, tocolor(128, 128, 128, 255), 1.00, fonts[8], "center", "center", false, false, true, false, false)
            dxDrawText("Excluir", x * (posCel + 151), y * 432, x * (posCel + 231), y * 447, tocolor(128, 128, 128, 255), 1.00, fonts[8], "center", "center", false, false, true, false, false)
        end
    elseif Aba == "Chamada" then
        if subAba == "Chamando" then 
            dxDrawImage(x * (posCel + 18), y * 180, x * 246, y * 538, "files/Chamada/base_chamando.png")
            dxDrawRectangle(x * 1155, y * 327, x * 101, y * 101)
            if isMouseInPosition(x * 1189, y * 512, x * 35, y * 35) then 
                dxDrawImage(x * 1189-1, y * 512-1, x * 35+2, y * 35+2, "files/Chamada/microfone_"..(stateMic and "desmutado" or "mutado")..".png")
            else 
                dxDrawImage(x * 1189, y * 512, x * 35, y * 35, "files/Chamada/microfone_"..(stateMic and "desmutado" or "mutado")..".png")
            end 
            if isMouseInPosition(x * 1183, y * 569, x * 48, y * 48) then 
                dxDrawImage(x * 1183-1, y * 569-1, x * 48+2, y * 48+2, "files/Chamada/botao_desligar.png")
            else 
                dxDrawImage(x * 1183, y * 569, x * 48, y * 48, "files/Chamada/botao_desligar.png")
            end 
            dxDrawText(theContactInfos.NomeC, x * 1083, y * 258, x * 1330, y * 295, tocolor(255, 255, 255, 255), 1.00, fonts[32], "center", "center")
        elseif subAba == "Recebendo" then 
            dxDrawImage(x * (posCel + 18), y * 180, x * 246, y * 538, "files/Chamada/base_recebendo.png")
            dxDrawRectangle(x * 1155, y * 327, x * 101, y * 101)
            if isMouseInPosition(x * 1122, y * 569, x * 48, y * 48) then 
                dxDrawImage(x * 1122-1, y * 569-1, x * 48+2, y * 48+2, "files/Chamada/botao_desligar.png")
            else 
                dxDrawImage(x * 1122, y * 569, x * 48, y * 48, "files/Chamada/botao_desligar.png")
            end 
            if isMouseInPosition(x * 1242, y * 569, x * 48, y * 48) then 
                dxDrawImage(x * 1242-1, y * 569-1, x * 48+2, y * 48+2, "files/Chamada/botao_atender.png")
            else 
                dxDrawImage(x * 1242, y * 569, x * 48, y * 48, "files/Chamada/botao_atender.png")
            end 
            dxDrawText(theContactInfos.NomeC, x * 1083, y * 258, x * 1330, y * 295, tocolor(255, 255, 255, 255), 1.00, fonts[32], "center", "center")
        elseif subAba == "Em Chamada" then 
            dxDrawImage(x * (posCel + 18), y * 180, x * 246, y * 538, "files/Chamada/base_emchamada.png")
            dxDrawRectangle(x * 1155, y * 327, x * 101, y * 101) 
            if isMouseInPosition(x * 1189, y * 512, x * 35, y * 35) then 
                dxDrawImage(x * 1189-1, y * 512-1, x * 35+2, y * 35+2, "files/Chamada/microfone_"..(stateMic and "desmutado" or "mutado")..".png")
            else 
                dxDrawImage(x * 1189, y * 512, x * 35, y * 35, "files/Chamada/microfone_"..(stateMic and "desmutado" or "mutado")..".png")
            end 
            if isMouseInPosition(x * 1183, y * 569, x * 48, y * 48) then 
                dxDrawImage(x * 1183-1, y * 569-1, x * 48+2, y * 48+2, "files/Chamada/botao_desligar.png")
            else 
                dxDrawImage(x * 1183, y * 569, x * 48, y * 48, "files/Chamada/botao_desligar.png")
            end 
            dxDrawImage(x * 1134, y * 301, x * 90, y * 13, "files/Chamada/ligacao_enviada.png")
            local min, sec = convertTimeSeconds(getRealTime().timestamp - timestampInicio)
            dxDrawText(min..":"..sec, x * 1227, y * 300, x * 40, y * 12, tocolor(255, 255, 255, 255), 1.00, fonts[18])
            dxDrawText(theContactInfos.NomeC, x * 1083, y * 258, x * 1330, y * 295, tocolor(255, 255, 255, 255), 1.00, fonts[32], "center", "center")
        end 
        local time = getRealTime()
        local formattedTime = ((time.hour < 10 and "0"..(time.hour) or time.hour)..":"..(time.minute < 10 and "0"..(time.minute) or time.minute))
        dxDrawText(formattedTime, x * (34 + posCel), y * 184, x * 153, y * 71, tocolor(255, 255, 255), 1, fonts[3])
        dxDrawImage(x * (posCel), y * 165, x * 282, y * 566, "files/base.png")
        
        dxDrawImage(x * (posCel+217), y * 186, x * 34, y * 8, "files/infos.png", 0, 0, 0, tocolor(255,255,255))
    elseif Aba == "Whatsapp" then
        if subAba == "Home" then 
            dxDrawRectangle(x * (posCel + 18), y * 180, x * 246, y * 535, tocolor(255, 255, 255))
            dxSetRenderTarget(renderTarget, true)
            dxSetBlendMode("modulate_add")  -- Set 'modulate_add' when drawing stuff on the render target

            dxDrawImage(x * ((posCel + 20) - calculoRender[1]), y * (180 - calculoRender[2]) - posY, x * (246), y * (538), "files/Whatsapp/base_home.png")
            if theTableHome and #theTableHome > 0 then 
                local linha = 0
                for i,v in ipairs(theTableHome) do 
                    linha = linha + 1
                    if linha > 1 then 
                        dxDrawRectangle(x * (1084 - calculoRender[1]), y * ((198     + linha * 45) - calculoRender[2]), x * 246, y * 2, tocolor(248, 248, 248))
                    end 
                    if v.Imagem then 
                        if type(v.Imagem) ~= "string" then 
                            dxDrawImage(x * (1093 - calculoRender[1]), y * ((206 + linha * 45) - calculoRender[2]) - posY, x * 29, y * 29, v.Imagem)
                        else
                            progress = interpolateBetween(0, 0, 0, 8000, 0, 0, (getTickCount() - tickAnim) / 80000, "Linear")
                            dxDrawRectangle(x * (1199 - calculoRender[1]) + 4, y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) + 4, x * 116, y * 116, tocolor(217, 217, 217))
                            dxDrawImage(x * (1199 - calculoRender[1]) + 7, y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) + 7, x * 110, y * 110, "files/Whatsapp/loading.png", progress, 0, 0)
                        end 
                        
                    else 
                        dxDrawImage(x * (1093 - calculoRender[1]), y * ((206 + linha * 47) - calculoRender[2]) - posY, x * 29, y * 29, ":characters/files/imgs/avatars/"..(v.Avatar or 0)..".png")
                    end 
                    
                    dxDrawText((v.Nome or v.Numero or ""), x * (1128 - calculoRender[1]), y * ((205 + linha * 45) - calculoRender[2]) - posY, x * (1138), y * (490), tocolor(0, 0, 0, 255), 1.00, fonts[13], "left", "top")  
                    dxDrawText((v.UltimaMensagem[2] == "Enviou" and v.UltimaMensagem[4] and v.UltimaMensagem[4] or v.UltimaMensagem[2] == "Recebeu" and v.UltimaMensagem[5] and v.UltimaMensagem[5] or v.UltimaMensagem[1]), x * (1128 - calculoRender[1]), y * ((221 + linha * 45) - calculoRender[2]) - posY, x * (1138), y * (490), tocolor(0, 0, 0, 255), 1.00, fonts[26], "left", "top")  
                    if v.NaoLidas and v.NaoLidas > 0 then 
                        dxDrawImage(x * (1302 - calculoRender[1]), y * ((216 + linha * 45) - calculoRender[2]) - posY, x * (16), y * (16), "files/Whatsapp/nao_lida.png")
                        dxDrawText(v.NaoLidas, x * (1303 - calculoRender[1]), y * ((217 + linha * 45) - calculoRender[2]) - posY, x * (1317 - calculoRender[1]), y * ((231 + linha * 45) - calculoRender[2]) - posY, tocolor(255, 255, 255, 255), 1.00, fonts[23], "center", "center")
                    end 
                end 
            end 

            dxSetBlendMode("blend")  -- Restore default blending
            dxSetRenderTarget()      -- Restore default render target
            
            dxDrawImage(x * (posCel + 17) , y * 181, x * 247, y * 534, renderTarget)
        elseif subAba == "Pesquisa" then 
            dxDrawRectangle(x * (posCel + 18), y * 180, x * 246, y * 535, tocolor(255, 255, 255))
            dxSetRenderTarget(renderTarget, true)
            dxSetBlendMode("modulate_add")  -- Set 'modulate_add' when drawing stuff on the render target

            dxDrawImage(x * ((posCel + 20) - calculoRender[1]), y * (180 - calculoRender[2]) - posY, x * (246), y * (538), "files/Whatsapp/base_pesquisa.png")
            dxDrawText(guiGetText(edits[11]), x * (1102 - calculoRender[1]), y * (216 - calculoRender[2]) - posY, x * (143), y * (12), tocolor(34, 171, 155), 1, fonts[18])
            local linha = 0
            for i,v in ipairs(tableCategorias) do
                if v.NomeCategoria ~= "Emergência" then 
                    for indx,conteudo in ipairs(tableContatos[v.NomeCategoria]) do 
                        if guiGetText(edits[11]) == "" or guiGetText(edits[11]) == "Procure pelos seus contatos..." or string.find(string.lower(conteudo.Nome), string.lower(guiGetText(edits[11]))) then 
                            linha = linha + 1
                            dxDrawRectangle(x * (1084 - calculoRender[1]), y * ((289 + linha * 45) - calculoRender[2]) - posY, x * (246), y * (2), tocolor(248, 248, 248))
                            dxDrawImage(x * (1093 - calculoRender[1]), y * ((299 + linha * 45) - calculoRender[2]) - posY, x * 29, y * 29, ":characters/files/imgs/avatars/"..(conteudo.Avatar or 0)..".png")
                            dxDrawText(conteudo.Nome, x * (1128 - calculoRender[1]), y * ((303 + linha * 45) - calculoRender[2]) - posY, x * (1138), y * (490), tocolor(0, 0, 0, 255), 1.00, fonts[13], "left", "top")                
                        end 
                    end
                end 
            end 

            if escolhendoAlguem then 
                local linha = 0
                local indxTotal = 0
                if voltandoBanco then 
                    ycal, ycal2  = interpolateBetween(539, 577, 0, 788, 826, 0, (getTickCount() - tickAnim)/1000, "Linear")
                else 
                    ycal, ycal2  = interpolateBetween(788, 826, 0, 539, 577, 0, (getTickCount() - tickAnim)/1000, "Linear")
                end 
                dxDrawRectangle(x * (1086 - calculoRender[1]), y * (180 - calculoRender[2]), x * 246, y * 535, tocolor(0, 0, 0, 76))
                dxDrawImage(x * (1086 - calculoRender[1]), y * (ycal - calculoRender[2]), x * 246, y * 179, "files/Whatsapp/nova_conversa.png")
                for i,v in ipairs(tableCategorias) do
                    if v.NomeCategoria ~= "Emergência" and escolhendoAlguem then 
                        for indx,conteudo in ipairs(tableContatos[v.NomeCategoria]) do
                            indxTotal = indxTotal + 1
                            if indxTotal > proximaPagina and linha < 4 then  
                                linha = linha + 1
                                if isMouseInPosition(x * 1083, y * ((ycal2 - 29) + linha * 25), x * 245, y * 25) or theSelected == indxTotal  then 
                                    dxDrawText((string.len(conteudo.Nome) > 15 and string.sub(conteudo.Nome, 1, 15).."." or conteudo.Nome), x * (1083 - calculoRender[1]), y * ((ycal2 + (linha - 1) * 20) - calculoRender[2]), x * (1329 - calculoRender[1]), y * (((ycal2 + 18) + (linha - 1) * 20) - calculoRender[2]), tocolor(169, 61, 255, 255), 1.00, fonts[18], "center", "center")                
                                else 
                                    dxDrawText((string.len(conteudo.Nome) > 15 and string.sub(conteudo.Nome, 1, 15).."." or conteudo.Nome), x * (1083 - calculoRender[1]), y * ((ycal2 + (linha - 1) * 20) - calculoRender[2]), x * (1329 - calculoRender[1]), y * (((ycal2 + 18) + (linha - 1) * 20) - calculoRender[2]), tocolor(0, 0, 0, 255), 1.00, fonts[18], "center", "center")                
                                end 
                            end 
                        end 
                    end 
                end 
            end 

            dxSetBlendMode("blend")  -- Restore default blending
            dxSetRenderTarget()      -- Restore default render target
            
            dxDrawImage(x * (posCel + 17) , y * 181, x * 247, y * 534, renderTarget)
        elseif subAba == "Conversa" then
            dxDrawImage(x * (posCel + 18), y * 180, x * 246, y * 535, "files/Whatsapp/fundo_conversa.png")
            dxSetRenderTarget(renderTarget, true)
            dxSetBlendMode("modulate_add")  -- Set 'modulate_add' when drawing stuff on the render target

            if conversaAtual and #conversaAtual > 0 then 
                local linha = 0
                local linhasAdicionais = 0
                for i,v in ipairs(conversaAtual) do 
                    linha = linha + 1
                    if contatoAtual.Tipo and contatoAtual.Tipo == "Grupo" then 
                        if v[3] == tabelaInfos.Numero then 
                            if v[5] then 
                                if v[5] == "Localização" then 
                                    contagemLinhas = 3
                                    alturaTexto = 50
                                    larguraTexto = 132
                                    dxDrawRoundedRectangle(x * (1192 - calculoRender[1]), y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * larguraTexto, y * (alturaTexto), tocolor(203, 255, 172), 2)
                                    dxDrawImage(x * (1197 - calculoRender[1]), y * ((651 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * 124, y * 42, "files/Whatsapp/base_localizacao.png")
                                elseif v[5] == "Contato" then 
                                    contagemLinhas = 2.5
                                    alturaTexto = 42
                                    larguraTexto = 132
                                    dxDrawRoundedRectangle(x * (1192 - calculoRender[1]), y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * larguraTexto, y * (alturaTexto), tocolor(203, 255, 172), 2)
                                    dxDrawImage(x * (1197 - calculoRender[1]), y * ((673 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * 126, y * 12, "files/Whatsapp/base_contato.png")
                                    dxDrawImage(x * (1200 - calculoRender[1]), y * ((650 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) , x * 21, y * 21, ":characters/files/imgs/avatars/"..(v[1][3] or 0)..".png")
                                    dxDrawText(v[1][1], x * (1225 - calculoRender[1]), y * ((654 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) , x * 21, y * 21, tocolor(0, 0, 0), 1, fonts[23])
                                elseif v[5] == "Imagem" then
                                    contagemLinhas = 7
                                    alturaTexto = 124
                                    larguraTexto = 124
                                    dxDrawRoundedRectangle(x * (1199 - calculoRender[1]), y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * larguraTexto, y * (alturaTexto), tocolor(203, 255, 172), 2)
                                    if type(v[1]) ~= "string" then 
                                        dxDrawImage(x * (1199 - calculoRender[1]) + 4, y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) + 4, x * 116, y * 116, v[1])
                                    elseif v[1] then 
                                        progress = interpolateBetween(0, 0, 0, 8000, 0, 0, (getTickCount() - tickAnim) / 80000, "Linear")
                                        dxDrawRectangle(x * (1199 - calculoRender[1]) + 4, y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) + 4, x * 116, y * 116, tocolor(217, 217, 217))
                                        dxDrawImage(x * (1199 - calculoRender[1]) + 7, y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) + 7, x * 110, y * 110, "files/Whatsapp/loading.png", progress, 0, 0)
                                    end 
                                end 
                            else 
                                larguraTexto = dxGetTextWidth(v[1], 1, fonts[18])
                                alturaTexto = dxGetFontHeight(1, fonts[18])
                                contagemLinhas = getContagemLinhas(larguraTexto / 224)
                                dxDrawRoundedRectangle(x * ((1324 - (contagemLinhas > 1 and 235 or (larguraTexto + 6))) - calculoRender[1]), y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * (contagemLinhas > 1 and 235 or (larguraTexto + 6)), y * (contagemLinhas * alturaTexto), tocolor(203, 255, 172), 2)
                                dxDrawText(v[1], x * (1093 - calculoRender[1]), y * ((648 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * (1321 - calculoRender[1]), y * ((670 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), tocolor(0, 0, 0, 255), 1.00, fonts[18], "right", "top", false, true, false, false, false)
                            end     
                            linhasAdicionais = linhasAdicionais + contagemLinhas
                        else
                            if v[5] then 
                                if v[5] == "Localização" then 
                                    contagemLinhas = 4
                                    alturaTexto = 64
                                    larguraTexto = 132
                                    dxDrawRoundedRectangle(x * (1089 - calculoRender[1]), y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * larguraTexto, y * (alturaTexto), tocolor(255, 255, 255), 2)
                                    dxDrawText((tableNumeros[v[3]] and tableNumeros[v[3]].Nome or v[3]), x * (1093 - calculoRender[1]), y * ((648 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * (1321 - calculoRender[1]), y * ((670 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2]), (tableNumeros[v[3]] and tocolor(unpack(tableNumeros[v[3]].Cor)) or tocolor(0, 0, 0, 255)), 1.00, fonts[17], "left", "top", false, true, false, false, false)
                                    dxDrawImage(x * (1094 - calculoRender[1]), y * ((665 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * 124, y * 42, "files/Whatsapp/base_localizacao.png")
                                elseif v[5] == "Contato" then 
                                    contagemLinhas = 3.5
                                    alturaTexto = 56
                                    larguraTexto = 132
                                    dxDrawRoundedRectangle(x * (1089 - calculoRender[1]), y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * larguraTexto, y * (alturaTexto), tocolor(255, 255, 255), 2)
                                    dxDrawText((tableNumeros[v[3]] and tableNumeros[v[3]].Nome or v[3]), x * (1093 - calculoRender[1]), y * ((648 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * (1321 - calculoRender[1]), y * ((670 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2]), (tableNumeros[v[3]] and tocolor(unpack(tableNumeros[v[3]].Cor)) or tocolor(0, 0, 0, 255)), 1.00, fonts[17], "left", "top", false, true, false, false, false)
                                    dxDrawImage(x * (1094 - calculoRender[1]), y * ((687 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * 126, y * 12, "files/Whatsapp/base_contato.png")
                                    dxDrawImage(x * (1097 - calculoRender[1]), y * ((664 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) , x * 21, y * 21, ":characters/files/imgs/avatars/"..(v[1][3] or 0)..".png")
                                    dxDrawText(v[1][1], x * (1123 - calculoRender[1]), y * ((668 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) , x * 21, y * 21, tocolor(0, 0, 0), 1, fonts[23])
                                elseif v[5] == "Imagem" then
                                    contagemLinhas = 8
                                    alturaTexto = 138
                                    larguraTexto = 124
                                    dxDrawRoundedRectangle(x * (1089 - calculoRender[1]), y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * larguraTexto, y * (alturaTexto), tocolor(255, 255, 255), 2)
                                    dxDrawText((tableNumeros[v[3]] and tableNumeros[v[3]].Nome or v[3]), x * (1093 - calculoRender[1]), y * ((648 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * (1321 - calculoRender[1]), y * ((670 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2]), (tableNumeros[v[3]] and tocolor(unpack(tableNumeros[v[3]].Cor)) or tocolor(0, 0, 0, 255)), 1.00, fonts[17], "left", "top", false, true, false, false, false)
                                    if type(v[1]) ~= "string" then 
                                        dxDrawImage(x * (1089 - calculoRender[1]) + 4, y * ((661 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) + 4, x * 116, y * 116, v[1])
                                    elseif v[1] then 
                                        progress = interpolateBetween(0, 0, 0, 8000, 0, 0, (getTickCount() - tickAnim) / 80000, "Linear")
                                        dxDrawRectangle(x * (1089 - calculoRender[1]) + 4, y * ((661 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) + 4, x * 116, y * 116, tocolor(217, 217, 217))
                                        dxDrawImage(x * (1089 - calculoRender[1]) + 7, y * ((661 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) + 7, x * 110, y * 110, "files/Whatsapp/loading.png", progress, 0, 0)
                                    end 
                                end 
                            else 
                                alturaTexto = dxGetFontHeight(1, fonts[18])
                                larguraTexto = dxGetTextWidth(v[1], 1, fonts[18])
                                contagemLinhas = getContagemLinhas(dxGetTextWidth(v[1], 1, fonts[18]) / 224)+1
                                dxDrawRoundedRectangle(x * (1089 - calculoRender[1]), y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * (contagemLinhas > 1 and 235 or larguraTexto + 6), y * (contagemLinhas * alturaTexto), tocolor(255, 255, 255), 2)
                                dxDrawText((tableNumeros[v[3]] and tableNumeros[v[3]].Nome or v[3]), x * (1093 - calculoRender[1]), y * ((648 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * (1321 - calculoRender[1]), y * ((670 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2]), (tableNumeros[v[3]] and tocolor(unpack(tableNumeros[v[3]].Cor)) or tocolor(0, 0, 0, 255)), 1.00, fonts[17], "left", "top", false, true, false, false, false)
                                dxDrawText(v[1], x * (1093 - calculoRender[1]), y * ((662 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * (1321 - calculoRender[1]), y * ((670 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2]), tocolor(0, 0, 0, 255), 1.00, fonts[18], "left", "top", false, true, false, false, false)
                            end   
                            linhasAdicionais = linhasAdicionais + contagemLinhas
                        end 
                    else 
                        if v[2] == "Enviou" then 
                            if v[4] then 
                                if v[4] == "Localização" then 
                                    contagemLinhas = 3
                                    alturaTexto = 50
                                    larguraTexto = 132
                                    dxDrawRoundedRectangle(x * (1192 - calculoRender[1]), y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * larguraTexto, y * (alturaTexto), tocolor(203, 255, 172), 2)
                                    dxDrawImage(x * (1197 - calculoRender[1]), y * ((651 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * 124, y * 42, "files/Whatsapp/base_localizacao.png")
                                elseif v[4] == "Contato" then 
                                    contagemLinhas = 3
                                    alturaTexto = 42
                                    larguraTexto = 132
                                    dxDrawRoundedRectangle(x * (1192 - calculoRender[1]), y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * larguraTexto, y * (alturaTexto), tocolor(203, 255, 172), 2)
                                    dxDrawImage(x * (1197 - calculoRender[1]), y * ((673 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * 126, y * 12, "files/Whatsapp/base_contato.png")
                                    dxDrawImage(x * (1200 - calculoRender[1]), y * ((650 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) , x * 21, y * 21, ":characters/files/imgs/avatars/"..(v[1][3] or 0)..".png")
                                    dxDrawText(v[1][1], x * (1225 - calculoRender[1]), y * ((654 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) , x * 21, y * 21, tocolor(0, 0, 0), 1, fonts[23])
                                elseif v[4] == "Imagem" then
                                    contagemLinhas = 7
                                    alturaTexto = 124
                                    larguraTexto = 124
                                    dxDrawRoundedRectangle(x * (1199 - calculoRender[1]), y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * larguraTexto, y * (alturaTexto), tocolor(203, 255, 172), 2)
                                    if type(v[1]) ~= "string" then 
                                        dxDrawImage(x * (1199 - calculoRender[1]) + 4, y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) + 4, x * 116, y * 116, v[1])
                                    elseif v[1] then 
                                        progress = interpolateBetween(0, 0, 0, 8000, 0, 0, (getTickCount() - tickAnim) / 80000, "Linear")
                                        dxDrawRectangle(x * (1199 - calculoRender[1]) + 4, y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) + 4, x * 116, y * 116, tocolor(217, 217, 217))
                                        dxDrawImage(x * (1199 - calculoRender[1]) + 7, y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) + 7, x * 110, y * 110, "files/Whatsapp/loading.png", progress, 0, 0)
                                    end 
                                end 
                            else 
                                larguraTexto = dxGetTextWidth(v[1], 1, fonts[18])
                                alturaTexto = dxGetFontHeight(1, fonts[18])
                                contagemLinhas = getContagemLinhas(larguraTexto / 224)
                                dxDrawRoundedRectangle(x * ((1324 - (contagemLinhas > 1 and 235 or (larguraTexto + 6))) - calculoRender[1]), y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * (contagemLinhas > 1 and 235 or (larguraTexto + 6)), y * (contagemLinhas * alturaTexto), tocolor(203, 255, 172), 2)
                                dxDrawText(v[1], x * (1093 - calculoRender[1]), y * ((648 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * (1321 - calculoRender[1]), y * ((670 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), tocolor(0, 0, 0, 255), 1.00, fonts[18], "right", "top", false, true, false, false, false)
                            end     
                            linhasAdicionais = linhasAdicionais + contagemLinhas
                        elseif v[2] == "Recebeu" then 
                            if v[5] then 
                                if v[5] == "Localização" then 
                                    contagemLinhas = 3
                                    alturaTexto = 50
                                    larguraTexto = 132
                                    dxDrawRoundedRectangle(x * (1089 - calculoRender[1]), y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * larguraTexto, y * (alturaTexto), tocolor(255, 255, 255), 2)
                                    dxDrawImage(x * (1094 - calculoRender[1]), y * ((651 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * 124, y * 42, "files/Whatsapp/base_localizacao.png")
                                elseif v[5] == "Contato" then 
                                    contagemLinhas = 3
                                    alturaTexto = 42
                                    larguraTexto = 132
                                    dxDrawRoundedRectangle(x * (1089 - calculoRender[1]), y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * larguraTexto, y * (alturaTexto), tocolor(255, 255, 255), 2)
                                    dxDrawImage(x * (1094 - calculoRender[1]), y * ((673 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * 126, y * 12, "files/Whatsapp/base_contato.png")
                                    dxDrawImage(x * (1097 - calculoRender[1]), y * ((650 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) , x * 21, y * 21, ":characters/files/imgs/avatars/"..(v[1][3] or 0)..".png")
                                    dxDrawText(v[1][1], x * (1123 - calculoRender[1]), y * ((654 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) , x * 21, y * 21, tocolor(0, 0, 0), 1, fonts[23])
                                elseif v[5] == "Imagem" then
                                    contagemLinhas = 7
                                    alturaTexto = 124
                                    larguraTexto = 124
                                    dxDrawRoundedRectangle(x * (1096 - calculoRender[1]), y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * larguraTexto, y * (alturaTexto), tocolor(203, 255, 172), 2)
                                    if type(v[1]) ~= "string" then 
                                        dxDrawImage(x * (1096 - calculoRender[1]) + 4, y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) + 4, x * 116, y * 116, v[1])
                                    elseif v[1] then 
                                        progress = interpolateBetween(0, 0, 0, 8000, 0, 0, (getTickCount() - tickAnim) / 80000, "Linear")
                                        dxDrawRectangle(x * (1096 - calculoRender[1]) + 4, y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) + 4, x * 116, y * 116, tocolor(217, 217, 217))
                                        dxDrawImage(x * (1096 - calculoRender[1]) + 7, y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) + 7, x * 110, y * 110, "files/Whatsapp/loading.png", progress, 0, 0)
                                    end 
                                end 
                            else 
                                alturaTexto = dxGetFontHeight(1, fonts[18])
                                larguraTexto = dxGetTextWidth(v[1], 1, fonts[18])
                                contagemLinhas = getContagemLinhas(dxGetTextWidth(v[1], 1, fonts[18]) / 224)
                                dxDrawRoundedRectangle(x * (1089 - calculoRender[1]), y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * (contagemLinhas > 1 and 235 or larguraTexto + 6), y * (contagemLinhas * alturaTexto), tocolor(255, 255, 255), 2)
                                dxDrawText(v[1], x * (1093 - calculoRender[1]), y * ((648 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY), x * (1321 - calculoRender[1]), y * ((670 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2]), tocolor(0, 0, 0, 255), 1.00, fonts[18], "left", "top", false, true, false, false, false)
                            end   
                            linhasAdicionais = linhasAdicionais + contagemLinhas
                        end 
                    end 
                end
            end 
            if escolhendoAlguem then 
                local linha = 0
                local indxTotal = 0
                if voltandoBanco then 
                    ycal, ycal2  = interpolateBetween(539, 577, 0, 788, 826, 0, (getTickCount() - tickAnim)/1000, "Linear")
                else 
                    ycal, ycal2  = interpolateBetween(788, 826, 0, 539, 577, 0, (getTickCount() - tickAnim)/1000, "Linear")
                end 
                dxDrawRectangle(x * (1086 - calculoRender[1]), y * (180 - calculoRender[2]), x * 246, y * 535, tocolor(0, 0, 0, 76))
                dxDrawImage(x * (1086 - calculoRender[1]), y * (ycal - calculoRender[2]), x * 246, y * 179, "files/Whatsapp/nova_conversa.png")
                for i,v in ipairs(tableCategorias) do
                    if v.NomeCategoria ~= "Emergência" and escolhendoAlguem then 
                        for indx,conteudo in ipairs(tableContatos[v.NomeCategoria]) do
                            indxTotal = indxTotal + 1
                            if indxTotal > proximaPagina and linha < 4 then  
                                linha = linha + 1
                                if isMouseInPosition(x * 1083, y * ((ycal2 - 29) + linha * 25), x * 245, y * 25) or theSelected == indxTotal  then 
                                    dxDrawText((string.len(conteudo.Nome) > 15 and string.sub(conteudo.Nome, 1, 15).."." or conteudo.Nome), x * (1083 - calculoRender[1]), y * ((ycal2 + (linha - 1) * 20) - calculoRender[2]), x * (1329 - calculoRender[1]), y * (((ycal2 + 18) + (linha - 1) * 20) - calculoRender[2]), tocolor(169, 61, 255, 255), 1.00, fonts[18], "center", "center")                
                                else 
                                    dxDrawText((string.len(conteudo.Nome) > 15 and string.sub(conteudo.Nome, 1, 15).."." or conteudo.Nome), x * (1083 - calculoRender[1]), y * ((ycal2 + (linha - 1) * 20) - calculoRender[2]), x * (1329 - calculoRender[1]), y * (((ycal2 + 18) + (linha - 1) * 20) - calculoRender[2]), tocolor(0, 0, 0, 255), 1.00, fonts[18], "center", "center")                
                                end 
                            end 
                        end 
                    end 
                end 
            end 

            dxSetBlendMode("blend")  -- Restore default blending
            dxSetRenderTarget()      -- Restore default render target
            
            dxDrawImage(x * (posCel + 17) , y * 181, x * 247, y * 534, renderTarget)

            
            dxDrawImage(x * ((posCel + 18)), y * (180) , x * (246), y * (67), "files/Whatsapp/base_conversa.png")
            if contatoAtual.Imagem then 
                if type(contatoAtual.Imagem) ~= "string" then 
                    dxDrawImage(x * (1093   ), y * (212) , x * 29, y * 29, contatoAtual.Imagem)
                elseif contatoAtual.Imagem then 
                    progress = interpolateBetween(0, 0, 0, 8000, 0, 0, (getTickCount() - tickAnim) / 80000, "Linear")
                    dxDrawRectangle(x * (1199 - calculoRender[1]) + 4, y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) + 4, x * 116, y * 116, tocolor(217, 217, 217))
                    dxDrawImage(x * (1199 - calculoRender[1]) + 7, y * ((647 - (linhasAdicionais + contagemLinhas) * 18) - calculoRender[2] + posY) + 7, x * 110, y * 110, "files/Whatsapp/loading.png", progress, 0, 0)
                end 
            else 
                dxDrawImage(x * (1093), y * (206) , x * 29, y * 29, ":characters/files/imgs/avatars/"..(contatoAtual.Avatar or 0)..".png")
            end 
            
            dxDrawText(contatoAtual.Nome, x * (1128), y * (206) , x * 61, y * 18, tocolor(255, 255, 255), 1, fonts[36])
            dxDrawText((contatoAtual and tonumber(contatoAtual.Online) and contatoAtual.Online.." Membros no Grupo" or contatoAtual.Online and contatoAtual.Online or "Offline"), x * (1128), y * (206+dxGetFontHeight(1, fonts[36])) , x * 61, y * 18, tocolor(255, 255, 255), 1, fonts[18])
            if not escolhendoAlguem then 
                dxDrawRectangle(x * 1083, y * 648, x * 246, y * 67, tocolor(214, 214, 214))
                dxDrawRectangle(x * 1083, y * 648, x * 246, y * 1, tocolor(170, 170, 170))
                dxDrawImage(x * (1089), y * (657), x * 191, y * 27, "files/Whatsapp/caixa_mensagem.png")
                dxDrawText((string.len(guiGetText(edits[12])) > 10 and string.sub(guiGetText(edits[12]), string.len(guiGetText(edits[12])) - 10, string.len(guiGetText(edits[12]))) or guiGetText(edits[12])), x * 1116, y * 657, x * 1244, y * 680, (guiGetText(edits[12]) == "Mensagem" and tocolor(223, 223, 223, 255) or tocolor(100, 100, 100, 255)), 1.00, fonts[33], "left", "center")
                if isMouseInPosition(x * (1285), y * (653), x * 35, y * 35) then 
                    dxDrawImage(x * (1285)-1, y * (653) - 1 , x * 35+2, y * 35+2, "files/Whatsapp/botao_enviar.png")
                else 
                    dxDrawImage(x * (1285), y * (653), x * 35, y * 35, "files/Whatsapp/botao_enviar.png")
                end 
                if escolhendoClipe then  
                    dxDrawImage(x * (1107), y * (572), x * 190, y * 105, "files/Whatsapp/clip_wpp.png")
                end  
            end 
        elseif subAba == "Criar Grupo" then 
            dxDrawImage(x * (posCel + 18), y * 180, x * 246, y * 535, "files/Whatsapp/base_criargrupo.png")
            dxDrawText((string.len(guiGetText(edits[13])) > 15 and string.sub(guiGetText(edits[13]), string.len(guiGetText(edits[13])) - 15, string.len(guiGetText(edits[13]))) or guiGetText(edits[13])), x * (posCel + 66), y * 256, x * 93, y * 13, tocolor(185, 185, 185), 1, fonts[13])
            dxDrawText(config.maximoCaracteresGrupo - string.len(guiGetText(edits[13])), x * (posCel + 234), y * 256, x * 93, y * 13, tocolor(185, 185, 185), 1, fonts[13])
            if imagemGrupo then 
                dxDrawImage(x * (posCel + 27), y * 245, x * 35, y * 35, imagemGrupo[1])
            else 
                dxDrawRectangle(x * (posCel + 27), y * 245, x * 35, y * 35, tocolor(217, 217, 217))
            end 
            
            for i,v in ipairs(tablePartcipants) do 
                dxDrawImage(x * (posCel + 26), y * (319 + i * 46), x * 29, y * 29, ':characters/files/imgs/avatars/'..(v.Avatar or 0)..'.png')
                dxDrawText(v.Cargo, x * (posCel + config.tableCoresCargo[v.Cargo].posXcargo), y * (328 + i * 46), x * 29, y * 29, config.tableCoresCargo[v.Cargo].Cor, 1, fonts[6])
                dxDrawText(v.Nome, x * (posCel + 61), y * (328 + i * 46), x * 29, y * 29, tocolor(0, 0, 0), 1, fonts[17])
                if config.tableCoresCargo[v.Cargo].posXmais then 
                    dxDrawText("-", (posCel + config.tableCoresCargo[v.Cargo].posXcargo - 10), y * (325 + i * 46), x * 6, y * 15, (v.Cargo == "Membro" and tocolor(187, 187, 187, 255) or tocolor(2, 117, 255, 255)), 1, fonts[38])
                    dxDrawText("+", (posCel + config.tableCoresCargo[v.Cargo].posXmais), y * (325 + i * 46), x * 9, y * 15, (v.Cargo == "Membro" and tocolor(2, 117, 255, 255) or tocolor(187, 187, 187, 255)), 1, fonts[38])
                end 
            end 

            dxSetRenderTarget(renderTarget, true)
            dxSetBlendMode("modulate_add")  -- Set 'modulate_add' when drawing stuff on the render target

            
            if escolhendoAlguem then 
                local linha = 0
                local indxTotal = 0
                if voltandoBanco then 
                    ycal, ycal2  = interpolateBetween(539, 577, 0, 788, 826, 0, (getTickCount() - tickAnim)/1000, "Linear")
                else 
                    ycal, ycal2  = interpolateBetween(788, 826, 0, 539, 577, 0, (getTickCount() - tickAnim)/1000, "Linear")
                end 
                dxDrawRectangle(x * (1086 - calculoRender[1]), y * (180 - calculoRender[2]), x * 246, y * 535, tocolor(0, 0, 0, 76))
                dxDrawImage(x * (1086 - calculoRender[1]), y * (ycal - calculoRender[2]), x * 246, y * 179, "files/Whatsapp/nova_conversa.png")
                for i,v in ipairs(tableCategorias) do
                    if v.NomeCategoria ~= "Emergência" and escolhendoAlguem then 
                        for indx,conteudo in ipairs(tableContatos[v.NomeCategoria]) do
                            indxTotal = indxTotal + 1
                            if indxTotal > proximaPagina and linha < 4 then  
                                linha = linha + 1
                                if isMouseInPosition(x * 1083, y * ((ycal2 - 29) + linha * 25), x * 245, y * 25) or theSelected == indxTotal  then 
                                    dxDrawText((string.len(conteudo.Nome) > 15 and string.sub(conteudo.Nome, 1, 15).."." or conteudo.Nome), x * (1083 - calculoRender[1]), y * ((ycal2 + (linha - 1) * 20) - calculoRender[2]), x * (1329 - calculoRender[1]), y * (((ycal2 + 18) + (linha - 1) * 20) - calculoRender[2]), tocolor(169, 61, 255, 255), 1.00, fonts[18], "center", "center")                
                                else 
                                    dxDrawText((string.len(conteudo.Nome) > 15 and string.sub(conteudo.Nome, 1, 15).."." or conteudo.Nome), x * (1083 - calculoRender[1]), y * ((ycal2 + (linha - 1) * 20) - calculoRender[2]), x * (1329 - calculoRender[1]), y * (((ycal2 + 18) + (linha - 1) * 20) - calculoRender[2]), tocolor(0, 0, 0, 255), 1.00, fonts[18], "center", "center")                
                                end 
                            end 
                        end 
                    end 
                end 
            end 
            dxSetBlendMode("blend")  -- Restore default blending
            dxSetRenderTarget()      -- Restore default render target
            dxDrawImage(x * (posCel + 17) , y * 181, x * 247, y * 534, renderTarget)
        elseif subAba == "Informações Grupo" then 
            dxDrawImage(x * (posCel + 18), y * 180, x * 246, y * 535, "files/Whatsapp/infoGrupo.png")
            dxDrawText((string.len(guiGetText(edits[13])) > 15 and string.sub(guiGetText(edits[13]), string.len(guiGetText(edits[13])) - 15, string.len(guiGetText(edits[13]))) or guiGetText(edits[13])), x * (posCel + 66), y * 256, x * 93, y * 13, tocolor(185, 185, 185), 1, fonts[13])
            dxDrawText(config.maximoCaracteresGrupo - string.len(guiGetText(edits[13])), x * (posCel + 234), y * 256, x * 93, y * 13, tocolor(185, 185, 185), 1, fonts[13])
            if grupoAtual.Imagem then 
                if type(grupoAtual.Imagem) ~= "string" then 
                    dxDrawImage(x * (posCel + 27), y * 245, x * 35, y * 35, grupoAtual.Imagem)
                else 
                    dxDrawRectangle(x * (posCel + 27), y * 245, x * 35, y * 35, tocolor(217, 217, 217))
                end 
            else 
                dxDrawRectangle(x * (posCel + 27), y * 245, x * 35, y * 35, tocolor(217, 217, 217))
            end 
            local linha = 0 
            for i,v in ipairs(grupoAtual.Participantes) do 
                if i > proximaPagina and linha < 9 then 
                    linha = linha + 1
                    --dxDrawImage(x * (posCel + 26), y * (285 + linha * 46), x * 29, y * 29, ':characters/files/imgs/avatars/'..(v[2] or 0)..'.png')
                    dxDrawText(v[3], x * (posCel + config.tableCoresCargo[v[3]].posXcargo), y * (294 + linha * 46), x * 29, y * 29, config.tableCoresCargo[v[3]].Cor, 1, fonts[6])
                    dxDrawText((tableNumeros[v[4]] and tableNumeros[v[4]].Nome or v[1] == "Você" and v[1] or v[4]), x * (posCel + 61), y * (294 + linha * 46), x * 29, y * 29, tocolor(0, 0, 0), 1, fonts[17])
                    if v[4] == tabelaInfos.Numero and v[3] == "Dono(a)" then 
                        isAdm = true 
                    end
                    if config.tableCoresCargo[v[3]].posXmais and isAdm then 
                        dxDrawText("-", (posCel + config.tableCoresCargo[v[3]].posXcargo - 10), y * (291 + linha * 46), x * 6, y * 15, (v[3] == "Membro" and tocolor(187, 187, 187, 255) or tocolor(2, 117, 255, 255)), 1, fonts[38])
                        dxDrawText("+", (posCel + config.tableCoresCargo[v[3]].posXmais), y * (291 + linha * 46), x * 9, y * 15, (v[3] == "Membro" and tocolor(2, 117, 255, 255) or tocolor(187, 187, 187, 255)), 1, fonts[38])
                        if isMouseInPosition(x * (posCel + 249), y * (295 + linha * 46), x * 9, y * 12) then 
                            dxDrawImage(x * (posCel + 249)-1, y * (295 + linha * 46)-1, x * 9+2, y * 12+2, "files/Whatsapp/lixeira.png")
                        else 
                            dxDrawImage(x * (posCel + 249), y * (295 + linha * 46), x * 9, y * 12, "files/Whatsapp/lixeira.png")
                        end 
                    end 

                end 
            end 
            dxSetRenderTarget(renderTarget, true)
            dxSetBlendMode("modulate_add")  -- Set 'modulate_add' when drawing stuff on the render target
        
            if escolhendoAlguem then 
                local linha = 0
                local indxTotal = 0
                if voltandoBanco then 
                    ycal, ycal2  = interpolateBetween(539, 577, 0, 788, 826, 0, (getTickCount() - tickAnim)/1000, "Linear")
                else 
                    ycal, ycal2  = interpolateBetween(788, 826, 0, 539, 577, 0, (getTickCount() - tickAnim)/1000, "Linear")
                end 
                dxDrawRectangle(x * (1086 - calculoRender[1]), y * (180 - calculoRender[2]), x * 246, y * 535, tocolor(0, 0, 0, 76))
                dxDrawImage(x * (1086 - calculoRender[1]), y * (ycal - calculoRender[2]), x * 246, y * 179, "files/Whatsapp/nova_conversa.png")
                for i,v in ipairs(tableCategorias) do
                    if v.NomeCategoria ~= "Emergência" and escolhendoAlguem then 
                        for indx,conteudo in ipairs(tableContatos[v.NomeCategoria]) do
                            indxTotal = indxTotal + 1
                            if indxTotal > proximaPagina and linha < 4 then  
                                linha = linha + 1
                                if isMouseInPosition(x * 1083, y * ((ycal2 - 29) + linha * 25), x * 245, y * 25) or theSelected == indxTotal  then 
                                    dxDrawText((string.len(conteudo.Nome) > 15 and string.sub(conteudo.Nome, 1, 15).."." or conteudo.Nome), x * (1083 - calculoRender[1]), y * ((ycal2 + (linha - 1) * 20) - calculoRender[2]), x * (1329 - calculoRender[1]), y * (((ycal2 + 18) + (linha - 1) * 20) - calculoRender[2]), tocolor(169, 61, 255, 255), 1.00, fonts[18], "center", "center")                
                                else 
                                    dxDrawText((string.len(conteudo.Nome) > 15 and string.sub(conteudo.Nome, 1, 15).."." or conteudo.Nome), x * (1083 - calculoRender[1]), y * ((ycal2 + (linha - 1) * 20) - calculoRender[2]), x * (1329 - calculoRender[1]), y * (((ycal2 + 18) + (linha - 1) * 20) - calculoRender[2]), tocolor(0, 0, 0, 255), 1.00, fonts[18], "center", "center")                
                                end 
                            end 
                        end 
                    end 
                end 
            end 
            dxSetBlendMode("blend")  -- Restore default blending
            dxSetRenderTarget()      -- Restore default render target
        
            dxDrawImage(x * (posCel + 17) , y * 181, x * 247, y * 534, renderTarget)
        end 
        local time = getRealTime()
        local formattedTime = ((time.hour < 10 and "0"..(time.hour) or time.hour)..":"..(time.minute < 10 and "0"..(time.minute) or time.minute))
        dxDrawText(formattedTime, x * (34 + posCel), y * 184, x * 153, y * 71, tocolor(255, 255, 255), 1, fonts[3])
        dxDrawImage(x * (posCel), y * 165, x * 282, y * 566, "files/base.png")
        dxDrawImage(x * (posCel+217), y * 186, x * 34, y * 8, "files/infos.png", 0, 0, 0, tocolor(255,255,255))
        if isMouseInPosition(x * (posCel+86), y * 701, x * 111, y * 5) then 
            dxDrawRoundedRectangle(x * (posCel+86)-1, y * 701-1, x * 111+1, y * 5+1, tocolor(32, 32, 32), 2)
        else 
            dxDrawRoundedRectangle(x * (posCel+86), y * 701, x * 111, y * 5, tocolor(32, 32, 32), 2)
        end 
        local time = getRealTime()
        local formattedTime = ((time.hour < 10 and "0"..(time.hour) or time.hour)..":"..(time.minute < 10 and "0"..(time.minute) or time.minute))
        dxDrawText(formattedTime, x * (34 + posCel), y * 184, x * 153, y * 71, tocolor(255, 255, 255), 1, fonts[3])
        dxDrawImage(x * (posCel), y * 165, x * 282, y * 566, "files/base.png")
        dxDrawImage(x * (posCel+217), y * 186, x * 34, y * 8, "files/infos.png", 0, 0, 0, tocolor(255,255,255))
        if isMouseInPosition(x * (posCel+86), y * 701, x * 111, y * 5) then 
            dxDrawRoundedRectangle(x * (posCel+86)-1, y * 701-1, x * 111+1, y * 5+1, tocolor(32, 32, 32), 2)
        else 
            dxDrawRoundedRectangle(x * (posCel+86), y * 701, x * 111, y * 5, tocolor(32, 32, 32), 2)
        end 
    end 
    if AnimationApp then 
        if tickAlpha then 
            alpha = interpolateBetween(255, 0, 0, 0, 0, 0, (getTickCount() - tickAlpha) / 500, "Linear")
        else 
            alpha = 255 
        end 
        if not theWallpaper then 
            dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, "files/Wallpaper/1.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
        else 
            dxDrawImage(x * (posCel+18), y * 180, x * 246, y * 535, theWallpaper, 0, 0, 0, tocolor(255, 255, 255, alpha))
        end 
        
        local xA, yA = interpolateBetween(225, 668, 0, 17, 181, 0, (getTickCount() - tickA) / 500, "Linear")
        local wA, hA = interpolateBetween(39, 47, 0, 247, 534, 0, (getTickCount() - tickA) / 500, "Linear")
        dxDrawRoundedRectangle(x * (xA + posCel), y * yA, x * wA, y * hA, tocolor(255, 255, 255, alpha), 25)
        dxDrawImage(x * posCel, y * 165, x * 282, y * 566, "files/base.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
        dxDrawImage(x * (posCel+217), y * 186, x * 34, y * 8, "files/infos.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
        local time = getRealTime()
        local formattedTime = ((time.hour < 10 and "0"..(time.hour) or time.hour)..":"..(time.minute < 10 and "0"..(time.minute) or time.minute))
        if wA >= 46 and hA >= 46 then 
            if not tickApp then 
                tickApp = getTickCount()
                setTimer(
                    function ()
                        tickAlpha = getTickCount()
                    end, 500, 1
                )
            end 
            local xApp, yApp = interpolateBetween(212, 667, 0, 118, 427, 0, (getTickCount() - tickApp) / 500, "Linear")
            dxDrawImage(x * (posCel+(xApp)), y * yApp, x * 46, y * 46, theImgApp, 0, 0, 0, tocolor(255, 255, 255, alpha))
        end 
    end 
end 

bindKey("F1", "down", 
function ()
    if animacao then return end 
    if not isEventHandlerAdded("onClientRender", root, dxDraw) then 
        triggerServerEvent("MeloSCR:openCelularS", localPlayer, localPlayer)
    else
        if Aba == "Câmera" then 
            removeEventHandler('onClientPreRender', root, render)
            removeEventHandler('onClientCursorMove', root, mousecalc)
            setCameraTarget(localPlayer)
            toggleAllControls(true)
            setPedAnimation(localPlayer, false)
        end 
        removeEventHandler('onClientCursorMove', root, mousecalcYpos)
        triggerServerEvent("MeloSCR:setAnimationPhone", localPlayer, 2)
        tick = getTickCount()
        voltando = true
        animacao = true
        Aba = false
        subAba = false
        setTimer(
            function ()
                animacao = nil
                removeEventHandler("onClientRender", root, dxDraw)
                showCursor(false)
                editBox()
            end, 500, 1
        )
    end 
end)

bindKey("enter", "down", 
function ()
    if animacao then return end 
    if isEventHandlerAdded("onClientRender", root, dxDraw) then 
        if Aba == "Whatsapp" and subAba == "Conversa" then 
            if guiGetText(edits[12]) ~= "" and guiGetText(edits[12]) ~= "Mensagem" then 
                if contatoAtual.Tipo and contatoAtual.Tipo == "Grupo" then 
                    triggerServerEvent("MeloSCR:sendWhatsappMessage", localPlayer, localPlayer, contatoAtual.Nome, guiGetText(edits[12]), _, tabelaInfos)
                    guiSetText(edits[12], "")
                else 
                    triggerServerEvent("MeloSCR:sendWhatsappMessage", localPlayer, localPlayer, contatoAtual.Conta, guiGetText(edits[12]))
                    guiSetText(edits[12], "")
                end 
                
            end 
        end 
    end 
end)

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        myScreenSource = dxCreateScreenSource(500, 500)
    end
)


addEvent("MeloSCR:openCelular", true)
addEventHandler("MeloSCR:openCelular", root, 
function (theTable, thaTable2, theTable3, theConta)
    if not isEventHandlerAdded("onClientRender", root, dxDraw) then 
        theContaSource = theConta
        conversaAtual = nil 
        contatoAtual = nil 
        escolhendoFoto = nil 
        subAba = nil 
        Texturas = {}
        TexturasTwo = {}
        Configs = {}
        Anim = {}
        voltando = nil 
        animacao = true
        posY = 0
        editBox("add")
        triggerServerEvent("MeloSCR:setAnimationPhone", localPlayer, 1)
        setTimer(
            function ()
                animacao = nil
            end, 500, 1
        )
        addEventHandler("onClientRender", root, dxDraw)
        addEventHandler('onClientCursorMove', root, mousecalcYpos)
        showCursor(true)
        numeroCalculadora = ""
        numeroCelular = ""
        tick = getTickCount()
        Aba = "Bloqueio"
        totalApps = #config.Aplicativos
        tabelaApps = theTable
        tabelaInfos = thaTable2
        table.sort(theTable3, function (a, b) return a[3] > b[3] end)
        tabelaNotificacoes = theTable3
    else 
        escolhendoFoto = nil 
        conversaAtual = nil 
        contatoAtual = nil 
        editBox()
        if Aba == "Câmera" then 
            removeEventHandler('onClientPreRender', root, render)
            removeEventHandler('onClientCursorMove', root, mousecalc)
            setCameraTarget(localPlayer)
            toggleAllControls(true)
            setPedAnimation(localPlayer, false)
        end 
        removeEventHandler('onClientCursorMove', root, mousecalcYpos)
        triggerServerEvent("MeloSCR:setAnimationPhone", localPlayer, 2)
        tick = getTickCount()
        voltando = true
        animacao = true
        setTimer(
            function ()
                animacao = nil
                removeEventHandler("onClientRender", root, dxDraw)
                showCursor(false)
            end, 500, 1
        )
    end 
end)

addEventHandler("onClientKey", root, 
function (button)
    if isEventHandlerAdded("onClientRender", root, dxDraw) and subAba == "Conversa" and button ~= "enter" and button ~= "mouse_wheel_up" and button ~= "mouse_wheel_down" then 
        cancelEvent()
    end 
end)

bindKey("backspace", "down",
function ()
    if isEventHandlerAdded("onClientRender", root, dxDraw) then 
        deposit = false
        if Aba == "Calculadora" then 
            if string.len(numeroCalculadora) > 0 then 
                numeroCalculadora = string.sub(numeroCalculadora, 1, string.len(numeroCalculadora)-1)
            end 
        elseif Aba == "Telefone" then 
            if string.len(numeroCelular) > 0 then 
                if string.len(numeroCelular) == 6 then 
                    numeroCelular = string.sub(numeroCelular, 1, string.len(numeroCelular)-2)
                else 
                    numeroCelular = string.sub(numeroCelular, 1, string.len(numeroCelular)-1)
                end 
                
            end 
        elseif Aba == "Contatos" and editandoContato then 
            setTimer(
                function ()
                    editandoContato = false  
                    voltandoCTT = false 
                end, 1000, 1
            )
            voltandoCTT = true 
            tickAnim = getTickCount()
        elseif Aba == "Contatos" and adicionandoContato then 
            setTimer(
                function ()
                    adicionandoContato = false  
                    voltandoCTT = false 
                end, 1000, 1
            )
            voltandoCTT = true 
            tickAnim = getTickCount()
        elseif Aba == "Banco" and escolhendoAlguem or Aba == "Banco" and registrandoPix then 
            setTimer(
                function ()
                    escolhendoAlguem = false  
                    registrandoPix = false  
                    voltandoBanco = false 
                end, 1000, 1
            )
            voltandoBanco = true 
            tickAnim = getTickCount()
        elseif Aba == "Whatsapp" then 
            if subAba == "Pesquisa" then 
                if escolhendoAlguem then 
                    setTimer(
                        function ()
                            escolhendoAlguem = false  
                            voltandoBanco = false 
                        end, 1000, 1
                    )
                    voltandoBanco = true 
                    tickAnim = getTickCount()
                else 
                    subAba = "Home"
                    escolhendoFoto = nil 
                    escolhendoFoto = nil
                end 
            elseif subAba == "Conversa" then
                subAba = "Home"
                escolhendoFoto = nil 
                escolhendoFoto = nil
            end 
        elseif Aba == "Historico Banco" then 
            Aba = "Banco"
        elseif Aba == "MercadoLivre" then 
            publicandoProduto = nil 
            typeSelected = nil 
            guiSetText(edits[14], "Digite um título")
            guiSetText(edits[15], "Digite um valor...")
            guiSetText(edits[16], "Digite um valor...")
        end 
    end 
end)

addEventHandler("onClientClick", root, 
function (botton, state)
    if isEventHandlerAdded("onClientRender", root, dxDraw) then 
        if botton == "left" and state == "down" then 
            if Aba == "Bloqueio" then 
                if isMouseInPosition(x * (117 + posCel), y * 622, x * 48, y * 48) then  
                    Aba = "Home"
                    conversaAtual = nil 
                    contatoAtual = nil 
                    subAba = nil 
                    guiSetInputMode("allow_binds")
                    posY = 0
                end 
                for i,v in ipairs(tabelaNotificacoes) do 
                    if isMouseInPosition(x * (posCel + 21), y * (303 + i * 47), x * 240, y * 50) then 
                        onAppOpened({["1"] = getAppNameFromImage(v[1]), ["2"] = v[1]})
                    end 
                end 
            elseif Aba == "Home" then    
                for i,v in ipairs(tabelaApps) do 
                    if v.Slot and posIconesHome[v.Slot] then 
                        if isMouseInPosition(x * (posCel+posIconesHome[v.Slot][1]), posIconesHome[v.Slot][2], posIconesHome[v.Slot][3], posIconesHome[v.Slot][4]) and v.Baixado then 
                            pressionando = v 
                            setTimer(
                                function () 
                                    if pressionando then 
                                        pressionando = nil 
                                        appSelected = i
                                    end 
                                end, 250, 1
                            )
                            
                        end 
                    elseif v.Favorito then 
                        if isMouseInPosition(x * (posCel+posIconesFavoritosHome[v.Favorito][1]), posIconesFavoritosHome[v.Favorito][2], posIconesFavoritosHome[v.Favorito][3], posIconesFavoritosHome[v.Favorito][4]) and v.Baixado then 
                            pressionando = v 
                            setTimer(
                                function ()
                                    if pressionando then 
                                        pressionando = nil 
                                        appSelected = i
                                    end 
                                end, 250, 1
                            )
                            
                        end 
                    end 
                end 
            else 
                if isMouseInPosition(x * 1152-1, y * 701-1, x * 111+1, y * 5+1) then 
                    if Aba ~= "Blaze" then
                        if Aba == "Câmera" then 
                            removeEventHandler('onClientPreRender', root, render)
                            removeEventHandler('onClientCursorMove', root, mousecalc)
                            setCameraTarget(localPlayer)
                            toggleAllControls(true)
                            setPedAnimation(localPlayer, false)
                            triggerServerEvent("JOAO.fotosRecente", localPlayer, localPlayer)
                        end 
                        subAba = nil
                        Aba = "Home"
                        conversaAtual = nil 
                        contatoAtual = nil 
                        posY = 0
                    end
                end 
            end 
            if Aba == "Appstore" then
                local linha = 0
                for i,v in ipairs(tabelaApps) do 
                    linha = linha + 1
                    if v.Baixado then 
                        if isMouseInPosition(x * (1285), y * ((565 + linha * 46)) - posY, x * 20, y * 20) then 
                            v.Baixado = false 
                            triggerServerEvent("MeloSCR:updateCell", localPlayer, localPlayer, tabelaApps)
                        end 
                    else 
                        if appBaixando and appBaixando == i then 

                        else 
                            if isMouseInPosition(x * (1265), y * ((569 + linha * 46)) - posY, x * 49, y * 18) then 
                                if not appBaixando then 
                                    animBaixando = true 
                                    appBaixando = i
                                    setTimer(
                                        function ()
                                            v.Baixado = true
                                            animBaixando = nil 
                                            appBaixando = nil 
                                            triggerServerEvent("MeloSCR:updateCell", localPlayer, localPlayer, tabelaApps)
                                        end, 5000, 1
                                    )
                                    tickAnim = getTickCount()
                                else 
                                    notifyC("Ja há um download em andamento!", "error")
                                end 
                            end     
                        end 
                    end 
                end 
            elseif Aba == "Calculadora" then 
                if isMouseInPosition(x * 1083, y * 288, x * 246, y * 72) then 
                    if tonumber(numeroCalculadora) then 
                        textoCopiado = true
                        tickTexto = getTickCount()
                        setTimer(
                            function ()
                                textoCopiado = nil
                            end, 5000, 1
                        )
                        setClipboard(numeroCalculadora)
                    end 
                end 
                for i,v in ipairs(botoesCalculadora) do 
                    if isMouseInPosition(x * (posCel+v[1]), v[2], v[3], v[4]) then 
                        animNumero[i] = true 
                        typeAnim = v.tipoAnim
                        tickAnimacao[i] = getTickCount()
                        setTimer(
                            function ()
                                animNumero[i] = nil 
                            end, 800, 1
                        )
                        if v.number then  
                            if v[10] == "." then 
                                if string.sub(numeroCalculadora, string.len(numeroCalculadora), string.len(numeroCalculadora)) == "." then return end 
                            end 
                            numeroCalculadora = numeroCalculadora..v[10]
                        else 
                            if v[10] == "=" then 
                                if salvarOperacao and salvarNumero and tonumber(numeroCalculadora) then 
                                    if salvarOperacao == "+" then 
                                        numeroCalculadora = tonumber(salvarNumero)+tonumber(numeroCalculadora) 
                                        salvarOperacao = nil 
                                        salvarNumero = nil 
                                    elseif salvarOperacao == "-" then 
                                        numeroCalculadora = tonumber(salvarNumero)-tonumber(numeroCalculadora) 
                                        salvarOperacao = nil 
                                        salvarNumero = nil 
                                    elseif salvarOperacao == "/" then 
                                        numeroCalculadora = tonumber(salvarNumero)/tonumber(numeroCalculadora) 
                                        salvarOperacao = nil 
                                        salvarNumero = nil 
                                    elseif salvarOperacao == "x" then 
                                        numeroCalculadora = tonumber(salvarNumero)*tonumber(numeroCalculadora) 
                                        salvarOperacao = nil 
                                        salvarNumero = nil 
                                    end 
                                end     
                            elseif v[10] == "AC" then 
                                salvarOperacao = nil 
                                salvarNumero = nil 
                                numeroCalculadora = ""
                            elseif v[10] == "+/-" then 
                                numeroCalculadora = (numeroCalculadora)*(-1)
                            elseif v[10] == "%" then 
                                if salvarOperacao and salvarNumero and tonumber(numeroCalculadora) then 
                                    local porcento = tonumber(salvarNumero)/100
                                    local porcentagem = porcento*tonumber(numeroCalculadora)
                                    numeroCalculadora = porcentagem
                                end 
                            else 
                                salvarNumero = numeroCalculadora
                                salvarOperacao = v[10]
                                numeroCalculadora = ""
                            end 
                        end 
                        break 
                    end 
                end 
            elseif Aba == "Câmera" then 
                if isMouseInPosition(x * (posCel+112), y * 627, x * 58, y * 58) then 
                    animacaoFoto = true 
                    tickAnim = getTickCount()
                    setTimer(
                        function ()
                            animacaoFoto = false 
                        end, 800, 1
                    )
                    pos = {getElementPosition(localPlayer)}
                    Texturas = {}
                    TexturasTwo = {}
                    Baixado = false
                    pngPixels = dxConvertPixels(dxGetTexturePixels(myScreenSource), 'png')
                    TimerPhoto = setTimer(function()
                    end, 8000, 1)
                    triggerServerEvent("Schootz.photoVerify", localPlayer)
                end 
                if isMouseInPosition(x * 1287, y * 641, x * 29, y * 29) then 
                    rotX, rotY = 0,0
                    selfie = not selfie
                end   
            elseif Aba == "Galeria" then 
                if #Texturas > 0 then 
                    tableOrganizacaoX = {}
                    tableOrganizacaoY = {}
                    local linha = 0
                    for i, v in ipairs(Texturas) do
                        linha = linha + 1
                        table.insert(tableOrganizacaoX, linha)
                        table.insert(tableOrganizacaoY, linha)
                        if isMouseInPosition(x * ((1025 + #tableOrganizacaoX * 75)), y * ((192 + #tableOrganizacaoY * 75) - posY), x * 64, y * 63) then 
                            if not escolhendoFoto then 
                                Aba = "Ver Foto"
                                posY = 0
                                confirmacaoExcluir = nil  
                                imageView = v
                            elseif antigaAba == "Whatsapp" then 
                                if criandoGrupo then 
                                    imagemGrupo = v
                                    Aba = "Whatsapp"
                                    subAba = "Criar Grupo"
                                    criandoGrupo = nil 
                                elseif editandoGrupo then 
                                    imagemGrupo = v
                                    grupoAtual.Imagem = v[1]
                                    Aba = "Whatsapp"
                                    subAba = "Informações Grupo"
                                    editandoGrupo = nil 
                                else 
                                    if contatoAtual.Tipo and contatoAtual.Tipo == "Grupo" then 
                                        triggerServerEvent("MeloSCR:sendWhatsappMessage", localPlayer, localPlayer, contatoAtual.Nome, v[2], "Imagem", tabelaInfos)
                                    else 
                                        triggerServerEvent("MeloSCR:sendWhatsappMessage", localPlayer, localPlayer, contatoAtual.Conta, v[2], "Imagem")
                                    end 
                                    guiSetText(edits[12], "Mensagem")
                                    Aba = "Whatsapp"
                                    subAba = "Conversa"
                                    Texturas = {}
                                    TexturasTwo = {}
                                end 
                            elseif antigaAba == "MercadoLivre" then 
                                Aba = "MercadoLivre"
                                subAba = "Home"
                                fotoEscolhida = v
                                publicandoProduto = true
                                tickAnim = getTickCount()
                                Texturas = {}
                                TexturasTwo = {}
                            end 
                        end 
                        if #tableOrganizacaoX == 3 then
                            tableOrganizacaoX = {}
                        else 
                            table.remove(tableOrganizacaoY, #tableOrganizacaoY)
                        end 
                    end
                end   
            elseif Aba == "Ver Foto" then 
                if isMouseInPosition(x * (posCel + 235), y * 216, x * 16, y * 18) then 
                    confirmacaoExcluir = true
                end 
                if confirmacaoExcluir then 
                    if isMouseInPosition(x * (posCel + 50), y * 432, x * 82, y * 16) then 
                        confirmacaoExcluir = nil 
                    end 
                    if isMouseInPosition(x * (posCel + 150), y * 432, x * 82, y * 16) then 
                        confirmacaoExcluir = nil 
                        Texturas = {}
                        TexturasTwo = {}
                        triggerServerEvent("MeloSCR:deletePhoto", localPlayer, imageView)
                        Aba = "Galeria"
                        posY = 0
                        triggerServerEvent("JOAO.fotos", localPlayer, localPlayer)
                    end 
                end 
            elseif Aba == "Banco" then 
                if isMouseInPosition(x * 1117, y * 530, x * 154, y * 23) then 
                    if guiEditSetCaretIndex(edits[1], string.len(guiGetText(edits[1]))) then
                        guiBringToFront(edits[1])
                        guiSetInputMode('no_binds_when_editing') 
                        if (guiGetText(edits[1]) == "Insira a Quantidade...") then 
                            guiSetText(edits[1], '')
                        end
                    end
                end 
                if isMouseInPosition(x * 1167, y * 311, x * 20, y * 13) then 
                    vendoValor = not vendoValor
                end 
                if isMouseInPosition(x * (1095), y * 444, x * 45, y * 45) then 
                    if escolhendoAlguem then 
                        setTimer(
                            function ()
                                escolhendoAlguem = false  
                                registrandoPix = false  
                                voltandoBanco = false 
                            end, 1000, 1
                        )
                        voltandoBanco = true 
                        tickAnim = getTickCount()
                    else 
                        escolhendoAlguem = true 
                        tickAnim = getTickCount()
                    end   
                end 
                if escolhendoAlguem then 
                    local linha = 0
                    local indxTotal = 0
                    for i,v in ipairs(tableCategorias) do
                        if v.NomeCategoria ~= "Emergência" and escolhendoAlguem then 
                            for indx, conteudo in ipairs(tableContatos[v.NomeCategoria]) do
                                indxTotal = indxTotal + 1
                                if indxTotal > proximaPagina and linha < 4 then  
                                    linha = linha + 1
                                    if isMouseInPosition(x * 1083, y * (582 + linha * 25), x * 245, y * 25) then 
                                        theSelected = indxTotal
                                        tableSelected = conteudo
                                        break 
                                    end 
                                end 
                            end 
                        end 
                    end
                    if isMouseInPosition(x * 1083, y * 573, x * 245, y * 32) then 
                        escolhendoAlguem = nil  
                        registrandoPix = true 
                        tickAnim = getTickCount()
                    end 
                end 
                if registrandoPix then 
                    if isMouseInPosition(x * 1091, y * 621, x * 232, y * 20) then 
                        if guiEditSetCaretIndex(edits[9], string.len(guiGetText(edits[9]))) then
                            guiBringToFront(edits[9])
                            guiSetInputMode('no_binds_when_editing') 
                            if guiGetText(edits[9]) == "Nome de contato..." then 
                                guiSetText(edits[9], "")
                            end 
                        end
                    end 
                    if isMouseInPosition(x * 1091, y * 646, x * 232, y * 20) then 
                        if guiEditSetCaretIndex(edits[10], string.len(guiGetText(edits[10]))) then
                            guiBringToFront(edits[10])
                            guiSetInputMode('no_binds_when_editing')
                            if guiGetText(edits[10]) == "Número de telefone..." then 
                                guiSetText(edits[10], "")
                            end  
                        end
                    end 
                    if isMouseInPosition(x * 1166, y * 676, x * 82, y * 16) then 
                        if guiGetText(edits[9]) == "Nome de contato..." or guiGetText(edits[9]) == "" then 
                            return notifyC("Informe um nome de contato verdadeiro!", "error")
                        end 
                        if guiGetText(edits[10]) == "Número de telefone..." or guiGetText(edits[10]) == "" then 
                            return notifyC("Informe um número de telefone válido!", "error")
                        end 
                        theSelected = 0 
                        tableSelected = {Nome = guiGetText(edits[9]), Numero = guiGetText(edits[10])}
                        setTimer(
                            function ()
                                escolhendoAlguem = false  
                                registrandoPix = false  
                                voltandoBanco = false 
                            end, 1000, 1
                        )
                        voltandoBanco = true 
                        tickAnim = getTickCount()
                    end 
                end 
                if not registrandoPix and not escolhendoAlguem then 
                    if isMouseInPosition(x * 1272, y * 530, x * 46, y * 22) then
                        if theSelected then 
                            if tonumber(guiGetText(edits[1])) then 
                                triggerServerEvent("MeloSCR:sendMoneyBank", localPlayer, localPlayer, tonumber(guiGetText(edits[1])), tableSelected, tabelaInfos)
                            else 
                                notifyC("Digite um número válido!", "error")
                            end 
                        else 
                            notifyC("Você deve selecionar algum contato!", "error")
                        end     
                    end
                    local linha = 0
                    local abertoAtual = 0
                    for i,v in ipairs(tableCategorias) do
                        if v.NomeCategoria ~= "Emergência" and linha < 5 then 
                            for indx,conteudo in ipairs(tableContatos[v.NomeCategoria]) do 
                                linha = linha + 1
                                if isMouseInPosition(x * (1095 + linha * 35), y * 444, x * 45, y * 45) then 
                                    if abertoAtual ~= 0 and abertoAtual ~= linha then 
                                    else
                                        theSelected = linha 
                                        tableSelected = conteudo
                                        break 
                                    end 
                                end 
                            end
                        end 
                    end  
                    local abertoAtual_2 = 0 
                    for linha,conteudo in ipairs(tableLogBanco) do 
                        if linha < 5 then 
                            if isMouseInPosition(x * (1060 + (linha+1) * 35), y * 603, x * 45, y * 45) then 
                                theSelected = 0 
                                tableSelected = conteudo
                            end 
                        end 
                    end 
                    if isMouseInPosition(x * (1060 + (1) * 35), y * 603, x * 45, y * 45) then 
                        escolhendoAlguem = false  
                        registrandoPix = false  
                        voltandoBanco = false 
                        Aba = "Historico Banco"
                    end 
                end 
            elseif Aba == "Configuração" then 
                if not escolhendoWallpaper then 
                    local linha = 0
                    for i,v in pairs(animacoesConfig) do 
                        linha = linha + 1
                        if isMouseInPosition(x * (1276), y * ((318+linha*32) - posY), x * 39, y * 18) then
                            if timerAnim and isTimer(timerAnim) then 
                            else
                                Anim[i] = true 
                                tickAnim = getTickCount()
                                timerAnim = setTimer(
                                    function ()
                                        Anim[i] = nil 
                                        Configs[i] = not Configs[i] 
                                    end, 500, 1
                                )
                            end 
                        end 
                    end 
                else 
                    if isMouseInPosition(x * 1091, y * 648, x * 232, y * 20) then 
                        if guiEditSetCaretIndex(edits[2], string.len(guiGetText(edits[2]))) then
                            guiBringToFront(edits[2])
                            guiSetInputMode('no_binds_when_editing') 
                            if (guiGetText(edits[2]) == "Insira a URL da imagem...") then 
                                guiSetText(edits[2], '')
                            end
                        end
                    end 
                end 
                if isMouseInPosition(x * 1084, y * (279 - posY), x * 241, y * 22) then
                    if escolhendoWallpaper then 
                        setTimer(
                            function ()
                                escolhendoWallpaper = false  
                                voltandoWPP = false 
                            end, 1000, 1
                        )
                        voltandoWPP = true 
                        tickAnim = getTickCount()
                    else 
                        if not voltandoWPP then 
                            escolhendoWallpaper = true 
                            tickAnim = getTickCount()
                        end 
                    end 
                    
                end 
                if escolhendoWallpaper and ycal then 
                    if isMouseInPosition(x * (posCel+100), y * (ycal+72), x * 82, y * 16) then 
                        triggerServerEvent("MeloSCR:setWallpaperCelular", localPlayer, localPlayer, guiGetText(edits[2]))
                        escolhendoWallpaper = false
                        guiSetText(edits[2], 'Insira a URL da imagem...')
                    end 
                end 
            elseif Aba == "Telefone" then 
                for i,v in ipairs(botoesTelefone) do 
                    if isMouseInPosition((v[1]), v[2], v[3], v[4]) then 
                        animNumero[i] = true 
                        tickAnimacao[i] = getTickCount()
                        setTimer(
                            function ()
                                animNumero[i] = nil 
                            end, 800, 1
                        )
                        if #numeroCelular == 4 then 
                            numeroCelular = numeroCelular.."-"
                        elseif #numeroCelular == 9 then 
                            return 
                        end 
                        numeroCelular = numeroCelular..v[5]
                    end 
                end 
                if isMouseInPosition(x * (posCel + 114), y * 616, x * 54, y * 55) then 
                    triggerServerEvent("MeloSCR:onCall", localPlayer, localPlayer, numeroCelular)
                end 
            elseif Aba == "Notas" then 
                if subAba == "Home" then 
                    if isMouseInPosition(x * 1096, y * 243, x * 221, y * 20) then 
                        if guiEditSetCaretIndex(edits[3], string.len(guiGetText(edits[3]))) then
                            guiBringToFront(edits[3])
                            guiSetInputMode('no_binds_when_editing') 
                            if (guiGetText(edits[3]) == "Pesquise sua nota...") then 
                                guiSetText(edits[3], '')
                            end
                        end
                    end 
                    if isMouseInPosition(x * 1289, y * 671, x * 16, y * 16) then 
                        subAba = "Criar"
                    end 
                    local linha = 0
                    if tableNotas then 
                        for i,v in pairs(tableNotas) do 
                            if guiGetText(edits[3]) ~= "" and guiGetText(edits[3]) ~= "Pesquise sua nota..." then 
                                if string.find(v.titulo, guiGetText(edits[3])) then 
                                    if i > proximaPagina and linha < 10 then 
                                        linha = linha + 1
                                        if isMouseInPosition(x * 1273, y * (246 + linha * 39), x * 14, y * 8) then 
                                            subAba = "Ver"
                                            NotaVer = v
                                            indexNota = i
                                            break 
                                        end 
                                        if isMouseInPosition(x * 1292, y * (242 + linha * 39), x * 15, y * 15) then 
                                            subAba = "Editar"
                                            guiSetText(edits[4], v.titulo)
                                            guiSetText(edits[5], v.texto)
                                            NotaVer = v
                                            indexNota = i
                                            break
                                        end 
                                    end 
                                end 
                            else 
                                if i > proximaPagina and linha < 10 then 
                                    linha = linha + 1
                                    if isMouseInPosition(x * 1273, y * (246 + linha * 39), x * 14, y * 8) then 
                                        subAba = "Ver"
                                        NotaVer = v
                                        indexNota = i
                                        break 
                                    end 
                                    if isMouseInPosition(x * 1292, y * (242 + linha * 39), x * 15, y * 15) then 
                                        subAba = "Editar"
                                        guiSetText(edits[4], v.titulo)
                                        guiSetText(edits[5], v.texto)
                                        NotaVer = v
                                        indexNota = i
                                        break
                                    end 
                                end 
                            end 
                            
                        end 
                    end 
                    if isMouseInPosition(x * 1108, y * 671, x * 16, y * 16) then 
                        notifyC("Visualize uma nota para poder exclui-la!", "error")
                    end 
                elseif subAba == "Criar" or subAba == "Editar" then 
                    if isMouseInPosition(x * 1096, y * 226, x * 13, y * 13) then 
                        subAba = "Home"
                        escolhendoFoto = nil
                        escolhendoFoto = nil 
                        proximaPagina = 0
                        cursorY = y * 272
                        triggerServerEvent("MeloSCR:loadNotas", localPlayer, localPlayer)
                    end  
                    if isMouseInPosition(x * 1110, y * 219, x * 188, y * 30) then
                        if guiEditSetCaretIndex(edits[4], string.len(guiGetText(edits[4]))) then
                            guiBringToFront(edits[4])
                            guiSetInputMode('no_binds_when_editing') 
                            if (guiGetText(edits[4]) == "Defina um Título...") then 
                                guiSetText(edits[4], '')
                            end
                        end
                    end     
                    if isMouseInPosition(x * 1094, y * 255, x * 231, y * 393) then
                        if guiEditSetCaretIndex(edits[5], string.len(guiGetText(edits[5]))) then
                            guiBringToFront(edits[5])
                            guiSetInputMode('no_binds_when_editing') 
                            if (guiGetText(edits[5]) == "Anote as informações aqui...") then 
                                guiSetText(edits[5], '')
                            end
                        end
                    end     
                    if isMouseInPosition(x * 1288, y * 671, x * 17, y * 19) then 
                        if (guiGetText(edits[4]) ~= "Defina um Título..." and guiGetText(edits[4]) ~= "") then 
                            if (guiGetText(edits[5]) ~= "Anote as informações aqui..." and guiGetText(edits[5]) ~= "") then 
                                if subAba == "Criar" then 
                                    triggerServerEvent("MeloSCR:saveNota", localPlayer, localPlayer, guiGetText(edits[4]), guiGetText(edits[5]))
                                else 
                                    triggerServerEvent("MeloSCR:saveNota", localPlayer, localPlayer, guiGetText(edits[4]), guiGetText(edits[5]), indexNota)
                                end 
                                guiSetText(edits[4], "Defina um Título...")
                                guiSetText(edits[5], "Anote as informações aqui...")
                                subAba = "Home"
escolhendoFoto = nil
                                proximaPagina = 0
                                cursorY = y * 272
                            else 
                                notifyC("Você deve definir um Conteúdo!", "error")
                            end 
                        else 
                            notifyC("Você deve definir um Título!", "error")
                        end 
                    end 
                elseif subAba == "Ver" then 
                    if isMouseInPosition(x * 1096, y * 226, x * 13, y * 13) then 
                        subAba = "Home"
                        escolhendoFoto = nil
                        proximaPagina = 0
                        cursorY = y * 272
                    end  
                    if isMouseInPosition(x * 1108, y * 671, x * 16, y * 16) then 
                        subAba = "Excluir"
                        proximaPagina = 0
                        cursorY = y * 272
                    end 
                    if isMouseInPosition(x * 1285, y * 667, x * 23, y * 23) then 
                        subAba = "Editar"
                        guiSetText(edits[4], NotaVer.titulo)
                        guiSetText(edits[5], NotaVer.texto)
                    end 
                elseif subAba == "Excluir" then 
                    if isMouseInPosition(x * 1116, y * 432, x * 82, y * 16) then 
                        NotaVer = nil 
                        subAba = "Home"
                        escolhendoFoto = nil
                        proximaPagina = 0
                        cursorY = y * 272
                    end 
                    if isMouseInPosition(x * 1216, y * 432, x * 82, y * 16) then 
                        triggerServerEvent("MeloSCR:deleteNota", localPlayer, localPlayer, indexNota)
                        subAba = "Home"
                        escolhendoFoto = nil
                        proximaPagina = 0
                        cursorY = y * 272
                        indexNota = nil 
                        NotaVer = nil 
                    end 
                end 
            elseif Aba == "Spotify" then 
                if isMouseInPosition(x * 1123, y * 259, x * 189, y * 18) then 
                    if guiEditSetCaretIndex(edits[6], string.len(guiGetText(edits[6]))) then
                        guiBringToFront(edits[6])
                        guiSetInputMode('no_binds_when_editing') 
                        if (guiGetText(edits[6]) == "Pesquise sua música...") then 
                            guiSetText(edits[6], '')
                        end
                    end
                end 
                if isMouseInPosition(x * 1096, y * 258, x * 25, y * 20) then 
                    if guiGetText(edits[6]) ~= "Pesquise sua música..." and guiGetText(edits[6]) ~= "" then 
                        triggerServerEvent("Schootz.getMusicSpotify", localPlayer, guiGetText(edits[6]))
                        imagemSpotifyCount = {}
                    else 
                        notifyC("Digite algo relacionado a música desejada!", "error")
                    end 
                end 
                local linha = 0
                for i,v in ipairs(imagemSpotifyCount) do 
                    if i > proximaPagina and linha < 7 then 
                        linha = linha + 1
                        if isMouseInPosition(x * (posCel + 23), y * (246 + linha * 46), x * 228, y * 34) then 
                            tocarSom(v[3])
                            tocandoMusica = v
                        end 
                    end 
                end 
                if tocandoMusica and sound and isElement(sound) then 
                    if isMouseInPosition(x * 1262, y * 624, x * 9, y * 11) then 
                        setSoundPaused(sound, not isSoundPaused(sound))
                        pontoinicial = barra
                    end 
                    if isMouseInPosition(x * 1279, y * 623, x * 13, y * 12) then 
                        setSoundVolume(sound, getSoundVolume(sound)-0.5)
                    end 
                    if isMouseInPosition(x * 1300, y * 623, x * 13, y * 12) then 
                        setSoundVolume(sound, getSoundVolume(sound)+0.5)
                    end 
                end 
                if isMouseInPosition(x * 1134, y * 667, x * 34, y * 18) then
                    --JBL
                end 
                if isMouseInPosition(x * 1248, y * 664, x * 28, y * 23) then 
                    if tocandoMusica and sound and isElement(sound) then 
                        if getPedOccupiedVehicle(localPlayer) then 
                            setSoundPaused(sound, true)
                            triggerServerEvent("JOAO.tocarNoCarroSpotify", localPlayer, localPlayer, tocandoMusica[3])
                        else 
                            notifyC("Você deve estar em um veículo!", "error")
                        end 
                    else 
                        notifyC("Não há nenhuma música sendo reproduzida!", "error")
                    end 
                end 
            elseif Aba == "Contatos" then 
                if isMouseInPosition(x * 1091, y * 246, x * 232, y * 20) then 
                    if guiEditSetCaretIndex(edits[8], string.len(guiGetText(edits[8]))) then
                        guiBringToFront(edits[8])
                        guiSetInputMode('no_binds_when_editing') 
                        if (guiGetText(edits[8]) == "Pesquisar") then 
                            guiSetText(edits[8], '')
                        end
                    end
                end 
                additionalY = 0
                for i,v in ipairs(tableCategorias) do
                    additionalY = additionalY + 25 
                    for indx,conteudo in ipairs(tableContatos[v.NomeCategoria]) do 
                        if guiGetText(edits[8]) == "Pesquisar" or guiGetText(edits[8]) == "" or string.find(conteudo.Nome, guiGetText(edits[8])) then 
                            additionalY = additionalY + 25
                            if isMouseInPosition(x * (1087), y * (((250 + additionalY)) - posY), x * 240, y * 24) then
                                if selectedContact and selectedContact == additionalY then 
                                    if v.NomeCategoria ~= "Emergência" then 
                                        if isMouseInPosition(x * (1255), y * ((250 + additionalY)) - posY, x * 13, y * 13) then 
                                            confirmacaoExcluir = true 
                                            contatoExcluir = conteudo
                                        end 
                                        if isMouseInPosition(x * (1273), y * ((250 + additionalY)) - posY, x * 13, y * 13) then 
                                            if editandoContato then 
                                                setTimer(
                                                    function ()
                                                        editandoContato = false  
                                                        voltandoCTT = false 
                                                    end, 1000, 1
                                                )
                                                voltandoCTT = true 
                                                tickAnim = getTickCount()
                                            else 
                                                editandoContato = conteudo 
                                                guiSetText(edits[9], conteudo.Nome)
                                                guiSetText(edits[10], conteudo.Numero)
                                                tickAnim = getTickCount()
                                            end 
                                        end 
                                        if isMouseInPosition(x * (1291), y * ((250 + additionalY)) - posY, x * 13, y * 13) then 
                                            
                                        end 
                                    end 
                                    if isMouseInPosition(x * (1309), y * ((250 + additionalY)) - posY, x * 13, y * 13) then 
                                        triggerServerEvent("MeloSCR:onCall", localPlayer, localPlayer, conteudo.Numero)
                                    end 
                                    selectedContact = nil
                                else 
                                    selectedContact = additionalY
                                end 
                            end 
                        end 
                    end 
                end 
                if editandoContato then 
                    if isMouseInPosition(x * 1091, y * 621, x * 232, y * 20) then 
                        if guiEditSetCaretIndex(edits[9], string.len(guiGetText(edits[9]))) then
                            guiBringToFront(edits[9])
                            guiSetInputMode('no_binds_when_editing') 
                        end
                    end 
                    if isMouseInPosition(x * 1091, y * 646, x * 232, y * 20) then 
                        if guiEditSetCaretIndex(edits[10], string.len(guiGetText(edits[10]))) then
                            guiBringToFront(edits[10])
                            guiSetInputMode('no_binds_when_editing') 
                        end
                    end 
                    if isMouseInPosition(x * (1166), y * 676, x * 82, y * 16) then  
                        if guiGetText(edits[9]) ~= "" then 
                            if guiGetText(edits[10]) ~= "" then 
                                triggerServerEvent("MeloSCR:editContact", localPlayer, localPlayer, editandoContato, guiGetText(edits[9]), guiGetText(edits[10]))
                                editandoContato = false  
                                voltandoCTT = false 
                            else 
                                notifyC("Número Inválido!", "error")
                            end 
                        else 
                            notifyC("Nome Inválido!", "error")
                        end 
                    end 
                end     
                if adicionandoContato then 
                    if isMouseInPosition(x * 1091, y * 621, x * 232, y * 20) then 
                        if guiEditSetCaretIndex(edits[9], string.len(guiGetText(edits[9]))) then
                            guiBringToFront(edits[9])
                            guiSetInputMode('no_binds_when_editing') 
                            if guiGetText(edits[9]) == "Nome de contato..." then 
                                guiSetText(edits[9], "")
                            end 
                        end
                    end 
                    if isMouseInPosition(x * 1091, y * 646, x * 232, y * 20) then 
                        if guiEditSetCaretIndex(edits[10], string.len(guiGetText(edits[10]))) then
                            guiBringToFront(edits[10])
                            guiSetInputMode('no_binds_when_editing')
                            if guiGetText(edits[10]) == "Número de telefone..." then 
                                guiSetText(edits[10], "")
                            end  
                        end
                    end 
                    if isMouseInPosition(x * (1166), y * 676, x * 82, y * 16) then  
                        if guiGetText(edits[9]) ~= "" and guiGetText(edits[9]) ~= "Nome de contato..." then 
                            if guiGetText(edits[10]) ~= "" and guiGetText(edits[10]) ~= "Número de telefone..." then 
                                triggerServerEvent("MeloSCR:addContact", localPlayer, localPlayer, guiGetText(edits[9]), guiGetText(edits[10]))
                                adicionandoContato = false  
                                voltandoCTT = false 
                            else 
                                notifyC("Número Inválido!", "error")
                            end 
                        else 
                            notifyC("Nome Inválido!", "error")
                        end 
                    end 
                end     
                if confirmacaoExcluir then 
                    if isMouseInPosition(x * (posCel + 50), y * 432, x * 82, y * 16) then 
                        confirmacaoExcluir = nil 
                    end 
                    if isMouseInPosition(x * (posCel + 150), y * 432, x * 82, y * 16) then 
                        confirmacaoExcluir = nil 
                        triggerServerEvent("MeloSCR:deleteContact", localPlayer, localPlayer, contatoExcluir)
                    end 
                end 
                if isMouseInPosition(x * 1240, y * (216 - posY), x * 77, y * 14) then 
                    if adicionandoContato then 
                        setTimer(
                            function ()
                                adicionandoContato = false  
                                voltandoCTT = false 
                            end, 1000, 1
                        )
                        voltandoCTT = true 
                        tickAnim = getTickCount()
                    else 
                        adicionandoContato = true
                        guiSetText(edits[9], "Nome de contato...")
                        guiSetText(edits[10], "Número de telefone...")
                        tickAnim = getTickCount()
                    end 
                end 
            elseif Aba == "Chamada" then 
                if subAba == "Chamando" then 
                    if isMouseInPosition(x * 1183, y * 569, x * 48, y * 48) then 
                        Aba = "Home"
                        subAba = nil 
                        conversaAtual = nil 
                        contatoAtual = nil 
                        guiSetInputMode("allow_binds")
                        posY = 0
                    end 
                    if isMouseInPosition(x * 1189, y * 512, x * 35, y * 35) then 
                        stateMic = not stateMic
                    end 
                elseif subAba == "Recebendo" then 
                    if isMouseInPosition(x * 1122, y * 569, x * 48, y * 48) then 
                        Aba = "Home"
                        conversaAtual = nil 
                        contatoAtual = nil 
                        posY = 0
                        subAba = nil 
                    end 
                    if isMouseInPosition(x * 1242, y * 569, x * 48, y * 48) then 
                        subAba = "Em Chamada"
                        timestampInicio = getRealTime().timestamp
                        stateMic = true
                    end 
                elseif subAba == "Em Chamada" then 
                    if isMouseInPosition(x * 1183, y * 569, x * 48, y * 48) then 
                        Aba = "Home"
                        conversaAtual = nil 
                        contatoAtual = nil 
                        posY = 0
                        subAba = nil 
                    end 
                    if isMouseInPosition(x * 1189, y * 512, x * 35, y * 35) then 
                        stateMic = not stateMic
                    end 
                end 
            elseif Aba == "Whatsapp" then
                if subAba == "Home" then 
                    if isMouseInPosition(x * 1303, y * 214, x * 15, y * 15) then 
                        subAba = "Pesquisa"
                    end 
                    if theTableHome and #theTableHome > 0 then 
                        local linha = 0
                        for i,v in ipairs(theTableHome) do 
                            linha = linha + 1
                            if isMouseInPosition(x * 1084, y * (199 + linha * 45), x * 246, y * 41) then 
                                guiSetText(edits[12], "Mensagem")
                                if not v.theType then 
                                    contatoAtual = v.theAllTable
                                    triggerServerEvent("MeloSCR:getInfosContato", localPlayer, localPlayer, contatoAtual.Conta, v.NaoLidas)
                                    contatoAtual.Online = "Offline"
                                    if tableWhatsapp and #tableWhatsapp > 0 then 
                                        for i,v in pairs(fromJSON(tableWhatsapp[1].Conversas)) do 
                                            if i == contatoAtual.Conta then 
                                                conversaAtual = v
                                                table.sort(conversaAtual, function (a,b) return a[3] > b[3] end)
                                                if conversaAtual and #conversaAtual > 0 then 
                                                    triggerServerEvent("MeloSCR:loadImages", localPlayer, localPlayer, conversaAtual)
                                                    tickAnim = getTickCount()
                                                    local linhasAdicionais = 0
                                                    maxY["Whatsapp"] = 0
                                                    for i,v in ipairs(conversaAtual) do 
                                                        if v[2] == "Enviou" and v[4] then 
                                                            if v[4] == "Localização" then contagemLinhas = 50 end 
                                                            if v[4] == "Contato" then contagemLinhas = 42 end 
                                                            if v[4] == "Imagem" then contagemLinhas = 124 end 
                                                        elseif v[2] == "Recebeu" and v[5] then 
                                                            if v[5] == "Localização" then contagemLinhas = 50 end 
                                                            if v[5] == "Contato" then contagemLinhas = 42 end 
                                                            if v[5] == "Imagem" then contagemLinhas = 124 end 
                                                        else 
                                                            contagemLinhas = getContagemLinhas(dxGetTextWidth(v[1], 1, fonts[18]) / 224)
                                                        end 
                                                        maxY["Whatsapp"] = (linhasAdicionais + contagemLinhas) * 9
                                                        linhasAdicionais = linhasAdicionais + contagemLinhas
                                                    end 
                                                end 
                                                subAba = "Conversa"
                                                break  
                                            end 
                                        end 
                                    end
                                    break 
                                elseif v.theType == "Grupo" then 
                                    contatoAtual = {Tipo = "Grupo", Nome = v.Nome}
                                    contatoAtual.Imagem = v.Imagem
                                    triggerServerEvent("MeloSCR:getInfosContato", localPlayer, localPlayer, contatoAtual, v.NaoLidas, tabelaInfos)
                                    if type(v.theAllTable.Participantes) == "string" then 
                                        contatoAtual.Online = #fromJSON(v.theAllTable.Participantes)
                                    else 
                                        contatoAtual.Online = #v.theAllTable.Participantes
                                    end 
                                    
                                    if tableWhatsapp and #tableWhatsapp > 0 then 
                                        for i,v in pairs(fromJSON(tableWhatsapp[1].Conversas)) do 
                                            if i == contatoAtual.Nome then 
                                                conversaAtual = v[2]
                                                table.sort(conversaAtual, function (a,b) return a[4] > b[4] end)
                                                if conversaAtual and #conversaAtual > 0 then 
                                                    triggerServerEvent("MeloSCR:loadImages", localPlayer, localPlayer, conversaAtual)
                                                    tickAnim = getTickCount()
                                                    local linhasAdicionais = 0
                                                    maxY["Whatsapp"] = 0
                                                    for i,v in ipairs(conversaAtual) do 
                                                        if v[5] then 
                                                            if v[5] == "Localização" then contagemLinhas = 50 end 
                                                            if v[5] == "Contato" then contagemLinhas = 42 end 
                                                            if v[5] == "Imagem" then contagemLinhas = 124 end 
                                                        else 
                                                            contagemLinhas = getContagemLinhas(dxGetTextWidth(v[1], 1, fonts[18]) / 224)
                                                        end 
                                                        maxY["Whatsapp"] = (linhasAdicionais + contagemLinhas) * 9
                                                        linhasAdicionais = linhasAdicionais + contagemLinhas
                                                    end 
                                                end 
                                                subAba = "Conversa"
                                                break  
                                            end 
                                        end 
                                    end
                                    break 
                                end 
                            end 
                        end 
                    end 
                elseif subAba == "Pesquisa" then 
                    if isMouseInPosition(x * 1095, y * 211, x * 200, y * 21) then 
                        if guiEditSetCaretIndex(edits[11], string.len(guiGetText(edits[11]))) then
                            guiBringToFront(edits[11])
                            guiSetInputMode('no_binds_when_editing') 
                            if guiGetText(edits[11]) == "Procure pelos seus contatos..." then 
                                guiSetText(edits[11], "")
                            end 
                        end
                    end 
                    if isMouseInPosition(x * 1084, y * 244, x * 246, y * 41) then 
                        if escolhendoAlguem then 
                            setTimer(
                                function ()
                                    escolhendoAlguem = false  
                                    voltandoBanco = false 
                                end, 1000, 1
                            )
                            voltandoBanco = true 
                            tickAnim = getTickCount()
                        else 
                            escolhendoAlguem = true 
                            tickAnim = getTickCount()
                        end  
                    end 
                    if isMouseInPosition(x * 1084, y * 289, x * 246, y * 41) then 
                        if escolhendoAlguem then 
                            setTimer(
                                function ()
                                    escolhendoAlguem = false  
                                    voltandoBanco = false 
                                end, 1000, 1
                            )
                            voltandoBanco = true 
                            tickAnim = getTickCount()
                        end  
                        subAba = "Criar Grupo"
                        tablePartcipants = {}
                        table.insert(tablePartcipants, {Nome = "Você", Cargo = "Dono(a)", Avatar = (getElementData(localPlayer, "Avatar") or 0), Numero = tabelaInfos.Numero})
                    end 
                    local linha = 0
                    for i,v in ipairs(tableCategorias) do
                        if v.NomeCategoria ~= "Emergência" then 
                            for indx,conteudo in ipairs(tableContatos[v.NomeCategoria]) do 
                                if guiGetText(edits[11]) == "" or guiGetText(edits[11]) == "Procure pelos seus contatos..." or string.find(string.lower(conteudo.Nome), string.lower(guiGetText(edits[11]))) then 
                                    linha = linha + 1
                                    if isMouseInPosition(x * 1084, y * (289 + linha * 45), x * 246, y * 41) then 
                                        subAba = "Conversa"
                                        contatoAtual = conteudo
                                        triggerServerEvent("MeloSCR:getInfosContato", localPlayer, localPlayer, contatoAtual.Conta)
                                        if tableWhatsapp and #tableWhatsapp > 0 then 
                                            for i,v in pairs(fromJSON(tableWhatsapp[1].Conversas)) do 
                                                if i == contatoAtual.Conta then 
                                                    conversaAtual = v
                                                    table.sort(conversaAtual, function (a,b) return a[3] > b[3] end)
                                                    if conversaAtual and #conversaAtual > 0 then 
                                                        triggerServerEvent("MeloSCR:loadImages", localPlayer, localPlayer, conversaAtual)
                                                        tickAnim = getTickCount()
                                                        local linhasAdicionais = 0
                                                        local contagemLinhas = 0
                                                        maxY["Whatsapp"] = 0
                                                        for i,v in ipairs(conversaAtual) do 
                                                            if v[2] == "Enviou" and v[4] then 
                                                                if v[4] == "Localização" then contagemLinhas = 50 end 
                                                                if v[4] == "Contato" then contagemLinhas = 42 end 
                                                            elseif v[2] == "Recebeu" and v[5] then 
                                                                if v[5] == "Localização" then contagemLinhas = 50 end 
                                                                if v[5] == "Contato" then contagemLinhas = 42 end 
                                                            else 
                                                                contagemLinhas = getContagemLinhas(dxGetTextWidth(v[1], 1, fonts[18]) / 224)
                                                            end 
                                                            maxY["Whatsapp"] = (linhasAdicionais + contagemLinhas) * 9
                                                            linhasAdicionais = linhasAdicionais + contagemLinhas
                                                        end 
                                                    end 
                                                    return 
                                                end 
                                            end 
                                        end
                                        conversaAtual = {}
                                    end 
                                end 
                            end 
                        end 
                    end 
                    if escolhendoAlguem then 
                        local linha = 0
                        local indxTotal = 0
                        for i,v in ipairs(tableCategorias) do
                            if v.NomeCategoria ~= "Emergência" and escolhendoAlguem then 
                                for indx,conteudo in ipairs(tableContatos[v.NomeCategoria]) do
                                    indxTotal = indxTotal + 1
                                    if indxTotal > proximaPagina and linha < 4 then  
                                        linha = linha + 1
                                        if isMouseInPosition(x * 1083, y * ((577 - 29) + linha * 25), x * 245, y * 25) or theSelected == indxTotal  then 
                                            subAba = "Conversa"
                                            contatoAtual = conteudo
                                            contatoAtual.Online = "Offline"
                                            triggerServerEvent("MeloSCR:getInfosContato", localPlayer, localPlayer, conteudo.Conta)
                                            escolhendoAlguem = nil 
                                            if tableWhatsapp and #tableWhatsapp > 0 then 
                                                for i,v in pairs(fromJSON(tableWhatsapp[1].Conversas)) do 
                                                    if i == contatoAtual.Conta then 
                                                        conversaAtual = v
                                                        table.sort(conversaAtual, function (a,b) return a[3] > b[3] end)
                                                        if conversaAtual and #conversaAtual > 0 then 
                                                            triggerServerEvent("MeloSCR:loadImages", localPlayer, localPlayer, conversaAtual)
                                                            tickAnim = getTickCount()
                                                            local linhasAdicionais = 0
                                                            maxY["Whatsapp"] = 0
                                                            for i,v in ipairs(conversaAtual) do 
                                                                if v[2] == "Enviou" and v[4] then 
                                                                    if v[4] == "Localização" then contagemLinhas = 50 end 
                                                                    if v[4] == "Contato" then contagemLinhas = 42 end 
                                                                elseif v[2] == "Recebeu" and v[5] then 
                                                                    if v[5] == "Localização" then contagemLinhas = 50 end 
                                                                    if v[5] == "Contato" then contagemLinhas = 42 end 
                                                                else 
                                                                    contagemLinhas = getContagemLinhas(dxGetTextWidth(v[1], 1, fonts[18]) / 224)
                                                                end 
                                                                maxY["Whatsapp"] = (linhasAdicionais + contagemLinhas) * 9
                                                                linhasAdicionais = linhasAdicionais + contagemLinhas
                                                            end 
                                                        end 
                                                        return 
                                                    end 
                                                end 
                                            end
                                            conversaAtual = {}
                                        end 
                                    end 
                                end 
                            end 
                        end 
                    end 
                elseif subAba == "Conversa" then 
                    if isMouseInPosition(x * 1113, y * 657, x * 138, y * 27) then 
                        if guiEditSetCaretIndex(edits[12], string.len(guiGetText(edits[12]))) then
                            guiBringToFront(edits[12])
                            guiSetInputMode('allow_binds') 
                            if guiGetText(edits[12]) == "Mensagem" then 
                                guiSetText(edits[12], "")
                            end 
                        end
                    end 
                    if isMouseInPosition(x * (1285), y * (653), x * 35, y * 35) then 
                        if guiGetText(edits[12]) ~= "" and guiGetText(edits[12]) ~= "Mensagem" then 
                            if contatoAtual.Tipo and contatoAtual.Tipo == "Grupo" then 
                                triggerServerEvent("MeloSCR:sendWhatsappMessage", localPlayer, localPlayer, contatoAtual.Nome, guiGetText(edits[12]), _, tabelaInfos)
                            else 
                                triggerServerEvent("MeloSCR:sendWhatsappMessage", localPlayer, localPlayer, contatoAtual.Conta, guiGetText(edits[12]))
                            end 
                            
                            guiSetText(edits[12], "")
                        end 
                    end 
                    if contatoAtual.Tipo and contatoAtual.Tipo == "Grupo" then 
                        if isMouseInPosition(x * 1082, y * 199, x * 251, y * 47) then 
                            for i,v in ipairs(theTableHome) do 
                                if v.theType == "Grupo" and v.theAllTable.NomeGrupo == contatoAtual.Nome then 
                                    grupoAtual = v.theAllTable
                                    grupoAtual.Imagem = contatoAtual.Imagem
                                    if type(grupoAtual.Participantes) == "string" then 
                                        grupoAtual.Participantes = fromJSON(grupoAtual.Participantes)
                                    end 
                                    subAba = "Informações Grupo"
                                    guiSetText(edits[13], grupoAtual.NomeGrupo)
                                    isAdm = nil 
                                    break 
                                end 
                            end 
                        end 
                    end 
                    if isMouseInPosition(x * (1251), y * (657), x * 29, y * 27) then 
                        escolhendoClipe = not escolhendoClipe
                    end 
                    if escolhendoAlguem then 
                        local linha = 0
                        local indxTotal = 0
                        for i,v in ipairs(tableCategorias) do
                            if v.NomeCategoria ~= "Emergência" and escolhendoAlguem then 
                                for indx,conteudo in ipairs(tableContatos[v.NomeCategoria]) do
                                    indxTotal = indxTotal + 1
                                    if indxTotal > proximaPagina and linha < 4 then  
                                        linha = linha + 1
                                        if isMouseInPosition(x * 1083, y * ((577 - 29) + linha * 25), x * 245, y * 25) then 
                                            if contatoAtual.Tipo and contatoAtual.Tipo == "Grupo" then 
                                                triggerServerEvent("MeloSCR:sendWhatsappMessage", localPlayer, localPlayer, contatoAtual.Nome, conteudo, "Contato", tabelaInfos)
                                            else 
                                                triggerServerEvent("MeloSCR:sendWhatsappMessage", localPlayer, localPlayer, contatoAtual.Conta, conteudo, "Contato")
                                            end 
                                            
                                            if escolhendoAlguem then 
                                                setTimer(
                                                    function ()
                                                        escolhendoAlguem = false  
                                                        registrandoPix = false  
                                                        voltandoBanco = false 
                                                    end, 1000, 1
                                                )
                                                voltandoBanco = true 
                                                tickAnim = getTickCount()
                                            end   
                                            break 
                                        end 
                                    end 
                                end 
                            end 
                        end 
                    end 
                    if escolhendoClipe then 
                        if isMouseInPosition(x * 1104, y * 574, x * 66, y * 72) then 
                            escolhendoClipe = false 
                            escolhendoAlguem = true 
                            tickAnim = getTickCount() 
                        end 
                        if isMouseInPosition(x * 1170, y * 574, x * 64, y * 72) then 
                            triggerServerEvent("JOAO.fotos", localPlayer, localPlayer)
                            Aba = "Galeria"
                            escolhendoFoto = true
                            antigaAba = "Whatsapp"
                        end 
                        if isMouseInPosition(x * 1234, y * 575, x * 60, y * 72) then 
                            if contatoAtual.Tipo and contatoAtual.Tipo == "Grupo" then 
                                triggerServerEvent("MeloSCR:sendWhatsappMessage", localPlayer, localPlayer, contatoAtual.Nome, _, "Localização", tabelaInfos)
                            else 
                                triggerServerEvent("MeloSCR:sendWhatsappMessage", localPlayer, localPlayer, contatoAtual.Conta, _, "Localização")
                            end 
                            
                            escolhendoClipe = false 
                        end 
                    end 
                    if conversaAtual and #conversaAtual > 0 then 
                        local linha = 0
                        local linhasAdicionais = 0
                        for i,v in ipairs(conversaAtual) do 
                            linha = linha + 1
                            if v[2] == "Enviou" then 
                                if v[4] then 
                                    if v[4] == "Localização" then 
                                        contagemLinhas = 3
                                        alturaTexto = 50
                                        larguraTexto = 132
                                        if isMouseInPosition(x * (1192), y * ((647 - (linhasAdicionais + contagemLinhas) * 18) + posY), x * larguraTexto, y * (alturaTexto)) then 
                                            if getPedOccupiedVehicle(localPlayer) then 
                                                notifyC("Rota Marcada em seu GPS!", "info")
                                                exports["radar"]:makeRoute(v[1][1], v[1][2], true)
                                            else 
                                                notifyC("Você não está em um veículo!", "error")
                                            end 
                                            break 
                                        end 
                                    elseif v[4] == "Contato" then 
                                        contagemLinhas = 3
                                        alturaTexto = 50
                                        larguraTexto = 132
                                        if isMouseInPosition(x * (1192), y * ((647 - (linhasAdicionais + contagemLinhas) * 18) + posY), x * larguraTexto, y * (alturaTexto)) then 
                                            setClipboard(v[1][2])
                                            notifyC("Contato Copiado!", "success")
                                            break 
                                        end 
                                    end 
                                end     
                                linhasAdicionais = linhasAdicionais + contagemLinhas
                            elseif v[2] == "Recebeu" then 
                                if v[5] then 
                                    if v[5] == "Localização" then 
                                        contagemLinhas = 3
                                        alturaTexto = 50
                                        larguraTexto = 132
                                        if isMouseInPosition(x * (1089), y * ((647 - (linhasAdicionais + contagemLinhas) * 18) + posY), x * larguraTexto, y * (alturaTexto)) then 
                                            if getPedOccupiedVehicle(localPlayer) then 
                                                notifyC("Rota Marcada em seu GPS!", "info")
                                                exports["radar"]:makeRoute(v[1][1], v[1][2], true)
                                            else 
                                                notifyC("Você não está em um veículo!", "error")
                                            end 
                                            break 
                                        end 
                                    elseif v[5] == "Contato" then 
                                        contagemLinhas = 3
                                        alturaTexto = 50
                                        larguraTexto = 132
                                        if isMouseInPosition(x * (1089), y * ((647 - (linhasAdicionais + contagemLinhas) * 18) + posY), x * larguraTexto, y * (alturaTexto)) then 
                                            setClipboard(v[1][2])
                                            notifyC("Contato Copiado!", "success")
                                            break 
                                        end 
                                    end 
                                end   
                                linhasAdicionais = linhasAdicionais + contagemLinhas
                            end 
                        end 
                    end 
                elseif subAba == "Criar Grupo" then 
                    if isMouseInPosition(x * 1083, y * 209, x * 46, y * 23) then 
                        subAba = "Home"
escolhendoFoto = nil
                        escolhendoAlguem = nil 
                    end 
                    if isMouseInPosition(x * 1132, y * 245, x * 162, y * 37) then 
                        if guiEditSetCaretIndex(edits[13], string.len(guiGetText(edits[13]))) then
                            guiBringToFront(edits[13])
                            guiSetInputMode('no_binds_when_editing') 
                            if guiGetText(edits[13]) == "Nome do Grupo..." then 
                                guiSetText(edits[13], "")
                            end 
                        end
                    end 
                    if isMouseInPosition(x * 1273, y * 206, x * 53, y * 30) then 
                        if imagemGrupo then 
                            triggerServerEvent("MeloSCR:createWhatsappGroup", localPlayer, localPlayer, guiGetText(edits[13]), tablePartcipants, imagemGrupo[2])
                            subAba = "Home"
                            escolhendoFoto = nil
                            escolhendoAlguem = nil
                        else 
                            notifyC("Você deve escolher um imagem para o grupo!", "error")
                        end 
                    end 
                    if isMouseInPosition(x * 1303, y * 320, x * 12, y * 13) then 
                        escolhendoAlguem = true 
                        tickAnim = getTickCount() 
                    end 
                    if isMouseInPosition(x * (posCel + 27), y * 245, x * 35, y * 35) then 
                        triggerServerEvent("JOAO.fotos", localPlayer, localPlayer)
                        Aba = "Galeria"
                        escolhendoFoto = true
                        antigaAba = "Whatsapp"
                        criandoGrupo = true
                    end 
                    if escolhendoAlguem then 
                        local linha = 0
                        local indxTotal = 0
                        for i,v in ipairs(tableCategorias) do
                            if v.NomeCategoria ~= "Emergência" and escolhendoAlguem then 
                                for indx,conteudo in ipairs(tableContatos[v.NomeCategoria]) do
                                    indxTotal = indxTotal + 1
                                    if indxTotal > proximaPagina and linha < 4 then  
                                        linha = linha + 1
                                        if isMouseInPosition(x * 1083, y * ((577 - 29) + linha * 25), x * 245, y * 25) then 
                                            table.insert(tablePartcipants, {Nome = conteudo.Nome, Cargo = "Membro", Numero = conteudo.Numero, Avatar = conteudo.Avatar, Conta = conteudo.Conta})
                                            if escolhendoAlguem then 
                                                setTimer(
                                                    function ()
                                                        escolhendoAlguem = false  
                                                        registrandoPix = false  
                                                        voltandoBanco = false 
                                                    end, 1000, 1
                                                )
                                                voltandoBanco = true 
                                                tickAnim = getTickCount()
                                            end   
                                            break 
                                        end 
                                    end 
                                end 
                            end 
                        end 
                    end
                    for i,v in ipairs(tablePartcipants) do 
                        if config.tableCoresCargo[v.Cargo].posXmais then 
                            if isMouseInPosition((posCel + config.tableCoresCargo[v.Cargo].posXcargo - 10), y * (325 + i * 46), x * 6, y * 15) then 
                                if v.Cargo == "Admin" then 
                                    v.Cargo = "Membro" 
                                end 
                            end 
                            if isMouseInPosition((posCel + config.tableCoresCargo[v.Cargo].posXmais), y * (325 + i * 46), x * 9, y * 15) then 
                                if v.Cargo == "Membro" then 
                                    v.Cargo = "Admin" 
                                end 
                            end 
                        end 
                    end 
                elseif subAba == "Informações Grupo" then 
                    if isMouseInPosition(x * 1083, y * 209, x * 46, y * 23) then 
                        subAba = "Home"
                        escolhendoFoto = nil
                        escolhendoAlguem = nil
                    end 
                    if isAdm then 
                        if isMouseInPosition(x * 1132, y * 245, x * 162, y * 37) then 
                            if guiEditSetCaretIndex(edits[13], string.len(guiGetText(edits[13]))) then
                                guiBringToFront(edits[13])
                                guiSetInputMode('no_binds_when_editing') 
                                if guiGetText(edits[13]) == "Nome do Grupo..." then 
                                    guiSetText(edits[13], "")
                                end 
                            end
                        end 
                        if isMouseInPosition(x * 1273, y * 206, x * 53, y * 30) then 
                            triggerServerEvent("MeloSCR:updateWhatsappGroup", localPlayer, localPlayer, guiGetText(edits[13]), grupoAtual, (imagemGrupo and imagemGrupo[2] and imagemGrupo[2] or _))
                            subAba = "Home"
                            escolhendoFoto = nil
                            escolhendoAlguem = nil
                            contatoAtual = nil 
                            conversaAtual = nil 
                        end 
                        
                        if isMouseInPosition(x * 1303, y * 289, x * 12, y * 12) then 
                            escolhendoAlguem = true 
                            tickAnim = getTickCount() 
                        end 
                        if isMouseInPosition(x * (posCel + 27), y * 245, x * 35, y * 35) then 
                            triggerServerEvent("JOAO.fotos", localPlayer, localPlayer)
                            Aba = "Galeria"
                            escolhendoFoto = true
                            antigaAba = "Whatsapp"
                            editandoGrupo = true
                        end 
                        if escolhendoAlguem then 
                            local linha = 0
                            local indxTotal = 0
                            for i,v in ipairs(tableCategorias) do
                                if v.NomeCategoria ~= "Emergência" and escolhendoAlguem then 
                                    for indx,conteudo in ipairs(tableContatos[v.NomeCategoria]) do
                                        indxTotal = indxTotal + 1
                                        if indxTotal > proximaPagina and linha < 4 then  
                                            linha = linha + 1
                                            if isMouseInPosition(x * 1083, y * ((577 - 29) + linha * 25), x * 245, y * 25) then
                                                for indx2, conteudo2 in ipairs(grupoAtual.Participantes) do 
                                                    if conteudo2[1] == conteudo.Conta then 
                                                        return notifyC("Este membro ja foi adicionado!", "error")
                                                    end 
                                                end 
                                                table.insert(grupoAtual.Participantes, {conteudo.Conta, conteudo.Avatar,"Membro", conteudo.Numero})
                                                if escolhendoAlguem then 
                                                    setTimer(
                                                        function ()
                                                            escolhendoAlguem = false  
                                                            registrandoPix = false  
                                                            voltandoBanco = false 
                                                        end, 1000, 1
                                                    )
                                                    voltandoBanco = true 
                                                    tickAnim = getTickCount()
                                                end   
                                                break 
                                            end 
                                        end 
                                    end 
                                end 
                            end 
                        end
                        local linha = 0
                        for i,v in ipairs(grupoAtual.Participantes) do 
                            if i > proximaPagina and linha < 9 then 
                                linha = linha + 1
                                if config.tableCoresCargo[v[3]].posXmais then 
                                    if isMouseInPosition((posCel + config.tableCoresCargo[v[3]].posXcargo - 10), y * (291 + linha * 46), x * 6, y * 15) then 
                                        if v[3] == "Admin" then 
                                            v[3] = "Membro" 
                                        end 
                                        break
                                    end 
                                    if isMouseInPosition((posCel + config.tableCoresCargo[v[3]].posXmais), y * (291 + linha * 46), x * 9, y * 15) then 
                                        if v[3] == "Membro" then 
                                            v[3] = "Admin" 
                                        end 
                                        break
                                    end 
                                    if isMouseInPosition(x * (posCel + 249), y * (295 + linha * 46), x * 9, y * 12) then
                                        newTable = {}
                                        for indx,conteudo in ipairs(grupoAtual.Participantes) do 
                                            if i ~= indx then 
                                                table.insert(newTable, indx, conteudo)
                                            end 
                                        end 
                                        grupoAtual.Participantes = newTable
                                        contatoAtual.Online = #grupoAtual.Participantes
                                        triggerServerEvent("MeloSCR:updateWhatsappGroup", localPlayer, localPlayer, guiGetText(edits[13]), grupoAtual, (imagemGrupo and imagemGrupo[2] and imagemGrupo[2] or _))
                                        break 
                                    end 
                                end 
                            end 
                        end 
                    end 
                end 
            end 
        elseif botton == "left" and state == "up" then
            if rolandobarra then rolandobarra = nil end 
            if pressionando then 
                onAppOpened(pressionando)
            end 
            if appSelected then 
                for i,v in ipairs(posIconesHome) do 
                    if isMouseInPosition(x * (posCel+v[1]), v[2], v[3], v[4]) then 
                        for indx,conteudo in ipairs(tabelaApps) do 
                            if conteudo.Slot == i then
                                if tabelaApps[appSelected].Slot then 
                                    conteudo.Slot = tabelaApps[appSelected].Slot
                                elseif tabelaApps[appSelected].Favorito then 
                                    conteudo.Slot = false 
                                    conteudo.Favorito = tabelaApps[appSelected].Favorito
                                end 
                                break 
                            end  
                        end 
                        if tabelaApps[appSelected].Favorito then
                            tabelaApps[appSelected].Favorito = false 
                        end
                        tabelaApps[appSelected].Slot = i
                        appSelected = nil 
                        break 
                    end 
                end 
                for i,v in ipairs(posIconesFavoritosHome) do 
                    if isMouseInPosition(x * (posCel+v[1]), v[2], v[3], v[4]) then 
                        for indx,conteudo in ipairs(tabelaApps) do 
                            if conteudo.Favorito and conteudo.Favorito == i then
                                if tabelaApps[appSelected].Slot then 
                                    conteudo.Favorito = false
                                    conteudo.Slot = tabelaApps[appSelected].Slot
                                else 
                                    conteudo.Favorito = tabelaApps[appSelected].Favorito
                                end 
                                break 
                            end  
                        end 
                        tabelaApps[appSelected].Slot = false
                        tabelaApps[appSelected].Favorito = i
                        appSelected = nil 
                        break 
                    end 
                end 
                triggerServerEvent("MeloSCR:updateCell", localPlayer, localPlayer, tabelaApps)
            end     
        end 
    end 
end)

addEvent("JOAO.changeAbaCellVanish", true)
addEventHandler("JOAO.changeAbaCellVanish", root,
function()
    Aba = "Home"
end)

function onAppOpened(theApp)
    AnimationApp = true 
    Aba = theApp["1"]
    posY = 0
    theImgApp = theApp["2"]
    tickA = getTickCount()
    if Aba == "Notas" then 
        subAba = "Home"
        escolhendoFoto = nil
        proximaPagina = 0
        cursorY = y * 272
        triggerServerEvent("MeloSCR:loadNotas", localPlayer, localPlayer)
    elseif Aba == "Spotify" then 
        proximaPagina = 0
        cursorY = y * 290
    elseif Aba == "Contatos" then 
        proximaPagina = 0
        posY = 0
        selectedContact = nil
        guiSetText(edits[8], "Pesquisar")
        triggerServerEvent("MeloSCR:loadContacts", localPlayer, localPlayer)
    elseif Aba == "Blaze" then
        setTimer(function()
            triggerServerEvent("JOAO.loadBlaze", localPlayer, localPlayer)
        end, 500, 1)
    elseif Aba == "Banco" then 
        triggerServerEvent("MeloSCR:loadContacts", localPlayer, localPlayer)
        triggerServerEvent("MeloSCR:loadHistoricoBanco", localPlayer, localPlayer)
    elseif Aba == "Whatsapp" then
        subAba = "Home"
        escolhendoFoto = nil 
        escolhendoAlguem = nil
        triggerServerEvent("MeloSCR:loadContacts", localPlayer, localPlayer)
        triggerServerEvent("MeloSCR:loadConversas", localPlayer, localPlayer)
    elseif Aba == "Appstore" then 
        if (totalApps - 2) > 0 then 
            maxY[Aba] = ((totalApps - 2) * (y * 50))
        else 
            maxY[Aba] = 0
        end 
    end 
    setTimer(
        function ()
            AnimationApp = nil 
            tickA = nil 
            tickAlpha = nil 
            tickApp = nil 
            Texturas = {}
            TexturasTwo = {}
            if Aba == "Câmera" then 
                rotX, rotY = 0,0
                selfie = false
                showCursor(false)
                toggleAllControls(false)
                setPedAnimation(localPlayer, false)
                setPedAnimation(localPlayer, 'PED', 'gang_gunstand')
                addEventHandler('onClientPreRender', root, render)
                addEventHandler('onClientCursorMove', root, mousecalc)
            elseif Aba == "Galeria" then 
                triggerServerEvent("JOAO.fotos", localPlayer, localPlayer)
            
            end 
        end, 1500, 1
    )
    pressionando = nil
end 

addEvent("JOAO.criarPhotoC", true)
addEventHandler("JOAO.criarPhotoC", root,
function()
    triggerServerEvent("Schootz.createPhoto", localPlayer, dxGetTexturePixels(myScreenSource), "recentes", (#Texturas + 1), getZoneName(pos[1], pos[2], pos[3], true), getZoneName(pos[1], pos[2], pos[3]), pngPixels)
end)

addEvent( "JOAO.recenteFotos", true )
addEventHandler( "JOAO.recenteFotos", resourceRoot,
function(pixels, link, textdate, textlocale, textlocalem, id)
    photosRecente = {}
    table.insert(photosRecente, {dxCreateTexture(pixels), link, textdate, textlocale, textdate, textlocalem, id})
end)

addEvent("MeloSCR:loadProductsML_C", true)
addEventHandler("MeloSCR:loadProductsML_C", root, 
function (theTable)
    if #theTable > 0 then 
        tableProducts = fromJSON(theTable[1].Produtos)
        newTable = {}
        for i,v in ipairs(tableProducts) do 
            if v[1] then 
                if v[11] then 
                    v[11] = fromJSON(v[11])
                else 
                    v[11] = {}
                end 
                table.insert(newTable, v)
            end 
        end 
        table.sort(newTable, function (a,b) return a[6] > b[6] end)
        tableProducts = newTable
    else 
        tableProducts = {}
    end 
	
end)

function tocarSom(link)
    if isElement(sound) then
        comMusica = false
        destroyElement(sound) 
    end
    pontoinicial = 0 
    sound = playSound('https://music.lunarresources.com.br/v1/download/'..link..'/ZXTOKEN', false)
    setSoundVolume(sound, 0.5)
    tickSomTocando = getTickCount()
    comMusica = true
end

addEvent("MeloSCR:loadNotasC", true)
addEventHandler("MeloSCR:loadNotasC", root, 
function (theTable)
    if theTable and #theTable > 0 and theTable[1].Notas then 
        tableNotas = fromJSON(theTable[1].Notas)
    else 
        tableNotas = nil 
    end 
end)

addEvent( "JOAO.enviarImagemBuscarSpotify", true )
addEventHandler( "JOAO.enviarImagemBuscarSpotify", resourceRoot,
function(pixels, title, id, timestamp, authorname, description, authorimage, contaplayer, favorite, timestamp, idcolum, image)
    table.insert(imagemSpotifyCount, {_, title, id, timestamp, authorname, description, authorimage, contaplayer, favorite, timestamp, idcolum, image})
end)

addEvent("MeloSCR:loadVehiclesC", true)
addEventHandler("MeloSCR:loadVehiclesC", root, 
function (theTable)
    for i,v in ipairs(theTable) do 
        if not v.placa then v.placa = "0" end 
        if not v.imposto then v.imposto = "0" end 
        if not v.seguro then v.seguro = "Não" end 
        v.dataCar = fromJSON(v.dataCar)
    end    
    tableVehicles = theTable
    if (#tableVehicles - 7) > 0 then 
        maxY[Aba] = (#tableVehicles - 7) * 50
    else 
        maxY[Aba] = 0
    end 
end)

timerVoltar = {}

addEvent("JOAO.tempLocalizar", true)
addEventHandler("JOAO.tempLocalizar", root,
function(tempo, theVeh)
    if theVeh then 
        if timerAnim and isTimer(timerAnim) then 
        else
            AnimLoc = true 
            tickAnim = getTickCount()
            timerAnim = setTimer(
                function (theVeh)
                    AnimLoc = nil 
                    if LocAtiva[theVeh] then 
                        if timerVoltar[theVeh] and isTimer(timerVoltar[theVeh]) then killTimer(timerVoltar[theVeh]) end 
                    end
                    LocAtiva[theVeh] = not LocAtiva[theVeh] 
                end, 500, 1, theVeh
            )
        end 
        timerVoltar[theVeh] = setTimer(
            function (theVeh)
                LocAtiva[theVeh] = nil 
            end, tempo , 1, theVeh
        )
    end 
end)

addEvent("MeloSCR:loadContactsC", true)
addEventHandler("MeloSCR:loadContactsC", root, 
function (theTable1, theTable2)
    tableContatos = theTable1
    tableCategorias = theTable2
    tableNumeros = {}
    totalContatos = 0
    for i,v in ipairs(tableCategorias) do
        if v.NomeCategoria ~= "Emergência"  then 
            for indx,conteudo in ipairs(tableContatos[v.NomeCategoria]) do
                totalContatos = totalContatos + 1
                conteudo.Cor = config.tableCoresContatosRandom[math.random(1, #config.tableCoresContatosRandom)]
                tableNumeros[conteudo.Numero] = conteudo
            end 
        end 
    end 
end)

addEvent("MeloSCR:onCallC", true)
addEventHandler("MeloSCR:onCallC", root, 
function (contactInfos, theAba)
    theContactInfos = contactInfos
    Aba = "Chamada"
    stateMic = true
    subAba = theAba
end)

function getAppNameFromImage(theImage) 
    for i,v in ipairs(config.Aplicativos) do 
        if v[2] == theImage then 
            return v[1] 
        end 
    end 
end 

--------------------------------------------UTIL----------------------------------------------------

bindKey("mouse_wheel_down", "down", 
function ()
    if isEventHandlerAdded("onClientRender", root, dxDraw) then 
        posY = posY + 10
        if maxY[Aba] and posY > maxY[Aba] then 
            posY = maxY[Aba]
        end 
        
        if Aba and escolhendoAlguem then 
            proximaPagina = proximaPagina + 1
            if proximaPagina > (totalContatos - 4) then 
                proximaPagina = proximaPagina -1 
            end 
        end 
    end 
end)

bindKey("mouse_wheel_up", "down", 
function ()
    if isEventHandlerAdded("onClientRender", root, dxDraw) then 
        if posY >= 10 then 
            posY = posY - 10
        else 
            posY = 0
        end
        if proximaPagina > 0 then 
            proximaPagina = proximaPagina - 1 
        end 
    end 
end)


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


addEventHandler('onClientResourceStart', resourceRoot, 
    function()
        local txd = engineLoadTXD('files/phone.txd')
        engineImportTXD(txd, 330)
        local dff = engineLoadDFF('files/phone.dff')
        engineReplaceModel(dff, 330)
    end
) 

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

function editBox(action)
    if (action == 'add') then 
        edits[1] = guiCreateEdit(1000, 1000, 0, 0, 'Insira a Quantidade...', false)
        guiEditSetMaxLength(edits[1], 9)
        guiSetProperty(edits[1], 'ValidationString', '[0-9]*')
        edits[2] = guiCreateEdit(1000, 1000, 0, 0, 'Insira a URL da imagem...', false)
        edits[3] = guiCreateEdit(1000, 1000, 0, 0, 'Pesquise sua nota...', false)
        edits[4] = guiCreateEdit(1000, 1000, 0, 0, 'Defina um Título...', false)
        guiEditSetMaxLength(edits[4], 15)
        edits[5] = guiCreateEdit(1000, 1000, 0, 0, 'Anote as informações aqui...', false)
        guiEditSetMaxLength(edits[5], 1000)
        edits[6] = guiCreateEdit(1000, 1000, 0, 0, 'Pesquise sua música...', false)
        edits[7] = guiCreateEdit(1000, 1000, 0, 0, 'Procure pelo seu veículo...', false)
        edits[8] = guiCreateEdit(1000, 1000, 0, 0, 'Pesquisar', false)
        edits[9] = guiCreateEdit(1000, 1000, 0, 0, 'Nome de contato...', false)
        edits[10] = guiCreateEdit(1000, 1000, 0, 0, 'Número de telefone...', false)
        edits[11] = guiCreateEdit(1000, 1000, 0, 0, 'Procure pelos seus contatos...', false)
        edits[12] = guiCreateEdit(1000, 1000, 0, 0, 'Mensagem', false)
        edits[13] = guiCreateEdit(1000, 1000, 0, 0, 'Nome do Grupo...', false)
        guiEditSetMaxLength(edits[13], 24)
        edits[14] = guiCreateEdit(1000, 1000, 0, 0, "Digite um título", false)
        guiEditSetMaxLength(edits[14], 15)
        edits[15] = guiCreateEdit(1000, 1000, 0, 0, "Digite um valor...", false)
        guiSetProperty(edits[15], 'ValidationString', '[0-9]*')
        guiEditSetMaxLength(edits[15], 15)
        edits[16] = guiCreateEdit(1000, 1000, 0, 0, "Digite um valor...", false)
        guiSetProperty(edits[16], 'ValidationString', '[0-9]*')
        guiEditSetMaxLength(edits[16], 15)
        edits[17] = guiCreateEdit(1000, 1000, 0, 0, "Escreva um comentário...", false)
        guiEditSetMaxLength(edits[17], 30)
        edits[18] = guiCreateEdit(1000, 1000, 0, 0, "Quantia", false)
        guiEditSetMaxLength(edits[18], 30)
    else 
        for i=1, #edits do 
            if edits[i] and isElement(edits[i]) then destroyElement(edits[i]) end 
        end 
    end
end

function createEditBox(x, y, w, h, color, fontType, typeBox)
    if (dxGetTextWidth((select == typeBox and guiGetText(edits[typeBox])..'|' or guiGetText(edits[typeBox])), 1.00, fontType) <= w - 10) then
        dxDrawText(select == typeBox and guiGetText(edits[typeBox])..'|' or guiGetText(edits[typeBox]), x + 5, y, w - 10, h, color, 1.00, fontType, "left", "center", true, false, false, false, false)
    else
        dxDrawText(select == typeBox and guiGetText(edits[typeBox])..'|' or guiGetText(edits[typeBox]), x + 5, y, w - 10, h, color, 1.00, fontType, "right", "center", true, false, false, false, false)
    end
end

dxDrawRoundedRectangle = function(x, y, rx, ry, color, radius)
    rx = rx - radius * 2
    ry = ry - radius * 2
    x = x + radius
    y = y + radius
    if (rx >= 0) and (ry >= 0) then
        dxDrawRectangle(x, y, rx, ry, color)
        dxDrawRectangle(x, y - radius, rx, radius, color)
        dxDrawRectangle(x, y + ry, rx, radius, color)
        dxDrawRectangle(x - radius, y, radius, ry, color)
        dxDrawRectangle(x + rx, y, radius, ry, color)
        dxDrawCircle(x, y, radius, 180, 270, color, color, 7)
        dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 7)
        dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7)
        dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 7)
    end
end

gWeekDays = { "Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado" }
gMonthNames = {"Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"}

addEventHandler("onClientPaste", root, 
function ()
    if isEventHandlerAdded("onClientRender", root, dxDraw) then 
        if Aba == "Configuração" then return end 
        for i=1, #edits do 
            if edits[i] and isElement(edits[i]) then destroyElement(edits[i]) end 
        end 
        edits[1] = guiCreateEdit(1000, 1000, 0, 0, 'Insira a Quantidade...', false)
        guiEditSetMaxLength(edits[1], 9)
        guiSetProperty(edits[1], 'ValidationString', '[0-9]*')
        edits[2] = guiCreateEdit(1000, 1000, 0, 0, 'Insira a URL da imagem...', false)
        edits[3] = guiCreateEdit(1000, 1000, 0, 0, 'Pesquise sua nota...', false)
        edits[4] = guiCreateEdit(1000, 1000, 0, 0, 'Defina um Título...', false)
        guiEditSetMaxLength(edits[4], 15)
        edits[5] = guiCreateEdit(1000, 1000, 0, 0, 'Anote as informações aqui...', false)
        guiEditSetMaxLength(edits[5], 1000)
        edits[6] = guiCreateEdit(1000, 1000, 0, 0, 'Pesquise sua música...', false)
        edits[7] = guiCreateEdit(1000, 1000, 0, 0, 'Procure pelo seu veículo...', false)
        edits[8] = guiCreateEdit(1000, 1000, 0, 0, 'Pesquisar', false)
        edits[9] = guiCreateEdit(1000, 1000, 0, 0, 'Nome de contato...', false)
        edits[10] = guiCreateEdit(1000, 1000, 0, 0, 'Número de telefone...', false)
        edits[11] = guiCreateEdit(1000, 1000, 0, 0, 'Procure pelos seus contatos...', false)
        edits[12] = guiCreateEdit(1000, 1000, 0, 0, 'Mensagem', false)
        edits[13] = guiCreateEdit(1000, 1000, 0, 0, 'Nome do Grupo...', false)
        guiEditSetMaxLength(edits[13], 24)
        edits[14] = guiCreateEdit(1000, 1000, 0, 0, "Digite um título", false)
        guiEditSetMaxLength(edits[14], 15)
        edits[15] = guiCreateEdit(1000, 1000, 0, 0, "Digite um valor...", false)
        guiSetProperty(edits[15], 'ValidationString', '[0-9]*')
        guiEditSetMaxLength(edits[15], 15)
        edits[16] = guiCreateEdit(1000, 1000, 0, 0, "Digite um valor...", false)
        guiSetProperty(edits[16], 'ValidationString', '[0-9]*')
        guiEditSetMaxLength(edits[16], 15)
        edits[17] = guiCreateEdit(1000, 1000, 0, 0, "Escreva um comentário...", false)
        guiEditSetMaxLength(edits[17], 30)
        edits[18] = guiCreateEdit(1000, 1000, 0, 0, "Quantia", false)
        guiEditSetMaxLength(edits[18], 30)
        notifyC("Você não pode colar nada no celular!", "error")
    end 
end)

addEvent( "onClientGotImage", true )
addEventHandler( "onClientGotImage", resourceRoot,
function(pixels, link, textdate, textlocale, textlocalem, idcolum)
    table.insert(Texturas, {dxCreateTexture(pixels), link, textdate, textlocale, textdate, textlocalem, idcolum})
end)

addEvent("JOAO.startImage", true)
addEventHandler("JOAO.startImage", root,
function()
    if #TexturasTwo == 0 then 
        tickAnim = getTickCount()
    end 
    table.insert(TexturasTwo, {"a"})
end)

function convertTime(ms) 
    local min = math.floor ( ms/60000 ) 
    local sec = math.floor( (ms/1000)%60 ) 
    return min, sec
end 

function convertTimeSeconds(ms) 
    local ms = ms * 1000
    local min = math.floor ( ms/60000 ) 
    local sec = math.floor( (ms/1000)%60 ) 
    if min < 10 then min = "0"..min end 
    if sec < 10 then sec = "0"..sec end 
    return min, sec
end 

-------------------------------------------------------------------------UTIL CAMERA-------------------------------------------------------------------------------------

local rootElement = getRootElement ( )
local mplayer = getLocalPlayer ( )
local sw, sh = guiGetScreenSize ( )

local speed, strafespeed = 0, 0
local rotX, rotY = 0,0
local mouseFrameDelay = 0
local rotXposY, rotYposY = 0,0
local mouseFrameDelayPosY = 0

local options = 
{
    invertMouseLook = false,
    mouseSensitivity = 0.1
}


function convertTime(ms) 
    local min = math.floor ( ms/60000 ) 
    local sec = math.floor( (ms/1000)%60 ) 
    return min, sec 
end

function math.clamp ( value, lower, upper )
 value, lower, upper = tonumber ( value ), tonumber ( lower ), tonumber ( upper )
 if value and lower and upper then
  if value < lower then 
   value = lower
  elseif value > upper then 
   value = upper 
  end
  return value
 end
 return false
end

function getElementOffset ( entity, offX, offY, offZ )
    local posX, posY, posZ = 0, 0, 0
    if isElement ( entity ) and type ( offX ) == 'number' and type ( offY ) == 'number' and type ( offZ ) == 'number' then
        local center = getElementMatrix ( entity )
        if center then
            posX = offX * center [ 1 ] [ 1 ] + offY * center [ 2 ] [ 1 ] + offZ * center [ 3 ] [ 1 ] + center [ 4 ] [ 1 ]
            posY = offX * center [ 1 ] [ 2 ] + offY * center [ 2 ] [ 2 ] + offZ * center [ 3 ] [ 2 ] + center [ 4 ] [ 2 ]
            posZ = offX * center [ 1 ] [ 3 ] + offY * center [ 2 ] [ 3 ] + offZ * center [ 3 ] [ 3 ] + center [ 4 ] [ 3 ]
        end
    end
 return posX, posY, posZ
end

function render ( )    
    local camPosX, camPosY, camPosZ = getPedBonePosition ( mplayer, 25 )
    camPosZ = camPosZ + 0.29
 
    if selfie then 
        camTargetX, camTargetY, camTargetZ = getElementOffset ( mplayer, -2, -3, 0 )
    else 
        camTargetX, camTargetY, camTargetZ = getElementOffset ( mplayer, 2, 3, 0.5 )
    end 
    if rotX > 2.5 then rotX = 2.5 end 
    if rotX < -2.5 then rotX = -2.5 end 
    local _, _, rotPed = getElementRotation(localPlayer)
    if rotPed <= 180 then 
        camTargetX = camTargetX + rotX
    else 
        camTargetX = camTargetX - rotX
    end
    camTargetY = camTargetY
    camTargetZ = camPosZ + rotY
    setPedAimTarget ( mplayer, camTargetX, camTargetY, camTargetZ )
    setCameraMatrix ( camPosX, camPosY, camPosZ, camTargetX, camTargetY, camTargetZ )
end


function mousecalc ( _, _, aX, aY )
    if isCursorShowing ( ) or isMTAWindowActive ( ) then
     mouseFrameDelay = 5
     return
    elseif mouseFrameDelay > 0 then
     mouseFrameDelay = mouseFrameDelay - 1
     return
    end
    
    aX = aX - sw / 2 
    aY = aY - sh / 2
    
    if options.invertMouseLook then
     aY = -aY
    end
    
    rotX = rotX + aX * options.mouseSensitivity * 0.01745
    rotY = rotY - aY * options.mouseSensitivity * 0.01745
       
    local PI = math.pi
    if rotX > PI then
     rotX = rotX - 2 * PI
    elseif rotX < -PI then
     rotX = rotX + 2 * PI
    end
       
    if rotY > PI then
     rotY = rotY - 2 * PI
    elseif rotY < -PI then
     rotY = rotY + 2 * PI
    end
   
    rotY = math.clamp ( rotY, -PI / 2.05, PI / 2.05 )
   end
   
   local UniStat = { 
       items = { }
   }


function mousecalcYpos ( _, _, aXposY, aYposY )
    if isEventHandlerAdded("onClientRender", root, dxDraw) and Aba then 
        if not isCursorShowing ( ) or isMTAWindowActive ( ) or not getKeyState("mouse1") or not isMouseInPosition(x * (posCel+18), y * 180, x * 246, y * 535) then
        mouseFrameDelayPosY = 5
        
        return
        elseif mouseFrameDelayPosY > 0 then
        mouseFrameDelayPosY = mouseFrameDelayPosY - 1
        return
        end
        
        aXposY = aXposY - sw / 2 
        aYposY = aYposY - sh / 2
        
        if options.invertMouseLook then
        aYposY = -aYposY
        end
        
        rotXposY = rotXposY + aXposY * options.mouseSensitivity * 0.01745
        rotYposY = rotYposY - aYposY * options.mouseSensitivity * 0.01745
        
        local PI = math.pi
        if rotXposY > PI then
        rotXposY = rotXposY - 2 * PI
        elseif rotXposY < -PI then
        rotXposY = rotXposY + 2 * PI
        end
        
        if rotYposY > PI then
        rotYposY = rotYposY - 2 * PI
        elseif rotYposY < -PI then
        rotYposY = rotYposY + 2 * PI
        end
    
        rotYposY = math.clamp ( rotYposY, -PI / 2.05, PI / 2.05 )
        posY = posY + rotYposY
        if posY < 0 then posY = 0 end 
        if Aba and maxY[Aba] and posY > maxY[Aba] then 
            posY = posY - rotYposY
        end 
    end 
end
   

local gWeekDays = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }
function formatDate(format, escaper, timestamp)
	
	escaper = (escaper or "'"):sub(1, 1)
	local time = getRealTime(timestamp)
	local formattedDate = ""
	local escaped = false

	time.year = time.year + 1900
	time.month = time.month + 1
	
	local datetime = { d = ("%02d"):format(time.monthday), h = ("%02d"):format(time.hour), i = ("%02d"):format(time.minute), m = ("%02d"):format(time.month), s = ("%02d"):format(time.second), w = gWeekDays[time.weekday+1]:sub(1, 2), W = gWeekDays[time.weekday+1], y = tostring(time.year):sub(-2), Y = time.year }
	
	for char in format:gmatch(".") do
		if (char == escaper) then escaped = not escaped
		else formattedDate = formattedDate..(not escaped and datetime[char] or char) end
	end
	
	return formattedDate
end

function check(pattern, ...)
	if type(pattern) ~= 'string' then check('s', pattern) end
	local types = {s = "string", n = "number", b = "boolean", f = "function", t = "table", u = "userdata"}
	for i=1, #pattern do
		local c = pattern:sub(i,i)
		local t = #arg > 0 and type(arg[i])
		if not t then error('got pattern but missing args') end
		if t ~= types[c] then error(("bad argument #%s to '%s' (%s expected, got %s)"):format(i, debug.getinfo(2, "n").name, types[c], tostring(t)), 3) end
	end
end

----------------------------------------------------------------------------------------------------------------------------------------------------

function mathfloorcustomT(valor)
    if string.len(valor) >= 1 then 
        local part1 = string.sub(valor, 1, 4)
        return part1
    end
    return tonumber(valor)
end

addEvent("MeloSCR:loadHistoricoBancoC", true)
addEventHandler("MeloSCR:loadHistoricoBancoC", root, 
function (theTable)
    tableLogBanco = theTable
end)


addEvent("MeloSCR:loadConversasC", true)
addEventHandler("MeloSCR:loadConversasC", root, 
function (theTable1, theTable, theTableGrupos)
    tableAll = theTable
    tableWhatsapp = theTable1
    if tableWhatsapp and #tableWhatsapp > 0 then 
        newTable = fromJSON(tableWhatsapp[1].Conversas)
        if #theTableGrupos > 0 then 
            for i,v in ipairs(theTableGrupos) do 
                newTable[v.NomeGrupo] = {"Grupo", fromJSON(v.Conversas), v}
            end 
            tableWhatsapp[1].Conversas = toJSON(newTable)
        end 
    end 
    theTableHome = {}
    theTableVerify = {}
    if tableWhatsapp and #tableWhatsapp > 0 then 
        for i,v in pairs(fromJSON(tableWhatsapp[1].Conversas)) do 
            if not theTableVerify[i] then 
                theTableVerify[i] = true
                tableContato = getContatoFromConta(i)
                local ContagemNaoLidas = 0 
                if v[1] == "Grupo" then 
                    if v[2][#v[2]] then 
                        if v[2][#v[2]][5] then 
                            UltimaMensagemG = {v[2][#v[2]][5], "Enviou", v[2][#v[2]][4]}
                        else 
                            UltimaMensagemG = {v[2][#v[2]][1], "Enviou", v[2][#v[2]][4]}
                        end 
                        
                    else 
                        UltimaMensagemG = {"", "Enviou", getRealTime().timestamp}
                    end 
                    
                    tipoConversa = "Grupo"
                else 
                    tipoConversa = "Contato"
                end 
                ImagemG = nil 
                for i,v in ipairs(v) do 
                    if v[1] == "Grupo" then 
                        if v[3].Imagem then 
                            ImagemG = v[3].Imagem
                        end 
                    else 
                        if v[2] == "Recebeu" and v[4] == "Não" then 
                            ContagemNaoLidas = ContagemNaoLidas + 1
                        end 
                    end 
                end 
                if tipoConversa == "Contato" then 
                    table.insert(theTableHome, {theAllTable = tableContato, Nome = tableContato.Nome, Avatar = tableContato.Avatar, Conta = i, UltimaMensagem = v[#v], NaoLidas = ContagemNaoLidas})
                else 
                    table.insert(theTableHome, {theType = "Grupo", theAllTable = v[3], Nome = i, Imagem = ImagemG, UltimaMensagem = UltimaMensagemG, NaoLidas = ContagemNaoLidas})
                end 
             end 
             
            if contatoAtual and i == contatoAtual.Conta then 
                conversaAtual = v
                table.sort(conversaAtual, function (a,b) return a[3] > b[3] end)
                if conversaAtual and #conversaAtual > 0 then 
                    triggerServerEvent("MeloSCR:loadImages", localPlayer, localPlayer, conversaAtual)
                    tickAnim = getTickCount()
                    maxY["Whatsapp"] = 0
                    for i,v in ipairs(conversaAtual) do 
                        if v[2] == "Enviou" and v[4] then 
                            if v[4] == "Localização" then contagemLinhas = 50 end 
                            if v[4] == "Contato" then contagemLinhas = 42 end 
                            if v[4] == "Imagem" then contagemLinhas = 124 end 
                        elseif v[2] == "Recebeu" and v[5] then 
                            if v[5] == "Localização" then contagemLinhas = 50 end 
                            if v[5] == "Contato" then contagemLinhas = 42 end 
                            if v[5] == "Imagem" then contagemLinhas = 124 end 
                        else 
                            contagemLinhas = getContagemLinhas(dxGetTextWidth(v[1], 1, fonts[18]) / 224)
                        end 
                        maxY["Whatsapp"] = maxY["Whatsapp"] + (dxGetFontHeight(1, fonts[18]) * contagemLinhas)
                    end
                else 
                    maxY["Whatsapp"] = 0 
                end  
            elseif contatoAtual and contatoAtual.Tipo and contatoAtual.Tipo == "Grupo" then
                if i == contatoAtual.Nome then 
                    conversaAtual = v[2]
                    table.sort(conversaAtual, function (a,b) return a[4] > b[4] end)
                    if conversaAtual and #conversaAtual > 0 then 
                        triggerServerEvent("MeloSCR:loadImages", localPlayer, localPlayer, conversaAtual)
                        tickAnim = getTickCount()
                        local linhasAdicionais = 0
                        maxY["Whatsapp"] = 0
                        for i,v in ipairs(conversaAtual) do 
                            if v[5] then 
                                if v[5] == "Localização" then contagemLinhas = 50 end 
                                if v[5] == "Contato" then contagemLinhas = 42 end 
                                if v[5] == "Imagem" then contagemLinhas = 124 end 
                            else 
                                contagemLinhas = getContagemLinhas(dxGetTextWidth(v[1], 1, fonts[18]) / 224)
                            end 
                            maxY["Whatsapp"] = (linhasAdicionais + contagemLinhas) * 9
                            linhasAdicionais = linhasAdicionais + contagemLinhas
                        end 
                    end 
                    subAba = "Conversa"
                    break  
                end   
            end 
        end 
        table.sort(theTableHome, function (a,b) return a.UltimaMensagem[3] > b.UltimaMensagem[3] end)
    end
end)

addEvent("MeloSCR:NotificacaoWpp", true)
addEventHandler("MeloSCR:NotificacaoWpp", root, 
function ()
    theSound = playSound("files/Whatsapp/msg1.mp3")
end)

function getContatoFromConta(theConta)
    for i,v in ipairs(tableCategorias) do
        if v.NomeCategoria ~= "Emergência" then 
            for indx,conteudo in ipairs(tableContatos[v.NomeCategoria]) do 
                if conteudo.Conta and conteudo.Conta == theConta then 
                    return conteudo
                end 
            end
        end 
    end 
    for i,v in ipairs(tableAll) do 
        if v.Conta == theConta then 
            return {Nome = v.Numero, Numero = v.Numero, Avatar = 0, Conta = theConta}
        end 
    end 
    return theConta
end 


function getContagemLinhas(numero)
    local numero = tostring(numero)
    if #numero > 1 then 
        return tonumber(string.sub(numero, 1,1))+1 
    else 
        return tonumber(string.sub(numero, 1,1))
    end 
end 

addEvent("MeloSCR:updateInfosContatoC", true)
addEventHandler("MeloSCR:updateInfosContatoC", root, 
function (theState)
    if contatoAtual then 
        contatoAtual.Online = theState
    end 
end)

addEvent("MeloSCR:updateConversaC", true)
addEventHandler("MeloSCR:updateConversaC", root, 
function (theIndex, theFileIMG)
    if conversaAtual then 
        for i,v in ipairs(conversaAtual) do 
            if theIndex == i then 
                v[1] = dxCreateTexture(theFileIMG)
            end 
        end 
        
    end 
end)

addEvent("MeloSCR:updateImagemGrupoC", true)
addEventHandler("MeloSCR:updateImagemGrupoC", root, 
function (theIndex, theFileIMG)
    for i,v in ipairs(theTableHome) do 
        if v.theType == "Grupo" and v.Nome == theIndex then 
            v.Imagem = dxCreateTexture(theFileIMG)
        end 
    end 
end)

addEvent("MeloSCR:loadWallpaperC", true)
addEventHandler("MeloSCR:loadWallpaperC", root, 
function (theFileIMG, theLink)
    if not linkSalvo or theLink ~= linkSalvo then 
        theWallpaper = dxCreateTexture(theFileIMG)
        linkSalvo = theLink
    end 
end)

addEvent("MeloSCR:loadImageProductC", true)
addEventHandler("MeloSCR:loadImageProductC", root, 
function (theLink, theFileIMG)
    for i,v in ipairs(tableProducts) do
        if not v.Imagem then  
            if v[5] == theLink then 
                v.Imagem = dxCreateTexture(theFileIMG)
            end 
        end 
    end 
end)

addEvent("MeloSCR:deleteWallpaperC", true)
addEventHandler("MeloSCR:deleteWallpaperC", root, 
function ()
    if theWallpaper then 
        destroyElement(theWallpaper)
        theWallpaper = nil 
        linkSalvo = nil
    end 
end)

function verifyInAposta()
    for i, v in ipairs(playersBetting["crash"]) do
        if v[3] == (getElementData(localPlayer, "ID") or 0) then
            return true
        end
    end
    return false
end