--[[
    --» sᴄʀɪᴘᴛ ғᴇɪᴛᴏ ᴘᴏʀ » Pedro Developer
--]]

outputDebugString('[PEDRO DEVELOPER] RESOURCE '..getResourceName(getThisResource())..' ATIVADA COM SUCESSO', 4, 204, 82, 82)

local colectRewards, refreshTimestamp = {}, {}

local db = dbConnect('sqlite', 'assets/database/data.sqlite')
dbExec(db, 'Create table if not exists tableCacheData(colectRewards TEXT, refreshTimestamp TEXT)')

function a(source)
    local username = getAccountName(getPlayerAccount(source))
        if not (colectRewards[username]) then 

            colectRewards[username] = 0 

        end 

        if not (refreshTimestamp[username]) then 

            refreshTimestamp[username] = 0 

        end 

        triggerClientEvent(source, 'onClientDrawDayRewards', source, colectRewards[username], refreshTimestamp[username])
end

addEvent('onPlayerGiveBoxPanel', true)
addEventHandler('onPlayerGiveBoxPanel', root, a)
addCommandHandler('rewards', a)

addEvent('onPlayerColectDayGiftFromPanel', true)
addEventHandler('onPlayerColectDayGiftFromPanel', root, 

    function(player)

        if (client ~= player) then 

            return 

        end

        local username = getAccountName(getPlayerAccount(player))
        if not (colectRewards[username]) then 

            colectRewards[username] = 0 

        end 

        if not (refreshTimestamp[username]) then 

            refreshTimestamp[username] = 0 

        end 

        if (refreshTimestamp[username] > getRealTime().timestamp) then 

            return 

        end 

        refreshTimestamp[username] = getRealTime().timestamp + 86400 
        colectRewards[username] = colectRewards[username] + 1 
        config.notify(player, 'Você coletou sua recompensa com sucesso.', 'success')
        
        local rewardData = config.rewards[colectRewards[username]] 
        if (rewardData[2] == 'money') then 
            
            givePlayerMoney(player, rewardData[1])

        else

            setElementData(player, config.elementDataCash, (getElementData(player, config.elementDataCash) or 0) + tonumber(rewardData[1]))

        end

        if (colectRewards[username] >= #config.rewards) then 

            colectRewards[username] = 0 

        end 

        triggerClientEvent(player, 'onClientReceiveDayRewardsInfos', player, colectRewards[username], refreshTimestamp[username])

    end

)

addEventHandler('onResourceStart', getResourceRootElement(getThisResource()), 

    function()

        local data = dbPoll(dbQuery(db, 'Select * from tableCacheData'), - 1)
        if (#data ~= 0) then 

            colectRewards = fromJSON(data[1]['colectRewards'])
            refreshTimestamp = fromJSON(data[1]['refreshTimestamp'])

        end

    end

)

addEventHandler('onResourceStop', getResourceRootElement(getThisResource()), 

    function()

        if (#dbPoll(dbQuery(db, 'Select * from tableCacheData'), - 1) ~= 0) then 

            dbExec(db, 'Update tableCacheData set colectRewards = ?, refreshTimestamp = ?', toJSON(colectRewards), toJSON(refreshTimestamp))

        else

            dbExec(db, 'Insert into tableCacheData(colectRewards, refreshTimestamp) Values(?, ?)', toJSON(colectRewards), toJSON(refreshTimestamp))

        end 

    end

)