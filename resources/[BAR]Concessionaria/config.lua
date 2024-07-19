config = {
    ["gerais"] = {
        ["permissions"] = {"Console"};
        ["time.teste-drive"] = 60 * 60000;
        ["price.slot"] = 5; -- // Preço do slot adicional (aPoints).
        ["bind.open"] = "F4"; -- // Bind para abrir o painel de meus veiculos.
    };

    ["categorys"] = {
        {tittle = "CARROS", desc = "Veículos padrão", icon = "assets/gfx/icon_car.png", size = {42, 25, 17}, count = 13};
        {tittle = "MOTOCICLETAS", desc = "Veículos padrão", icon = "assets/gfx/icon_moto.png", size = {46, 18, 25}, count = 10};
        {tittle = "AERONAVES", desc = "Veículos premium", icon = "assets/gfx/icon_aircraft.png", size = {42, 25, 21}, count = 12};
        {tittle = "BARCOS", desc = "Veículos premium", icon = "assets/gfx/icon_diamond.png", size = {43, 23, 19}, count = 13};
    };

    ["colors"] = { -- // Máximo de 10 cores.
        {0, 0, 0}; -- Preto
        {255, 0, 0}; -- Vermelho
        {22, 72, 245}; -- Azul
        {255, 255, 255}; -- Branco
        {240, 168, 84}; -- Dourado
        {64, 255, 83}; -- Verde Neon
        {122, 55, 229}; -- Roxo
        {115, 174, 112}; -- Verde Claro
        {14, 158, 247}; -- Azul Claro
        {247, 14, 238}; -- Rosa
    };

    ["veiculos"] = {
        ["CARROS"] = { -- // Name, ID, Price, Price Pontos, KG Porta Malas, Informações do veiculo (velocidade, aceleração, freio e tração).
            {'Chevette', 517, 10000, 5, 10, statics = {speed = 102, aceleration = 25, brake = 20, traction = 4}};
            {'Fiat Palio', 507, 15000, 7, 20, statics = {speed = 108, aceleration = 25, brake = 20, traction = 4}};
            {'Chevrolet Corsa', 551, 20000, 8, 30, statics = {speed = 117, aceleration = 20, brake = 20, traction = 4}};
            {'Gol Quadrado', 527, 25000, 9, 40, statics = {speed = 112, aceleration = 10, brake = 20, traction = 4}};
            {'Volkswagen Golf', 445, 30000, 10, 50, statics = {speed = 120, aceleration = 25, brake = 10, traction = 4}};

            {'Volkswagen Fox', 546, 50000, 15, 70, statics = {speed = 128, aceleration = 25, brake = 25, traction = 4}};
            {'Peugeot 308', 604, 100000, 20, 80, statics = {speed = 127, aceleration = 25, brake = 25, traction = 4}};
            {'Renault Kwid', 426, 150000, 25, 90, statics = {speed = 127, aceleration = 25, brake = 25, traction = 4}};
            {'Toyota Camry', 540, 200000, 30, 100, statics = {speed = 142, aceleration = 30, brake = 30, traction = 4}};
            
            {'Sonata', 580, 500000, 30, 70, statics = {speed = 182, aceleration = 25, brake = 20, traction = 4}};
            {'Mercedes-Benz S-Class', 587, 750000, 50, 120, statics = {speed = 192, aceleration = 30, brake = 25, traction = 4}};
            {'BMW 7 Series', 458, 800000, 60, 130, statics = {speed = 202, aceleration = 25, brake = 25, traction = 4}};
            {'Audi A8', 479, 1000000, 80, 140, statics = {speed = 205, aceleration = 30, brake = 30, traction = 4}};
            {'Jaguar XJ', 405, 2000000, 90, 150, statics = {speed = 210, aceleration = 30, brake = 30, traction = 4}};
            {'BMW X1', 529, 5000000, 100, 160, statics = {speed = 215, aceleration = 30, brake = 30, traction = 4}};
            {'Lexus LS', 547, 10000000, 120, 170, statics = {speed = 220, aceleration = 30, brake = 30, traction = 4}};
            {'Porsche Panamera', 516, 15000000, 140, 180, statics = {speed = 224, aceleration = 30, brake = 30, traction = 4}};
            {'Rolls-Royce Phantom', 560, 20000000, 150, 190, statics = {speed = 230, aceleration = 30, brake = 30, traction = 4}};
            {'Aston Martin DB11', 411, 30000000, 2000, 200, statics = {speed = 262, aceleration = 25, brake = 30, traction = 4}};
            {'SCANIA (1.000 KG)', 515, 15000000, 150, 1000, statics = {speed = 80, aceleration = 25, brake = 30, traction = 4}};
        };

        ["MOTOCICLETAS"] = {
            {'CG 160', 461, 5000, 5, 10, statics = {speed = 130, aceleration = 20, brake = 22, traction = 4}};
            {'Fazer', 462, 15000, 10, 20, statics = {speed = 142, aceleration = 25, brake = 22, traction = 4}};
            {'PCX', 581, 30000, 15, 30, statics = {speed = 150, aceleration = 25, brake = 22, traction = 4}};
            {'XT 600', 468, 50000, 20, 50, statics = {speed = 170, aceleration = 25, brake = 22, traction = 4}};
            {'Z1000', 522, 100000, 30, 60, statics = {speed = 201, aceleration = 25, brake = 22, traction = 4}};
            {'BMW S1000', 521, 300000, 50, 80, statics = {speed = 225, aceleration = 25, brake = 30, traction = 4}};
        };

        ["AERONAVES"] = {
            {'Helicóptero', 487, 20000000, 150, 500, statics = {speed = 100, aceleration = 25, brake = 30, traction = 4}};
        };

        ["BARCOS"] = {
            {'Jetsky', 473, 2300000, 30, 500, statics = {speed = 100, aceleration = 25, brake = 30, traction = 4}};
            
        };
    };

    ["lojas"] = {
        {1571.6207275391,-1289.9865722656,18.326639175415};
    };

    ["garagens"] = {
        {1360.248, -1659.007, 13.383};
        {2204.288, -1157.124, 25.744};
        {311.732, -1787.253, 4.581};
        {2145.4, 1396.346, 10.813};
        {2514.013, 2526.393, 10.82};
        {951.327, 1714.333, 8.648};
        {-2617.106, 1353.909, 7.143};
        {-1630.419, 1290.166, 7.039};
        {-2645.701, -289.668, 7.51};
        {-2475.212, 408.78, 27.774};
        {1868.866, -1408.387, 13.539};
        {1504.885, -1364.556, 13.954};
        {1216.666, -1425.046, 13.363};
        {2856.802, -1986.282, 10.937};
        {2410.374, -1719.694, 13.855};
    };

    ["detrans"] = {
        {1613.801, -1090.066, 24.128};
    };

    ["vips"] = {
        "Alpha";
        "Epsylon";
        "Sigma";
        "Omega";
        "Patrocinador";
    };

    ["slots"] = {
        ["Patrocinador"] = 14;
        ["Omega"] = 12;
        ["Sigma"] = 10;
        ["Epsylon"] = 8;
        ["Alpha"] = 6;
        ["Everyone"] = 3;
    };

    ["logs"] = {
        ["web-hook"] = "https://discord.com/api/webhooks/1170119215408234576/1zFT325EXd0X5bO7CXNtIiVQupNFAp2LL2S1o9L9OK0KQI8kFkH4Ccgoe61jlvACP-dr";
    };
};

--function sendMessage (action, element, message, type)
--    if action == "client" then
--        return triggerEvent ("addBox", element, type, message)
--    elseif action == "server" then
--        return triggerClientEvent (element, "addBox", element, type, message)
--    end
--end

function sendMessage(action, element, message, type)
    if action == 'server' then
        exports['FR_DxMessages']:addBox(element, message, type)
    elseif action == 'client' then 
        exports['FR_DxMessages']:addBox(message, type)
    end
end