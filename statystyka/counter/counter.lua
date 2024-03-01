---wiekszosc kodu pobrana z https://github.com/tjurczyk/arkadia, przerobione na potrzeby warlocka
scripts.counter = scripts.counter or {}
scripts.counter2 = scripts.counter2 or {}
scripts.counter["killed"] = scripts.counter["killed"] or {}
scripts.counter["killed_amount"] = scripts.counter["killed_amount"] or {}
scripts.counter["all_kills"] = scripts.counter["all_kills"] or 0
scripts.counter.killed_amount["JA"] = scripts.counter.killed_amount["JA"] or 0

-- counter2
scripts.counter2["db_log"] = db:create("counter2_log", {
    counter2_log = {
        year = 0,
        month = 0,
        day = 0,
        hour = "",
        text = "",
        character = "",
        changed = db:Timestamp("CURRENT_TIMESTAMP")
    }
})

scripts.counter2["db_daysum"] = db:create("counter2_daysum", {
    counter2_daysum = {
        year = 0,
        month = 0,
        day = 0,
        type = "",
        character = "",
        amount = 0,
    }
})


function scripts.counter:add_killed(key, person)
    local l_key = key

    -- add entry for this person if necessary
    if not scripts.counter.killed[person] then
        scripts.counter.killed[person] = {}
        scripts.counter.killed_amount[person] = 0
    end

    -- Add key if necessary or increment counter
    if scripts.counter.killed[person][l_key] then
        scripts.counter.killed[person][l_key] = scripts.counter.killed[person][l_key] + 1
    else
        scripts.counter.killed[person][l_key] = 1
    end

    scripts.counter.killed_amount[person] = scripts.counter.killed_amount[person] + 1
    scripts.counter.all_kills = scripts.counter.all_kills + 1
end

function scripts.counter:print_killed()
    local per_type_count = scripts.counter:calculate_per_type_sums()
    cecho("+-------------- <green>Licznik zabitych<grey> ---------------+\n")
    cecho("|                                               |\n")

    local all_sum = 0

    if scripts.counter.killed[scripts.character_name] then
        cecho("| <yellow>JA<grey>                                            |\n")

        local summed = 0
        for k, v in spairs(scripts.counter.killed[scripts.character_name]) do
            local name = string.sub(k .. " ...............................", 0, 32)
            local color = scripts.counter.utils:is_rare(name) and "<orange>" or ""

            local amount = tostring(v) .. " / " .. tostring(per_type_count[k])
            cecho("| " .. color .. name .. " " .. string.sub(amount .. "            ", 0, 12) .. " <grey>|\n")
            summed = summed + v
        end
        all_sum = all_sum + summed
        cecho("|                                               |\n")
        cecho("| <light_slate_blue>LACZNIE<grey>: ....................... " .. string.sub(summed .. " (" .. roundToDecimal(summed/scripts.counter.all_kills*100,2) .. "%)            ", 0, 12) .. " |\n")
    end

    cecho("|                                               |\n")

    for k, v in pairs(scripts.counter.killed) do
        if k ~= scripts.character_name then
            local str_name = string.sub(k .. "<grey>                                           ", 0, 52)
            cecho("| <yellow>" .. str_name .. "|\n")

            local summed = 0
            for i, j in spairs(v) do
                local name = string.sub(i .. " ..............................", 0, 32)
                local color = scripts.counter.utils:is_rare(name) and "<orange>" or ""

                local amount = tostring(j) .. " / " .. tostring(per_type_count[i])
                cecho("| " .. color .. name .. " " .. string.sub(amount .. "            ", 0, 12) .. " <grey>|\n")
                summed = summed + j
            end
            cecho("|                                               |\n")
			cecho("| <light_slate_blue>LACZNIE<grey>: ....................... " .. string.sub(summed .. " (" .. roundToDecimal(summed/scripts.counter.all_kills*100,2) .. "%)            ", 0, 12) .. " |\n")
            cecho("|                                               |\n")
            all_sum = all_sum + summed
        end
    end
    if table.size(scripts.counter.killed) > 0 then
        cecho("|                                               |\n")
        cecho("| <light_slate_blue>DRUZYNA LACZNIE<grey>: ............... " .. string.sub(all_sum .. "            ", 0, 12) .. " |\n")
        cecho("|                                               |\n")
        cecho("+-----------------------------------------------+\n")
    else
        cecho("+-----------------------------------------------+\n")
    end
end

function scripts.counter:calculate_per_type_sums()
    local per_type_count = {}
    for char, di in pairs(scripts.counter.killed) do
        for monster, amount in pairs(di) do
            if not per_type_count[monster] then
                per_type_count[monster] = amount
            else
                per_type_count[monster] = per_type_count[monster] + amount
            end
        end
    end
    return per_type_count
end

function scripts.counter:reset()
    scripts.counter.killed = {}
    scripts.counter.killed_amount = {}    
    scripts.counter.all_kills = 0
    scripts:print_log("Licznik zresetowany")
end

function alias_zabici_func()
    scripts.counter:print_killed() 
end
function alias_reset_zabici_func()
    scripts.counter:reset()
    scripts.zabici.kille = {}
end

function alias_stats_def()

	stats = stats or {}
	stats.defensywne = stats.defensywne or {}
	stats.defensywne.miss = stats.defensywne.miss or 0
	stats.defensywne.uniki = stats.defensywne.uniki or 0
	stats.defensywne.parowanie = stats.defensywne.parowanie or 0
	stats.defensywne.tarcza = stats.defensywne.tarcza or 0
	stats.defensywne.zbroja = stats.defensywne.zbroja or 0
	stats.defensywne.hit = stats.defensywne.hit or 0

	local total = stats.defensywne.miss + stats.defensywne.uniki + stats.defensywne.parowanie + stats.defensywne.tarcza + stats.defensywne.zbroja + stats.defensywne.hit
	if total <1 then total = 1 end

	local display_miss = roundToDecimal(stats.defensywne.miss/total*100,0)
	local display_uniki = roundToDecimal(stats.defensywne.uniki/total*100,0)
	local display_parowanie = roundToDecimal(stats.defensywne.parowanie/total*100,0)
	local display_tarcza = roundToDecimal(stats.defensywne.tarcza/total*100,0)
	local display_zbroja = roundToDecimal(stats.defensywne.zbroja/total*100,0)
	local display_hit = roundToDecimal(stats.defensywne.hit/total*100,0)

	cecho("<grey>----------------------\n")
	cecho("<light_sea_green>   STATY DEFENSYWNE\n")
	cecho("<grey>----------------------\n")
	cecho(string.format("<light_sea_green>%-5s <grey>%16s\n", "Data:", os.date("%Y.%m.%d")))
	cecho(string.format("<light_sea_green>%-5s <grey>%16s\n", "Imie:", string.upper(gmcp.Char.Info.name)))
	cecho("<grey>----------------------\n")
	cecho(string.format("<light_sea_green>%-10s <grey>%5s (%2s%%)\n", "Chybione:", stats.defensywne.miss, display_miss))
	cecho(string.format("<light_sea_green>%-10s <grey>%5s (%2s%%)\n", "Uniki:", stats.defensywne.uniki, display_uniki))
	cecho(string.format("<light_sea_green>%-10s <grey>%5s (%2s%%)\n", "Parowanie:", stats.defensywne.parowanie, display_parowanie))
	cecho(string.format("<light_sea_green>%-10s <grey>%5s (%2s%%)\n", "Tarcza:", stats.defensywne.tarcza, display_tarcza))
	cecho(string.format("<light_sea_green>%-10s <grey>%5s (%2s%%)\n", "Zbroja:", stats.defensywne.zbroja, display_zbroja))
	cecho(string.format("<light_sea_green>%-10s <grey>%5s (%2s%%)\n", "Trafienia:", stats.defensywne.hit, display_hit))
	cecho("<grey>----------------------\n")

end

function roundToDecimal(number, decimalPlaces)
  local multiplier = 10 ^ decimalPlaces
  return math.floor(number * multiplier + 0.5) / multiplier
end