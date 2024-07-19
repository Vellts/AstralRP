data = {
    ["status"] = false,
    ["phoneImage"] = nil,
    ["lockScreen"] = {},
    ["screenAnim"] = false,
    ["homeScreen"] = {},
    ["appScreen"] = {
        ["callApp"] = {}
    },
    ["timerHours"] = nil,
    ["globalFonts"] = {
        ["SemiBold"] = nil,
        ["Bold"] = nil
    },
    ["actualScreen"] = "lock"
}

function restoreData()
    data = {
        ["status"] = false,
        ["phoneImage"] = nil,
        ["lockScreen"] = {},
        ["screenAnim"] = false,
        ["homeScreen"] = {},
        ["appScreen"] = {
            ["callApp"] = {
                ["numbers"] = {}
            }
        },
        ["timerHours"] = nil,
        ["globalFonts"] = {
            ["SemiBold"] = nil,
            ["Bold"] = nil
        },
        ["actualScreen"] = "lock"
    }
end

FakeContactsData = {
    [1] = {
        id = 1,
        name = "Luis Perez",
        number = "1234567890",
    },
    [2] = {
        id = 2,
        name = "Maria Garcia",
        number = "9876543210",
    },
    [3] = {
        id = 3,
        name = "Carlos Martinez",
        number = "4567890123",
    },
    [4] = {
        id = 4,
        name = "Ana Lopez",
        number = "7890123456",
    },
    [5] = {
        id = 5,
        name = "Juan Rodriguez",
        number = "2345678901",
    },
    [6] = {
        id = 6,
        name = "Sofia Hernandez",
        number = "9012345678",
    },
    [7] = {
        id = 7,
        name = "Diego Ramirez",
        number = "3456789012",
    },
    [8] = {
        id = 8,
        name = "Laura Torres",
        number = "6789012345",
    },
    [9] = {
        id = 9,
        name = "Pedro Gomez",
        number = "0123456789",
    },
    [10] = {
        id = 10,
        name = "Marta Castro",
        number = "5678901234",
    },
    [11] = {
        id = 11,
        name = "Laura Castañeda",
        number = "8901234567",
    }
}
