scripts_loaded = scripts_loaded or false


local luaDirectory = getMudletHomeDir():gsub("\\", "/") .. "/warlock_scripts/?.lua"
if not package.path:find(luaDirectory, 1, true) then
    package.path = string.format("%s;%s", luaDirectory, package.path)
end

local result, prio = pcall(getModulePriority, "warlock")
local base_prio = result and prio or 0

function load_scripts(force)
    if not force and scripts_loaded then
        return
    end

    if mudletOlderThan(4, 15) then
        cecho("\n\n<red>Zaktualizuj Mudlet. Skrypty moga nie dzialac poprawnie! Wymagana wersja 4.15+\n\n")
    end

    cecho("\n<CadetBlue>(skrypty):<tomato> Laduje pliki skryptow.\n")
    package.loaded.scriptsList = nil

    local mudlet_modules = require("scriptsList")
    raiseEvent("beforeLoadModules", mudlet_modules)

    for k, v in pairs(mudlet_modules) do
        local status, err = pcall(function()
            package.loaded[v] = nil
            require(v)
        end)
        if not status then
            cecho("\n\n")
            cecho("<red>" .. err)
            cecho("\n")
            cecho("\n<CadetBlue>(skrypty):<red> Jezeli widzisz ten blad to cos poszlo nie tak z ladowaniem skryptow.")
            cecho("\n<CadetBlue>(skrypty):<red> Przeinstaluj skrypty. Jezeli to nie pomoze to zglos problem zalaczajac powyzszy komunikat bledu.")
            cecho("\n\n")
        end
    end
    
    scripts_loaded = true
    raiseEvent("scriptsLoaded")    
    if force then
        if gmcp.Char.Info ~= nil then
            scripts.character_name = string.lower(gmcp.Char.Info.name)
            scripts.character_id = gmcp.Char.Info.id
        end
    end
end

load_scripts(false)