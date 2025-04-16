-- helpers...
function scripts.windows:get_seq_num()
	scripts.windows.seq_num = scripts.windows.seq_num + 1
	return scripts.windows.seq_num
end

-- creators...
function scripts.windows:createStatsLayout(window)
	containerStats = containerStats or Geyser.Container:new({
		name="stats",
    --x = "-31%",
    --y = mapper.get_y() + mapper.get_height(),
		--width="30%", height=containerBottom.get_y() - (mapper.get_y() + mapper.get_height()) - 10,
    x = "0px",
    y = "0px",
    width = "100%",
    height = "100%"
	}, window)
	containerDruzyna = containerDruzyna or scripts.windows:createNewLayout({
		align = "BOTTOM",
		name="druzyna", x = "0px", y = "0px",
		width="100%", height="97%",
		v_policy=Geyser.Fixed, h_policy=Geyser.Fixed,
	}, containerStats)
end

function scripts.windows:getStylesheetForStat(args)
	if(args.is_own) then
		return [[background: rgb(0, 0, 60, 255);]]
	elseif(args.is_enemy) then
		return [[background: rgb(60, 0, 0, 255);]]
	elseif(args.is_leader) then
		return [[background: rgb(60, 60, 0, 255);]]
	else
		return [[background: rgb(20, 20, 60, 255);]]
	end
end


-- tworzy klikalne labelki z akcjami. TODO: zamienic na miniconsole + echoLink aby mogly byc tooltipy.
function scripts.windows:createButtonsForStat(args, parent)
	local buttons = args.is_enemy and scripts.windows.buttons_enemy or (args.is_own and scripts.windows.buttons_own or scripts.windows.buttons_druzyna)
	local seq = args.seq or scripts.windows:get_seq_num()
	local start_x = -10
	local step_x = -15
	for i, v in pairs(buttons) do
		parent[v.name] = scripts.windows:createNewLabel({
			name = v.name .. "_" .. seq, message = v.message, tooltip = v.tooltip, fgColor = "white", color = "black", fontSize = 7,
			width = 10, height = 10, x = start_x, y = -10,
		}, parent)
    parent[v.name]:setToolTip(v.tooltip)
		start_x = start_x + step_x
	end
end

-- aktualizuje callbacki do klikania - ustawia aktualne id podpiete pod statystyki
function scripts.windows:updateButtonStatsCallback(args, parent)
	local buttons = args.is_enemy and scripts.windows.buttons_enemy or (args.is_own and scripts.windows.buttons_own or scripts.windows.buttons_druzyna)
	for i, v in pairs(buttons) do
		parent[v.name]:setClickCallback(v.callback, parent.id, unpack(v.args))
	end
end

-- Uzywamy tutaj template pattern, yay for design patterns!
-- pojedynczy box z imieniem i statmi jednej istoty
function scripts.windows:createStatsContainer(args, parent)	
	local kind = "stats_container_" .. (args.is_enemy and "enemy" or args.is_own and "own" or "team")
	local ctor = {nil, scripts.windows.statsContainerCtor}	
	local stat = scripts.windows:getElementFromPool(kind, ctor, args, parent)
	-- customize!
	stat.imieLabel:echo("<center>" .. args.imie .. "</center>")
	stat.imieLabel:setStyleSheet(scripts.windows:getStylesheetForStat(args))
	stat.imie = args.imie
	stat.id = args.id
	stat.is_own = args.is_own

	scripts.windows:updateButtonStatsCallback(args, stat)

	return stat
end

function scripts.windows.statsContainerCtor(args, parent)			
	local seq = args.seq or scripts.windows:get_seq_num()
	local stats = Geyser.Container:new({
	  		name = args.name or ("stats_" .. seq),
			v_policy=Geyser.Fixed, h_policy=Geyser.Fixed,
			width = "90px", height = (18 + 15 * #args.paski + 5),
		}, parent)
	stats.is_enemy = args.is_enemy
	stats.imieLabel = Geyser.Label:new({
			name = "imie" .. seq, x = 0, y = 2,
			width = "100%", height = "13px",
			fgColor = "white",	color = "black",
			fontSize = 8,
			message = ""
		}, stats)

    scripts.windows:createButtonsForStat(args, stats)

	local start_y = 18
	for i, v in pairs(args.paski) do
			k = v[1]
			stats[k] = Geyser.Gauge:new({
				name=k .. seq, x = "2px", y = start_y,
				width="-2px", height="10px",
				fontSize = 6,
			}, stats)
			stats[k .. "label"] = Geyser.Label:new({
				name=k .. seq .. "label", x = "2px", y = start_y + 1,
				width="-2px", height="10px",
				fontSize = 7,
			}, stats)
			stats[k .. "label"]:setColor(0, 0, 0, 0)

			stats[k].front:setStyleSheet([[
				background: ]] .. v[2] .. [[;
   				border-top: 1px black solid;
	    		border-left: 1px black solid;
	   		 	border-bottom: 1px black solid;
   		 		border-radius: 2;
	   	 	padding: 1px;
			]])
			stats[k].back:setStyleSheet([[
				background: ]] .. v[3] .. [[;
   				border-top: 1px black solid;
	    		border-left: 1px black solid;
	   			border-bottom: 1px black solid;
				border-radius: 2;
				padding: 1px;
			]])
			start_y = start_y + 15
	end
	
	scripts.windows:createBox(stats, "Box" .. seq, "1px", bcol)
	return stats
end

function scripts.windows:createRowWrapper(args, parent)
	local kind = "stats_row_wrapper"
	local ctor = {nil, scripts.windows.rowWrapperCtor}	
	
	local row = scripts.windows:getElementFromPool(kind, ctor, args, parent)
	-- customize!
	return row
end

function scripts.windows.rowWrapperCtor(args, parent)
	local seq = args.seq or scripts.windows:get_seq_num()
	local row = scripts.windows:createNewLayout({
			align = args.align or "RIGHT", kind = kind,
			name = args.name or ("row_wrapper_" .. seq),
			height = args.height, width = args.width or "100%",
			v_policy=Geyser.Fixed, h_policy=Geyser.Fixed
		}, parent)
	return row
end

-- funkcja usuwajaca zagubione elementy z kontenera statystyk
function scripts.windows:cleanupStatLeftovers()
	for k, v in pairs(scripts.windows:findElementsByAttribute("kind", "stats_row_wrapper", containerStats)) do
		if(table.size(v.windowList) == 0) then
			scripts.windows:debugmsg("* Removing leftover row: " .. v.name)
			local parent = v.container
			scripts.windows:removeElement(v)
			parent:reposition()
		else
			scripts.windows:debugmsg("* Row " .. v.name .. " has " .. table.size(v.windowList) .. " elements")
		end
	end
end

-- obsluga pokazywania i chowania statow dla siebie i czlonkow druzyny
function scripts.windows:showStatsFor(id, imie, moje, leader, rank)
	moje = moje or false
	local stat = scripts.windows:findElementById(id, containerStats)		
	if(stat == nil) then		
		scripts.windows:debugmsg("* Creating new stats for " .. imie .. " (" .. id .. ", " .. (moje and "moje" or "czyjes") .. ")")
		local paski = moje and scripts.windows.paski_ja or scripts.windows.paski_inni		
		local row = scripts.windows:createRowWrapper({height = 20 + 15 * #paski + 3, width = "100%"}, containerDruzyna)
		
		stat = scripts.windows:createStatsContainer({id = id, imie = imie, paski = paski, is_enemy = false, is_own = moje, is_leader = leader, team_rank = rank}, row)
		row:reposition()
		containerDruzyna:reposition()
	end
	stat:show()
	return stat
end

function scripts.windows:hideStatsFor(id)
	local stat = scripts.windows:findElementById(id, containerStats)
	if(stat == nil) then return end
	local row = stat.container
	local parent = row.container
	scripts.windows:debugmsg("* Removing stats for " .. id)
	for i, v in pairs(row.windowList) do
		scripts.windows:removeElement(v)
	end
	scripts.windows:removeElement(row)
	parent:reposition()
end

-- obsluga pokazywania i chowania statow dla wrogow
function scripts.windows:showEnemyStatsFor(id, enemy_id, enemy_name, move_enemy)
	scripts.windows:debugmsg("* Show stats for " .. id .. "'s enemy " .. enemy_id .. ", " .. enemy_name)
	local nasz_stat = scripts.windows:findElementById(id, containerStats)
	local enemy_stat = scripts.windows:findElementById(enemy_id, containerStats)
	if(enemy_stat == nil) then
		scripts.windows:debugmsg("* Creating new stats for " .. enemy_name .. " (" .. id .. ")")
		local seq = scripts.windows:get_seq_num()
		local ename = string.split(enemy_name, " ")
		ename = table.concat({ename[#ename], ename[#ename - 1]}, ", ")
		enemy_stat = scripts.windows:createStatsContainer({id = enemy_id, imie = ename, real_name = enemy_name, paski = scripts.windows.paski_inni, is_enemy = true, name = "stats_" .. seq, seq = seq}, nasz_stat.container)
		nasz_stat.container:reposition()
	elseif(enemy_stat.container ~= nasz_stat.container and move_enemy == true) then
		scripts.windows:debugmsg("* Moving enemy " .. enemy_stat.id .. " to " .. nasz_stat.id)
		local old_row = enemy_stat.container
		old_row:remove(enemy_stat)
		old_row:reposition()
		nasz_stat.container:add(enemy_stat)
		nasz_stat.container:reposition()
	end
	enemy_stat:show()
	return stat
end

function scripts.windows:hideEnemyStatsFor(enemy_id)
	local enemy_stat = (type(enemy_id) == "table") and enemy_id or scripts.windows:findElementById(enemy_id, containerStats)
	if(enemy_stat == nil) then return end
	local row = enemy_stat.container
	scripts.windows:removeElement(enemy_stat)
	row:reposition()
end

-- aktualizacje wskazniczkow
function scripts.windows:setStatGauge(id, gauge, wartosc, max)
	local stat = scripts.windows:findElementById(id, containerStats)
	--debugmsg("setGauge: " .. id .. ", " .. gauge .. " => " .. wartosc .. ", stat found: " .. (stat ~= nil and "yes" or "no"))
	if(stat ~= nil and stat[gauge] ~= nil and max > 0) then
		stat[gauge]:setValue(wartosc, max);
		stat[gauge .. "label"]:echo( "<center><b>" .. wartosc .. "</b> / " .. max .. "</center>", "white")
	end
end

-- onsluga akcje podpietych pod wrogow (te literki klikalne)
function scripts.windows:commandEnemyById(id, komenda)
	send(komenda .. " ob_" .. id, false)
end

function scripts.windows:callScriptById(id, co)
	if(akcja[co] == nil or akcja[co] == "" or akcja[co] == " ") then
		echo("    Brak ustalonej akcji. Wykonaj /akcja " .. co .. " kopnij % w kostke\n")
		return
	end
	local cmd_ev = akcja[co]:gsub("%%", "ob_" .. tostring(id))
	send(cmd_ev, false);
end

-- funkcje, powiedzmy, API, dla reszty skryptow
function scripts.windows:getWholeTeam()
	return scripts.windows:tableMerge(scripts.windows:findElementsByAttribute("kind", "stats_container_team", containerStats), scripts.windows:findElementsByAttribute("kind", "stats_container_own", containerStats))
end

function scripts.windows:getEnemiesFor(id)
	local stat = nil
	if(type(id) == "table") then 
		stat = id
	else
		stat = scripts.windows:findElementById(id, containerStats)
	end
	local t = {}
	for k, v in pairs(stat.container.windowList or {}) do
		if(v.is_enemy) then
			table.insert(t, v.id)
		end
	end
	return t
end
function scripts.windows:removeAllEnemiesFor(id)
	--for i, eid in ipairs(scripts.windows:getEnemiesFor(id)) do
	--	scripts.windows:hideEnemyStatsFor(eid)
	--end
end
function scripts.windows:adjustCombatOnMove()
--	local team = scripts.windows:getWholeTeam()
--	for i, data in ipairs(team) do
--		scripts.windows:removeAllEnemiesFor(data)
--	end
end
