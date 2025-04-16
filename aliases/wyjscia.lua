function alias_roominfo_func()
    echo("Obszar: " .. getRoomAreaName(scripts.mapper.currentRoom.areaId) .. " (id: " .. scripts.mapper.currentRoom.areaId .. "), lokacji: " .. table.size(getAreaRooms(scripts.mapper.currentRoom.areaId)) .. "\n")
    echo("Nazwa lokacji: " .. getRoomName(scripts.mapper.currentRoom.id) .. " (id: " .. scripts.mapper.currentRoom.id .. ") (hash: " .. getRoomHashByID(scripts.mapper.currentRoom.id) .. ")\n")
    local x,y,z = getRoomCoordinates(scripts.mapper.currentRoom.id)
    echo("Wspolrzedne: " .. x .. ", " .. y .. ", " .. z .. "\n")
    echo("Rodzaj lokacji: " .. env[getRoomEnv(scripts.mapper.currentRoom.id) - scripts.mapper.ENV_START_NUM].type .. "\n")
    local serv = getRoomUserData(scripts.mapper.currentRoom.id, "service")
    display(serv)
    if(serv ~= nil and serv ~= "") then
    serv = yajl.to_value(serv)
    if(serv.type ~= nil) then
        echo("Usluga na lokacji: " .. serv.type .. "\n")
    end
    end
end

function alias_cleararea_func()
    local areaID = getRoomArea(scripts.mapper.currentRoom.id)
    echo("Usuwam aktualny obszar: " .. getRoomAreaName(areaID) .. " (id " .. areaID .. ")\n")
    deleteArea(areaID)

    scripts.mapper:makeMapRoom(scripts.mapper.currentRoom.room)
end

function alias_clearmap_func()
    scripts.mapper:clearMap()
end

function alias_areas_func()
    local areas = getAreaTableSwap()
    for id, area in pairs(areas) do
        local arealoc = getAreaRooms(id) 
        echo("Area: " .. area .. ", id: " .. id .. ", lokacji: " .. table.size(arealoc) .. " - ")
        echoLink("[usun obszar]", "deleteArea(" .. id .. ")", "Usuwa caly obszar " .. area .. " z mapy")
        echo("\n")
    end
end

function alias_add_door_func()
    --Wyjscia::drzwi::addDoor
    setDoor(scripts.mapper.currentRoom.id, matches[2], matches[3])
end