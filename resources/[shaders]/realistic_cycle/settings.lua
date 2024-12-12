Times = {
    ["Los santos"] = {
        -- { weather, fog_value, rain_value, grain_value }
        {0, }
    }
}

--[[
    Probabilidades de eventos
    NUBLADO_BAJO: 45%
    NUBLADO_ALTO: 20%
    SOLEADO_ALTO: 17%
    SOLEADO_BAJO: 15%
    TORMENTA: 3%
]]
Weather = {
    ["SOLEADO_ALTO"]    =  0,
    ["SOLEADO_BAJO"]    =  1,
    ["NUBLADO_ALTO"]    =  4,
    ["NUBLADO_BAJO"]    =  7,
    ["TORMENTA"]        =  16
}

Weather_names = {
    [0]     = "SOLEADO_ALTO",
    [1]     = "SOLEADO_BAJO",
    [4]     = "NUBLADO_ALTO",
    [7]     = "NUBLADO_BAJO",
    [16]    = "TORMENTA"
}
