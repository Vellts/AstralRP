panelConfig.tuning = {
    w = respc(430),
    h = respc(443),
    x = Vector2({getScreenStartPositionFromBox(respc(430), respc(443), respc(25), respc(0), "left", "center")}).x,
    y = Vector2({getScreenStartPositionFromBox(respc(430), respc(443), respc(25), respc(0), "left", "center")}).y,
}

panelConfig.tuningColor = {
    w = respc(406),
    h = respc(374),
    x = Vector2({getScreenStartPositionFromBox(respc(406), respc(374), respc(25), respc(0), "right", "center")}).x,
    y = Vector2({getScreenStartPositionFromBox(respc(406), respc(374), respc(25), respc(0), "right", "center")}).y,
}

panelConfig.keyboard = {
    w = respc(247),
    h = respc(99),
    x = Vector2({getScreenStartPositionFromBox(respc(247), respc(99), respc(25), respc(37), "left", "bottom")}).x,
    y = Vector2({getScreenStartPositionFromBox(respc(247), respc(99), respc(25), respc(37), "left", "bottom")}).y,
}

panelConfig.SVG = {
    tuning = svgCreate(respc(40), respc(42), [[
        <svg width="40" height="42" viewBox="0 0 40 42" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M21.9543 0V4.24837C30.756 5.38408 36.9914 13.7757 35.9088 23.0085C34.9865 30.664 29.2523 36.7421 21.9543 37.6465V41.8528C32.9815 40.696 41.0014 30.4327 39.8986 18.8653C38.9964 8.87531 31.4377 0.988483 21.9543 0ZM17.9444 0.0630946C14.0347 0.462694 10.3055 2.04006 7.25794 4.69004L10.125 7.8027C12.3706 5.90986 15.0773 4.69004 17.9444 4.2694V0.0630946ZM4.43095 7.65548C1.92407 10.8467 0.381347 14.7496 0 18.8653H4.00991C4.39086 15.8788 5.51363 13.0396 7.29804 10.663L4.43095 7.65548ZM0.0200495 23.0716C0.421041 27.1938 1.96486 31.0846 4.451 34.2814L7.29804 31.2739C5.52752 28.8965 4.39878 26.0636 4.02996 23.0716H0.0200495ZM10.125 34.3656L7.25794 37.2469C10.295 39.9025 14.0132 41.5563 17.9444 42V37.7937C15.0921 37.4068 12.3914 36.2228 10.125 34.3656ZM29.6132 27.6775L21.3728 19.0336C22.1949 16.8463 21.7337 14.2804 20.0095 12.4927C18.205 10.5789 15.4983 10.2003 13.3129 11.2519L17.2025 15.332L14.4958 18.1923L10.506 14.0911C9.42329 16.3836 9.92453 19.2228 11.6889 21.1367C13.4132 22.9454 15.8592 23.4081 17.9444 22.5669L26.1847 31.1898C26.5456 31.5894 27.087 31.5894 27.4479 31.1898L29.533 29.0235C29.9741 28.645 29.9741 27.972 29.6132 27.6775Z" fill="white"/>
        </svg>
    ]], function (element) dxSetTextureEdge (element, 'border') end),
    cor = svgCreate(respc(42), respc(40), [[
        <svg width="42" height="40" viewBox="0 0 42 40" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M3.72588 8.0286C9.91912 -0.179488 22.748 -2.56688 31.8777 3.08195C40.8937 8.65741 44.2094 19.3828 40.5146 29.4438C37.0282 38.9452 27.8416 42.7075 21.2207 37.9286C18.7413 36.1386 17.7786 33.8937 17.3152 30.2487L17.0919 28.1799L16.9971 27.3457C16.738 25.388 16.342 24.5118 15.512 24.0507C14.385 23.4261 13.633 23.4114 12.1521 23.9815L11.4127 24.2876L11.0356 24.4511C8.89955 25.3733 7.47974 25.6982 5.68286 25.323L5.26155 25.2245L4.91607 25.126C-0.959079 23.315 -1.82908 15.3857 3.72588 8.0286ZM30.9593 17.9261C31.0488 18.2585 31.2032 18.57 31.4137 18.843C31.6242 19.116 31.8867 19.3451 32.1862 19.5171C32.4857 19.6892 32.8163 19.8009 33.1591 19.8458C33.502 19.8907 33.8504 19.868 34.1844 19.779C34.5184 19.6899 34.8316 19.5363 35.1059 19.3268C35.3803 19.1174 35.6105 18.8562 35.7834 18.5582C35.9564 18.2602 36.0686 17.9313 36.1137 17.5901C36.1589 17.249 36.1361 16.9023 36.0466 16.5699C35.8658 15.8987 35.4245 15.3264 34.8197 14.9789C34.2149 14.6314 33.4961 14.5372 32.8215 14.7171C32.1468 14.8969 31.5717 15.336 31.2224 15.9378C30.8732 16.5396 30.7785 17.2548 30.9593 17.9261ZM32.002 25.2371C32.0844 25.577 32.2343 25.897 32.4429 26.1784C32.6515 26.4598 32.9146 26.6967 33.2167 26.8754C33.5188 27.054 33.8537 27.1706 34.2018 27.2184C34.5499 27.2662 34.9041 27.2442 35.2435 27.1537C35.583 27.0632 35.9007 26.906 36.1781 26.6914C36.4556 26.4768 36.687 26.2091 36.8588 25.9041C37.0306 25.5991 37.1393 25.2629 37.1786 24.9155C37.2178 24.568 37.1867 24.2163 37.0872 23.8809C36.8927 23.2255 36.4485 22.6716 35.8494 22.3375C35.2502 22.0033 34.5436 21.9153 33.8802 22.0923C33.2168 22.2692 32.6491 22.697 32.2982 23.2845C31.9473 23.872 31.841 24.5727 32.002 25.2371ZM26.7904 11.6317C26.9712 12.3029 27.4125 12.8753 28.0173 13.2227C28.6221 13.5702 29.3409 13.6644 30.0156 13.4846C30.6902 13.3047 31.2654 12.8656 31.6146 12.2638C31.9638 11.662 32.0585 10.9468 31.8777 10.2755C31.7882 9.94318 31.6338 9.6316 31.4233 9.3586C31.2128 9.08561 30.9503 8.85654 30.6508 8.68449C30.046 8.337 29.3272 8.24282 28.6526 8.42265C27.978 8.60249 27.4028 9.04161 27.0536 9.64342C26.7044 10.2452 26.6097 10.9604 26.7904 11.6317ZM26.7315 30.4918C26.8209 30.8242 26.9754 31.1358 27.1859 31.4088C27.3964 31.6818 27.6589 31.9108 27.9583 32.0829C28.2578 32.255 28.5884 32.3666 28.9313 32.4116C29.2741 32.4565 29.6225 32.4338 29.9566 32.3447C30.2906 32.2557 30.6037 32.102 30.8781 31.8926C31.1525 31.6831 31.3827 31.422 31.5556 31.124C31.7285 30.826 31.8408 30.497 31.8859 30.1559C31.9311 29.8147 31.9082 29.4681 31.8188 29.1357C31.638 28.4644 31.1967 27.8921 30.5919 27.5446C29.987 27.1972 29.2683 27.103 28.5936 27.2828C27.919 27.4626 27.3438 27.9018 26.9946 28.5036C26.6454 29.1054 26.5507 29.8206 26.7315 30.4918ZM19.3649 9.59434C19.4518 9.9293 19.6046 10.2438 19.8144 10.5197C20.0241 10.7956 20.2867 11.0275 20.587 11.2018C20.8873 11.3762 21.2193 11.4897 21.5639 11.5358C21.9086 11.5818 22.2589 11.5595 22.5948 11.4701C22.9307 11.3807 23.2454 11.226 23.5209 11.0149C23.7964 10.8038 24.0271 10.5405 24.1998 10.2403C24.3725 9.93999 24.4837 9.60865 24.527 9.26539C24.5703 8.92213 24.5449 8.57373 24.4522 8.2403C24.267 7.57433 23.8249 7.00812 23.2221 6.66494C22.6194 6.32176 21.9048 6.22939 21.2339 6.40795C20.563 6.58651 19.9902 7.02153 19.6402 7.61831C19.2901 8.21509 19.1912 8.92531 19.3649 9.59434Z" fill="white"/>
        </svg>
    ]], function (element) dxSetTextureEdge (element, 'border') end),
}

panelConfig.fonts = {
    [1] = dxCreateFont("files/fonts/semibold.ttf", 15),
    [2] = dxCreateFont("files/fonts/medium.ttf", 12),
    [3] = dxCreateFont("files/fonts/medium.ttf", 10),
}

function dx()
    dxDrawImage(0, 0, panelConfig.screenX, panelConfig.screenY, "files/imgs/base.png")
    if panelConfig.window == "index" then
        dxDrawImage(panelConfig.tuning.x + respc(12), panelConfig.tuning.y + respc(1), respc(40), respc(42), panelConfig.SVG.tuning)
        dxDrawText("Tunagem", panelConfig.tuning.x + respc(66), panelConfig.tuning.y, respc(347), respc(43), tocolor(255, 255, 255, 255), 1.00, panelConfig.fonts[1], "left", "center", false, false, false, false, false)
        panelConfig.linha = 0
        for i, v in ipairs(config["Category's"]) do
            if (i > panelConfig.prox and panelConfig.linha < 5) then
                panelConfig.linha = panelConfig.linha + 1
                if panelConfig.configuration.tuning.select == i then
                    dxDrawImage(panelConfig.tuning.x, panelConfig.tuning.y + respc((-6 + 69 * panelConfig.linha)), respc(430), respc(65), "files/imgs/button.png", 0, 0, 0, tocolor(73, 166, 252))
                    dxDrawText(v[1], panelConfig.tuning.x + respc(76), panelConfig.tuning.y + respc((-6 + 69 * panelConfig.linha)), respc(337), respc(65), tocolor(255, 255, 255, 255), 1.00, panelConfig.fonts[2], "left", "center", false, false, false, false, false)
                    dxDrawImage(panelConfig.tuning.x + respc(15), panelConfig.tuning.y + respc((6 + 69 * panelConfig.linha)), respc(40), respc(40), v[4], 0, 0, 0, tocolor(255, 255, 255, 255))
                else
                    dxDrawImage(panelConfig.tuning.x, panelConfig.tuning.y + respc((-6 + 69 * panelConfig.linha)), respc(430), respc(65), "files/imgs/button.png", 0, 0, 0, tocolor(27, 27, 27))
                    dxDrawText(v[1], panelConfig.tuning.x + respc(76), panelConfig.tuning.y + respc((-6 + 69 * panelConfig.linha)), respc(337), respc(65), tocolor(255, 255, 255, 50), 1.00, panelConfig.fonts[2], "left", "center", false, false, false, false, false)
                    dxDrawImage(panelConfig.tuning.x + respc(15), panelConfig.tuning.y + respc((6 + 69 * panelConfig.linha)), respc(40), respc(40), v[4], 0, 0, 0, tocolor(255, 255, 255, 50))
                end
            end
        end
        dxDrawImage(panelConfig.tuning.x, #config["Category's"] > 5 and (panelConfig.tuning.y + respc(63 + 69 * 5)) or (panelConfig.tuning.y + respc(63 + 69 * #config["Category's"])), respc(430), respc(35), "files/imgs/selector.png")
    elseif panelConfig.window == "lsddoor" or panelConfig.window == "tires" or panelConfig.window == "engines" or panelConfig.window == "turbos" or panelConfig.window == "nitros" or panelConfig.window == "weight" or panelConfig.window == "bumperFront" or panelConfig.window == "bumperRear" or panelConfig.window == "roof" or panelConfig.window == "dischargepipe" or panelConfig.window == "spoiler" or panelConfig.window == "wheels" or panelConfig.window == "skirts" or panelConfig.window == "hydraulics" or panelConfig.window == "neon" or panelConfig.window == "horns" or panelConfig.window == "sizewheels" or panelConfig.window == "offroadmode" or panelConfig.window == "traction" or panelConfig.window == "directionlock" or panelConfig.window == "armortires" or panelConfig.window == "carcolor" then
        dxDrawImage(panelConfig.tuning.x + respc(12), panelConfig.tuning.y + respc(1), respc(40), respc(42), panelConfig.SVG.tuning)
        dxDrawText("Tunagem", panelConfig.tuning.x + respc(66), panelConfig.tuning.y, respc(347), respc(43), tocolor(255, 255, 255, 255), 1.00, panelConfig.fonts[1], "left", "center", false, false, false, false, false)
        dxDrawText(config["Category's"][panelConfig.configuration.tuning.select][1], panelConfig.tuning.x + respc(66), panelConfig.tuning.y, respc(347), respc(43), tocolor(255, 255, 255, 50), 1.00, panelConfig.fonts[1], "right", "center", false, false, false, false, false)
        panelConfig.linha = 0
        for i, v in ipairs(config["Upgrades"][panelConfig.window]) do
            if (i > panelConfig.proxUpgrade and panelConfig.linha < 5) then
                panelConfig.linha = panelConfig.linha + 1
                if panelConfig.configuration.upgrade.select == i then
                    dxDrawImage(panelConfig.tuning.x, panelConfig.tuning.y + respc((-6 + 69 * panelConfig.linha)), respc(430), respc(65), "files/imgs/button.png", 0, 0, 0, tocolor(73, 166, 252))
                    dxDrawText(v.Name, panelConfig.tuning.x + respc(76), panelConfig.tuning.y + respc((-6 + 69 * panelConfig.linha)), respc(337), respc(65), tocolor(255, 255, 255, 255), 1.00, panelConfig.fonts[2], "left", "center", false, false, false, false, false)
                    dxDrawText(v.Price and "R$ "..(v.Price) or "R$ 0", panelConfig.tuning.x + respc(76), panelConfig.tuning.y + respc((-6 + 69 * panelConfig.linha)), respc(337), respc(65), tocolor(255, 255, 255, 255), 1.00, panelConfig.fonts[2], "right", "center", false, false, false, false, false)
                    dxDrawImage(panelConfig.tuning.x + respc(15), panelConfig.tuning.y + respc((6 + 69 * panelConfig.linha)), respc(40), respc(40), config["Category's"][panelConfig.configuration.tuning.select][4], 0, 0, 0, tocolor(255, 255, 255, 255))
                else
                    dxDrawImage(panelConfig.tuning.x, panelConfig.tuning.y + respc((-6 + 69 * panelConfig.linha)), respc(430), respc(65), "files/imgs/button.png", 0, 0, 0, tocolor(27, 27, 27))
                    dxDrawText(v.Name, panelConfig.tuning.x + respc(76), panelConfig.tuning.y + respc((-6 + 69 * panelConfig.linha)), respc(337), respc(65), tocolor(255, 255, 255, 50), 1.00, panelConfig.fonts[2], "left", "center", false, false, false, false, false)
                    dxDrawText(v.Price and "R$ "..(v.Price) or "R$ 0", panelConfig.tuning.x + respc(76), panelConfig.tuning.y + respc((-6 + 69 * panelConfig.linha)), respc(337), respc(65), tocolor(255, 255, 255, 50), 1.00, panelConfig.fonts[2], "right", "center", false, false, false, false, false)
                    dxDrawImage(panelConfig.tuning.x + respc(15), panelConfig.tuning.y + respc((6 + 69 * panelConfig.linha)), respc(40), respc(40), config["Category's"][panelConfig.configuration.tuning.select][4], 0, 0, 0, tocolor(255, 255, 255, 50))
                end
            end
        end
        dxDrawImage(panelConfig.tuning.x, #config["Upgrades"][panelConfig.window] > 5 and (panelConfig.tuning.y + respc(63 + 69 * 5)) or (panelConfig.tuning.y + respc(63 + 69 * #config["Upgrades"][panelConfig.window])), respc(430), respc(35), "files/imgs/selector.png")
        if panelConfig.window == "carcolor" then
            picker:render()
            dxDrawImage(panelConfig.tuningColor.x + respc(10), panelConfig.tuningColor.y + respc(1), respc(42), respc(40), panelConfig.SVG.cor)
            dxDrawText("Selecione uma cor", panelConfig.tuningColor.x + respc(63), panelConfig.tuningColor.y, respc(311), respc(43), tocolor(255, 255, 255, 255), 1.00, panelConfig.fonts[1], "left", "center", false, false, false, false, false)
            if isMouseInPosition(panelConfig.tuningColor.x, panelConfig.tuningColor.y + respc(309), respc(406), respc(65)) then
                dxDrawImage(panelConfig.tuningColor.x, panelConfig.tuningColor.y + respc(309), respc(406), respc(65), "files/imgs/button_confirm.png", 0, 0, 0, tocolor(73, 166, 252))
                dxDrawText("Confirmar", panelConfig.tuningColor.x, panelConfig.tuningColor.y + respc(309), respc(406), respc(65), tocolor(255, 255, 255, 255), 1.00, panelConfig.fonts[2], "center", "center", false, false, false, false, false)
            else
                dxDrawImage(panelConfig.tuningColor.x, panelConfig.tuningColor.y + respc(309), respc(406), respc(65), "files/imgs/button_confirm.png", 0, 0, 0, tocolor(27, 27, 27))
                dxDrawText("Confirmar", panelConfig.tuningColor.x, panelConfig.tuningColor.y + respc(309), respc(406), respc(65), tocolor(255, 255, 255, 50), 1.00, panelConfig.fonts[2], "center", "center", false, false, false, false, false)
            end
            local vehicleColor = {getVehicleColor(panelConfig.vehicle, true)}
            local colorPicker = picker:getColor()
            if panelConfig.configuration.upgrade.select == 1 then
                setVehicleColor(panelConfig.vehicle, colorPicker[1], colorPicker[2], colorPicker[3], vehicleColor[4], vehicleColor[5], vehicleColor[6], vehicleColor[7], vehicleColor[8], vehicleColor[9], vehicleColor[10], vehicleColor[11], vehicleColor[12])
            elseif panelConfig.configuration.upgrade.select == 2 then
                setVehicleColor(panelConfig.vehicle, vehicleColor[1], vehicleColor[2], vehicleColor[3], colorPicker[1], colorPicker[2], colorPicker[3], vehicleColor[7], vehicleColor[8], vehicleColor[9], vehicleColor[10], vehicleColor[11], vehicleColor[12])
            elseif panelConfig.configuration.upgrade.select == 3 then
                setVehicleColor(panelConfig.vehicle, vehicleColor[1], vehicleColor[2], vehicleColor[3], vehicleColor[4], vehicleColor[5], vehicleColor[6], colorPicker[1], colorPicker[2], colorPicker[3], vehicleColor[10], vehicleColor[11], vehicleColor[12])
            elseif panelConfig.configuration.upgrade.select == 4 then
                setVehicleColor(panelConfig.vehicle, vehicleColor[1], vehicleColor[2], vehicleColor[3], vehicleColor[4], vehicleColor[5], vehicleColor[6], vehicleColor[7], vehicleColor[8], vehicleColor[9], colorPicker[1], colorPicker[2], colorPicker[3])
            end
        end
    elseif panelConfig.window == "headlightcolor" then
        picker:render()
        dxDrawImage(panelConfig.tuningColor.x + respc(10), panelConfig.tuningColor.y + respc(1), respc(42), respc(40), panelConfig.SVG.cor)
        dxDrawText("Selecione uma cor", panelConfig.tuningColor.x + respc(63), panelConfig.tuningColor.y, respc(311), respc(43), tocolor(255, 255, 255, 255), 1.00, panelConfig.fonts[1], "left", "center", false, false, false, false, false)
        if isMouseInPosition(panelConfig.tuningColor.x, panelConfig.tuningColor.y + respc(309), respc(406), respc(65)) then
            dxDrawImage(panelConfig.tuningColor.x, panelConfig.tuningColor.y + respc(309), respc(406), respc(65), "files/imgs/button_confirm.png", 0, 0, 0, tocolor(73, 166, 252))
            dxDrawText("Confirmar", panelConfig.tuningColor.x, panelConfig.tuningColor.y + respc(309), respc(406), respc(65), tocolor(255, 255, 255, 255), 1.00, panelConfig.fonts[2], "center", "center", false, false, false, false, false)
        else
            dxDrawImage(panelConfig.tuningColor.x, panelConfig.tuningColor.y + respc(309), respc(406), respc(65), "files/imgs/button_confirm.png", 0, 0, 0, tocolor(27, 27, 27))
            dxDrawText("Confirmar", panelConfig.tuningColor.x, panelConfig.tuningColor.y + respc(309), respc(406), respc(65), tocolor(255, 255, 255, 50), 1.00, panelConfig.fonts[2], "center", "center", false, false, false, false, false)
        end
        local colorPicker = picker:getColor()
        if panelConfig.configuration.upgrade.select == 1 then
            setVehicleHeadLightColor(panelConfig.vehicle, colorPicker[1], colorPicker[2], colorPicker[3])
        end
    end
    dxDrawImage(panelConfig.keyboard.x, panelConfig.keyboard.y, panelConfig.keyboard.w, panelConfig.keyboard.h, "files/imgs/keyboard.png")
    dxDrawText("ENTER", panelConfig.keyboard.x + respc(9), panelConfig.keyboard.y + respc(4), respc(63), respc(36), tocolor(43, 43, 43, 255), 1.00, panelConfig.fonts[3], "center", "center", false, false, false, false, false)
    dxDrawText("Confirmar compra", panelConfig.keyboard.x + respc(105), panelConfig.keyboard.y, respc(152), respc(46), tocolor(255, 255, 255, 255), 1.00, panelConfig.fonts[3], "left", "center", false, false, false, false, false)
    dxDrawText("BACKSPACE", panelConfig.keyboard.x + respc(12), panelConfig.keyboard.y + respc(57), respc(90), respc(36), tocolor(43, 43, 43, 255), 1.00, panelConfig.fonts[3], "center", "center", false, false, false, false, false)
    dxDrawText("Voltar/Fechar", panelConfig.keyboard.x + respc(135), panelConfig.keyboard.y + respc(53), respc(152), respc(46), tocolor(255, 255, 255, 255), 1.00, panelConfig.fonts[3], "left", "center", false, false, false, false, false)
end

addEvent("JOAO.openTuning", true)
addEventHandler("JOAO.openTuning", root,
function(vehicle)
    if not panelConfig.open then
        panelConfig.window = "index"
        panelConfig.configuration = {}
        panelConfig.vehicle = vehicle
        panelConfig.configuration.tuning = {}
        panelConfig.configuration.upgrade = {}
        panelConfig.configuration.tuning.select = 1
        panelConfig.configuration.upgrade.select = 1
        panelConfig.open = true
        panelConfig.prox = 0
        panelConfig.proxUpgrade = 0
        addEventHandler("onClientKey", getRootElement(), onKeyHandler, true, "low-500")
		addEventHandler("onClientPreRender", getRootElement(), onPreRenderHandler)
        local x, y, z = getElementPosition(panelConfig.vehicle)
        local rx, ry, rz = getElementRotation(panelConfig.vehicle)
		camera = {}
		camera.view = "base"
		camera.rotation = 45
		camera.height = -1.5
		camera.zoomLevel = 1
		camera.zoomInterpolate = false
		camera.moveInterpolate = false
		camera.startPos = false
		camera.stopPos = false
		screenAnimMultipler = 0
        camera.position = {x - 7.5 * math.sin(rx), y + 7.5 * math.cos(rx)+1.5, z + 2.5, x, y, z}
		screenAnim = {getTickCount() + 250, 0, 1, "enteringProcess"}
		exitingProcess = false
        addEventHandler("onClientRender", root, dx)
        showCursor(true)
        showChat(false)
    end
end)

function onPreRenderHandler(timeSlice)
	if getKeyState("mouse1") and not isMouseInPosition(panelConfig.tuningColor.x, panelConfig.tuningColor.y, panelConfig.tuningColor.w, panelConfig.tuningColor.h) then
		local cursorX, cursorY = getCursorPosition()
		if tonumber(cursorX) then
			cursorX = cursorX * panelConfig.screenX
			cursorY = cursorY * panelConfig.screenY

			if not lastCursorPos then
				lastCursorPos = {
					onMoveStartX = cursorX,
					onMoveStartY = cursorY,
					yawStart = camera.rotation,
					pitchStart = camera.height
				}
			end

			camera.rotation = lastCursorPos.yawStart - (cursorX - lastCursorPos.onMoveStartX) / panelConfig.screenX * 270
			camera.height = lastCursorPos.pitchStart + (cursorY - lastCursorPos.onMoveStartY) / panelConfig.screenY * 20

			if camera.rotation > 360 then
				camera.rotation = camera.rotation - 360
			elseif camera.rotation < 0 then
				camera.rotation = camera.rotation + 360
			end

			local maxZ = math.abs(getElementDistanceFromCentreOfMassToBaseOfModel(panelConfig.vehicle) - 1)

			if camera.height > maxZ then
				camera.height = maxZ
			elseif camera.height < -2 then
				camera.height = -2
			end
		end
	elseif lastCursorPos then
		lastCursorPos = false
	end
    if camera.zoomInterpolate then
		local elapsedTime = getTickCount() - camera.zoomInterpolate[1]
		local progress = elapsedTime / 150

		camera.zoomLevel = interpolateBetween(camera.zoomInterpolate[2], 0, 0, camera.zoomInterpolate[3], 0, 0, progress, "InOutQuad")

		if progress >= 1 then
			camera.zoomInterpolate = false
		end
	end

	if camera.moveInterpolate then
		local elapsedTime = getTickCount() - camera.moveInterpolate
		local progress = elapsedTime / 475

		camera.rotation, camera.height, camera.zoomLevel = interpolateBetween(
			camera.startPos[1], camera.startPos[2], camera.startPos[3],
			camera.stopPos[1] or camera.startPos[1], camera.stopPos[2] or camera.startPos[2], camera.stopPos[3] or camera.startPos[3],
			progress, "InOutQuad")

		if progress >= 1 then
			camera.moveInterpolate = false
			camera.zoomInterpolate = false
		end
	end

	local deltaX = camera.position[1] - camera.position[4]
	local deltaY = camera.position[2] - camera.position[5]
	local theta = math.rad(camera.rotation)
	setCameraMatrix(
		camera.position[4] + deltaX * math.cos(theta) - deltaY * math.sin(theta),
		camera.position[5] + deltaX * math.sin(theta) + deltaY * math.cos(theta),
		camera.position[3] + camera.height,
		camera.position[4],
		camera.position[5],
		camera.position[6],
		0, 70 / camera.zoomLevel
	)
end

function onKeyHandler(key, press)
	if isCursorShowing() and not isMTAWindowActive() then
		if camera then
			if (key == "mouse_wheel_up" or key == "mouse_wheel_down") and not camera.zoomInterpolate then
				local value = 0

				if key == "mouse_wheel_down" then
                    if camera.zoomLevel <= 0.7 then
                        value = 0.7
                    elseif camera.zoomLevel > 0.5 then
						value = camera.zoomLevel - 0.2 * camera.zoomLevel
					end
				elseif camera.zoomLevel <= 1.75 then
					value = camera.zoomLevel + 0.2 * camera.zoomLevel
				end
				if value < 0.5 then
					value = 0.5
				elseif value > 1.75 then
					value = 1.75
				end
				camera.zoomInterpolate = {getTickCount(), camera.zoomLevel, value}
			end
		end
	end
end

addEventHandler("onClientKey", root,
function (button, press)
    if panelConfig.open then
		if button == "arrow_d" and press then
            if panelConfig.window == "index" then
                if (panelConfig.configuration.tuning.select < #config["Category's"]) then
                    panelConfig.configuration.tuning.select = panelConfig.configuration.tuning.select + 1
                end
                if panelConfig.configuration.tuning.select > 5 then
                    panelConfig.prox = panelConfig.prox + 1
                    if (panelConfig.prox > #config["Category's"] - 5) then
                        panelConfig.prox = #config["Category's"] - 5
                    end
                end
            elseif panelConfig.window == "lsddoor" or panelConfig.window == "tires" or panelConfig.window == "engines" or panelConfig.window == "turbos" or panelConfig.window == "nitros" or panelConfig.window == "weight" or panelConfig.window == "bumperFront" or panelConfig.window == "bumperRear" or panelConfig.window == "roof" or panelConfig.window == "dischargepipe" or panelConfig.window == "spoiler" or panelConfig.window == "wheels" or panelConfig.window == "skirts" or panelConfig.window == "hydraulics" or panelConfig.window == "neon" or panelConfig.window == "horns" or panelConfig.window == "sizewheels" or panelConfig.window == "offroadmode" or panelConfig.window == "traction" or panelConfig.window == "directionlock" or panelConfig.window == "armortires" or panelConfig.window == "carcolor" then
                if (panelConfig.configuration.upgrade.select < #config["Upgrades"][panelConfig.window]) then
                    panelConfig.configuration.upgrade.select = panelConfig.configuration.upgrade.select + 1
                end
                if config["Upgrades"][panelConfig.window][panelConfig.configuration.upgrade.select].Type == "upgrade" then
                    local vehicle = panelConfig.vehicle
                    if config["Upgrades"][panelConfig.window][panelConfig.configuration.upgrade.select].Price then
                        if panelConfig.window == "bumperFront" or panelConfig.window == "bumperRear" or panelConfig.window == "roof" or panelConfig.window == "dischargepipe" or panelConfig.window == "spoiler" or panelConfig.window == "wheels" or panelConfig.window == "skirts" or panelConfig.window == "hydraulics" then
                            for k, b in ipairs(config["Upgrades"][panelConfig.window][panelConfig.configuration.upgrade.select].Value) do
                                addVehicleUpgrade(vehicle, b) 
                            end
                        end
                    else
                        if panelConfig.window == "bumperFront" or panelConfig.window == "bumperRear" or panelConfig.window == "roof" or panelConfig.window == "dischargepipe" or panelConfig.window == "spoiler" or panelConfig.window == "wheels" or panelConfig.window == "skirts" or panelConfig.window == "hydraulics" then
                            for k, b in ipairs(config["Upgrades"][panelConfig.window][panelConfig.configuration.upgrade.select].Value) do
                                removeVehicleUpgrade(vehicle, b) 
                            end
                        end
                    end
                elseif config["Upgrades"][panelConfig.window][panelConfig.configuration.upgrade.select].Type == "custom" then
                    local vehicle = panelConfig.vehicle
                    if config["Upgrades"][panelConfig.window][panelConfig.configuration.upgrade.select].Price then
                        if panelConfig.window == "neon" then
                            addNeon(vehicle, config["Upgrades"][panelConfig.window][panelConfig.configuration.upgrade.select].Value)
                        elseif panelConfig.window == "horns" then
                            playSound(config["Upgrades"][panelConfig.window][panelConfig.configuration.upgrade.select].Value, false, false)
                        end
                    else
                        if panelConfig.window == "neon" then
                            removeNeon(vehicle, true)
                        end
                    end
                end
                if panelConfig.configuration.upgrade.select > 5 then
                    panelConfig.proxUpgrade = panelConfig.proxUpgrade + 1
                    if (panelConfig.proxUpgrade > #config["Upgrades"][panelConfig.window] - 5) then
                        panelConfig.proxUpgrade = #config["Upgrades"][panelConfig.window] - 5
                    end
                end
            end
        elseif button == "arrow_u" and press then
            if panelConfig.window == "index" then
                if (panelConfig.configuration.tuning.select > 1) then
                    panelConfig.configuration.tuning.select = panelConfig.configuration.tuning.select - 1
                end
                if (panelConfig.prox > 0) then
                    panelConfig.prox = panelConfig.prox - 1
                end
            elseif panelConfig.window == "lsddoor" or panelConfig.window == "tires" or panelConfig.window == "engines" or panelConfig.window == "turbos" or panelConfig.window == "nitros" or panelConfig.window == "weight" or panelConfig.window == "bumperFront" or panelConfig.window == "bumperRear" or panelConfig.window == "roof" or panelConfig.window == "dischargepipe" or panelConfig.window == "spoiler" or panelConfig.window == "wheels" or panelConfig.window == "skirts" or panelConfig.window == "hydraulics" or panelConfig.window == "neon" or panelConfig.window == "horns" or panelConfig.window == "sizewheels" or panelConfig.window == "offroadmode" or panelConfig.window == "traction" or panelConfig.window == "directionlock" or panelConfig.window == "armortires" or panelConfig.window == "carcolor" then
                if (panelConfig.configuration.upgrade.select > 1) then
                    panelConfig.configuration.upgrade.select = panelConfig.configuration.upgrade.select - 1
                end
                if config["Upgrades"][panelConfig.window][panelConfig.configuration.upgrade.select].Type == "upgrade" then
                    local vehicle = panelConfig.vehicle
                    if config["Upgrades"][panelConfig.window][panelConfig.configuration.upgrade.select].Price then
                        if panelConfig.window == "bumperFront" or panelConfig.window == "bumperRear" or panelConfig.window == "roof" or panelConfig.window == "dischargepipe" or panelConfig.window == "spoiler" or panelConfig.window == "wheels" or panelConfig.window == "skirts" or panelConfig.window == "hydraulics" then
                            for k, b in ipairs(config["Upgrades"][panelConfig.window][panelConfig.configuration.upgrade.select].Value) do
                                addVehicleUpgrade(vehicle, b) 
                            end
                        end
                    else
                        if panelConfig.window == "bumperFront" or panelConfig.window == "bumperRear" or panelConfig.window == "roof" or panelConfig.window == "dischargepipe" or panelConfig.window == "spoiler" or panelConfig.window == "wheels" or panelConfig.window == "skirts" or panelConfig.window == "hydraulics" then
                            for k, b in ipairs(config["Upgrades"][panelConfig.window][panelConfig.configuration.upgrade.select].Value) do
                                removeVehicleUpgrade(vehicle, b) 
                            end
                        end
                    end
                elseif config["Upgrades"][panelConfig.window][panelConfig.configuration.upgrade.select].Type == "custom" then
                    local vehicle = panelConfig.vehicle
                    if config["Upgrades"][panelConfig.window][panelConfig.configuration.upgrade.select].Price then
                        if panelConfig.window == "neon" then
                            addNeon(vehicle, config["Upgrades"][panelConfig.window][panelConfig.configuration.upgrade.select].Value)
                        elseif panelConfig.window == "horns" then
                            playSound(config["Upgrades"][panelConfig.window][panelConfig.configuration.upgrade.select].Value, false, false)
                        end
                    else
                        if panelConfig.window == "neon" then
                            removeNeon(vehicle, true)
                        end
                    end
                end
                if (panelConfig.proxUpgrade > 0) then
                    panelConfig.proxUpgrade = panelConfig.proxUpgrade - 1
                end
            end
        elseif (button == "enter" or button == "num_enter") and press then
            if panelConfig.window == "index" then
                panelConfig.configuration.upgrade.select = 1
                panelConfig.proxUpgrade = 0
                panelConfig.window = config["Category's"][panelConfig.configuration.tuning.select][2]
                if panelConfig.window == "carcolor" then
                    panelConfig.tuningColor = {
                        w = respc(406),
                        h = respc(374),
                        x = Vector2({getScreenStartPositionFromBox(respc(406), respc(374), respc(25), respc(0), "right", "center")}).x,
                        y = Vector2({getScreenStartPositionFromBox(respc(406), respc(374), respc(25), respc(0), "right", "center")}).y,
                    }
                    picker = Colorpicker:create(panelConfig.tuningColor.x, panelConfig.tuningColor.y + respc(60), respc(406), respc(229), Vector2(10, 10), "full", false, false, false)
                elseif panelConfig.window == "headlightcolor" then
                    panelConfig.tuningColor = {
                        w = respc(406),
                        h = respc(374),
                        x = Vector2({getScreenStartPositionFromBox(respc(406), respc(374), respc(25), respc(0), "left", "center")}).x,
                        y = Vector2({getScreenStartPositionFromBox(respc(406), respc(374), respc(25), respc(0), "left", "center")}).y,
                    }
                    picker = Colorpicker:create(panelConfig.tuningColor.x, panelConfig.tuningColor.y + respc(60), respc(406), respc(229), Vector2(10, 10), "full", false, false, false)
                end
            elseif panelConfig.window == "lsddoor" or panelConfig.window == "tires" or panelConfig.window == "engines" or panelConfig.window == "turbos" or panelConfig.window == "nitros" or panelConfig.window == "weight" or panelConfig.window == "bumperFront" or panelConfig.window == "bumperRear" or panelConfig.window == "roof" or panelConfig.window == "dischargepipe" or panelConfig.window == "spoiler" or panelConfig.window == "wheels" or panelConfig.window == "skirts" or panelConfig.window == "hydraulics" or panelConfig.window == "neon" or panelConfig.window == "horns" or panelConfig.window == "sizewheels" or panelConfig.window == "offroadmode" or panelConfig.window == "traction" or panelConfig.window == "directionlock" or panelConfig.window == "armortires" then
                triggerServerEvent("JOAO.buyTuningCar", localPlayer, localPlayer, config["Upgrades"][panelConfig.window][panelConfig.configuration.upgrade.select], panelConfig.window, panelConfig.configuration.upgrade.select)
            end
        elseif button == "backspace" and press then
            if panelConfig.window == "lsddoor" or panelConfig.window == "tires" or panelConfig.window == "engines" or panelConfig.window == "turbos" or panelConfig.window == "nitros" or panelConfig.window == "weight" or panelConfig.window == "bumperFront" or panelConfig.window == "bumperRear" or panelConfig.window == "roof" or panelConfig.window == "dischargepipe" or panelConfig.window == "spoiler" or panelConfig.window == "wheels" or panelConfig.window == "skirts" or panelConfig.window == "hydraulics" or panelConfig.window == "neon" or panelConfig.window == "horns" or panelConfig.window == "sizewheels" or panelConfig.window == "offroadmode" or panelConfig.window == "traction" or panelConfig.window == "directionlock" or panelConfig.window == "armortires" or panelConfig.window == "carcolor" or panelConfig.window == "headlightcolor" then
                panelConfig.window = "index"
            elseif panelConfig.window == "index" then
                closeMenu()
            end
        end
	end
end)

addEvent("JOAO.applyColorsVeh", true)
addEventHandler("JOAO.applyColorsVeh", root,
function(vehicle, colorVeh, colorHeadlight, upgradesVeh, neonState)
    if vehicle and colorVeh and colorHeadlight then
        setVehicleColor(vehicle, unpack(colorVeh))
        setVehicleHeadLightColor(vehicle, unpack(colorHeadlight))
        local upgrades = getVehicleUpgrades(vehicle)
        for _, v in ipairs(upgrades) do
            removeVehicleUpgrade(vehicle, v)
        end
        for i, v in ipairs(upgradesVeh) do
            addVehicleUpgrade(vehicle, v)
        end
        if not neonState then
            removeNeon(vehicle, true)
        end
    end
end)

function bindHoron( key, keyState ) 
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if vehicle then
        local elementData = (getElementData(vehicle, "JOAO.Horns") or false)
        if elementData and elementData.tuningTable then
            toggleControl( 'horn', false ) 
            triggerServerEvent("JOAO.openHornS", localPlayer, localPlayer, keyState)
        end
    end 
end 
bindKey( 'h', 'down', bindHoron ) 
bindKey( 'h', 'up', bindHoron ) 
bindKey( 'capslock', 'down', bindHoron ) 
bindKey( 'capslock', 'up', bindHoron ) 

addEventHandler('onClientVehicleDamage', root,
function(_, _, _, _, _, _, pneu)
    if (getElementData(source, "JOAO.Armortires") or false) then
        if (pneu) then
            local antigavida = getElementHealth(source)
            local a, b, c, d = getVehicleWheelStates(source)
            cancelEvent()
            fixVehicle(source)
            setVehicleWheelStates(source, a, b, c, d)
            setElementHealth(source, antigavida)
        end
    end
end)

addEvent("JOAO.openHorn", true)
addEventHandler("JOAO.openHorn", root,
function(vehicle, statekey, directory, pos)
    if vehicle and statekey and directory and pos then
        local elementData = (getElementData(vehicle, "JOAO.Horns") or false)
        if elementData then
            if ( statekey == 'down' ) then 
                toggleControl( 'horn', false ) 
                sound = playSound3D( directory, pos[1], pos[2], pos[3] ) 
                attachElements( sound, vehicle ) 
            elseif ( statekey == 'up' ) then 
                toggleControl( 'horn', true ) 
                if isElement( sound ) then  
                    stopSound( sound )  
                end 
            end 
        end
    end
end)

addEventHandler("onClientClick", root,
function(_, state)
    if state == "up" then
        if panelConfig.open then
            if panelConfig.window == "carcolor" then
                if isMouseInPosition(panelConfig.tuningColor.x, panelConfig.tuningColor.y + respc(309), respc(406), respc(65)) then
                    local colorPicker = picker:getColor()
                    triggerServerEvent("JOAO.buyTuningColor", localPlayer, localPlayer, config["Upgrades"][panelConfig.window][panelConfig.configuration.upgrade.select], config["Upgrades"][panelConfig.window][panelConfig.configuration.upgrade.select].Value, colorPicker)
                end
            elseif panelConfig.window == "headlightcolor" then
                if isMouseInPosition(panelConfig.tuningColor.x, panelConfig.tuningColor.y + respc(309), respc(406), respc(65)) then
                    local colorPicker = picker:getColor()
                    triggerServerEvent("JOAO.buyTuningColor", localPlayer, localPlayer, config["Upgrades"][panelConfig.window], "headlight", colorPicker)
                end
            end
        end
    end
end)

function closeMenu()
    if panelConfig.open then
        if panelConfig.window ~= "index" then
            picker:destroy()
            return
        end
        panelConfig.open = false
        showChat(true)
        removeEventHandler("onClientKey", getRootElement(), onKeyHandler)
        removeEventHandler("onClientPreRender", getRootElement(), onPreRenderHandler)
        triggerServerEvent("JOAO.removeCarTuning", localPlayer, localPlayer)
        removeEventHandler("onClientRender", root, dx)
        showCursor(false)
    end
end