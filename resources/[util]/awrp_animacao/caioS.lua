modelObject = {} boneAnimation = {}

addEvent('Caio.onPararAnimation', true)
addEventHandler('Caio.onPararAnimation', root, function ()
    if isElement(modelObject[source]) then
        destroyElement(modelObject[source])
    end
    toggleControl(source, 'fire', true)
    toggleControl(source, 'jump', true)
    toggleControl(source, 'enter_passenger', true)
    setPedAnimation(source, nil)
    triggerClientEvent(root, 'Caio.onPararAnimationsClient', root, source)
end)

for i, v in ipairs(ANIMATIONS) do
    if v.WalkStyles then
        for _, vv in ipairs(v.WalkStyles) do
            addCommandHandler(vv.Command, function (player)
                if not isPedInVehicle(player) then
                    setPedWalkingStyle(player, tonumber(vv.Style))
                    config.notifyS(player, 'Você mudou seu estilo de andar para '..vv.Name..'.', 'info')
                end
            end)
        end
    else
        for _, vv in ipairs(v.Animations) do
            addCommandHandler(vv.Command, function (player)
                if not isPedInVehicle(player) then
                    if vv.Custom then
                        local table = CUSTOM_ANIMATIONS[vv.Anim[1]][vv.Anim[2]]
                        if table then
                            if table.blockAttack then
                                toggleControl(player, 'fire', false)
                            end
                            if table.blockJump then
                                toggleControl(player, 'jump', false)
                            end
                            if table.blockVehicle then
                                toggleControl(player, 'enter_passenger', false)
                            end
                            if table.Object then
                                if isElement(modelObject[player]) then
                                    destroyElement(modelObject[player])
                                end
                                modelObject[player] = createObject(table.Object.Model, getElementPosition(player))
                                if table.Object.Scale then
                                    setObjectScale(modelObject[player], table.Object.Scale)
                                end
                                setElementCollisionsEnabled(modelObject[player], false)
                                exports['pAttach']:attach(modelObject[player], player, unpack(table.Object.Offset))
                                config.notifyS(player, 'Você pegou o objeto '..vv.Name..'.', 'info')
                            end
                            if table.BonesRotation then
                                if boneAnimation[player] then
                                    triggerClientEvent(root, 'Caio.onPararAnimationsClient', root, player)
                                    boneAnimation[player] = false
                                end
                                boneAnimation[player] = true
                                triggerClientEvent(root, 'Caio.onSetBonePosition', root, player, table.BonesRotation)
                            end
                        end
                    elseif vv.IFP then
                        triggerClientEvent(root, 'Caio.onSetAnimation', root, player, vv.Anim)
                    else
                        setPedAnimation(player, unpack(vv.Anim))
                        config.notifyS(player, 'Você ativou a animação '..vv.Name..'.', 'info')
                    end
                end
            end)
        end
    end
end

proposta = {}

function getPlayerProx (element)
    local x, y, z = getElementPosition(element)
    for i, v in ipairs(getElementsByType('player')) do
        if v ~= element then
            local xx, yy, zz = getElementPosition(v)
            if getDistanceBetweenPoints3D(x, y, z, xx, yy, zz) < 5 then
                return v
            end
        end
    end
    return false
end

addEvent('Caio.ConviteCommand', true)
addEventHandler('Caio.ConviteCommand', root, function (command)
    local player = getPlayerProx(source)
    if player then
        if not proposta[player] then
            proposta[player] = {
                cmd = command,
                owner = source
            }
            setTimer(function(player)
                proposta[player] = nil
            end, 8000, 1, player)
            config.notifyS(source, 'Solicitação foi enviada com sucesso.', 'info')
            config.notifyS(player, 'Digite /aceitar para aceitar o convite para dançar.', 'info')
        else
            config.notifyS(source, 'O jogador já possui uma outra proposta pendente.', 'info')
        end
    else
        config.notifyS(source, 'Não possui nenhum jogador proximo a você.', 'info')
    end
end)

addCommandHandler('aceitar', function(player)
    if proposta[player] then
        if isElement(proposta[player].owner) then
            local x, y, z = getElementPosition(player)
            local xx, yy, zz = getElementPosition(proposta[player].owner)
            if getDistanceBetweenPoints3D(x, y, z, xx, yy, zz) < 5 then
                config.notifyS(player, 'Você aceitou a proposta de dançar', 'info')
                config.notifyS(proposta[player].owner, 'Jogador aceitou a proposta de dançar', 'info')
                executeCommandHandler(proposta[player].cmd, player)
                executeCommandHandler(proposta[player].cmd, proposta[player].owner)
            else
                config.notifyS(source, 'O jogador está muito longe de você.', 'info')
            end
        else
            config.notify(source, 'Este convite falhou.', 'error')    
        end
        proposta[player] = nil
    else
        config.notifyS(source, 'Você não possui nenhuma proposta pendente.', 'info')
    end
end)

addEvent('Caio.onExecuteCommand', true)
addEventHandler('Caio.onExecuteCommand', root, function (command)
    executeCommandHandler(command, source)
end)

addEventHandler('onPlayerWasted', root, function ()
    if isElement(modelObject[source]) then
        destroyElement(modelObject[source])
    end
    toggleControl(source, 'fire', true)
    toggleControl(source, 'jump', true)
    toggleControl(source, 'enter_passenger', true)
    setPedAnimation(source, nil)
    triggerClientEvent(root, 'Caio.onPararAnimationsClient', root, source)
end)

addEventHandler('onPlayerQuit', root, function ()
    if isElement(modelObject[source]) then
        destroyElement(modelObject[source])
    end
    toggleControl(source, 'fire', true)
    toggleControl(source, 'jump', true)
    toggleControl(source, 'enter_passenger', true)
    setPedAnimation(source, nil)
    triggerClientEvent(root, 'Caio.onPararAnimationsClient', root, source)
end)