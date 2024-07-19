function updateChartsDeveloper(player, state)
    iprint(player, state)
    triggerClientEvent(player, "developer::updateStatusCharts", player, state)
end
