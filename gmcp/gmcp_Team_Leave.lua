function gmcp_Team_Leave()
	local v = gmcp.Team.Leave
	if(v == nil) then return end	
	scripts.windows:hideStatsFor(v.id)	
	scripts.druzyna:removeMemberById(v.id)
end

if scripts.event_handlers["scripts/gmcp/GmcpTeamLeave"] then
    killAnonymousEventHandler(scripts.event_handlers["scripts/gmcp/GmcpTeamLeave"])
end

scripts.event_handlers["scripts/gmcp/GmcpTeamLeave"] = registerAnonymousEventHandler("gmcp.Team.Leave", gmcp_Team_Leave)