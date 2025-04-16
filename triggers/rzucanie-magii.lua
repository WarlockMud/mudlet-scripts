function trigger_magia_koncentracja_func()
    selectCurrentLine()
    fg("white")

    deselect()
    resetFormat()
end

function trigger_magia_wyciszony_func()
    selectCurrentLine()
    fg("forest_green")
    resetFormat()
end

function trigger_magia_porazka_czarowania_func()
    selectCurrentLine()
    fg("maroon")
    resetFormat()    
end

function trigger_magia_mozliwy_ponownie_func()
    selectCurrentLine()
    fg("olive_drab")
    selectCaptureGroup(2)
    fg("white")
    resetFormat()    
end