--
-- c_switch.lua
--

----------------------------------------------------------------
----------------------------------------------------------------
-- Effect switching on and off
--
--	To switch on:
--			triggerEvent( "switchSkyAlt", root, true )
--
--	To switch off:
--			triggerEvent( "switchSkyAlt", root, false )
--
----------------------------------------------------------------
----------------------------------------------------------------


--------------------------------
-- Switch effect on or off
--------------------------------
function switchSkyAlt( sbaOn )
	if sbaOn then
		startShaderResource()
	else
		stopShaderResource()
	end
end

addEvent( "switchSkyAlt", true )
addEventHandler( "switchSkyAlt", root, switchSkyAlt )
switchSkyAlt(true)

--------------------------------
-- onClientResourceStop
-- Stop the resource
--------------------------------
addEventHandler( "onClientResourceStop", getResourceRootElement( getThisResource()),stopShaderResource)
