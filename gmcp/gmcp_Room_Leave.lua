function gmcp_Room_Leave()	
	local id = gmcp.Room.Leave.id	
end

if scripts.event_handlers["scripts/gmcp/RoomLeave"] then
    killAnonymousEventHandler(scripts.event_handlers["scripts/gmcp/RoomLeave"])
end

scripts.event_handlers["scripts/gmcp/RoomLeave"] = registerAnonymousEventHandler("gmcp.Room.Leave", gmcp_Room_Leave)


