scripts["help"] = scripts["help"] or {}

function scripts.help:makeHelpLink(tekst, description)
    selectString(tekst, 1);
    fg("white");
    setUnderline(true);
    setLink([[send("?]] .. tekst .. [[")]], description);
    resetFormat();
    deselect()
end

function scripts.help:makeHelpLinksFromSeeAlso(linia)
    local tematy = linia:gsub(" ", ""):gsub("\t", ""):split(",")
    for i, v in pairs(tematy) do
        scripts.help:makeHelpLink(v, v);
    end
end

function scripts.help.handleHelpCommands(eventName, cmd)
    if (cmd:sub(1, 1) == "?") then
        -- zadanie pomocy!
        local temat = cmd:sub(2)
        local trigs = {}
        if (temat == "ogolne") then
            table.insert(trigs, tempRegexTrigger("([a-z]+)[ ]+-[ ]+([a-zA-Z]+.*)", [[
       makeHelpLink(matches[2], matches[3]);
      ]]));
        end
        table.insert(trigs, tempRegexTrigger("(ZOBACZ TEZ|PATRZ TEZ|ZOBACZ TAKZE)", [[
      tempLineTrigger(1, 1, "scripts.help:makeHelpLinksFromSeeAlso(line)");
     ]]));
        local s = ""
        for i, v in pairs(trigs) do
            s = s .. "killTrigger(" .. v .. ");\n"
        end
        s = s .. [[ killTrigger(trigKoniecPomocy); ]]
        trigKoniecPomocy = tempRegexTrigger("^(EOF|Nie ma pomocy na ten temat.)", s);
    end
end

function scripts.help:displayHelp()
    echo("    Aliasy:\n")
    cecho("<light_slate_blue>/version<grey> - informacja o wersji skryptow (" .. scripts.ver .. ")\n")
    cecho("<light_slate_blue>/paste <komenda><grey> - wklejanie tekstu uzywajac komendy\n")
    cecho("<light_slate_blue>/eval <skrypt><grey> - wykonanie skryptu LUA z linii komend\n")
    cecho("<light_slate_blue>/zabici<grey> - pokazanie statystyk zabitych wrogow\n")
    cecho("<light_slate_blue>/zabici_reset<grey> - resetowanie statystyk zabitych\n")
    cecho("<light_slate_blue>/zabici2<grey> - globalny licznik zabitych (od resetu).\n")
    cecho("<light_slate_blue>/zabici2!<grey> - globalny licznik zabitych z uwzglednieniem zabitych/dzien.\n")
    cecho("<light_slate_blue>/zabici2 [data]<grey> - log zabitych z dnia o <light_slate_blue>[data]<grey>. \n")
    cecho("Data musi byc w takiej formie: <light_slate_blue>[rok]/[miesiac]/[dzien]<grey>,\n")
    cecho("np. <light_slate_blue>/zabici2 2017/1/22<grey>, <light_slate_blue>/zabici2 2017/1<grey> lub <light_slate_blue>/zabici2 2017<grey>\n")    
    cecho("<light_slate_blue>/zabici2_reset<grey> - reset globalnego licznika zabitych.\n")
    cecho("<light_slate_blue>/postepy<grey> - licznik postepow w tej sesji.                                       \n")
    cecho("<light_slate_blue>/postepy_reset<grey> - resetuje licznik postepow sesji.                              \n")    
    cecho("<light_slate_blue>/postepy2<grey> - globalny licznik postepow.                                         \n")
    cecho("<light_slate_blue>/postepy2+<grey> - dodaje jeden postep do globalnego licznika.                       \n")
    cecho("<light_slate_blue>/postepy2+ [ile]<grey> - dodaje <light_slate_blue>[ile]<grey> postepow do globalnego licznika.               \n")
    cecho("np <light_slate_blue>/postepy2+ 4<grey> doda 4 postepy. Musi to byc liczba mniejsza badz rowna 15!     \n")
    cecho("<light_slate_blue>/postepy2+ [id] [ile]<grey> - dodaje <light_slate_blue>[ile]<grey> postepow z globalnego licznika o <light_slate_blue>[id]<grey>.    \n")
    cecho("<light_slate_blue>/postepy2- [id]<grey> - usuwa wpis z globalnego licznika o tym <light_slate_blue>[id]<grey>. id mozna        \n")
    cecho("znalezc jako pierwsza kolumna od lewej w <light_slate_blue>/postepy2<grey>.                            \n")
    cecho("<light_slate_blue>/postepy2- [id] [ile]<grey> - odejmuje <light_slate_blue>[ile]<grey> postepow z globalnego licznika o <light_slate_blue>[id]<grey>.  \n")
    cecho("<light_slate_blue>/postepy2_reset<grey> - resetuje globalny licznik postepow.                          \n")
    cecho("<light_slate_blue>/postepy2_off<grey> - wylacza dodawanie do globalnego licznika postepow.             \n")
    cecho("<light_slate_blue>/postepy2_on<grey> - wlacza dodawanie do globalnego licznika postepow.               \n")
    cecho("<light_slate_blue>/drzwi<grey> (n|e|s|w|ne|...) (0|1|2|3) - dodaje drzwi w danym kierunku\n")    
    cecho("<light_slate_blue>/kolory<grey> - pokazuje tablice nazwanych kolorow\n")
    cecho("<light_slate_blue>/akcja<grey> (przeciwnik|druzyna|inni) komenda - ustawianie akcji dodatkowych (pod literka S)\n")
    cecho("<light_slate_blue>/statsfix<grey> - usuwa zagubione statystyki\n")
    cecho("<light_slate_blue>/opoz<grey> (ilosc_opoznienia) - opoznienie automatycznego chodzika mapy domyslnie 2 sekundy\n")
    cecho("<light_slate_blue>/stop<grey> - zastopowanie chodzika mapy (to samo co klawisz F12)\n")
    cecho("<light_slate_blue>/idzdo numer_lokacji<grey> - wykonuje sekwencje chodzika do numeru lokacji\n")
    cecho("<light_slate_blue>/findlok <short><grey> - wyszukuje lokacje z podanym shortem\n")
    cecho("<light_slate_blue>/pokazruny<grey> - pokazuje ilosc zdobytych run w sesji\n")
    cecho("<light_slate_blue>/resetujruny<grey> - resetuje ilosc zdobytych run\n")
    cecho("<light_slate_blue>/pobierzmape<grey> - pobiera ogolnodostepna mape muda\n")
    echo("\n")
    echo("    Klawisze:\n")
    echo("Klawiatura numeryczna:\n")
    echo("  0..9 - chodzenie (+ctrl - przemykanie, +ctrl+alt - przemykanie z druzyna\n")
    echo("  - - wyjscie\n")
    echo("  + - wyjscie specjalne lub jedno z (schody, wejscie)\n")
    echo("  * - lazik traktowy\n")
    echo("Klawisze funkcyjne:\n")
    echo("  F5 - kondycja\n")
    echo("  F6 - kondycja przeciwnika\n")
    echo("  F8 - stan\n")
    echo("  F12- przerwanie auto-chodzika\n")
    echo("\n")
    echo("Obsluga mapy:\n")
    echo("  kolko myszy - przyblizanie/oddalanie\n")
    echo("  ALT + przycisk myszy - przesuwanie mapy\n")
    echo("  lewy przycisk myszy - zaznaczanie lokacji (pojedynczo lub wiele naraz)\n")
    echo("  CTRL + lewy przycisk - dodawanie/odejmowanie lokacji z zaznaczenia\n")
    echo("  prawy przycisk myszy - menu kontekstowe do zaznaczonych wczesniej lokacji\n")
    echo("\n")
    echo("Okienka:\n")
    echo("  Domyslnie okienka rozmow, mapy oraz kondycji sa zablokowane. Pod prawym klawiszem myszy\n")
    echo("  na okienku pojawia sie menu kontekstowe gdzie mozna modyfikowac stan okienka, ukrywac, odblokowac.\n")
    echo("  Odblokowane okienka mozna przesuwac i zmieniac ich wielkosc.\n")
end
registerAnonymousEventHandler("sysDataSendRequest", scripts.help.handleHelpCommands)

tempTimer(4, [[ scripts:print_start_message() ]])

function scripts:print_start_message()
    scripts:print_log("Uzywasz Warlock Skrypty, ver. " .. scripts.ver .. ". Pomoc dostepna w '/pomoc'")
    scripts.latest:is_latest(function(release_info) scripts:print_log("Dostepna jest nowa wersja (" .. release_info.tag_name .. "). Wpisz /aktualizuj_skrypty zeby zaktualizowac") cecho("\n<SlateGray>" .. release_info.body .."\n<reset>") end)
    scripts.mapper.map_update:check_for_update()   
end