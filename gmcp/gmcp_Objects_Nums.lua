function gmcp_ObjectsNums(event)
	if(gmcp.Objects.Nums == nil) then return end
	local v = gmcp.Objects.Nums
	scripts.walka:process_nums(v)    
end
if scripts.event_handlers["scripts/gmcp/GmcpObjectsNums"] then
    killAnonymousEventHandler(scripts.event_handlers["sscripts/gmcp/GmcpObjectsNums"])
end

scripts.event_handlers["scripts/gmcp/GmcpObjectsNums"] = registerAnonymousEventHandler("gmcp.Objects.Nums", gmcp_ObjectsNums)