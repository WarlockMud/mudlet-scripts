function gmcp_ObjectsData(event)
	if(gmcp.Objects.Data == nil) then return end
	local v = gmcp.Objects.Data
	scripts.walka:process_objects(v)
end
if scripts.event_handlers["scripts/gmcp/GmcpObjectsData"] then
    killAnonymousEventHandler(scripts.event_handlers["sscripts/gmcp/GmcpObjectsData"])
end

scripts.event_handlers["scripts/gmcp/GmcpObjectsData"] = registerAnonymousEventHandler("gmcp.Objects.Data", gmcp_ObjectsData)