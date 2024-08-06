Times = {
    ["Los santos"] = {
        -- { weather, fog_value, rain_value, grain_value }
        {0, }
    }
}

--[[
    Probabilidades de eventos
    SOLEADO_BAJO: 25%
    NUBLADO_BAJO: 20%
    NIEBLA_ALTO: 18%
    NUBLADO_ALTO: 15%
    SOLEADO_ALTO: 10%
    LLUVIA_BAJO: 9%
    LLUVIA_ALTO: 3%
]]
Weather = {
    ["SOLEADO_ALTO"]    =  0,
    ["SOLEADO_BAJO"]    =  1,
    ["NUBLADO_ALTO"]    =  4,
    ["NUBLADO_BAJO"]    =  7,
    ["NIEBLA_ALTO"]     =  9,
    ["LLUVIA_ALTO"]     =  8,
    ["LLUVIA_BAJO"]     =  16
}

Weather_names = {
    [0] = "SOLEADO_ALTO",
    [1] = "SOLEADO_BAJO",
    [4] = "NUBLADO_ALTO",
    [7] = "NUBLADO_BAJO",
    [9] = "NIEBLA_ALTO",
    [8] = "LLUVIA_ALTO",
    [16] = "LLUVIA_BAJO"
}
