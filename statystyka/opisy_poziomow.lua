require "rex_pcre"
rex_pcre = rex_pcre or package.loaded.rex_pcre

scripts["opisy_poziomow"] = scripts["opisy_poziomow"] or {}

scripts.opisy_poziomow["kondycje"] = {"na skraju smierci", "ledwo zyw(y|a|e)", "zmasakrowan(y|a|e)", "ciezko rann(y|a|e)", "w zlym stanie",
"w zlej kondycji", "rann(y|a|e)", "poranion(y|a|e)", "pokiereszowan(y|a|e)", "lekko rann(y|a|e)", "poturbowan(y|a|e)",
"w dobrym stanie", "w swietnej kondycji", "w pelni zdrow(|a|e)"}

scripts.opisy_poziomow["mana"] = {"u kresu sil", "wykonczon(y|a|e)", "wyczerpan(y|a|e)", "w zlej kondycji", "bardzo zmeczon(y|a|e)",
"zmeczon(y|a|e)", "znuzon(y|a|e)", "oslabion(y|a|e)", "nadwyrezon(y|a|e)", "lekko oslabion(y|a|e)",
"nadwatlon(y|a|e)", "w pelni sil"}

scripts.opisy_poziomow["panika"] = {"smiertelnie przerazon(y|a|e)", "histerycznie przerazon(y|a|e)", "przerazon(y|a|e)", "nerwowo",
"strachliwie", "trwozliwie", "lekliwie", "niespokojnie", "nieswojo", "zaniepokojon(y|a|e)",
"spokojnie", "bezpiecznie", "bardzo bezpiecznie"}


scripts.opisy_poziomow["zmeczenie"] = {"calkowicie wycienczon(y|a|e)", "wycienczon(y|a|e)", "bardzo wyczerpan(y|a|e)",
	"wyczerpan(y|a|e)", "nieco wyczerpan(y|a|e)", "bardzo zmeczon(y|a|e)", "zmeczon(y|a|e)",
	"troche zmeczon(y|a|e)", "wypoczet(y|a|e)", "w pelni wypoczet(y|a|e)"}

scripts.opisy_poziomow["umiejetnosc"] = {"ledwo", "mizernie", "slabo", "powierzchownie", "znosnie", "poprawnie",
   "umiejetnie", "swietnie", "wspaniale", "fenomenalnie"}

scripts.opisy_poziomow["sytosc"] = {"bardzo glodn[ya]", "glodn[ya]", "najedzon[ya]", "bardzo najedzon[ya]"}

scripts.opisy_poziomow["pragnienie"] = {"chce ci sie bardzo pic", "chce ci sie pic", "troche chce ci sie pic", "nie chce ci sie pic"}

scripts.opisy_poziomow["opisy_rany"] = {
		{"powierzchownie nacina", "plytko nacina", "rozcina", "szeroko kroi", "gleboko tnie",
			"paskudnie rozcina", "rozplatuje", "w pol rozcina"},
		{"plytko nakluwa", "bolesnie kluje", "plytko dzga", "gleboko pcha", "dziurawi",
			"nabija", "na wylot przebija"},
		{"muska", "obija", "uderza", "tlucze", "gruchocze", "kruszy", "rozgniata", "miazdzy",
			"doszczetnie rozgniata"},
		{"[Nn]acina", "[Rr]ozcina", "[Tt]nie", "[Ss]iecze", "[Rr]abie", "[Rr]znie"},
		{"ledwo muska", "lekko rani", "rani", "powaznie rani", "bardzo ciezko rani", "potwornie rani", "masakruje"}
	}

scripts.opisy_poziomow["opisy_rany_alter"]	={
	"lekko raniac",
	"raniac bolesnie",
	"ciezko raniac",
	"okrutnie raniac"
}

scripts.opisy_poziomow["opisy_mrany"] = {
    {"drobne iskierki wyladowan trzeszcza w ranie",
    	"niebieskie iskry wyladowan skacza po ranie",
      "spore blekitne iskry przypalaja cialo",
		"niewielkie blyskawice wnikaja w cialo wokol, wstrzasajac nim spazmatycznie",
      "mocne wyladowanie skwierczy i wije sie niebieska blyskawica w ranie",
		"potezne wyladowanie rozswietla rane, rozchodzi sie zapach spalenizny i ozonu"},
    {"cialo lekko sztywnieje wokol rany",
		"drobiny ziemi wnikaja w cialo",
		"cialo wokol rany kamienieje",
      "od rany rozchodzi sie siatka pekniec w kamieniejacym ciele",
		"fragmenty skamienialego ciala wykruszaja sie i wypadaja",
      "cialo przemienia sie w kamien"},
	{"slaby rozblysk ognia nieznacznie przypieka cialo",
		"niewielki wybuch ognia lekko przypala rane",
      "wybuch ognia okrywa rane, mocno ja przypalajac",
		"jezory szkarlatnego ognia liza rane, palac ja znacznie",
		"gwaltowna eksplozja ognia calkowicie zwegla rane"},
	{"cialo wokol pokrywa sie cienka warstwa szronu",
		"niewielkie krysztaly lodu tworza sie w ranie",
      	"zmrozone cialo peka",
      	"zlodowaciale cialo kruszy sie i odpada",
      	"wokol pryskaja zlodowaciale fragmenty wyrwanego ciala"},
	{"blekitna poswiata oswieca rane"},
   {"ciemna platanina mroku otula rane",
		"mroczna chmura cienia wnika w rane",
		"mroczne i splatane wzory mroku i smierci wpijaja sie w rane",
		"klab mrocznej eksplozji wije sie wokol rany rozkladajac cialo i kosci"},
	}

scripts.opisy_poziomow["opisy_dt"] = {
	{"pchniecie", "pchniecia", "pcha"},
	{"ciecie", "ciecia", "tnie"},
	{"uderzenie", "uderzenia", "uderza"},
	}

scripts.opisy_poziomow["opisy_mdt_def"] = {
		"bezsilny podmuch wiatru",
		"chmura drobin piasku, zbyt drobnych by skrzywdzic",
		"krotki strumien ognia i klab dymu",
		"klab zmrozonej pary, ktora jednak szybko rozprasza sie w powietrzu",
		"lekka, niebieska poswiata",
		"czarny klab mrocznej, bezglosnej eksplozji",
	}

scripts.opisy_poziomow["opisy_latwosci"] = {
		"szczesliwie|ledwo|niezdarnie", "z trudem|z wysilkiem", "udanie|wprawnie|prosto",
		"gladko|umiejetnie|z latwoscia", "bez trudu|bez problemu|z latwoscia",
		"dokladnie|perfekcyjnie"
	}

scripts.opisy_poziomow["szermierz_sila_speca"] = {
		"nikla ranke",
		"niewielka rane",
		"zauwazalna rane",
		"spora rane",
		"gleboka rane",
		"paskudna rane",
		"prawie smiertelna rane, tnac miesnie i pryskajac krwia",
		"przedziurawione na wylot cialo, ktore pada na ziemie"
	}
	
scripts.opisy_poziomow["szermierz_sila_speca_zywiolaki"] = {
		"nieznaczny uszczerbek",
		"niewielki uszczerbek",
		"zauwazalny uszczerbek",
		"spory uszczerbek",
		"gleboka dziure",
		"paskudny uszczerbek",
		"prawie smiertelny w skutkach brak",
		"zmasakrowane szczatki"
	}
	
scripts.opisy_poziomow["szeregi"] = {["pierwszym"] = 1, ["drugim"] = 2, ["trzecim"] = 3}

function scripts.opisy_poziomow:jakiPoziomOpisu(tabelka, opis)
	for i, k in ipairs(tabelka) do
		if(type(k) == "table") then
			local idx, ss = scripts.opisy_poziomow:jakiPoziomOpisu(k, opis)
			if(idx ~= nil) then return idx, ss end
		elseif(rex_pcre.new("^" .. k .. "$"):exec(opis)) then
			return i, #tabelka
		end
	end
	return nil;
end

function scripts.opisy_poziomow:jakaPozycjaOpisu(tabelka, opis)
	local mb, me, mk = 0, 0, nil
	for i, k in ipairs(tabelka) do
		if(type(k) == "table") then
			local b, e, k = scripts.opisy_poziomow:jakaPozycjaOpisu(k, opis)
			if(b ~= nil and (me - mb < e - b)) then
				mb, me, mk =  b, e, k
			end
		else
			local b, e = rex_pcre.new(k):exec(opis)
			if(b ~= nil and (me - mb < e - b)) then
				mb, me, mk =  b, e, k
			end
		end
	end
	return mb, me, mk;
end
