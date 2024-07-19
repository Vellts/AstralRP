function addBox (element, mensagem, type)
    if element and mensagem and type then
        triggerClientEvent(element, 'addBox', element, mensagem, type)
    end
end