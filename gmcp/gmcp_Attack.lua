--deprecated do not use
function gmcp_Attack()
	if(gmcp.Attack == nil) then return end
end

if scripts.event_handlers["scripts/gmcp/gmcp_Attack"] then
    killAnonymousEventHandler(scripts.event_handlers["scripts/gmcp/gmcp_Attack"])
end

scripts.event_handlers["scripts/gmcp/gmcp_Attack"] = registerAnonymousEventHandler("gmcp.Attack", gmcp_Attack)