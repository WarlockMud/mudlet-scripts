function alias_eval_func()
    local f, e = loadstring(matches[2]);
    if(f ~= nil) then
        local a, b, c = f();
        if a ~= nil then echo ("A:  "); display(a, nil, 1); end
        if b ~= nil then echo ("B:  "); display(b, nil, 1); end
        if c ~= nil then echo ("C:  "); display(c, nil, 1); end
    end
    if e ~= nil then echo ("Er: "); display(e, nil, 1); end
    
end

function alias_version_func()
    cecho("<orange>Skrypty wersja: " .. scripts.ver .. "\n<reset>")
end

function alias_help_func()
    scripts.help:displayHelp()        
end

function alias_zabici2_func()
    if(table.size(scripts.zabici.kille) == 0) then
        echo("Dzis nikt jeszcze nikogo nie zabil. Przynajmniej niczego takiego nie widzielismy.\n")
        return
    end
    for i, z in pairs(scripts.zabici.kille) do
        local suma = 0
        echo("** " .. i .. ":\n")
        for ip, ii in pairs(z) do
            echo(string.format(" %20s: %3d\n", ip, ii))
            suma = suma + ii
        end
        echo("- Razem: " .. suma .. "\n")
    end    
end

function alias_debug_func()
    local temat = matches[3] or "lista"

    if(temat == "lista") then
        echo("/debug (stats|...)\n")
        return
    end
    
    if(temat == "stats") then
        for k, w in pairs(containerDruzyna.windowList) do
            echo("Row: " .. w.name .. "\n")
            for kk, ww in pairs(w.windowList) do
                echo("    Stats: " .. ww.name .. " id: " .. ww.id .. " imie: " .. ww.imie .. "\n")
            end
        end
        return
    end    
end

function alias_del_enemy_func()
    scripts.windows:hideEnemyStatsFor(matches[2])
end

function alias_akcja_func()
    local args = matches[3]
    local co, cmd
    
    if(args == nil) then
        echo("    Uzycie: /akcja (przeciwnik|druzyna|inni) (komenda, w miejsce % podstawiany jest cel)\n")
        return
    end
    
    local as = args:split(" ")
    co = as[1]
    
    if(akcja[co] == nil) then
        echo("    Nieprawidlowa wartosc. Dopuszczalne: ")
        for k, v in pairs(akcja) do echo(k .. " ") end
        echo("\n")
        return
    end
    
    cmd = args:sub(#co + 2)
    if(cmd:find("%%") == nil) then
        cmd = cmd .. " %"
    end
    
    if(cmd == nil or #cmd == 0) then
        echo("    Aktualna akcja dla " .. co .. " to: " .. (akcja[co] or "brak") .. "\n")
        return
    end
    if(cmd == "-") then
        akcja[co] = ""
        echo("    Akcja dla " .. co .. " usunieta.\n")
    else
        akcja[co] = cmd
        echo("    Akcja dla " .. co .. " ustawiona na: " .. cmd .. "\n")
    end
    remember("akcja")    
end

function alias_kolory_func()
    showColors()
end

function alias_statsfix_func()
    scripts.windows:cleanupStatLeftovers()
end

function alias_cont_show_all_func()
    Adjustable.Container:showAll()
end

function deleteContSaveFile(cont)
    cont:deleteSaveFile()
end

function alias_cont_reset_func()
    Adjustable.Container:doAll(deleteContSaveFile)
end

function alias_repair_team_view()
    scripts:print_log("Restartuje widok w oknie druzyny")
    expandAlias("/statsfix", false)
    expandAlias("/eval removeTeam()", false)
    send("druzyna", false)
    scripts:print_log("\n")
end