function gmcp_Init()
	if(gmcp.Gmcp.Init == nil) then return end	
	for i, data in ipairs(scripts.windows:getWholeTeam()) do
		--scripts.windows:removeAllEnemiesFor(data)
		scripts.windows:hideStatsFor(data.id)
	end
	
	scripts.windows:showStatsFor(gmcp.Gmcp.Init.id, string.title(gmcp.Gmcp.Init.nazwa), true)
	tempTimer(2.0, function() raiseEvent("warlock.newSession",  gmcp.Gmcp.Init.nazwa) end)	
end
if scripts.event_handlers["scripts/gmcp/GmcpInit"] then
    killAnonymousEventHandler(scripts.event_handlers["scripts/gmcp/GmcpInit"])
end

scripts.event_handlers["scripts/gmcp/GmcpInit"] = registerAnonymousEventHandler("gmcp.Gmcp.Init", gmcp_Init)
