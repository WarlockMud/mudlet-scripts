--author https://github.com/tjurczyk/arkadia
function scripts.licznik_postepow:add_improvee2(val, ignore_gmcp, id)
    if not scripts.character_name then
        scripts:print_log("Korzystanie z globalnej bazy postepow po ustawieniu 'scripts.character_name' w configu")
        return
    end

    local entry

    local hour = getTime(true, "hh:mm:ss")
    local year = getTime(true, "yyyy")
    local month = getTime(true, "MM")
    local day = getTime(true, "dd")

    if not id then
        entry = db:fetch(scripts.licznik_postepow.db_improvee.improvee, {
            db:eq(scripts.licznik_postepow.db_improvee.improvee.year, year),
            db:eq(scripts.licznik_postepow.db_improvee.improvee.month, month),
            db:eq(scripts.licznik_postepow.db_improvee.improvee.day, day),
            db:eq(scripts.licznik_postepow.db_improvee.improvee.character, scripts.character_name)
        })
    else 
        local sql_query = "SELECT * FROM improvee WHERE character=\"" .. scripts.character_name ..
        "\" AND _row_id=\"" .. id .. "\" ORDER BY _row_id ASC"
        entry = db:fetch_sql(scripts.licznik_postepow.db_improvee.improvee, sql_query)
    end

    local ret = true

    if entry and table.size(entry) == 1 then
        entry = entry[1]
        local currentVal = entry["val"]   

        if not ignore_gmcp then            
            if scripts.licznik_postepow.postepy_w_sesji < currentVal and scripts.licznik_postepow.postepy_dzisiaj == 0 then
                scripts.licznik_postepow.postepy_dzisiaj = currentVal + scripts.licznik_postepow.postepy_w_sesji
                entry["val"] = currentVal + scripts.licznik_postepow.postepy_w_sesji
            elseif scripts.licznik_postepow.postepy_w_sesji > currentVal then
                entry["val"] = scripts.licznik_postepow.postepy_w_sesji
                scripts.licznik_postepow.postepy_dzisiaj = currentVal + scripts.licznik_postepow.postepy_w_sesji
            else
                return
            end         
        else
            entry["val"] = entry["val"] + val
        end
    elseif table.size(entry) > 1 then
        scripts:print_log("Cos poszlo nie tak z baza")
        return
    else
        ret = db:add(scripts.licznik_postepow.db_improvee.improvee, {
            year = year,
            month = month,
            day = day,
            val = val,
            hour = hour,
            character = scripts.character_name
        })
        if ret then
            scripts:print_log("Ok, dodane do globalnego licznika")
        else
            scripts:print_log("Cos poszlo nie tak z zapisem do globalnych postepow")
        end
        return
    end
        
    if not db:update(scripts.licznik_postepow.db_improvee.improvee, entry) then
        ret = false
    end

    if not ret then
        scripts:print_log("Cos poszlo nie tak z zapisem do globalnych postepow")
    else
        scripts:print_log("Ok, dodane " .. tostring(val) .. " postepow do globalnego licznika")
    end
end

function scripts.licznik_postepow:print_improvee2()
    if not scripts.character_name then
        scripts:print_log("Korzystanie z bazy postepow po ustawieniu 'scripts.character_name' w configu")
        return
    end

    local sql_query = "SELECT * FROM improvee WHERE character=\"" .. scripts.character_name .. "\" ORDER BY _row_id ASC"
    local retrieved = db:fetch_sql(scripts.licznik_postepow.db_improvee.improvee, sql_query)

    cecho("<grey>+---------------------------------------------------------+\n")
    cecho("<grey>|                                                         |\n")
    local name = string.sub(scripts.character_name .. "                    ", 1, 20)
    cecho("<grey>|  POSTAC: <yellow>" .. name .. "<grey>                           |\n")
    cecho("<grey>|                                                         |\n")

    local sum = 0

    for k, v in pairs(retrieved) do
        local id = string.sub("    " .. v["_row_id"], -4)
        local this_date = v["year"] .. "/" .. v["month"] .. "/" .. v["day"]
        local date = string.sub(v["year"] .. "/" .. v["month"] .. "/" .. v["day"] .. "     ", 1, 11)
        local val_str = ""
        local value = v["val"]

        if value > 0 then
        
            sum = sum + value
            if value > 17 then
                local full = math.floor(value / 17)
                local extra = value % 17
                val_str = string.sub(tostring(full) .. " fantastycznych + " .. tostring(scripts.licznik_postepow.opisy_postepow[extra]) .. "<grey>                           ", 1, 41) .. "|"
            else
                val_str = string.sub(scripts.licznik_postepow.opisy_postepow[value] .. "                                ", 1, 35) .. "|"
            end
            
            cecho("| [<antique_white>" .. id .. "<grey>] <orange>" .. date .. "<grey> - <antique_white>" .. val_str .. "\n")
        else
            debugc('BLAD - postepy mniejsze niz zero dla id =' .. id)
        end
    end

    cecho("<grey>|                                                         |\n")
    cecho("<grey>|                                                         |\n")
    cecho("<grey>|       ------------------------------------              |\n")
    cecho("<grey>|                                                         |\n")
    local sum_global_str = string.sub(tostring(sum) .. " postepow" .. "           ", 1, 20)
    cecho("<grey>|  <pink>WSZYSTKICH DO TEJ PORY: <LawnGreen>" .. sum_global_str .. "<grey>           |\n")
    local niebot_str = string.sub("~" .. string.format("%.2f", sum / 17) .. " fantastycznych                ", 1, 25)
    cecho("<grey>|                          <LawnGreen>" .. niebot_str .. "<grey>      |\n")
    cecho("<grey>|                                                         |\n")
    cecho("<grey>+---------------------------------------------------------+\n")
end

function scripts.licznik_postepow:remove_improvee2(id)
    if not scripts.character_name then
        scripts:print_log("Korzystanie z bazy postepow po ustawieniu 'scripts.character_name' w configu")
        return
    end

    local sql_query = "SELECT * FROM improvee WHERE character=\"" .. scripts.character_name ..
            "\" AND _row_id=\"" .. id .. "\" ORDER BY _row_id ASC"
    local retrieved = db:fetch_sql(scripts.licznik_postepow.db_improvee.improvee, sql_query)
    
    if db:delete(scripts.licznik_postepow.db_improvee.improvee, retrieved[1]) then
        scripts:print_log("Ok")
    else
        scripts:print_log("Problem z baza")
    end
end

function scripts.licznik_postepow:remove_improvee2_val(id, val)
    local sql_query = "SELECT * FROM improvee WHERE character=\"" .. scripts.character_name .. "\" AND _row_id=\"" .. id .. "\" ORDER BY _row_id desc LIMIT 1"
    local retrieved = db:fetch_sql(scripts.licznik_postepow.db_improvee.improvee, sql_query)
    
    if retrieved ~= nil and table.size(retrieved) == 1 then        
        retrieved = retrieved[1]
        retrieved.val = math.max(0, retrieved.val - val)
        if not db:update(scripts.licznik_postepow.db_improvee.improvee, retrieved) then
            scripts:print_log("Cos poszlo nie tak z zapisem do globalnych postepow")
        else
            scripts:print_log("Ok, usunięte z globalnego licznika")
        end
    end
end

function scripts.licznik_postepow:reset_improvee2()
    if not scripts.character_name then
        scripts:print_log("Korzystanie z bazy postepow po ustawieniu 'scripts.character_name' w configu")
        return
    end

    if not scripts.licznik_postepow.retried then
        scripts:print_log("Probujesz wykasowac cala baze postepow, od tego nie ma odwrotu. Aby wykonac, powtorz komende")
        scripts.licznik_postepow.retried = true
    else
        db:delete(scripts.licznik_postepow.db_improvee.improvee, db:eq(scripts.licznik_postepow.db_improvee.improvee.character, scripts.character_name))
        scripts:print_log("Ok")
    end

    tempTimer(5, function() scripts.licznik_postepow.retried = nil end)
end

function scripts.licznik_postepow:print_improvee3()
    if not scripts.character_name then
        scripts:print_log("Korzystanie z bazy postepow po ustawieniu 'scripts.character_name' w configu")
        return
    end

    local sql_query = "SELECT SUM (val) as val, year, month FROM improvee WHERE character=\"" .. scripts.character_name .. "\"  GROUP BY year, month ORDER BY year, month"
    local retrieved = db:fetch_sql(scripts.licznik_postepow.db_improvee.improvee, sql_query)

    cecho("<grey>+------------------------------+\n")
    cecho("<grey>|                              |\n")
    local name = string.sub(scripts.character_name .. "                    ", 1, 20)
    cecho("<grey>|  POSTAC: <yellow>" .. name .. "<grey>|\n")
    cecho("<grey>|                              |\n")

    local sum = 0
    local year_sum = 0;
    local prev_year = nil;
    for k, v in pairs(retrieved) do

        local year = v['year'];
        local date = year .. '/' .. v['month'];
        local value = v["val"]

        if prev_year ~= nil and year ~= prev_year then
            local year_sum_value =  string.sub( "     " .. year_sum, -4);
            cecho("<grey>| ---------------------------- |\n")
            cecho("<grey>| <pink>Razem:     - <LawnGreen>".. year_sum_value.." postepow   <grey>|\n")
            cecho("<grey>|                              |\n")
            cecho("<grey>|                              |\n")
            year_sum = 0;
        end
        prev_year = year

        local date_str = string.sub(date .. "            ", 1, 11);

        if value > 0 then
            sum = sum + value
            year_sum = year_sum + value
            local val_str =  string.sub( "     " .. value, -4);

            cecho("| <orange>" .. date_str .. "<grey>- <antique_white>" .. val_str .. " postepow   <grey>|\n")
        end
    end
    local year_sum_value =  string.sub( "     " .. year_sum, -4);
    cecho("<grey>| ---------------------------- |\n")
    cecho("<grey>| <pink>Razem:     - <LawnGreen>".. year_sum_value.." postepow   <grey>|\n")
    cecho("<grey>|                              |\n")
    cecho("<grey>|        -------------         |\n")
    cecho("<grey>|                              |\n")
    local sum_global_str = string.sub(tostring(sum) .. " postepow" .. "           ", 1, 15)
    cecho("<grey>| <pink>WSZYSTKICH - <LawnGreen>" .. sum_global_str .. "<grey> |\n")
    local niebot_str = string.sub("~" .. string.format("%.2f", sum / 17) .. " niebot.             ", 1, 16)
    cecho("<grey>|             <LawnGreen>" .. niebot_str .. "<grey> |\n")
    cecho("<grey>|                              |\n")
    cecho("<grey>+------------------------------+\n")
end