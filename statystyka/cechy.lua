scripts["licznik_cech"] = scripts["licznik_cech"] or {}

cecha_to_stat = {
  [1] = 50, [2] = 70, [3] = 89, [4] = 107, [5] = 124, [6] = 140, [7] = 155, [8] = 169, [9] = 182, [10] = 194,
  [11] = 205, [12] = 215, [13] = 224, [14] = 232, [15] = 239, [16] = 245, [17] = 250, [18] = 255, [19] = 260, [20] = 265,
  [21] = 270, [22] = 275, [23] = 280, [24] = 285, [25] = 290, [26] = 295, [27] = 300, [28] = 305, [29] = 310, [30] = 315,
  [31] = 320, [32] = 325, [33] = 330, [34] = 335, [35] = 340, [36] = 345, [37] = 350, [38] = 355, [39] = 360, [40] = 365,
  [41] = 370, [42] = 375, [43] = 380, [44] = 385, [45] = 390, [46] = 395, [47] = 400, [48] = 405, [49] = 410, [50] = 415,
  [51] = 420, [52] = 425
}
    
-- CECHY SILA
scripts.licznik_cech.silaall = {}
scripts.licznik_cech.silaall["slabiutk"] = 1;
scripts.licznik_cech.silaall["slabowit"] = 2;
scripts.licznik_cech.silaall["watl"] = 3;
scripts.licznik_cech.silaall["cherlaw"] = 4;
scripts.licznik_cech.silaall["slab"] = 5;
scripts.licznik_cech.silaall["krzepk"] = 6;
scripts.licznik_cech.silaall["siln"] = 7;
scripts.licznik_cech.silaall["mocn"] = 8;
scripts.licznik_cech.silaall["teg"] = 9;
scripts.licznik_cech.silaall["potezn"] = 10;
scripts.licznik_cech.silaall["mocarn"] = 11;
scripts.licznik_cech.silaall["tytaniczn"] = 12;
scripts.licznik_cech.silaall["wszechmocn"] = 13;


-- CECHY ZRECZNOSC
scripts.licznik_cech.zrecznoscall ={}
scripts.licznik_cech.zrecznoscall["nieskoordynowan"] = 1;
scripts.licznik_cech.zrecznoscall["niezdarn"] = 2;
scripts.licznik_cech.zrecznoscall["niezreczn"] = 3;
scripts.licznik_cech.zrecznoscall["niezgrabn"] = 4;
scripts.licznik_cech.zrecznoscall["niewprawn"] = 5;
scripts.licznik_cech.zrecznoscall["sprawn"] = 6;
scripts.licznik_cech.zrecznoscall["zreczn"] = 7;
scripts.licznik_cech.zrecznoscall["szybk"] = 8;
scripts.licznik_cech.zrecznoscall["wprawn"] = 9;
scripts.licznik_cech.zrecznoscall["zwinn"] = 10;
scripts.licznik_cech.zrecznoscall["gibk"] = 11;
scripts.licznik_cech.zrecznoscall["akrobatyczn"] = 12;
scripts.licznik_cech.zrecznoscall["ekwilibrystyczn"] = 13;

-- CECHY WYTRZYMALOSC
scripts.licznik_cech.wytkaall ={}
scripts.licznik_cech.wytkaall["delikatn"] = 1;
scripts.licznik_cech.wytkaall["chorowit"] = 2;
scripts.licznik_cech.wytkaall["rachityczn"] = 3;
scripts.licznik_cech.wytkaall["mizern"] = 4;
scripts.licznik_cech.wytkaall["kruch"] = 5;
scripts.licznik_cech.wytkaall["dobrze zbudowan"] = 6;
scripts.licznik_cech.wytkaall["wytrzymal"] = 7;
scripts.licznik_cech.wytkaall["odporn"] = 8;
scripts.licznik_cech.wytkaall["masywn"] = 9;
scripts.licznik_cech.wytkaall["tward"] = 10;
scripts.licznik_cech.wytkaall["umiesnion"] = 11;
scripts.licznik_cech.wytkaall["muskularn"] = 12;
scripts.licznik_cech.wytkaall["atletyczn"] = 13;

-- CECHY INTELIGENCJA
scripts.licznik_cech.intall = {}
scripts.licznik_cech.intall["bezmysln"] = 1;
scripts.licznik_cech.intall["ciemn"] = 2;
scripts.licznik_cech.intall["tep"] = 3;
scripts.licznik_cech.intall["nierozumn"] = 4;
scripts.licznik_cech.intall["ograniczon"] = 5;
scripts.licznik_cech.intall["rozgarniet"] = 6;
scripts.licznik_cech.intall["pojetn"] = 7;
scripts.licznik_cech.intall["zmysln"] = 8;
scripts.licznik_cech.intall["inteligentn"] = 9;
scripts.licznik_cech.intall["lotn"] = 10;
scripts.licznik_cech.intall["bystr"] = 11;
scripts.licznik_cech.intall["blyskotliw"] = 12;
scripts.licznik_cech.intall["genialn"] = 13;

-- CECHY MADROSC
scripts.licznik_cech.madroscall = {}
scripts.licznik_cech.madroscall["glup"] = 1;
scripts.licznik_cech.madroscall["glupi"] = 1;
scripts.licznik_cech.madroscall["durn"] = 2;
scripts.licznik_cech.madroscall["zacofan"] = 3;
scripts.licznik_cech.madroscall["niemadr"] = 4;
scripts.licznik_cech.madroscall["niewyksztalcon"] = 5;
scripts.licznik_cech.madroscall["roztropn"] = 6;
scripts.licznik_cech.madroscall["wyksztalcon"] = 7;
scripts.licznik_cech.madroscall["rozsadn"] = 8;
scripts.licznik_cech.madroscall["logiczn"] = 9;
scripts.licznik_cech.madroscall["madr"] = 10;
scripts.licznik_cech.madroscall["uczon"] = 11;
scripts.licznik_cech.madroscall["oswiecon"] = 12;
scripts.licznik_cech.madroscall["wszechwiedzac"] = 13;

-- CECHY ODWAGA
scripts.licznik_cech.odwagaall={}
scripts.licznik_cech.odwagaall["tchorzliw"] =1;
scripts.licznik_cech.odwagaall["strachliw"] =2;
scripts.licznik_cech.odwagaall["bojazliw"] =3;
scripts.licznik_cech.odwagaall["lekliw"] =4;
scripts.licznik_cech.odwagaall["niepewn"] =5;
scripts.licznik_cech.odwagaall["zdecydowan"] =6;
scripts.licznik_cech.odwagaall["niezachwian"] =7;
scripts.licznik_cech.odwagaall["odwazn"] =8;
scripts.licznik_cech.odwagaall["dzieln"] = 9;
scripts.licznik_cech.odwagaall["nieugiet"] = 10;
scripts.licznik_cech.odwagaall["mezn"] = 11;
scripts.licznik_cech.odwagaall["bohatersk"] = 12;
scripts.licznik_cech.odwagaall["heroiczn"] = 13;

local s = "<red>[cos poszlo nie tak]<reset>"
local z = "<red>[cos poszlo nie tak]<reset>"
local w = "<red>[cos poszlo nie tak]<reset>"
local i = "<red>[cos poszlo nie tak]<reset>"
local m = "<red>[cos poszlo nie tak]<reset>"
local o = "<red>[cos poszlo nie tak]<reset>"

function trigger_licznik_cech_cechy_func()
  local cecha = matches[2]
  local koncowka = matches[3]
  local dopisek = ""
  local bonusy = ""
  local tymczasowa_cecha = 0
  local wyrownanie_cech = ""

  if matches[4] then
    dopisek = trim_string(matches[4])
  end
  if matches[5] then
    bonusy = matches[5]
  end

  selectCurrentLine()
  replace("")

  if dopisek == "jak na legende" then 
    tymczasowa_cecha = 13
  elseif dopisek == "jak na polboga" or dopisek == "jak na polboginie" then
    tymczasowa_cecha = 26
  elseif dopisek == "jak na boga" or dopisek == "jak na boginie" then
    tymczasowa_cecha = 39
  else
    tymczasowa_cecha = 0
  end

  if scripts.licznik_cech.silaall[cecha] then
    s = tymczasowa_cecha + scripts.licznik_cech.silaall[cecha]
    if s < 10 then
      wyrownanie_cech = " "
    else
      wyrownanie_cech = ""
    end
    scripts.licznik_cech:wyswietl_ceche(s,wyrownanie_cech)

  elseif scripts.licznik_cech.zrecznoscall[cecha] then
    z = tymczasowa_cecha + scripts.licznik_cech.zrecznoscall[cecha]
    if z < 10 then
      wyrownanie_cech = " "
    else
      wyrownanie_cech = ""
    end
    scripts.licznik_cech:wyswietl_ceche(z,wyrownanie_cech)
   
  elseif scripts.licznik_cech.wytkaall[cecha] then
    w = tymczasowa_cecha + scripts.licznik_cech.wytkaall[cecha]
    if w < 10 then
      wyrownanie_cech = " "
    else
      wyrownanie_cech = ""
    end
    scripts.licznik_cech:wyswietl_ceche(w,wyrownanie_cech)
   
  elseif scripts.licznik_cech.intall[cecha] then
    i = tymczasowa_cecha + scripts.licznik_cech.intall[cecha]
    if i < 10 then
      wyrownanie_cech = " "
    else
      wyrownanie_cech = ""
    end
    scripts.licznik_cech:wyswietl_ceche(i, wyrownanie_cech)
   
  elseif scripts.licznik_cech.madroscall[cecha] then
    m = tymczasowa_cecha + scripts.licznik_cech.madroscall[cecha]
    if m < 10 then
      wyrownanie_cech = " "
    else
      wyrownanie_cech = ""
    end
    scripts.licznik_cech:wyswietl_ceche(m, wyrownanie_cech)
   
  elseif scripts.licznik_cech.odwagaall[cecha] then
    o = tymczasowa_cecha + scripts.licznik_cech.odwagaall[cecha]
    if o < 10 then
      wyrownanie_cech = " "
    else
      wyrownanie_cech = ""
    end
    scripts.licznik_cech:wyswietl_ceche(o, wyrownanie_cech)
  end

  scripts.licznik_cech:cechy_policz_lvl(s,z,w,i,m,o)
end

function scripts.licznik_cech:cechy_policz_lvl(sila,zrecznosc,wytrzymalosc,inteligencja,madrosc,odwaga)

  local level = sila+zrecznosc+wytrzymalosc+inteligencja+madrosc+odwaga
  local bojowe = sila+zrecznosc+wytrzymalosc
  local mentalne = inteligencja+madrosc
  local procentbojowych = roundToDecimal(bojowe/level*100,1)
  local procentmentalnych = roundToDecimal(mentalne/level*100,1)
  local avg_stats = roundToDecimal((cecha_to_stat[sila]+cecha_to_stat[zrecznosc]+cecha_to_stat[wytrzymalosc]+cecha_to_stat[inteligencja]+cecha_to_stat[madrosc]+cecha_to_stat[odwaga])/6,1)
  cecho("\n<goldenrod>Masz "..level.."/312 cech. Srednia stats: "..avg_stats..". Bojowe: "..bojowe.." ("..procentbojowych.."%). Mentalne: "..mentalne.." ("..procentmentalnych.."%).")
  scripts.licznik_cech:resetuj_cechy()
end

function scripts.licznik_cech:wyswietl_ceche(cecha, wyrownanie)
	local stat = cecha_to_stat[cecha]
  cecho("<gold>["..cecha.."]"..wyrownanie.."<lemon_chiffon> Jestes "..matches[2]..matches[3].."<light_grey>"..matches[4]..matches[5]..". [<gold>"..stat.."<grey>]")
end

function scripts.licznik_cech:resetuj_cechy()
  s = "<red>[cos poszlo nie tak]<reset>"
  z = "<red>[cos poszlo nie tak]<reset>"
  w = "<red>[cos poszlo nie tak]<reset>"
  i = "<red>[cos poszlo nie tak]<reset>"
  m = "<red>[cos poszlo nie tak]<reset>"
  o = "<red>[cos poszlo nie tak]<reset>"
end