--gmcp_Room_Glance
function gmcp_Room_Glance(event)
    --display(gmcp.Room)
    if(gmcp.Room.Glance == nil) then return end
    local wyjscia_combined = gmcp.Room.Glance.wyjscia
    for k, v in pairs(gmcp.Room.Glance.drzwi) do table.insert(wyjscia_combined, v[1]) end
    scripts.minimap:drawExitsOnConsole(wyjscia_combined) -- zmienic na ...FromMap()
    scripts.mapper:enrichMapRoom(gmcp.Room.Glance)
    scripts.minimap:displaySpecialExitsFromMap()
--    gmcp.Room.Glance = nil
end
if scripts.event_handlers["scripts/gmcp/RoomGlance"] then
    killAnonymousEventHandler(scripts.event_handlers["scripts/gmcp/RoomGlance"])
end

scripts.event_handlers["scripts/gmcp/RoomGlance"] = registerAnonymousEventHandler("gmcp.Room.Glance", gmcp_Room_Glance)


