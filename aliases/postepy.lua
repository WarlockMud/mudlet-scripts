function alias_postepy_func()
    scripts.licznik_postepow:print_improve()
end
function alias_postepy_reset_func()
    scripts.licznik_postepow:improve_reset()
end
function alias_postepy2_func()
    scripts.licznik_postepow:print_improvee2()
end
function alias_postepy3_func()
    scripts.licznik_postepow:print_improvee3()
end
function alias_postepy2_reset_func()
    scripts.licznik_postepow:reset_improvee2()
end
function alias_postepy2_plus_func()
    scripts.licznik_postepow:add_improvee2(1,true)
end
function alias_postepy2_plus_val_func()
    if matches[3] then
        scripts.licznik_postepow:add_improvee2(tonumber(matches[3]),true, tonumber(matches[2]))        
    else
        scripts.licznik_postepow:add_improvee2(tonumber(matches[2]),true)
    end
end
function alias_postepy2_minus_func()
    scripts.licznik_postepow:remove_improvee2(tonumber(matches[2]))
end
function alias_postepy2_minus_val_func()    
    scripts.licznik_postepow:remove_improvee2_val(tonumber(matches[2]), tonumber(matches[3]))
end
function alias_postepy2_off_func()
    scripts.licznik_postepow["improve2_enabled"] = false
    scripts:print_log("Ok, nie bede dodawal do globalnego licznika postepow")
end
function alias_postepy2_on_func()
    scripts.licznik_postepow["improve2_enabled"] = true
    scripts:print_log("Ok, bede dodawal do globalnego licznika postepow")
end