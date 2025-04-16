scripts["minimap"] = scripts["minimap"] or {   }

--Wyjscia::minimap
function scripts.minimap:displaySpecialExits(exits)
	for k, v in ipairs(exits) do
		fg(minimapExits.name, "dark_olive_green")
		echo(minimapExits.name, " | ")
		fg(minimapExits.name, "slate_blue")
		echoLink(minimapExits.name, v, [[send("]] .. v .. [[")]], "Wyjscie specjalne: " .. v, true)
	end
	if #exits > 0 then
		fg(minimapExits.name, "dark_olive_green")
		echo(minimapExits.name, " | ")
	end
	resetFormat(minimapExits.name)
end

function scripts.minimap:displaySpecialExitsFromMap()
	local ex = {}
  room =scripts.mapper.currentRoom
  if(room == nil) then return end
	for k, v in pairs(getSpecialExitsSwap(room.id) or {}) do
		if(not table.contains(room.specialExits or {}, k)) then
			table.insert(ex, k)
		end
	end
	if(#ex > 0) then
		scripts.minimap:displaySpecialExits(ex)
	end
end

function scripts.minimap:drawExitsOnConsole(exits)
	local l = { {" ", " ", " ", " ", " "}, {" ", "o", " ", " ", " "}, {" ", " ", " ", " ", " "}, {" ", " ", " ", " ", " "}}
	local s = {}
	for i, data in ipairs(exits) do
		if(data == "gora") then
			l[1][5] = "^"
			l[2][5] = "|"
		elseif(data == "dol") then
			l[3][5] = "v"
			l[2][5] = "|"
		elseif(scripts.mapper.kierunki[data] ~= nil) then
			idx = scripts.mapper.kierunki[data][3]
			l[2 - idx[2] / 2][2 + idx[1] / 2] = scripts.mapper.kierunki[data][5]
		else -- special exit!
			table.insert(s, data)
		end
	end
	--display(l)
	clearWindow(minimap.name)
	clearWindow(minimapExits.name)
	minimap:echo(table.concat(l[1], "") .. "\n")
	minimap:echo(table.concat(l[2], "") .. "\n")
	minimap:echo(table.concat(l[3], "") .. "\n")
	minimap:echo(table.concat(l[4], ""))
	--minimapExits:echo(table.concat(s, ", "))
	scripts.minimap:displaySpecialExits(s)
	scripts.mapper.currentRoom.exits = table.n_complement(exits, s)
	scripts.mapper.currentRoom.specialExits = s
end
