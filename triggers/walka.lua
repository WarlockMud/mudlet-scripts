function trigger_zgony_func()
    selectCurrentLine()
    fg("red")
    selectCaptureGroup(4)
    fg("white")
    resetFormat()
end

function trigger_ataki_func()
    selectCurrentLine()
    fg("red")
    selectCaptureGroup(2)
    fg("white")
    resetFormat()    
end

function trigger_uniki_moje_func()
    local czym_kogo = matches[4]
    local czym = ""
    local kogo = ""
    local s = czym_kogo:split(" ")
    for i = 2, #s do
        if(s[i]:sub(-1) ~= s[1]:sub(-1)) then
            czym = table.concat(s, " ", 1, i - 1)
            kogo = table.concat(s, " ", i)
            break
        end
    end    
    selectString(kogo, 1)
    fg("white")
    
    selectString("unikasz", 1)
    fg("PaleGreen")
    
	stats = stats or {}
	stats.defensywne = stats.defensywne or {}
	stats.defensywne.uniki = (stats.defensywne.uniki or 0) + 1

    deselect()
    resetFormat()    
end

function trigger_uniki_moje_ani_func()
    selectCaptureGroup(2)
    fg("white")
    
    selectString("uniknac", 1)
    fg("PaleGreen")
    
	stats = stats or {}
	stats.defensywne = stats.defensywne or {}
	stats.defensywne.uniki = (stats.defensywne.uniki or 0) + 1
	
    deselect()
    resetFormat()    
end

function trigger_uniki_czyjes_func()
    local kto = matches[2]
    local czyjego = matches[4]
    local czym = matches[6]
    
    selectCaptureGroup(2)
    fg("white")
    
    selectString("unika", 1)
    fg("gold")
    
    deselect()
    resetFormat() 
end

function trigger_uniki_ktos_kogos_func()
    local kto = matches[2]
    local czym_czyjego = matches[4]
    
    selectCaptureGroup(2)
    fg("white")
    
    selectString("unika", 1)
    fg("gold")
    
    deselect()
    resetFormat()    
end

function trigger_parowania_moje_func()
    local kogo = matches[2]
    local czym = matches[4]
    local czym_paruje = matches[7]
    
    selectCaptureGroup(2)
    fg("white")
    selectCaptureGroup(6)
    fg("green")
    
	stats = stats or {}
	stats.defensywne = stats.defensywne or {}
	stats.defensywne.parowanie = (stats.defensywne.parowanie or 0) + 1
	
    resetFormat()
end

function trigger_parowania_czyjes_func()
    local czym = matches[3]
    local kogo = matches[4]
    local czym_paruje = matches[7]
    
    selectCaptureGroup(4)
    fg("white")
    selectCaptureGroup(6)
    fg("gold")
    
    resetFormat()    
end

function trigger_tarcza_moja_func()
    local kto = matches[2]
    local czym = matches[4]
    local czym_zastawia = matches[6]
    
    selectCaptureGroup(2)
    fg("white")
    selectCaptureGroup(5)
    fg("green")
    selectCaptureGroup(6)
    fg("white")
	
	stats = stats or {}
	stats.defensywne = stats.defensywne or {}
	stats.defensywne.tarcza = (stats.defensywne.tarcza or 0) + 1
	
    resetFormat()    
end

function trigger_tarcza_czyjas_func()
    local kto = matches[2]
    local kogo = matches[5]
    local czym = matches[4]
    local czym_zastawia = matches[7]
    
    selectCaptureGroup(2)
    fg("white")
    selectCaptureGroup(6)
    fg("gold")
    selectCaptureGroup(7)
    fg("white")
    
    resetFormat()    
end

function trigger_tarcza_ja_kogos_func()
    local kogo = matches[4]
    local czym = matches[5]
    local czym_zastawia = matches[6]

    selectCaptureGroup(4)
    fg("white")
    selectCaptureGroup(5)
    fg("gold")
    selectCaptureGroup(6)
    fg("white")
    resetFormat()
end

function trigger_zbroja_moja_func()
    local kto = matches[2]
    local czym = matches[4]
    local zbroja = matches[11]
    
	if matches[6] == "nie wyrzadzajac ci zadnej krzywdy"
	then
		selectCaptureGroup(2)
		fg("white")
		selectCaptureGroup(6)
		fg("steel_blue")
	else	
		selectCaptureGroup(2)
		fg("white")
		selectCaptureGroup(8)
		fg("powder_blue")
		selectCaptureGroup(10)
		fg("steel_blue")
		selectCaptureGroup(11)
		fg("white")
	end
    
	stats = stats or {}
	stats.defensywne = stats.defensywne or {}
	stats.defensywne.zbroja = (stats.defensywne.zbroja or 0) + 1
	
    resetFormat()    
end

function trigger_zbroja_czyjas_func()
    
end

function trigger_zbroja_czyjas_ani_func()

end

function trigger_zbroja_moja_ani_func()
    local kto = matches[2]
    local czym = matches[3]
    local zbroja = matches[6]
    
    selectCaptureGroup(2)
    fg("white")
    selectCaptureGroup(3)
    fg("powder_blue")
    selectCaptureGroup(5)
    fg("steel_blue")
    selectCaptureGroup(6)
    fg("white")
	
	stats = stats or {}
	stats.defensywne = stats.defensywne or {}
	stats.defensywne.zbroja = (stats.defensywne.zbroja or 0) + 1
    
    resetFormat()    
end

function trigger_pudlo_func()

	if matches[3] == "ciebie" then
		selectCaptureGroup(2)
		fg("white")
		selectString("nie udaje sie trafic", 1)
		fg("PaleGreen")
		
		stats = stats or {}
		stats.defensywne = stats.defensywne or {}
		stats.defensywne.miss = (stats.defensywne.miss or 0) + 1
	else
		selectCaptureGroup(2)
		fg("white")
		selectString("nie udaje sie trafic", 1)
		fg("gold")
	end

    resetFormat()
end

function trigger_ciosy_hum_func()    
    local kto = #matches[2]
    local rana_kogo_czym = matches[4]
    local gdzie = matches[6]
    local kogo, czym

    local b, e, rana = scripts.opisy_poziomow:jakaPozycjaOpisu(scripts.opisy_poziomow.opisy_rany, rana_kogo_czym)
    if(rana_kogo_czym:sub(e + 1, e + 4) == "cie") then
        kogo = "cie"
        czym = kogo_czym:sub(e + 6)
    else
        local kogo_czym = rana_kogo_czym:sub(e + 1)
        czym = ""
        local s = kogo_czym:split(" ")
        for i = 2, #s do
            if(s[i]:sub(-1) ~= s[1]:sub(-1)) then
                kogo = table.concat(s, " ", 1, i)
                czym = table.concat(s, " ", i + 1, #s)
                break
            end
        end
    end
    selectString(kogo, 1)
    if(kogo == "cie") then
        bg("red")
    else
        fg("white")
    end

    ipoz, max = scripts.opisy_poziomow:jakiPoziomOpisu(scripts.opisy_poziomow.opisy_rany, rana)
    if(ipoz) then
        selectString(rana, 1)
        setFgColor(255, 255 - (ipoz * 255 / max), 200 - (ipoz * 200 / max));
    end
	
    if(kogo == " cie") then
		stats = stats or {}
		stats.defensywne = stats.defensywne or {}
		stats.defensywne.hit = (stats.defensywne.hit or 0) + 1
		stats.defensywne.rany = stats.defensywne.rany or {}
		stats.defensywne.rany[rana] = (stats.defensywne.rany[rana] or 0) + 1
	end

    deselect()
    resetFormat()    
end

function trigger_ciosy_moje_func()
    local kto = "Ja"
    local rana = matches[4]
    local kogo_czym = matches[5]
    local gdzie = matches[6]
    local kogo, czym

    local s = kogo_czym:split(" ")
    for i = 1, #s do
        if(s[i]:sub(-1) ~= s[1]:sub(-1) or s[i+1] == 'prawa' or s[i+1] == 'lewa') then
            kogo = table.concat(s, " ", 1, i)
            czym = table.concat(s, " ", i + 1, #s)
            break
        end
    end
    
    selectString(kogo, 1)
    fg("white")

    ipoz, max = scripts.opisy_poziomow:jakiPoziomOpisu(scripts.opisy_poziomow.opisy_rany, rana)
    if(ipoz) then
        selectCaptureGroup(3)
        setFgColor(230 - (ipoz * 230 / max), 230 - (ipoz * 200 / max), 255);
    end
	
	prefix("<slate_grey>[CIOS "..ipoz.."/"..max.."] ", cecho)

    deselect()
    resetFormat()    
end

function trigger_ciosy_ani_func()

	selectCaptureGroup(2)
	fg("white")
	
    local rana = matches[3]
    ipoz, max = scripts.opisy_poziomow:jakiPoziomOpisu(scripts.opisy_poziomow.opisy_rany, rana)
    if(ipoz) then
        selectString(rana, 1)
        setFgColor(255, 255 - (ipoz * 255 / max), 200 - (ipoz * 200 / max));
    end

    if(matches[4] == "cie") then
		stats = stats or {}
		stats.defensywne = stats.defensywne or {}
		stats.defensywne.hit = (stats.defensywne.hit or 0) + 1
		stats.defensywne.rany = stats.defensywne.rany or {}
		stats.defensywne.rany[rana] = (stats.defensywne.rany[rana] or 0) + 1
	end

    deselect()
    resetFormat()    
end
function trigger_opis_walki_func()
    selectString(matches[1], 1)
    fg("red")
    resetFormat()    
end
