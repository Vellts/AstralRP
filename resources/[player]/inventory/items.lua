Items = {
    [1] = {
        name = "id_card",
        category = "documents",
        label = "Documento de identidad",
        description = "Un documento de identidad que te identifica como ciudadano de San Andreas.",
        weight = 1,
        stackeable = false,
        consumable = false,
        image = "id_card.png",
        slotId = 6,
        stack = 1
    },
    [2] = {
        name = "pill",
        category = "drugs",
        label = "Pildora de curación",
        description = "Esta pildora incrementará porcentualmente tu vida un 2% cada minuto. Alcanzando un máximo de 10% de curación a los 5 minutos.",
        weight = 2,
        stackeable = true,
        consumable = true,
        image = "pill.png",
        slotId = 1,
        stack = 2
    },
    [3] = {
        name = "hamburguer",
        category = "food",
        label = "Hamburguesa",
        description = "Una hamburguesa de carne con queso y lechuga.",
        weight = 4,
        stackeable = true,
        consumable = true,
        image = "hamburguer.png",
        slotId = 2,
        stack = 3
    },
    [4] = {
        name = "hamburguer",
        category = "food",
        label = "Hamburguesa",
        description = "Una hamburguesa de carne con queso y lechuga.",
        weight = 4,
        stackeable = true,
        consumable = true,
        image = "hamburguer.png",
        slotId = 10,
        stack = 3
    },
    [5] = {
        name = "shirt",
        category = "dress",
        subcategory = "shirt",
        label = "Camisa Adidas",
        description = "Una prenda personalizada. Puede ser colocada en el torso.",
        weight = 4,
        stackeable = false,
        consumable = false,
        image = "shirt.png",
        slotId = 11,
        stack = 1
    },
    [6] = {
        name = "pistol",
        category = "weapons",
        label = "Pistola 9mm",
        description = "Una pistola de 9mm con capacidad de 15 balas.",
        weight = 4,
        stackeable = false,
        consumable = false,
        image = "pistol.png",
        slotId = 3,
        stack = 1,
        action = {
            weapon_id = 22,
            ammo = 15
        }
    }
}