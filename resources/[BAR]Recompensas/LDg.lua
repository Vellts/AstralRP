---[[
    --» sᴄʀɪᴘᴛ ғᴇɪᴛᴏ ᴘᴏʀ » Pedro Developer
--]]

config = {

    notify = function(player, text, type)

        return exports['FR_DxMessages']:addBox(player, text, type);

    end; 

    notifyC = function(text, type)

        return triggerEvent('FR_DxMessages', localPlayer, text, type)

    end;    

    elementDataCash = 'aPoints';

    rewards = { -- // amount, type ('money' or 'cash')

        {30000, 'money'};    
        {40000, 'money'};
        {50000, 'money'};
        {60000, 'money'};
        {70000, 'money'};
        {80000, 'money'};
        {90000, 'money'};
        {100000, 'money'};
        {3, 'cash'};
    };
}