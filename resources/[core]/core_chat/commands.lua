validCommands = {
    ["me"] = {
        needAdmin = false,
        needPremium = false,
        chatAction = true,
        playerAction = false,
        color = tocolor(251, 111, 111, 150),
        suggest = "[acción]",
    },
    ["do"] = {
        needAdmin = false,
        needPremium = false,
        chatAction = true,
        playerAction = false,
        color = tocolor(111, 142, 251, 150),
        suggest = "[entorno]",
    },
    ["devmode"] = {
        needAdmin = true,
        needPremium = false,
        chatAction = false,
        playerAction = false,
        color = tocolor(106, 100, 169, 150)
    },
    ["e"] = {
        needAdmin = false,
        needPremium = false,
        chatAction = false,
        playerAction = false,
        color = tocolor(251, 111, 111, 150),
    },
    ["emote"] = {
        needAdmin = false,
        needPremium = false,
        chatAction = false,
        playerAction = true,
        color = tocolor(251, 111, 111, 150),
    }
}