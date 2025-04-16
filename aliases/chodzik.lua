function alias_opoz_func()
    local speedWalkSpeed = tonumber(matches[2])
    scripts.speedwalk.delay = speedWalkSpeed
    scripts:print_log("Ustawiam opoznienie chodzika na " .. matches[2])    
end
function alias_chodzik_stop_func()
    scripts.speedwalk:abortSpeedWalk()
end