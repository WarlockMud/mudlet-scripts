mudlet = mudlet or {}
mudlet.mapper_script = true
scripts["mapper"] = scripts["mapper"] or {
    kierunki = {},
    env = {},
    service = {},    
    ENV_START_NUM = 17,
	currentRoom = {},
	lastSentCommand = nil
}
scripts.mapper.kierunki["polnoc"] = {{"north", "n"}, 1, {0, 2, 0}, "poludnie", "|"}
scripts.mapper.kierunki["polnocny-wschod"] = {{"northeast", "ne"}, 2, {2, 2, 0}, "poludniowy-zachod", "/"}
scripts.mapper.kierunki["polnocny-zachod"] = {{"northwest", "nw"}, 3, {-2, 2, 0}, "poludniowy-wschod", "\\"}
scripts.mapper.kierunki["wschod"] = {{"east", "e"}, 4, {2, 0, 0}, "zachod", "-"}
scripts.mapper.kierunki["zachod"] = {{"west", "w"}, 5, {-2, 0, 0}, "wschod", "-"}
scripts.mapper.kierunki["poludnie"] = {{"south", "s"}, 6, {0, -2, 0}, "polnoc", "|"}
scripts.mapper.kierunki["poludniowy-wschod"] = {{"southeast", "se"}, 7, {2, -2, 0}, "polnocny-zachod", "\\"}
scripts.mapper.kierunki["poludniowy-zachod"] = {{"southwest", "sw"}, 8, {-2, -2, 0}, "polnocny-wschod", "/"}
scripts.mapper.kierunki["gora"] = {{"up", "u", "gore"}, 9, {0, 0, 2}, "dol", "^"}
scripts.mapper.kierunki["dol"] = {{"down", "d"}, 10, {0, 0, -2}, "gora", "v"}

scripts.mapper.env[0] = {type = "ROOM_NORMAL", weight = 2, color = {120, 120, 120, 255}}
scripts.mapper.env[1] = {type = "ROOM_IN_WATER", weight = 6, color = {120, 120, 220, 255}}
scripts.mapper.env[2] = {type = "ROOM_UNDER_WATER", weight = 20, color = {20, 20, 220, 255}}
scripts.mapper.env[3] = {type = "ROOM_IN_AIR", weight = 20, color = {190, 190, 190, 200}}
scripts.mapper.env[4] = {type = "ROOM_BEACH", weight = 4, color = {240, 230, 20, 255}}
scripts.mapper.env[5] = {type = "ROOM_IN_LOW_MOUNTAINS", weight = 5, color = {120, 120, 120, 255}}
scripts.mapper.env[6] = {type = "ROOM_IN_HIGH_MOUNTAINS", weight = 9, color = {80, 80, 80, 255}}
scripts.mapper.env[7] = {type = "ROOM_IN_HILLS", weight = 4, color = {120, 160, 120, 255}}
scripts.mapper.env[8] = {type = "ROOM_IN_FOREST", weight = 3, color = {0, 220, 0, 255}}
scripts.mapper.env[9] = {type = "ROOM_IN_PLAIN", weight = 2, color = {90, 120, 90, 255}}
scripts.mapper.env[10] = {type = "ROOM_IN_CAVE", weight = 4, color = {70, 70, 70, 255}}
scripts.mapper.env[11] = {type = "ROOM_IN_SWAMP", weight = 5, color = {0, 120, 50, 255}}
scripts.mapper.env[12] = {type = "ROOM_IN_ROAD", weight = 1, color = {170, 80, 12, 255}}
scripts.mapper.env[13] = {type = "ROOM_IN_CITY", weight = 1, color = {120, 120, 120, 255}}
scripts.mapper.env[14] = {type = "ROOM_IN_VILLAGE", weight = 1, color = {120, 120, 120, 255}}
scripts.mapper.env[15] = {type = "ROOM_UNVISITED", weight = 100, color = {120, 20, 120, 150}}

scripts.mapper.service[1] = {type = "ROOM_SERVICE_POSTOFFICE", letter = "P"}
scripts.mapper.service[2] = {type = "ROOM_SERVICE_SMITH", letter = "K"}
scripts.mapper.service[3] = {type = "ROOM_SERVICE_SHOP", letter = "S"}
scripts.mapper.service[4] = {type = "ROOM_SERVICE_BANK", letter = "$"}
scripts.mapper.service[5] = {type = "ROOM_SERVICE_MESSAGEBOARD", letter = "T"}
scripts.mapper.service[6] = {type = "ROOM_SERVICE_WATER", letter = "w", color = {0, 0, 200, 255}}
scripts.mapper.service[7] = {type = "ROOM_SERVICE_PUB", letter = "J"}
scripts.mapper.service[8] = {type = "ROOM_SERVICE_BARBER", letter = "F"}


function scripts.mapper.captureSentCommand(eventName, command)
    if command and #command > 0 then
         scripts.mapper.lastSentCommand = command
    else
         scripts.mapper.lastSentCommand = nil
    end
    return false
end

if scripts.event_handlers["scripts/mapper/captureSentCommand"] then
    killAnonymousEventHandler(scripts.event_handlers["scripts/mapper/captureSentCommand"])
end
scripts.event_handlers["scripts/mapper/captureSentCommand"] = registerAnonymousEventHandler("sysDataSendRequest", scripts.mapper.captureSentCommand)

function scripts.mapper:setupRoomColors()
	for i, data in ipairs(scripts.mapper.env) do
		setCustomEnvColor(scripts.mapper.ENV_START_NUM + i, unpack(data.color))
	end
end

function scripts.mapper:hasStubExit(roomId, kier)
	local stubs = getExitStubs(roomId)
	if(type(stubs) ~= "table") then return false end
	if(scripts.mapper.kierunki[kier] == nil) then return false end
	for i, v in pairs(stubs) do
		if(v == scripts.mapper.kierunki[kier][2]) then
			return true
		end
	end
	return false
end

function scripts.mapper:hasExit(roomId, kier)
	local exits = getRoomExits(roomId)
	if(type(exits) ~= "table") then return false end
	if(scripts.mapper.kierunki[kier] == nil) then return false end
	for i, v in pairs(exits) do
		if(i == scripts.mapper.kierunki[kier][1][1]) then
			return true
		end
	end
	return false
end

function scripts.mapper:deductFromMoveDesc(komenda)
	local do_gory = {"wspina", "na gore", "do gory", "na pietro"}
	local w_dol = {"schodzi", "na dol"}
	for k, data in pairs(scripts.mapper.kierunki) do
		if(komenda[2]:find(k)) then
			return data[3][1], data[3][2], data[3][3], true
		end
	end
	for k, v in pairs(do_gory) do
		if(komenda[2]:find(v)) then
			return 0, 0, 2, true
		end
	end
	for k, v in pairs(w_dol) do
		if(komenda[2]:find(v)) then
			return 0, 0, -2, true
		end
	end
	-- nie wiem nic, domyslna wartosc...
	return 0, 0, 0, false
end

function scripts.mapper:findMostSpacious(spaces)
	-- znalezc ciagle bloki, wybrac najdluzszy
	-- zwrocic srodkowe pole z najdluzszego bloku
	local dx, dy, dz = {0, 0, 0}, {0, 0, 0}, {0, 0, 0}
	local mx, my, mz = 2, 2, 2
	local i, j
	local found = false
	-- poziomy i piony zliczamy. gora-dol ignoruje chwilowo
	for i = 1, 3, 1 do
		for j = 1, 3, 1 do
			if(spaces[(i - 1) * 3 + j][1] == 0) then
				found = true
				dx[j] = dx[j] + 1
				if(dx[j] > dx[mx] or (dx[j] == dx[mx] and spaces[(my - 1) * 3 + j][2] == 0)) then mx = j end
				dy[i] = dy[i] + 1
				if(dy[i] > dy[my] or (dy[i] == dy[my] and spaces[(i - 1) * 3 + mx][3] == 0)) then my = i end
			end
		end
	end
	--display(dx)
	--display(dy)
	if(not found) then
		-- uhuh, nie ma miejsca. Gora i dol w takim razie!
		return 0, 0, 1 --gora na sztywno chwilowo
	end
	local s = spaces[mx + (my - 1) * 3]
	return s[2], s[3], s[4]
end

function scripts.mapper:getShiftedRoomCoordinates(fromId, komenda)
	local exit = komenda[3]
	local x, y, z = getRoomCoordinates(fromId)
	if(exit == nil or scripts.mapper.kierunki[exit] == nil) then
		-- wyjscie specjalne. Gdzie umiescic nowa lokacje?
		local dx, dy, dz, fs = scripts.mapper:deductFromMoveDesc(komenda)
		if(fs) then
			return x + dx, y + dy, z + dz
		end
		local nearby = {}
		for dy = -2, 2, 2 do for dx = -2, 2, 2 do
			local nr = getRoomsByPosition(getRoomArea(fromId), x + dx, y + dy, z + dz)
			table.insert(nearby, {table.size(nr), dx, dy, dz })
		end end
		local nx, ny, nz = scripts.mapper:findMostSpacious(nearby)
		--echo("Shifts: " .. nx .. ", " .. ny .. ", " .. nz .. "\n")
		return x + nx, y + ny, z + nz
	end
	x = x + scripts.mapper.kierunki[exit][3][1]
	y = y + scripts.mapper.kierunki[exit][3][2]
	z = z + scripts.mapper.kierunki[exit][3][3]
	return x, y, z
end

function scripts.mapper:updateNewRoom(newId, room)
	local prevId = getRoomIDbyHash(room.idprev)
	local x, y, z;
	if(room.idprev ~= nil and type(room.idprev) == "string") then
		if(prevId == -1) then
			x, y, z = 0, 0, 0
		else
			x, y, z = scripts.mapper:getShiftedRoomCoordinates(prevId, room.komenda)
		end
	else
		x, y, z = 0, 0, 0
	end
	setRoomCoordinates(newId, x, y, z)
	setRoomWeight(newId,scripts.mapper.env[room.rodzaj].weight)
	setRoomEnv(newId, scripts.mapper.ENV_START_NUM + room.rodzaj)
end

function scripts.mapper:createNewRoom(room, areaId)
	local newId = createRoomID()
	if(newId ~= nil and addRoom(newId)) then
		setRoomArea(newId, areaId)
		setRoomIDbyHash(newId, room.id)
		scripts.mapper:updateNewRoom(newId, room)
		--echo("rozmowy", "New room id: " .. newId .. ", coord: [" .. x .. "," .. y .. "," .. z .. "]\n")
		return newId
	end
	echo("rozmowy", "Nie stworzono pokoju!\n")
	return nil
end

function scripts.mapper:connectExits(room, roomId, prevId)
	if(prevId == nil or not roomExists(prevId)) then return end

	local cmd = room.komenda[3]
	local kdat = scripts.mapper.kierunki[cmd]
	if(kdat ~= nil) then
		if(scripts.mapper:hasStubExit(prevId, cmd)) then
			scripts.mapper:connectExitStubRpl(prevId, roomId, kdat[2], scripts.mapper.kierunki[kdat[4]][2])
		else
			local prevExits = getRoomExits(prevId)
			if(prevExits[kdat[1][1]] ~= roomId) then
				setExit(prevId, roomId, kdat[2])
			end
		end
	elseif(room.komenda[1] ~= "X" and room.komenda[3] ~= 0) then
		if scripts.mapper.lastSentCommand:match("^(%S+)") == room.komenda[1]:match("^(%S+)") then
			addSpecialExit(prevId, roomId, scripts.mapper.lastSentCommand)	
		end
	end
end

function scripts.mapper:getRoomsThatLeadHere(toId)
	local leads = {}
	for roomId, desc in pairs(getRooms()) do
		if(table.contains(getRoomExits(roomId), toId)) then
			table.insert(leads, roomId)
		end
	end
	return leads
end

function scripts.mapper:createOrUpdateArea(area_data)
  local areaId = nil
  local nazwa = area_data.obszar
  if(table.contains(getAreaTable(), nazwa)) then
    areaId = getAreaTable()[nazwa]
  else
    areaId = addAreaName(nazwa)
  end
  if(area_data.czas ~= nil) then
    setAreaUserData(areaId, "czas", tostring(area_data.czas))
  end
  return areaId
end

function scripts.mapper:getAreaId(nazwa)
  return scripts.mapper:createOrUpdateArea({obszar = nazwa, czas = nil})
end

-- Na razie takie zeby cokolwiek bylo.
-- Dodaje drzwi na mapie jesli wlasnie przeszlismy przez drzwi.
-- Docelowo dodac w gmcp glance info o drzwiach i ich statusie.
function scripts.mapper:insertDoors(room)
	local roomId = getRoomIDbyHash(room.id)
	local prevId = getRoomIDbyHash(room.idprev)
	if(string.match(room.komenda[2], "drzwi") and not room.komenda[3] == 0) then
		setDoor(roomId, scripts.mapper.kierunki[scripts.mapper.kierunki[room.komenda[3]][4]][1][2], 1)
	end
end

function scripts.mapper:insertVisibleDoors(roomId, drzwi)
	for i, door_data in ipairs(drzwi) do
		if(scripts.mapper.kierunki[door_data[1]] ~= nil) then
			if not scripts.mapper:hasExit(roomId, door_data[1]) then
				setExitStub(roomId, scripts.mapper.kierunki[door_data[1]][2], true)
			end
         -- Glupie troche - nie rysuje drzwi na exitStubach
			setDoor(roomId, scripts.mapper.kierunki[door_data[1]][1][2], 2 - door_data[2])
		end
	end
end

function scripts.mapper:makeMapStubRoom(room)
	local areaId = scripts.mapper:getAreaId(room.obszar)
	local roomId = getRoomIDbyHash(room.id)
	if(roomId == -1) then
		roomId = scripts.mapper:createNewRoom(room, areaId)
	end
	return roomId,areaId
end

function scripts.mapper:makeMapRoom(room)
  local areaId = scripts.mapper:getAreaId(room.obszar)
  local roomId = getRoomIDbyHash(room.id)
  local prevId = getRoomIDbyHash(room.idprev)
  local prevAreaId = getRoomArea(prevId)

  if(roomId == -1) then
    roomId = scripts.mapper:createNewRoom(room, areaId)
  end
  scripts.mapper:connectExits(room, roomId, prevId)
  if(areaId ~= prevAreaId and room.komenda[1] ~= "X" and prevAreaId ~= nil) then
    local labelId = getRoomUserData(prevId, "labelIdDo" .. areaId)
    if(labelId == nil or not table.contains(getMapLabels(prevAreaId), tonumber(labelId))) then
      local posx, posy, posz = scripts.mapper:getShiftedRoomCoordinates(prevId, room.komenda)
      if(posx < getRoomCoordinates(prevId)) then posy = posy + 1 end
      labelId = createMapLabel(prevAreaId, getRoomAreaName(areaId), posx, posy, posz, 0,0,0, 210,210,210, 20, 8, false, true)
      setRoomUserData(prevId, "labelIdDo" .. areaId, labelId)
    end
  end

  centerview(roomId)
  scripts.mapper.currentRoom.id = roomId
  scripts.mapper.currentRoom.prevId = prevId
  scripts.mapper.currentRoom.cmd = room.komenda
  scripts.mapper.currentRoom.areaId = areaId
  scripts.mapper.currentRoom.room = room
  scripts.mapper:insertDoors(room)
  return roomId,areaId
end

function scripts.mapper:connectExitStubRpl(roomId, prevRoomId, directionId, reverseDirectionId)
	setExit(roomId, prevRoomId, directionId)
	setExit(prevRoomId, roomId, reverseDirectionId)
end

function scripts.mapper:enrichMapRoom(room)
	local roomId = getRoomIDbyHash(room.id)
	if(roomId == nil) then return end

	setRoomName(roomId, room.nazwa)
	for i, k in ipairs(room.wyjscia) do
		if(scripts.mapper.kierunki[k] ~= nil and not scripts.mapper:hasExit(roomId, k)) then
			setExitStub(roomId, scripts.mapper.kierunki[k][2], true)
		end
	end
	if(scripts.mapper.currentRoom.cmd ~= nil and scripts.mapper.currentRoom.prevId ~= nil and scripts.mapper.currentRoom.id == roomId and scripts.mapper.kierunki[scripts.mapper.currentRoom.cmd[3]] ~= nil) then
		-- Przypuszczamy, ze jesli wyjscia sie pokrywaja, to sie lacza. Robimy dwustronne od razu.
		local cmd = scripts.mapper.kierunki[scripts.mapper.currentRoom.cmd[3]][4]
		local kdat = scripts.mapper.kierunki[cmd]
		if(scripts.mapper:hasStubExit(roomId, cmd)) then
			scripts.mapper:connectExitStubRpl(roomId, scripts.mapper.currentRoom.prevId, kdat[2], scripts.mapper.kierunki[kdat[4]][2])
		end
	end
	if(room.usluga > 0 and scripts.mapper.service[room.usluga] ~= nil) then
		setRoomChar(roomId, scripts.mapper.service[room.usluga].letter)
		setRoomUserData(roomId, "service", yajl.to_string(scripts.mapper.service[room.usluga]))
	end
	scripts.mapper:insertVisibleDoors(roomId, room.drzwi)
end

function scripts.mapper:clearMap()
	for k, v in pairs(getAreaTable()) do
		echo("Removing area: " .. k .. "\n")
		deleteArea(v);
	end	
end

scripts.mapper:setupRoomColors()