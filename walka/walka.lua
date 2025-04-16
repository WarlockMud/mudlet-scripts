scripts["walka"] = scripts["walka"] or {
    nums = {},
    objects = {}
}

function scripts.walka:process_nums(nums_obj)    
    scripts.walka.nums = nums_obj    
    scripts.windows:cleanContainerStatsUpForNums()
end
function scripts.walka:process_objects(objects)

    for k,v in pairs(scripts.walka.objects) do
		local remove = true;
		for z,n in pairs(scripts.walka.nums) do
			if tonumber(k) == n then
				remove = false
			end
		end
        if remove then
            scripts.walka.objects[k] = nil
            scripts.windows:hideEnemyStatsFor(tonumber(k))
        end
    end    
    for k,v in pairs(objects) do
        scripts.walka.objects[k] = v        
	end
	
	local numbers = 0
	local letters = 0
	
	for _, id in ipairs(scripts.walka.nums) do --ipairs + nums to keep correct symbol order
		local v = scripts.walka.objects[tostring(id)] or {}
		if v.avatar == 1 then
			v.symbol = "@"
			v.hostile = 0
		elseif v.team == 1 and v.avatar == 0 then
			letters = letters + 1
			letter = string.upper(string.char(96 + letters))
			v.symbol = letter
			v.hostile = 0
		else
			numbers = numbers + 1
			v.symbol = numbers
			if v.enemy == 1 or scripts.walka.objects[tostring(v.attack_num)] and
			(scripts.walka.objects[tostring(v.attack_num)].team == 1 or
			scripts.walka.objects[tostring(v.attack_num)].avatar == 1) then
				v.hostile = 1
			else
				v.hostile = 0
			end
		end
	end
	
	local targeted_by = {}
	for k, v in pairs(scripts.walka.objects) do
		targeted_by[tostring(v.attack_num)] = targeted_by[tostring(v.attack_num)] or {}
		table.insert(targeted_by[tostring(v.attack_num)], scripts.walka.objects[k].symbol)
	end

	for k, v in pairs(targeted_by) do
		if scripts.walka.objects[k] then
			scripts.walka.objects[k].targeted_by = v
		end
	end
	
    --procesujemy stan walki
    scripts.walka:process_attacks();
	raiseEvent("warlock.update_objects")
    
end
function scripts.walka:process_attacks()
    for k,v in pairs(scripts.walka.objects) do        
        if v.team > 0 then            
            scripts.windows:showStatsFor(tonumber(k), v.desc, v.avatar == 1, false, 0)	            
        end
        if v.enemy and v.attack_num ~= 0 then

            if scripts.walka.objects[tostring(v.attack_num)] ~= nil and (scripts.walka.objects[tostring(v.attack_num)].team > 0 or scripts.walka.objects[tostring(v.attack_num)].avatar > 0) then

                local stat = scripts.windows:findElementById(tonumber(v.attack_num), containerStats)
                if(stat ~= nil and stat.is_enemy == false) then		                                                
                    scripts.windows:showEnemyStatsFor(tonumber(v.attack_num), tonumber(k), v.desc, true)                    
                end

                stat = scripts.windows:findElementById(tonumber(k), containerStats)

                if(stat ~= nil and stat.is_enemy == false) then		                    
                    scripts.windows:showEnemyStatsFor(tonumber(k), tonumber(v.attack_num), scripts.walka.objects[tostring(v.attack_num)].desc, false)                    
                end
                raiseEvent("warlock.someoneAttacks", v.desc, scripts.walka.objects[tostring(v.attack_num)].desc)
            end
        end
        scripts.windows:setStatGauge(tonumber(k), "kondycja", v.hp + 1, #scripts.opisy_poziomow["kondycje"]);
        raiseEvent("warlock.hp_changed", v.desc, v.hp, #scripts.opisy_poziomow["kondycje"])
        scripts.windows:cleanupStatLeftovers()
    end
end