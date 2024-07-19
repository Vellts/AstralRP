config = {
    Aplicativos = {
      --{"NOME DO APP", "DIRETORIO IMG", "DESCRIÇÃO APP", isPadrao = true ou false}
        {"Configuração", "files/Icones/configuracao.png", "Configurações do celular", true},
        {"Calculadora", "files/Icones/calculadora.png", "Calcule suas vendas", true},
        {"Appstore", "files/Icones/appstore.png", "Baixe aplicativos neste app", true},
        {"Banco", "files/Icones/banco.png", "Faça transferencia para todos", true},
        {"Notas", "files/Icones/notas.png", "Crie lembretes para não esquecer", true},
        {"Spotify", "files/Icones/spotify.png", "Ouça musica de todo lugar", true},
        {"Minhas Informações", "files/Icones/infos.png", "Veja suas informações", true},
        {"Contatos", "files/Icones/contatos.png", "Veja seus contatos salvos", true},
        {"Whatsapp", "files/Icones/whatsapp.png", "Comunicação de qualquer lugar", true},
    },

    ContatosEmergenciais = {
        ["Deus"] = true, 
        ["Delegacia"] = true, 
        ["Hospital"] = true, 
        ["Mecânica"] = true, 
        ["Detran"] = true, 
    },

    elementsDataEmergencia = {
        ["Deus"] = {"ASC:Staff", 41}, 
        ["Delegacia"] = {"JOAO.servicePM", 30}, 
        ["Hospital"] = {"JOAO.serviceSAMU", 21}, 
        ["Mecânica"] = {"JOAO.serviceMEC", 27}, 
        ["Detran"] = {"JOAO.serviceDETRAN", 24}, 
    },

    tableCargosGrupo = {
        {"Admin"},
        {"Membro"},
    },

    tableCoresCargo = {
        ["Dono(a)"] = {Cor = tocolor(142, 0, 255, 255), posXcargo = 195},
        ["Admin"] = {Cor = tocolor(2, 117, 255, 255), posXcargo = 200, posXmais = 233},
        ["Membro"] = {Cor = tocolor(2, 117, 255, 255), posXcargo = 195, posXmais = 238},
    },

    maximoCaracteresGrupo = 24, 

    tableCoresContatosRandom = {
        {101, 210, 171, 255},
        {255, 179, 109, 255},
    },
}

notifyS = function (thePlayer, msg, type)
    exports["FR_DxMessages"]:addBox(thePlayer, msg, type)
end

notifyC = function (msg, type)
    exports["FR_DxMessages"]:addBox(msg, type)
end

formatNumber = function(number)   
    local formatted = number   
    while true do       
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')     
        if ( k==0 ) then       
            break   
        end   
    end   
    return formatted 
end 

function mathfloorcustom(valor)
    if string.len(valor) >= 3 then 
        local part1 = string.sub(valor, 1, 2)
        local part2 = string.sub(valor, 3, 3)
        return tonumber(part1..part2)
    end
    return tonumber(valor)
end

function removeHex (s)
    return s:gsub ("#%x%x%x%x%x%x", "") or false
end

function getPlayerFromAccountName(name) 
    local acc = getAccount(name)
    if not acc or isGuestAccount(acc) then
        return false
    end
    return getAccountPlayer(acc)
end

function mathfloorcustomT(valor)
    if string.len(valor) >= 1 then 
        local part1 = string.sub(valor, 1, 4)
        return part1
    end
    return tonumber(valor)
end