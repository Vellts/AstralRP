
-- loadstring(exports.assetify_library:import("threader"))()

function RenderIconItems(parent)
    if (table.size(Items_dgs.slots) == 0) then
        return
    end
    local items = GetPlayerItems(localPlayer)
    for _, item in pairs(items) do
        for _, slot in pairs(Items_dgs.slots) do
            if (slot.id == item.slotId) then
                local icon = Dgs:dgsCreateImage(0.25, 0.28, 0.5, 0.4, "assets/icons/item_"..item.image, true, slot.itemImage)
                slot.icon = icon
                slot.item = item

                -- stack -- 
                local stack = item.stack
                local stackLabel = Dgs:dgsCreateLabel(0.1, 0.05, 0.5, 0.2, tostring(stack), true, slot.itemImage)
                Dgs:dgsSetProperty(stackLabel, "textColor", tocolor(159, 159, 159, 255))
                Dgs:dgsSetProperty(stackLabel, "font", "default-bold")


                slot.stackLabel = stackLabel
            end
        end
    end
end

function RenderGridItems(parent)
    local x, y = 0, 0
    local w, h = Dgs:dgsGetSize(parent, false)
    local scrollPane = Dgs:dgsCreateScrollPane(x, y, w, h - (h * 0.04), false, parent)
    -- disable scrollbars
    Dgs:dgsSetProperty(scrollPane, "scrollBarThick", 0)

    -- render 4 items per column and 5 per row
    GenerateRespSlots(w, h, scrollPane, 5, 4, true, false)
end

function RenderMiniGridItems(parent)
    local w, h = (SW * 0.04), (SH * 0.075)
    local rows = 1
    local columns = 4
    local itemId = 0
    for i = 1, rows do
        local lastItemX = 0
        local lastItemW = 0
        for j = 1, columns do
            itemId = itemId + 1
            local itemRect = Dgs:dgsCreateRoundRect(6, false, tocolor(31, 27, 27, 245))
            local x1 = lastItemX + lastItemW + (w * 0.04)
            local y1 = (h * 0)

            local itemImage = Dgs:dgsCreateImage(x1, y1, w, h, itemRect, false, parent)
            Dgs:dgsAttachToAutoDestroy(itemRect, itemImage)

            -- NUMBER ITEM --

            local itemLabel = Dgs:dgsCreateLabel(0.425, 0.05, 0.1, 0.2, tostring(itemId), true, itemImage)
            Dgs:dgsSetProperties(itemLabel, {
                textColor = tocolor(159, 159, 159, 255),
                font = "default-bold"
            })

            Items_dgs.mini_menu.slots[itemImage] = {
                item = {},
                itemImage = itemImage,
                icon = nil,
                id = itemId,
                iconTexture = nil,
                stackLabel = nil
            }

            local xp, _ = Dgs:dgsGetPosition(itemImage, false)
            local wp, _ = Dgs:dgsGetSize(itemImage, false)

            lastItemX = xp
            lastItemW = wp
        end
    end
end

function RenderMenuItems(parent)
    -- RESOLUTION --
    local x, y = (SW * 0.48), (SH * 0.35)
    local w, h = (SW * 0.28), (SH * 0.35)

    -- SHADER --
    local circleShader = Dgs:dgsCreateRoundRect(6, false, tocolor(60, 70, 70, 245))

    -- BLUR --
    local blur = Dgs:dgsCreateBlurBox(w, h)
    Dgs:dgsSetProperty(blur, "updateScreenSource", true)
    Dgs:dgsBlurBoxSetFilter(blur, circleShader)
    Dgs:dgsBlurBoxSetIntensity(blur, 5)
    Dgs:dgsBlurBoxSetLevel(blur, 15)

    -- IMAGE --
    local image = Dgs:dgsCreateImage(x, y, w, h, blur, false, parent)

    -- IMAGE DELETE CONFIG --
    Dgs:dgsAttachToAutoDestroy(circleShader, image)
    Dgs:dgsAttachToAutoDestroy(blur, image)

    -- GRID --
    RenderGridItems(image)
    -- ITEMS --
    RenderIconItems(image)

    return image
end

function RenderMiniMenuItems()
    local w, h = (SW * 0.16), (SH * 0.075)
    local x, y = (SW * 0.42), (SH * 0.91)
    Items_dgs.mini_menu.main = Dgs:dgsCreateImage(x, y, w, h, nil, false)
    Dgs:dgsSetProperty(Items_dgs.mini_menu.main, "color", tocolor(0, 0, 0, 0))
    -- Dgs:dgsAttachToAutoDestroy(miniMenu, Items_dgs.background)
    RenderMiniGridItems(Items_dgs.mini_menu.main)
    UpdateMiniMenuItemsIcon()
    addEventHandler("onClientPlayerVehicleEnter", localPlayer, function(vehicle)
        if (not isElement(Items_dgs.mini_menu.main)) then return end
        
        RenderMiniInventory(false, 100)
        -- Dgs:dgsAlphaTo(Items_dgs.mini_menu.main, 0, "Linear", 100)
        -- setTimer(function()
        --     Dgs:dgsSetVisible(Items_dgs.mini_menu.main, false)
        -- end, 100, 1)
    end)

    addEventHandler("onClientPlayerVehicleExit", localPlayer, function(vehicle)
        if (not isElement(Items_dgs.mini_menu.main)) then return end
        
        RenderMiniInventory(true, 100)
        -- Dgs:dgsSetVisible(Items_dgs.mini_menu.main, true)
        -- Dgs:dgsAlphaTo(Items_dgs.mini_menu.main, 1, "OutQuad", 200)
    end)
end

ItemsAcc = 4
function UpdateMiniMenuItemsIcon()
    if (table.size(Items_dgs.mini_menu.slots) == 0) then
        return
    end

    if (table.size(Items_dgs.slots) == 0) then
        local items = GetPlayerItems(localPlayer)
        for _, item in pairs(items) do
            for _, slot in pairs(Items_dgs.mini_menu.slots) do
                if (slot.id == item.slotId) then
                    if (table.size(item) > 1) then
                        if (not slot.icon) then
                            slot.icon = Dgs:dgsCreateImage(0.25, 0.35, 0.5, 0.38, "assets/icons/item_"..item.image, true, slot.itemImage)
                            slot.item = item
                            ItemsAcc = ItemsAcc - 1
                        end
                    else
                        if (isElement(slot.icon)) then
                            ItemsAcc = ItemsAcc + 1
                            destroyElement(slot.icon)
                            slot.icon = nil
                            slot.item = {}
                        end
                    end
                end
            end
        end
        return
    end
    -- render the icon of the first 4 slots
    for _, item in pairs(Items_dgs.slots) do
        for _, slot in pairs(Items_dgs.mini_menu.slots) do
            -- get the item data of the first 4 slots
            if (slot.id == item.id) then
                if (table.size(item.item) > 0) then
                    if (not slot.icon) then
                        -- iprint(slot.id, item.id)
                        slot.icon = Dgs:dgsCreateImage(0.25, 0.35, 0.5, 0.38, "assets/icons/item_"..item.item.image, true, slot.itemImage)
                        slot.item = item.item
                        ItemsAcc = ItemsAcc - 1
                    end
                else
                    if (isElement(slot.icon)) then
                        ItemsAcc = ItemsAcc + 1
                        destroyElement(slot.icon)
                        
                        slot.icon = nil
                        slot.item = {}
                    end
                end
                if (ItemsAcc == 4) then
                    RenderMiniInventory(false, 500)
                elseif (ItemsAcc <= 3) then
                    RenderMiniInventory(true, 500)
                end
            end
        end
    end
end

function AddDataToNewSlot(oldSlot, newSlot)
    for _, slot in pairs(Items_dgs.slots) do
        if (slot.id == oldSlot.id) then
            if (table.size(newSlot.item) ~= 0) then
                return false
            end
            iprint("a", newSlot.item)
            if (isElement(slot.icon)) then
                destroyElement(slot.icon)
                slot.icon = nil
                newSlot.item = slot.item
                slot.item = {}
                UpdateMiniMenuItemsIcon()
            end
            if (isElement(slot.iconTexture)) then
                destroyElement(slot.iconTexture)
                slot.iconTexture = nil
            end
            if (isElement(slot.stackLabel)) then
                destroyElement(slot.stackLabel)
                slot.stackLabel = nil
            end
        end
    end
    return true
end

function CreteNewIconSlot(itemImage, newSlot, needIcon)
    if (not newSlot.iconTexture) then
        if (isElement(newSlot.icon)) then
            newSlot.iconTexture = dxCreateTexture("assets/icons/item_"..newSlot.item.image)
        end
    end
    if (not newSlot.stackLabel) then
        local stack = newSlot.item.stack
        local stackLabel = Dgs:dgsCreateLabel(0.1, 0.05, 0.5, 0.2, tostring(stack), true, itemImage)
        Dgs:dgsSetProperty(stackLabel, "textColor", tocolor(159, 159, 159, 255))
        Dgs:dgsSetProperty(stackLabel, "font", "default-bold")
        newSlot.stackLabel = stackLabel
    end
    if (needIcon) then
        newSlot.icon = Dgs:dgsCreateImage(0.25, 0.28, 0.5, 0.4, "assets/icons/item_"..newSlot.item.image, true, itemImage)
        playSound("assets/sounds/menu_sound_2.mp3")
    end
end

function GenerateRespSlots(w, h, parent, row, column, needShadow, isVertical, ...)
    local rows = row
    local columns = column
    if (not isVertical) then
        local baseY = (h * 0.05)
        local itemHeight = (h * 0.26)
        local itemSpacingY = (h * 0.05)
        local itemId = 0
        for i = 1, rows do
            local lastItemX = 0
            local lastItemW = 0
            for j = 1, columns do
                itemId = itemId + 1
                -- iprint(item)
                local itemRect = Dgs:dgsCreateRoundRect(6, false, tocolor(31, 27, 27, 245))
                
                local x1 = lastItemX + lastItemW + (w * 0.04)
                local y1 = baseY + (i - 1) * (itemHeight + itemSpacingY)
                local w1 = (w * 0.2)
                local h1 = itemHeight
                
                -- Render item shadow
                if (needShadow) then
                    local itemRectShadow = Dgs:dgsCreateRoundRect(6, false, tocolor(255, 255, 255, 50))
                    local itemShadow = Dgs:dgsCreateImage(x1 - (w1 * 0.02), y1 - (h1 * 0.02), w1 + (w1 * 0.04), h1 + (h1 * 0.04), itemRectShadow, false, parent)
                    Dgs:dgsAttachToAutoDestroy(itemRectShadow, itemShadow)
                end
                -- Render item
                local itemImage = Dgs:dgsCreateImage(x1, y1, w1, h1, itemRect, false, parent)
                
                local xp, _ = Dgs:dgsGetPosition(itemImage, false)
                local wp, _ = Dgs:dgsGetSize(itemImage, false)

                lastItemX = xp
                lastItemW = wp

                Items_dgs.shaders[itemImage] = itemRect
                Dgs:dgsAttachToAutoDestroy(itemRect, itemImage)

                -- EVENTS --

                Items_dgs.slots[itemImage] = {
                    item = {},
                    itemImage = itemImage,
                    icon = nil,
                    id = itemId,
                    iconTexture = nil,
                    stackLabel = nil
                }

                addEventHandler("onDgsDrag",itemImage,function(data)
                    local itemData = Items_dgs.slots[itemImage]

                    if (table.size(itemData.item) == 0) then
                        return
                    end

                    CreteNewIconSlot(itemImage, itemData, false)

                    Dgs:dgsSendDragNDropData({
                        item = itemData.item,
                        id = itemData.id,
                    }, itemData.iconTexture, nil, 0, 0, 40, 20)

                end,false)

                addEventHandler("onDgsDrop",itemImage,function(data)
                    local oldSlot = data
                    local newSlot = Items_dgs.slots[itemImage]
                    
                    -- delete the icon in the actual slot
                    local slotStatus = AddDataToNewSlot(oldSlot, newSlot)
                    if (not slotStatus) then
                        return
                    end
                    -- create the icon in the new slot
                    CreteNewIconSlot(itemImage, newSlot, true)
                end,false)

                

                addEventHandler("onDgsMouseLeave", itemImage, function()
                    if (source ~= itemImage) then return end
                    PopupItems(false)
                    ChangeSlotColor(itemImage, tocolor(31, 27, 27, 245))
                end, false)
                addEventHandler("onDgsMouseEnter", itemImage, function()
                    if (source ~= itemImage) then return end
                    local itemData = Items_dgs.slots[itemImage]
                    PopupItems(true, itemData)
                    ChangeSlotColor(itemImage, tocolor(13, 19, 99, 100))
                end, false)
            end
        end
    else
        local args = ...
        local rows = row
        local columns = column
        local baseY = args.y
        local itemHeight = (h * 0.9)
        local itemSpacingY = (h * 0.1)
        local itemId = 0
        for i = 1, rows do
            for j = 1, columns do
                itemId = itemId + 1
                local itemRect = Dgs:dgsCreateRoundRect(6, false, tocolor(60, 70, 70, 245))
                local blur = nil

                -- BLUR --
                if (args.needBlur) then
                    blur = Dgs:dgsCreateBlurBox(w, h)
                    Dgs:dgsSetProperty(blur, "updateScreenSource", true)
                    Dgs:dgsBlurBoxSetFilter(blur, itemRect)
                    Dgs:dgsBlurBoxSetIntensity(blur, 5)
                    Dgs:dgsBlurBoxSetLevel(blur, 15)
                end

                local x1 = args.x
                local y1 = baseY + (i - 1) * (itemHeight + itemSpacingY)
                local w1 = w
                local h1 = itemHeight

                local itemImage = Dgs:dgsCreateImage(x1, y1, w1, h1, (isElement(blur) and blur or itemRect), false, parent)
                if (table.size(args.icons) > 1) then
                    for k, _ in pairs(args.icons) do
                        -- iprint(k, v)
                        if (not args.icons[k]) then
                            local iconPath = "assets/icons/"..k..".png"
                            Dgs:dgsCreateImage(0.27, 0.3, 0.45, 0.4, iconPath, true, itemImage)
                            args.icons[k] = true
                            break
                        end
                    end
                end

                Dgs:dgsAttachToAutoDestroy(itemRect, itemImage)
                if (isElement(blur)) then
                    Dgs:dgsAttachToAutoDestroy(blur, itemImage)
                end
            end
        end
    end
end

function PopupItems(state, itemData)
    if (not Items_dgs.popup.parent) then
    --     local x, y = (SW * 0.48), (SH * 0.35)
    -- local w, h = (SW * 0.28), (SH * 0.35)
        local x, y = (SW * 0.48), (SW * 0.4)
        local w, h = (SW* 0.28), (SW * 0.05)
        local roundShader = Dgs:dgsCreateRoundRect(6, false, tocolor(70, 60, 60, 240))
        local blur = Dgs:dgsCreateBlurBox(w, h)
        Dgs:dgsSetProperty(blur, "updateScreenSource", true)
        Dgs:dgsBlurBoxSetFilter(blur, roundShader)
        Dgs:dgsBlurBoxSetIntensity(blur, 5)
        Dgs:dgsBlurBoxSetLevel(blur, 15)
        Items_dgs.popup.parent = Dgs:dgsCreateImage(x, y, w, h, blur, false, Items_dgs.background)
        -- local stackLabel = Dgs:dgsCreateLabel(0.1, 0.05, 0.5, 0.2, tostring(stack), true, slot.itemImage)
        -- Dgs:dgsSetProperty(stackLabel, "textColor", tocolor(159, 159, 159, 255))
        -- Dgs:dgsSetProperty(stackLabel, "font", "default-bold")
        local itemSelected = "Identificación"
        Items_dgs.popup.labelTitle = Dgs:dgsCreateLabel(0.04, 0.1, 0.8, 0.2, "#9F9F9FItem seleccionado: #99AFDD"..itemSelected, true, Items_dgs.popup.parent)
        Dgs:dgsSetProperties(Items_dgs.popup.labelTitle, {
            colorCoded = true,
            font = "default-bold",
            aligment = { "left", "center" }
        })
        local textDescription = "Esta es tu indentificación, te servirá para mostrar quien eres ante las autoridades y procesos necesitados por el gobierno."
        Items_dgs.popup.labelDescription = Dgs:dgsCreateLabel(0.04, 0.35, 0.92, 0.4, textDescription, true, Items_dgs.popup.parent)
        Dgs:dgsSetProperties(Items_dgs.popup.labelDescription, {
            font = "default-bold",
            wordBreak = true,
            aligment = { "left", "center" },
            textColor = tocolor(159, 159, 159, 255)
        })
        Dgs:dgsSetVisible(Items_dgs.popup.parent, false)
    end
    if (state) then
        if (isElement(Items_dgs.popup.parent)) then
            if (table.size(itemData.item) > 1) then
                Dgs:dgsSetVisible(Items_dgs.popup.parent, true)
                local labelTitle = itemData.item.label
                local labelDescription = itemData.item.description

                Dgs:dgsSetText(Items_dgs.popup.labelTitle, "#9F9F9FItem seleccionado: #99AFDD"..labelTitle)
                Dgs:dgsSetText(Items_dgs.popup.labelDescription, labelDescription)
            end
        end
    else
        if (isElement(Items_dgs.popup.parent)) then
            Dgs:dgsSetVisible(Items_dgs.popup.parent, false)
        end
    end
end

function ChangeSlotColor(elm, color)
    if (isElement(elm)) then
        if (Items_dgs.shaders[elm]) then
            -- iprint(":D")
            -- Dgs:dgsSetProperty(Items_dgs.shaders[elm], "color", tocolor(70, 60, 60, 240))
            Dgs:dgsRoundRectSetColor(Items_dgs.shaders[elm], color)
        end
    end
end

function GetPlayerItems(player)
    return Items
end

function GenerateItemId()
    local id = math.randomseed(os.time())
    return id
end

function table.size(tab)
    if not tab then return 0 end
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end