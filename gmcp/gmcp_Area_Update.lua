function gmcp_Area_Update()
    if(gmcp.Room.Area.Update == nil) then return end
    --display(gmcp.Room.Area.Update)
    local areaId = scripts.mapper:getAreaId(gmcp.Room.Area.Update.obszar)
    if(areaId ~= -1) then
      -- czas jest ustawiany w makeMapRoom.
      -- setAreaUserData(areaId, "czas", gmcp.Room.Area.Update.czas)
      local czas = tostring(gmcp.Room.Area.Update.czas)
      local zapisany = getAreaUserData(areaId, "czas") or "<brak>"
      if(zapisany ~= czas) then
        --echo(" * areaId: " .. areaId .. ", czas: " .. czas .. " vs zapisany czas: " .. zapisany .. "\n")
        echo(" * Kasuje obszar '" .. getRoomAreaName(areaId) .. "', wykryte zmiany.\n")
        deleteArea(areaId)
        scripts.mapper:createOrUpdateArea(gmcp.Room.Area.Update)
      end
    end
  end
  if scripts.event_handlers["scripts/gmcp/GmcpAreaUpdate"] then
    killAnonymousEventHandler(scripts.event_handlers["scripts/gmcp/GmcpAreaUpdate"])
end

scripts.event_handlers["scripts/gmcp/GmcpAreaUpdate"] = registerAnonymousEventHandler("gmcp.Room.Area.Update", gmcp_Area_Update)