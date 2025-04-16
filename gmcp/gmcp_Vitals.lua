function gmcp_Vitals(event)
	if(gmcp.Char.Vitals == nil) then return end
	local v = gmcp.Char.Vitals
	--display(v)
	local stat = scripts.windows:findElementById(v.id, containerStats)
	if(v.self == 1 and stat == nil) then
		scripts.windows:showStatsFor(v.id, string.title(v.nazwa), true); --safe-guard: pokaz staty dla gracza jesli nie ma...
	end

	if(v.self == 1) then				
		if(v.Hp) then
			scripts.windows:setStatGauge(v.id, "kondycja", v.Hp + 1, #scripts.opisy_poziomow["kondycje"]);
			raiseEvent("warlock.hp_changed", v.nazwa, v.Hp, #scripts.opisy_poziomow["kondycje"])
		end
		if(v.Mana) then
			scripts.windows:setStatGauge(v.id, "mana", v.Mana + 1, #scripts.opisy_poziomow["mana"]);
			raiseEvent("warlock.mana_changed", v.nazwa, v.Mana, #scripts.opisy_poziomow["mana"])
		end
		if(v.Fatigue) then
			scripts.windows:setStatGauge(v.id, "zmeczenie", v.Fatigue + 1, #scripts.opisy_poziomow["zmeczenie"]);
			raiseEvent("warlock.fatigue_changed", v.nazwa, v.Fatigue, #scripts.opisy_poziomow["zmeczenie"])
		end	
	end
end
if scripts.event_handlers["scripts/gmcp/GmcpVitals"] then
    killAnonymousEventHandler(scripts.event_handlers["scripts/gmcp/GmcpVitals"])
end

scripts.event_handlers["scripts/gmcp/GmcpVitals"] = registerAnonymousEventHandler("gmcp.Char.Vitals", gmcp_Vitals)