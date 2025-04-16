function gmcp_Introduced(event)
	local info = gmcp.Introduced.Info
	local co = info.odmiana[1]

	scripts.odmiana:ustawOdmiane(co, info.odmiana)
	scripts.druzyna:druzynaPodmien(info.id, co);
end
if scripts.event_handlers["scripts/gmcp/GmcpIntroduced"] then
    killAnonymousEventHandler(scripts.event_handlers["scripts/gmcp/GmcpIntroduced"])
end

scripts.event_handlers["scripts/gmcp/GmcpIntroduced"] = registerAnonymousEventHandler("gmcp.Introduced", gmcp_Introduced)