scripts["zabici"] = scripts["zabici"] or { kille = {} }

function scripts.zabici:dodajZabitego(kto,opis)
    opis = table.remove(opis:split(" "))
	if(scripts.zabici.kille[kto] == nil) then scripts.zabici.kille[kto] = {} end
	if(scripts.zabici.kille[kto][opis] == nil) then scripts.zabici.kille[kto][opis] = 0 end
	scripts.zabici.kille[kto][opis] = scripts.zabici.kille[kto][opis] + 1
end