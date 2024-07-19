function onVehicleDamage()
    local panel = getVehiclePanelState ( source, 5 )
    iprint  ( panel )
end

addEventHandler("onClientVehicleDamage", root, onVehicleDamage)