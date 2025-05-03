scripts.dir_binds = scripts.dir_binds or {}

scripts.dir_binds.short_to_long = {
  ["n"] = "north", ["north"] = "north",
  ["ne"] = "northeast", ["northeast"] = "northeast",
  ["e"] = "east", ["east"] = "east",
  ["se"] = "southeast", ["southeast"] = "southeast",
  ["s"] = "south", ["south"] = "south",
  ["sw"] = "southwest", ["southwest"] = "southwest",
  ["w"] = "west", ["west"] = "west",
  ["nw"] = "northwest", ["northwest"] = "northwest",
  ["u"] = "up", ["up"] = "up",
  ["d"] = "down", ["down"] = "down"
}

scripts.dir_binds.long_to_short = {
  ["north"] = "n",
  ["northeast"] = "ne",
  ["east"] = "e",
  ["southeast"] = "se",
  ["south"] = "s",
  ["southwest"] = "sw",
  ["west"] = "w",
  ["northwest"] = "nw",
  ["up"] = "u",
  ["down"] = "d"
}

function scripts.dir_binds.check_coords_match_direction(c_x, c_y, c_z, x, y, z, target_long_dir)
    local short_dir = scripts.dir_binds.long_to_short[target_long_dir]
    if not short_dir then return false end

    c_y = -c_y
    y = -y

    if short_dir == "s" then return x == c_x and y > c_y and z == c_z end
    if short_dir == "n" then return x == c_x and y < c_y and z == c_z end
    if short_dir == "e" then return x > c_x and y == c_y and z == c_z end
    if short_dir == "w" then return x < c_x and y == c_y and z == c_z end
    if short_dir == "nw" then return x < c_x and y < c_y and z == c_z end
    if short_dir == "ne" then return x > c_x and y < c_y and z == c_z end
    if short_dir == "sw" then return x < c_x and y > c_y and z == c_z end
    if short_dir == "se" then return x > c_x and y > c_y and z == c_z end
    if short_dir == "d" then return x == c_x and y == c_y and z < c_z end
    if short_dir == "u" then return x == c_x and y == c_y and z > c_z end

    return false
end

function scripts.dir_binds.send_mapped_direction(direction_input)
    local long_dir = scripts.dir_binds.short_to_long[direction_input]
    if not long_dir then
        return false
    end
    local short_dir = scripts.dir_binds.long_to_short[long_dir]

    local current_room = getPlayerRoom()
    if not current_room or type(current_room) ~= "number" or current_room <= 0 then
         send(short_dir)
         return false
    end

    local current_area_id = getRoomArea(current_room)
    local room_exits = getRoomExits(current_room) or {}

    if room_exits[short_dir] and room_exits[short_dir] ~= 0 then
        send(short_dir)
        return true
    end

    local special_exits = getSpecialExitsSwap(current_room)
    if special_exits then
        local c_x, c_y, c_z = getRoomCoordinates(current_room)
        local matching_exits_same_area = {}
        local matching_exits_other_area = {}

        for exit_cmd, dest_id in pairs(special_exits) do
            if not tonumber(exit_cmd) and dest_id and dest_id ~= 0 then
                local dest_coords = {getRoomCoordinates(dest_id)}
                if table.maxn(dest_coords) >= 3 then
                    if scripts.dir_binds.check_coords_match_direction(c_x, c_y, c_z, dest_coords[1], dest_coords[2], dest_coords[3], long_dir) then
                        local dest_area_id = getRoomArea(dest_id)
                        local exit_data = { cmd = exit_cmd, id = dest_id }
                        if dest_area_id == current_area_id then
                            table.insert(matching_exits_same_area, exit_data)
                        else
                            table.insert(matching_exits_other_area, exit_data)
                        end
                    end
                end
            end
        end


        if #matching_exits_same_area > 0 then
            send(matching_exits_same_area[1].cmd)
            return true
        end

        if #matching_exits_other_area > 0 then
            send(matching_exits_other_area[1].cmd)
            return true
        end
    end

    if room_exits["up"] and room_exits["up"] ~= 0 then
        local c_x, c_y, c_z = getRoomCoordinates(current_room)
        local dest_coords = {getRoomCoordinates(room_exits["up"])}
        if table.maxn(dest_coords) >= 3 then
            if scripts.dir_binds.check_coords_match_direction(c_x, c_y, c_z, dest_coords[1], dest_coords[2], dest_coords[3], long_dir) then
                send("u")
                return true
            end
        end
    end

    if room_exits["down"] and room_exits["down"] ~= 0 then
        local c_x, c_y, c_z = getRoomCoordinates(current_room)
        local dest_coords = {getRoomCoordinates(room_exits["down"])}
        if table.maxn(dest_coords) >= 3 then
            if scripts.dir_binds.check_coords_match_direction(c_x, c_y, c_z, dest_coords[1], dest_coords[2], dest_coords[3], long_dir) then
                send("d")
                return true
            end
        end
    end

    send(short_dir)
    return false
end