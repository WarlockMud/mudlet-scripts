scripts["runes"] = scripts["runes"] or {
    zdobyte_runy = {},
    zdobyte_runy_czas = {}
}

scripts.runes["runy"] = {
    [1] = {
        nazwa = "el",
        ilosc = 0
    },
    [2] = {
        nazwa = "eld",
        ilosc = 0
    },
    [3] = {
        nazwa = "tir",
        ilosc = 0
    },
    [4] = {
        nazwa = "nef",
        ilosc = 0
    },
    [5] = {
        nazwa = "eth",
        ilosc = 0
    },
    [6] = {
        nazwa = "ith",
        ilosc = 0
    },
    [7] = {
        nazwa = "tal",
        ilosc = 0
    },
    [8] = {
        nazwa = "ral",
        ilosc = 0
    },
    [9] = {
        nazwa = "ort",
        ilosc = 0
    },
    [10] = {
        nazwa = "thul",
        ilosc = 0
    },
    [11] = {
        nazwa = "amn",
        ilosc = 0
    },
    [12] = {
        nazwa = "sol",
        ilosc = 0
    },
    [13] = {
        nazwa = "shael",
        ilosc = 0
    },
    [14] = {
        nazwa = "dol",
        ilosc = 0
    },
    [15] = {
        nazwa = "hel",
        ilosc = 0
    },
    [16] = {
        nazwa = "io",
        ilosc = 0
    },
    [17] = {
        nazwa = "lum",
        ilosc = 0
    },
    [18] = {
        nazwa = "ko",
        ilosc = 0
    },
    [19] = {
        nazwa = "fal",
        ilosc = 0
    },
    [20] = {
        nazwa = "lem",
        ilosc = 0
    }
}

scripts.runes["runy_index"] = {
    ["el"] = 1,
    ["eld"] = 2,
    ["tir"] = 3,
    ["nef"] = 4,
    ["eth"] = 5,
    ["ith"] = 6,
    ["tal"] = 7,
    ["ral"] = 8,
    ["ort"] = 9,
    ["thul"] = 10,
    ["amn"] = 11,
    ["sol"] = 12,
    ["shael"] = 13,
    ["dol"] = 14,
    ["hel"] = 15,
    ["io"] = 16,
    ["lum"] = 17,
    ["ko"] = 18,
    ["fal"] = 19,
    ["lem"] = 20
}

scripts.runes["runy_liczone"] = {
    [1] = {
        nazwa = "el",
        ilosc = 0
    },
    [2] = {
        nazwa = "eld",
        ilosc = 0
    },
    [3] = {
        nazwa = "tir",
        ilosc = 0
    },
    [4] = {
        nazwa = "nef",
        ilosc = 0
    },
    [5] = {
        nazwa = "eth",
        ilosc = 0
    },
    [6] = {
        nazwa = "ith",
        ilosc = 0
    },
    [7] = {
        nazwa = "tal",
        ilosc = 0
    },
    [8] = {
        nazwa = "ral",
        ilosc = 0
    },
    [9] = {
        nazwa = "ort",
        ilosc = 0
    },
    [10] = {
        nazwa = "thul",
        ilosc = 0
    },
    [11] = {
        nazwa = "amn",
        ilosc = 0
    },
    [12] = {
        nazwa = "sol",
        ilosc = 0
    },
    [13] = {
        nazwa = "shael",
        ilosc = 0
    },
    [14] = {
        nazwa = "dol",
        ilosc = 0
    },
    [15] = {
        nazwa = "hel",
        ilosc = 0
    },
    [16] = {
        nazwa = "io",
        ilosc = 0
    },
    [17] = {
        nazwa = "lum",
        ilosc = 0
    },
    [18] = {
        nazwa = "ko",
        ilosc = 0
    },
    [19] = {
        nazwa = "fal",
        ilosc = 0
    },
    [20] = {
        nazwa = "lem",
        ilosc = 0
    }
}

function scripts.runes:dodaj_rune(runa)
    if scripts.runes.zdobyte_runy[runa] ~= nil then
        scripts.runes.zdobyte_runy[runa] = scripts.runes.zdobyte_runy[runa] + 1
    else
        scripts.runes.zdobyte_runy[runa] = 1
    end
    cecho("\n<green>--------------> RUNA:" .. runa .."<reset>\n")
  end

  function scripts.runes:pokaz_runy()
    cecho("<pink>Zdobyte runy:<reset>\n")
    for k,v in pairs(scripts.runes.zdobyte_runy) do
      cecho("<green>" .. k .. " -<red> " .. v.."<reset>\n")
    end
  end

  function scripts.runes:reset()
    scripts.runes.zdobyte_runy = {}
    scripts.runes.zdobyte_runy_czas = {}
    cecho("<pink>Statystyki do run zresetowano.<reset>\n")
  end

function scripts.runes:display_count()
  cecho("\n<CadetBlue>RUNY ktore posiadasz:<reset>\n")
  for k,v in pairs(scripts.runes["runy"]) do
    if v.ilosc > 0 then
      cecho("<yellow>"..v.nazwa .. ": - " .. v.ilosc.."<reset>\n")
    end
  end
  cecho("\n<CadetBlue>Oto co mozesz z nich zrobic:<reset>\n")
  for i=1,18 do     
      scripts.runes["runy_liczone"][i].ilosc  =  scripts.runes["runy"][i].ilosc
      if i ~= 1 then
        extra = math.floor(scripts.runes["runy_liczone"][i-1].ilosc / 2)
        scripts.runes["runy_liczone"][i].ilosc = scripts.runes["runy_liczone"][i].ilosc + extra
      end
      wartosc = scripts.runes["runy_liczone"][i]
      cecho("<yellow>"..wartosc.nazwa .. ": - " .. wartosc.ilosc.."<reset>\n")          
  end
end

--triggery
function trigger_runy_ilosc_func()
    local nazwa_runy = multimatches[1][3]
    local ilosc_runy = tonumber(multimatches[2][3])
    local index = scripts.runes["runy_index"][nazwa_runy]
    scripts.runes["runy"][index].ilosc = ilosc_runy
    scripts.runes["runy_liczone"][index].ilosc = ilosc_runy
end
function trigger_zdobyto_rune_func()
    local runa = matches[2]
    scripts.runes:dodaj_rune(runa)
    table.insert(scripts.runes.zdobyte_runy_czas,{ nazwa = runa, data = getTime(true) })
end
function trigger_zdobyto_runy_func()
    local runa = matches[2]
    local runa2 = matches[3]
    scripts.runes:dodaj_rune(runa)
    scripts.runes:dodaj_rune(runa2)
    table.insert(scripts.runes.zdobyte_runy_czas,{ nazwa = runa, data = getTime(true) })
    table.insert(scripts.runes.zdobyte_runy_czas,{ nazwa = runa2, data = getTime(true) })    
end
--aliasy
function alias_runy_func()
    for k,v in pairs(scripts.runes.runy) do
        v.ilosc = 0  
      end
      for k,v in pairs(scripts.runes.runy_liczone) do
        v.ilosc = 0  
      end
      send("ocen runy")
      tempTimer(2,function() scripts.runes:display_count() end)    
end

function alias_pokaz_runy_func()
    scripts.runes:pokaz_runy()
end

function alias_resetuj_runy_func()
    scripts.runes:reset()
end