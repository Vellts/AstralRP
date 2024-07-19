Wearables_icons = {
    [1] = {
        hat = false,
        shirt = false,
        pants = false,
        shoes = false,
        backpack = false
    },
    [2] = {
        glasses = false,
        mask = false,
        watch = false
    }
}

function RenderWearableItems(parent)
    -- First wearable slots
    local w, h = (SW * 0.05), (SH * 0.1)
    GenerateRespSlots(w, h, parent, 5, 1, false, true, {
        x = (SW * 0.28),
        y = (h * 2.9),
        needBlur = true,
        icons = Wearables_icons[1]
    })
    GenerateRespSlots(w, h, parent, 3, 1, false, true, {
        x = (SW * 0.22),
        y = (h * 3.9),
        needBlur = true,
        icons = Wearables_icons[2]
    })
end