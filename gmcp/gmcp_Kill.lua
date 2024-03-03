function gmcp_Kill()
	if(gmcp.Kill == nil) then return end
	local a = gmcp.Kill
	if a.kto.id == scripts.character_id then
		a.kto.nazwa = scripts.character_name -- hack dla druidow w przemianie
	end
	scripts.zabici:dodajZabitego(a.kto.nazwa, a.kogo.nazwa)
	scripts.counter:add_killed(a.kogo.rasa,string.lower(a.kto.nazwa))
	if scripts.character_name == string.lower(a.kto.nazwa) then
		scripts.counter2:add_item(a.kogo.nazwa, a.kogo.rasa)
	end
	raiseEvent("warlock.someoneDied", a.kto.nazwa, a.kogo.nazwa)	
end

if scripts.event_handlers["scripts/gmcp/GmcpKill"] then
    killAnonymousEventHandler(scripts.event_handlers["scripts/gmcp/GmcpKill"])
end

scripts.event_handlers["scripts/gmcp/GmcpKill"] = registerAnonymousEventHandler("gmcp.Kill", gmcp_Kill)