function zabij_po_symbolu()

	local player_killer = 0
	local znaleziono_cel = 0
	local potwierdzenie_ataku = 1

	for k, v in pairs(scripts.walka.objects) do
		if tostring(v.symbol) == matches[2] then
			if v.avatar == 1 or v.team == 1 then
				scripts:print_log("<light_steel_blue>Chyba nie chcesz zaatakowac takiego slabeusza?")
			elseif (v.player == 1 or v.entity_type == "mercenary" or v.entity_type == "servant" or v.entity_type == "horse")
			and player_killer == 0 then
				scripts:print_log("<i><grey>No, no, tyle agresji.</i>")
				scripts:print_log("<light_steel_blue>PK jest obecnie wylaczone.")
			else
				if potwierdzenie_ataku == 1 then
					scripts:print_log("<light_steel_blue>Atakuje <steel_blue>"..v.desc.."<light_steel_blue>.")
				end
				send("zabij ob_"..k)
			end
		znaleziono_cel = 1
		break
		end
	end

	if znaleziono_cel == 0 then
		scripts:print_log("<light_steel_blue>Nie znaleziono celu ataku.")
	end

end

function zaslon_po_symbolu()

	local znaleziono_cel = 0
	local potwierdzenie_zaslony = 1

	for k, v in pairs(scripts.walka.objects) do
		if tostring(v.symbol) == string.upper(matches[2]) then
			if v.avatar == 1 then
				scripts:print_log("<light_steel_blue>Ktos inny musi cie uratowac.")
			elseif v.team == 1 then
				if potwierdzenie_zaslony == 1 then
					scripts:print_log("<light_steel_blue>Zaslaniam <steel_blue>"..v.desc.."<light_steel_blue>.")
				end
				send("przejdz przed ob_"..k)
			else
				scripts:print_log("<light_steel_blue>Nie mozesz tego zrobic.")
			end
		znaleziono_cel = 1
		break
		end
	end

	if znaleziono_cel == 0 then
		scripts:print_log("<light_steel_blue>Nie znaleziono celu zaslony.")
	end

end

function wycofka_po_symbolu()

	local znaleziono_cel = 0
	local potwierdzenie_wycofki = 1

	for k, v in pairs(scripts.walka.objects) do
		if tostring(v.symbol) == string.upper(matches[2]) then
			if v.avatar == 1 then
				scripts:print_log("<light_steel_blue>Ktos inny musi cie uratowac.")
			elseif v.team == 1 then
				if potwierdzenie_wycofki == 1 then
					scripts:print_log("<light_steel_blue>Wycofuje sie za <steel_blue>"..v.desc.."<light_steel_blue>.")
				end
				send("przejdz za ob_"..k)
			else
				scripts:print_log("<light_steel_blue>Nie mozesz tego zrobic.")
			end
		znaleziono_cel = 1
		break
		end
	end

	if znaleziono_cel == 0 then
		scripts:print_log("<light_steel_blue>Nie znaleziono celu wycofania sie.")
	end

end