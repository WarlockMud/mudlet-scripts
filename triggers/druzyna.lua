function trigger_druzyna_zaprasza_func()
    selectCurrentLine()
    fg("white")
    selectCaptureGroup(2)
    fg("light_blue")
    selectCaptureGroup(3)
    fg("light_blue")
    
    resetFormat()    
end

function trigger_druzyna_dolacza_func()
    local kto = matches[2]
    local do_kogo = matches[3]

    selectCurrentLine()
    fg("white")

    selectCaptureGroup(2)
    fg("light_blue")

    selectCaptureGroup(3)
    fg("light_blue")

    resetFormat()
end

function trigger_druzyna_ja_dolaczam_func()
    local kto = "Ja"
    local do_kogo = matches[2]
    
    selectCurrentLine()
    fg("white")
    
    selectCaptureGroup(2)
    fg("light_blue")
    
    resetFormat()
end

function trigger_druzyna_porzucanie_func()
    
end

function trigger_druzyna_brak_druzyny_func()
    scripts.druzyna:removeTeam()
end

function trigger_opis_szereg_wspolne_i_dalsze_func()
    
    local ile = #matches / 6

    for i = 0, ile - 1 do
        local szereg = scripts.opisy_poziomow.szeregi[matches[3 + 6 * i]]
        local czy_ja = #matches[4 + 6 * i] > 0
        local kto = matches[6 + 6 * i]:gsub(", ", "|"):gsub(" i ", "|"):split("|")
        if(czy_ja) then table.insert(kto, "Ja") end

        selectCaptureGroup(3 + 6 * i)
        fg("white")
        selectCaptureGroup(6 + 6 * i)
        fg("light_blue")
        resetFormat()        
    end    
end

function trigger_opis_szereg_samotnie_func()
    local szereg = scripts.opisy_poziomow.szeregi[matches[3]]
    local kto = {"Ja"}
    
    selectCaptureGroup(2)
    fg("light_blue")
    selectCaptureGroup(3)
    fg("white")
    
    resetFormat()            
end

function trigger_druzyna_czlonek_func()    
    local prowadzacy = matches[2]
    local kto = matches[6]
    local szereg = scripts.opisy_poziomow.szeregi[matches[7]]

    selectCaptureGroup(2)
    fg("white")
    selectCaptureGroup(7)
    fg("white")
    selectCaptureGroup(6)
    fg("light_blue")

    resetFormat()    
end

function trigger_druzyna_moj_szereg_func()
    --display(matches)

    local szereg = scripts.opisy_poziomow.szeregi[matches[7]]
    local sam_stoje = #matches[6] > 0
    local kto = sam_stoje and matches[6] or matches[4]

    --echo("\nSzereg: " .. szereg .. ": " .. table.concat(kto, ", ") .. "\n")    
end

function trigger_druzyna_szereg_nie_moj_func()
    local szereg = scripts.opisy_poziomow.szeregi[matches[2]]
    local kto = matches[4]
    
    local kto = kto:gsub(", ", "|"):gsub(" i ", "|"):split("|")
    
    --echo("\nSzereg: " .. szereg .. ": " .. table.concat(kto, ", ") .. "\n")    
end

function trigger_druzyna_przejscia_func()
    selectCurrentLine()
    fg("white")
    
    selectCaptureGroup(2)
    fg("light_blue")
    
    selectCaptureGroup(3)
    fg("light_blue")
    
    selectCaptureGroup(4)
    fg("light_blue")    
end

function trigger_druzyna_rozwiazuje_func()

end

function trigger_druzyna_przedstawia_func()
    
end