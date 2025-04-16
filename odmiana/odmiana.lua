scripts["odmiana"] = scripts["odmiana"] or { seq_id_odmiana = 0, odmiana_id = 0, }
scripts.odmiana["przypadki"] = {"Mianownik", "Dopelniacz", "Celownik", "Biernik", "Narzednik", "Miejscownik"}

function scripts.odmiana:ustawOdmiane(co, odmtab)
	odmiana[co] = {}
	for i, przyp in pairs(przypadki) do
		odmiana[co][przyp] = odmtab[i]
		odmiana[przyp] = odmiana[przyp] or {}
		odmiana[przyp][odmtab[i]] = co
	end
end

function scripts.odmiana:odmienCallback(co, linia)
	local a, b, c = rex_pcre.new("([^ ]+): (.+)[.,]"):exec(linia)
	local przypadek = linia:sub(c[1], c[2])
	local wartosc = linia:sub(c[3], c[4])
	odmiana[co] = odmiana[co] or {}
	odmiana[co][przypadek] = wartosc
	odmiana[przypadek] = odmiana[przypadek] or {}
	odmiana[przypadek][wartosc] = co
end

function scripts.odmiana:odmien(co, callback_fun)
	if(co == nil or #co < 1) then return end
	if(odmiana[co] ~= nil) then
		if(callback_fun ~= nil) then tempTimer(0, callback_fun) end
		return
	end
	if(odmiana_id[co] ~= nil) then return end
	callback_fun = callback_fun or ""
	odmiana_id[co] = tempRegexTrigger("(> |)(.*?(" .. co:lower() .. "|" .. co:title() .. ").*?) odmienia sie nastepujaco:", [[
		killTrigger(odmiana_id["]] .. co .. [["]);
		odmiana_id["]] .. co .. [["] = nil;
		_wycinaj("]] .. callback_fun .. [[");
		tempLineTrigger(1, 6, "odmienCallback(\"" .. matches[3] .. "\", line)");		
	]])
	send("!odmien " .. co:lower(), false)
end

function scripts.odmiana:sprawdzOdmianyKondycja(komenda, callback_fun)
	if(not komenda) then return end
	callback_fun = callback_fun or ""
	local teamKonTrigger = tempRegexTrigger("(.+) jest ",
		[[
			odmien(matches[2]);
		]])
	wycinajDoPrompta("killTrigger(" .. teamKonTrigger .. "); " .. callback_fun)
	send("!" .. komenda, false)
end