scripts["windows"] = scripts["windows"] or {
    debug = false,    
    elementsPool = {},
    win_created = false,
    stats_created = false,
    WindowWidth = 0,
    WindowHeight = 0,
    borderTop = 50,
    borderLeft = 50,
    borderBottom = 20,
    borderRight = 0,
    paski_ja = {
        {"kondycja", "rgb(0, 180, 0, 255)", "rgb(100, 5, 0, 200)"},
        {"mana", "rgb(60, 0, 180, 255)", "rgb(150, 0, 100, 200)"},
        {"zmeczenie", "rgb(180, 100, 0, 255)", "rgb(60, 30, 0, 200)"}
    },
    paski_inni = {
        {"kondycja", "rgb(0, 180, 0, 255)", "rgb(100, 5, 0, 200)"},
    },
    seq_num = 0,
    akcja =  {przeciwnik = "narozkaz najemnikowi zabij %", druzyna = "", inni = "", ja = ""},
    buttons_enemy = {
        {name = "hide_me", message = "x", tooltip = "Zamknij", callback = "scripts.windows:hideEnemyStatsFor", args = {}},
        {name = "compare_me", message = "P", tooltip = "Porównaj się z ...", callback = "scripts.windows:commandEnemyById", args = {"porownaj sie z"}},
        {name = "kill_me", message = "Z", tooltip = "Zabij ...", callback = "scripts.windows:commandEnemyById", args = {"zabij"}},
        {name = "point_me", message = "W", tooltip = "Wskaz ...", callback = "scripts.windows:commandEnemyById", args = {"wskaz"}},
        {name = "script_me", message = "S", tooltip = "Akcja specjalna (/akcja przeciwnik)", callback = "scripts.windows:callScriptById", args = {"przeciwnik"}},
    },
    buttons_druzyna = {
      {name = "leave_me", message = "X", tooltip = "Porzuc ...", callback = "scripts.windows:commandEnemyById", args = {"porzuc"}},
      {name = "assist_me", message = "A", tooltip = "Wesprzyj ...", callback = "scripts.windows:commandEnemyById", args = {"wesprzyj"}},
      {name = "point_me", message = "z", tooltip = "Przejdz przed ...", callback = "scripts.windows:commandEnemyById", args = {"przejdz przed"}},
      {name = "point_me", message = "W", tooltip = "Wskaz ...", callback = "scripts.windows:commandEnemyById", args = {"wskaz"}},
      {name = "script_me", message = "S", tooltip = "Akcja specjalna (/akcja druzyna)", callback = "scripts.windows:callScriptById", args = {"druzyna"}},
    },
    buttons_own = {}    
}
scripts.windows.WindowWidth, scripts.windows.WindowHeight = getMainWindowSize();
function scripts.windows:debugmsg(msg)
    if scripts.windows.debug == true then
        cecho("  <yellow:dim_grey>--<yellow:black>" .. msg .. "\n")
    end
end
