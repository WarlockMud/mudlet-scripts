function trigger_brak_przejscia_func()
    selectCurrentLine()
    fg("red")
    resetFormat()
    raiseEvent("moveNoExit", matches[2])
end
function trigger_nie_przeszlismy_func()
    selectCurrentLine()
    fg("red")
    resetFormat()
    raiseEvent("moveNoExit", matches[2])
end
function trigger_drzwi_zamkniete_func()    
    selectCurrentLine()
    fg("red")
    resetFormat()
    raiseEvent("moveNoExit", matches[3])
end