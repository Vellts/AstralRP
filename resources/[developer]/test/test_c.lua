function applyMods()
    -- local txd = engineLoadTXD ( "copcarru.txd" )
    -- engineImportTXD ( txd, 599 )
    -- local dff = engineLoadDFF ( "copcarru.dff", 599 )
    -- engineReplaceModel ( dff, 599 )
    engineImportTXD(engineLoadTXD("copcarru.txd", 599), 599)
    engineReplaceModel(engineLoadDFF("copcarru.dff", 599), 599)
    engineImportTXD(engineLoadTXD("copcarvg.txd", 598), 598)
    engineReplaceModel(engineLoadDFF("copcarvg.dff", 598), 598)
end
addEventHandler("onClientResourceStart", getRootElement(), applyMods) 
