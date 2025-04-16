function trigger_moje_cudze_hp_func()    
    kto = #matches[3] > 0 and matches[3] or matches[4]
    poziom = matches[6]
    ipoz, max = scripts.opisy_poziomow:jakiPoziomOpisu(scripts.opisy_poziomow.kondycje, poziom)
    if(ipoz) then
        selectCaptureGroup(6)
        setFgColor(255 - (ipoz * 255 / max), ipoz * 255 / max, 60);
    end

    resetFormat();
end
function trigger_moja_mana_func()    
    poziom = matches[3]
    ipoz, max = scripts.opisy_poziomow:jakiPoziomOpisu(scripts.opisy_poziomow.mana, poziom)
    if(ipoz) then
        selectCaptureGroup(3)
        setFgColor(255 - (ipoz * (255 / max)), ipoz * (255 / max), 60);
    end
    resetFormat();
end
function trigger_panika_func()
    poziom = matches[2]
    ipoz, max = scripts.opisy_poziomow:jakiPoziomOpisu(scripts.opisy_poziomow.panika, poziom)
    if(ipoz) then
        selectCaptureGroup(2)
        setFgColor(255 - (ipoz * (255 / max)), ipoz * (255 / max), 60);
    end

    resetFormat();    
end
function trigger_picie_jedzenie_func()
    poziom_picie = matches[2]:lower()
    poziom_jedzenie = matches[3]

    ipoz, max = scripts.opisy_poziomow:jakiPoziomOpisu(scripts.opisy_poziomow.pragnienie, poziom_picie)
    if(ipoz) then
        selectCaptureGroup(2)
        setFgColor(255 - (ipoz * 255 / max), ipoz * 255 / max, 60);
    end
    resetFormat();
    ipoz, max = scripts.opisy_poziomow:jakiPoziomOpisu(scripts.opisy_poziomow.sytosc, poziom_jedzenie)
    if(ipoz) then
        selectCaptureGroup(3)
        setFgColor(255 - (ipoz * 255 / max), ipoz * 255 / max, 60);
    end
    resetFormat();    
end
function trigger_zmeczenie_func()
    poziom = matches[2]
    ipoz, max = scripts.opisy_poziomow:jakiPoziomOpisu(scripts.opisy_poziomow.zmeczenie, poziom)
    if(ipoz) then
        selectCaptureGroup(2)
        setFgColor(255 - (ipoz * 255 / max), ipoz * 255 / max, 60)
    end
    resetFormat()
end