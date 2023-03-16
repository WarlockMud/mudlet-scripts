scripts["spece"] = scripts["spece"] or {}

function scripts.spece:set_color_and_prefix_of_attacker(prefiks)
    if isYou then
        setFgColor(230 - (ipoz * 255 / max), 230 - (ipoz * 200 / max), 255);
        prefix("<deep_sky_blue>["..prefiks.."] ", cecho)

    else
        setFgColor(255, 255 - (ipoz * 255 / max), 200 - (ipoz * 200 / max))
        prefix("<orange>["..prefiks.."] ", cecho)
    end
end

function trigger_spec_autor_func(autor)
    isYou = false;
    if autor == "" then
        isYou = false
    else
        isYou = true
    end
end

function trigger_bractwo_spec_obrazenia_func()
    local bs_sily = {"delikatnym", "lekkim", "niezbyt silnym", "silnym", "mocnym", "poteznym", "niewiarygodnie poteznym"}
    local bs_rany = {"nikly slad|nieznaczny odprysk kostny|nieznaczny uszczerbek|nikla ranke",
                "niewielk(i|a) (slad|odprysk kostny|uszczerbek|rane)",
                "zauwazaln(y|a) (slad|odprysk kosci|uszczerbek|rane)",
                "spor(y|e|a) (slad|pekniecie|uszczerbek|rane)",
                "paskudn(y|e|a) (slad|polamane kosci|uszczerbek|rane)",
                "glebok(i|a) (slad|dziure|rane)|mocno i gleboko polamane kosci",
                "bruzde przedzielajaca niemalze na pol|gruchoczac i lamiac kosci|prawie smiertelny w skutkach brak|prawie smiertelna rane, tnac (wysuszone miesnie|miesnie i pryskajac krwia)",
                "bruzde na wylot|bezksztaltna mase polamanych kosci|zmasakrowane szczatki|straszliwie zmasakrowane cialo, ktore pada na ziemie( w kaluzy wlasnej krwi|)"
    }

    local ipoz, max, opis, sila, rana

    for a = 0,#matches-1,5 do
        -- kolor i styl dla calej linii
        selectCaptureGroup(a + 1)
        fg("PaleTurquoise")--; setBold(true)
        -- dalej osobne kolorki dla sily ciosu i poziomu zadanej rany
        sila = matches[a + 3]
        rana = matches[a + 5]
        selectCaptureGroup(a + 3)
        ipoz, max = scripts.opisy_poziomow:jakiPoziomOpisu(bs_sily, sila:lower())
        setFgColor(255, 255 - (ipoz * 255 / max), 200 - (ipoz * 200 / max));
        --replace(matches[a + 3] .. "(" .. ipoz .. ")")
        selectCaptureGroup(a + 5)
        ipoz, max = scripts.opisy_poziomow:jakiPoziomOpisu(bs_rany, rana:lower())
        setFgColor(255, 255 - (ipoz * 255 / max), 200 - (ipoz * 200 / max));
        --replace(matches[a + 5] .. "(" .. ipoz .. ")")
    end

    deselect()
    resetFormat()
end



function trigger_szermierze_spec_obrazenia_func(cios)
    selectCaptureGroup(2)
    
    if cios == "mija" or cios=="uchyla sie" then
        fg'plum'
    else
        ipoz, max = scripts.opisy_poziomow:jakiPoziomOpisu(scripts.opisy_poziomow.szermierz_sila_speca, cios:lower())
    end

    scripts.spece:set_color_and_prefix_of_attacker("SZ")
end

function trigger_szermierze_spec_rozbrojenie_func()
    local efekt = matches[2]
    selectCaptureGroup(2)

    if efekt == "z okrzykiem bolu opuszcza" and isYou then
        fg'deep_sky_blue'
    elseif efekt == "z okrzykiem bolu opuszcza" and not isYou then
        fg'orange_red'
    else
        fg'plum'
    end
    
    scripts.spece:set_color_and_prefix_of_attacker("SZ")
end

function trigger_szermierze_spec_unik_func()
    local efekt = matches[2]
    scripts.spece:set_color_and_prefix_of_attacker("SZ")

    selectCaptureGroup(2)

    if efekt == "zmuszajac do odsloniecia sie" and isYou then
        fg'deep_sky_blue'
    elseif efekt == "zmuszajac do odsloniecia sie" and not isYou then
        fg'orange_red'
    else
        fg'plum'
    end
end