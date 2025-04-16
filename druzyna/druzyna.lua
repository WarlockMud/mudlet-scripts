scripts["druzyna"] = scripts["druzyna"] or {}
scripts.druzyna.members = {}
function scripts.druzyna:removeTeam()
	--display(debug.traceback())
	local stats = scripts.windows:getWholeTeam()
	for k, v in pairs(stats) do
		--display("Team member: " .. v.name .. ", is own: " .. tostring(v.is_own))
		if(v.is_own ~= true) then
			scripts.windows:hideStatsFor(v.id)
		end
	end
end

-- Podmienia opis czlonka druzyny (np. jak sie przedstawil)
function scripts.druzyna:druzynaPodmien(id, imie)
	local stat = scripts.windows:findElementById(id, containerStats)
	if(stat ~= nil) then
		stat.imieLabel:echo("<center><b>" .. imie .. "</b></center>")
		stat.imie = imie
	end
end
function scripts.druzyna:removeMemberById(id)
	local key = nil
	for k,v in pairs(scripts.druzyna.members) do
		if v.id == id then
			key = k
		end		
	end
	if key ~= nil then
		scripts.druzyna.members[key]= nil	
	end
	
end