addEvent('Caio.exitEsc', true)
addEventHandler('Caio.exitEsc', root,
    function(player)
        kickPlayer(player, "Você clicou na opção de desconectar.")
    end
)
