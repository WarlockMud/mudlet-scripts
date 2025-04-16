function trigger_ciemno_nie_widac_func()
    selectCurrentLine()
    fg("red")
    resetFormat()
end
function trigger_widoczne_wyjscia_func()   
    selectCurrentLine()
    fg("dark_green")
    selectCaptureGroup(2)
    fg("green")
    selectCaptureGroup(3)
    fg("green")
    resetFormat()   
end
function trigger_ciemno_brak_wyjsc_func()
    selectCurrentLine()
    fg("red")
    resetFormat()
end