function trigger_jest_prompt_func()
    raiseEvent("gotPrompt")
end
function trigger_usun_prompt_func()
    selectCurrentLine()
    replaceLine("")
end
function trigger_podmieniaj_taby_func()
    while selectString("\t",1) > -1 do
        replace("    ")
    end
end
