function gmcp_char_info()
    if(gmcp.Char.Info == nil) then return end
    scripts.character_name = string.lower(gmcp.Char.Info.name)
    scripts.character_id = gmcp.Char.Info.id
end

if scripts.event_handlers["scripts/gmcp/gmcp_Char_Info"] then
    killAnonymousEventHandler(scripts.event_handlers["scripts/gmcp/gmcp_Char_Info"])
end

scripts.event_handlers["scripts/gmcp/gmcp_Char_Info"] = registerAnonymousEventHandler("gmcp.Char.Info", gmcp_char_info)