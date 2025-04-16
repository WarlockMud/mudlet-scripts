function update_okno_kondycji()

	local kolor_ramek = "<255,255,255>"
	local kolor_wrogow = "<255,75,75>"
	local kolor_druzyny = "<0,235,180>"
	local kolor_dowodcy = "<0,215,230>"
	local kolor_neutralnych = "<255,255,255>"
	local kolor_graczy = "<255,215,0>"
	local kolor_najmow = "<255,235,150>"
	local symbol_hp = "#"
	local symbol_dowodcy = "🜲"

	local hp_color_scale = {
		{255,0,0},
		{255,50,0},
		{255,80,0},
		{255,120,0},
		{255,160,0},
		{255,200,0},
		{255,220,0},
		{255,255,0},
		{220,255,0},
		{200,255,0},
		{150,255,0},
		{100,255,0},
		{50,255,0},
		{0,255,0}
	}

	clearWindow("Okno Kondycji")

	if gmcp.Char then
		local kolor_staminy = "<"..table.concat(hp_color_scale[gmcp.Char.State.fatigue+3],",")..">"
		local kolor_many = "<"..table.concat(hp_color_scale[gmcp.Char.State.mana+2],",")..">"
		decho("Okno Kondycji","\n  "..kolor_ramek.."Stamina: "..kolor_staminy..(gmcp.Char.State.fatigue+1).."/10 "..kolor_ramek.."Mana: "..kolor_many..(gmcp.Char.State.mana+1).."/12\n")
	end

	--for k, v in pairs(scripts.walka.objects) do
	for _, id in ipairs(scripts.walka.nums) do --ipairs + nums to keep correct object order
		local v = scripts.walka.objects[tostring(id)] or {}
		if v.avatar == 1 then
			local kolor_hp = "<"..table.concat(hp_color_scale[v.hp+1],",")..">"
			local kolor1 = kolor_druzyny
			if v.team_leader == 1 then
				kolor1 = kolor_dowodcy
			end
			local kolor2 = kolor_wrogow
			local symbol = v.symbol or ""
			local desc = "TY"
			if v.team_leader == 1 then
				desc = desc.." "..symbol_dowodcy
			end
			local strzalka = v.targeted_by and kolor_ramek.."<-- ["..kolor2..table.concat(v.targeted_by, kolor_ramek..","..kolor2)..kolor_ramek.."]" or ""
			local kratki_hp = string.rep(symbol_hp, v.hp+1)
			local szyk = v.team_rank == 0 and " " or (v.team_rank == 10 and 3) or v.team_rank
			decho("Okno Kondycji",string.format("\n"..kolor_ramek.."%3s["..kolor_hp.."%-14s"..kolor_ramek.."][%s]"..kolor1.." %s %s", symbol, kratki_hp, szyk, desc, strzalka))
		end
	end

	for _, id in ipairs(scripts.walka.nums) do
		local v = scripts.walka.objects[tostring(id)] or {}
		if v.team == 1 and v.avatar == 0 then
			local kolor_hp = "<"..table.concat(hp_color_scale[v.hp+1],",")..">"
			local kolor1 = kolor_druzyny
			if v.team_leader == 1 then
				kolor1 = kolor_dowodcy
			end
			local kolor2 = kolor_wrogow
			local symbol = v.symbol or ""
			local desc = v.desc or ""
			if v.team_leader == 1 then
				desc = desc.." "..symbol_dowodcy
			end
			local strzalka = v.targeted_by and kolor_ramek.."<-- ["..kolor2..table.concat(v.targeted_by, kolor_ramek..","..kolor2)..kolor_ramek.."]" or ""
			local kratki_hp = string.rep(symbol_hp, v.hp+1)
			local szyk = v.team_rank == 0 and " " or (v.team_rank == 10 and 3) or v.team_rank
			dechoLink("Okno Kondycji",string.format("\n"..kolor_ramek.."%3s["..kolor_hp.."%-14s"..kolor_ramek.."][%s]"..kolor1.." %s %s", symbol, kratki_hp, szyk, desc, strzalka), function() expandAlias("/zas "..symbol) end, "zaslon "..symbol.." - "..desc.." ("..id..")", true)
		end
	end

	for _, id in ipairs(scripts.walka.nums) do
		local v = scripts.walka.objects[tostring(id)] or {}
		if v.team == 0 and v.avatar == 0 then
			local kolor_hp = "<"..table.concat(hp_color_scale[v.hp+1],",")..">"
			local kolor1 = kolor_neutralnych
			local kolor2 = kolor_neutralnych
			if v.hostile == 1 then
				kolor1 = kolor_wrogow
				kolor2 = kolor_druzyny
			elseif v.player == 1 then
				kolor1 = kolor_graczy
			elseif v.mercenary == 1 then
				kolor1 = kolor_najmow
			end
			local symbol = v.symbol or ""
			local desc = v.desc or ""
			local strzalka = v.targeted_by and kolor_ramek.."<-- ["..kolor2..table.concat(v.targeted_by, kolor_ramek..","..kolor2)..kolor_ramek.."]" or ""
			local kratki_hp = string.rep(symbol_hp, v.hp+1)
			local szyk = v.team_rank == 0 and " " or (v.team_rank == 10 and 3) or v.team_rank
			dechoLink("Okno Kondycji",string.format("\n"..kolor_ramek.."%3s["..kolor_hp.."%-14s"..kolor_ramek.."][%s]"..kolor1.." %s %s", symbol, kratki_hp, szyk, desc, strzalka),	function() expandAlias("/z "..symbol) end, "zabij "..symbol.." - "..desc.." ("..id..")", true)
		end
	end

end

if scripts.event_handlers["scripts/okienka/okno_kondycji/objects"] then
    killAnonymousEventHandler(scripts.event_handlers["scripts/okienka/okno_kondycji/objects"])
end
scripts.event_handlers["scripts/okienka/okno_kondycji/objects"] = registerAnonymousEventHandler("warlock.update_objects", update_okno_kondycji)

if scripts.event_handlers["scripts/okienka/okno_kondycji/char.state"] then
    killAnonymousEventHandler(scripts.event_handlers["scripts/okienka/okno_kondycji/char.state"])
end
scripts.event_handlers["scripts/okienka/okno_kondycji/char.state"] = registerAnonymousEventHandler("gmcp.Char.State", update_okno_kondycji)