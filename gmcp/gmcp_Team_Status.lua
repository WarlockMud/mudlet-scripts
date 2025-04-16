function gmcp_Team_Status()
	local v = gmcp.Team.Status
	if(v == nil) then return end	
	if(v.prowadzacy == 0) then
		scripts.druzyna:removeTeam()
		return
	end
	for i, t in pairs(v.druzyna) do
        scripts.windows:showStatsFor(t.id, t.nazwa, t.self == 1, t.id == v.prowadzacy.id, t.szereg)
	end
	
end
if scripts.event_handlers["scripts/gmcp/GmcpTeamStatus"] then
    killAnonymousEventHandler(scripts.event_handlers["scripts/gmcp/GmcpTeamStatus"])
end

scripts.event_handlers["scripts/gmcp/GmcpTeamStatus"] = registerAnonymousEventHandler("gmcp.Team.Status", gmcp_Team_Status)