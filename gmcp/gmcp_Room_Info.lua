function gmcp_Room_Info(event)        
    if(type(gmcp.Room.Info.komenda) ~= "table") then
      gmcp.Room.Info.komenda = {"X", "", "", 0}
    end    
  
    scripts.mapper:makeMapRoom(gmcp.Room.Info)
    scripts.minimap:drawExitsOnConsole({})    
    raiseEvent("warlock.newRoom", gmcp.Room.Info.id)    
end

if scripts.event_handlers["scripts/gmcp/RoomInfo"] then
    killAnonymousEventHandler(scripts.event_handlers["scripts/gmcp/RoomInfo"])
end

scripts.event_handlers["scripts/gmcp/RoomInfo"] = registerAnonymousEventHandler("gmcp.Room.Info", gmcp_Room_Info)


