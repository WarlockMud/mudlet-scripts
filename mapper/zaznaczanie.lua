function mapper_zaznaczaj_func()
	highlightRoom(room.id,255,255,255,0,0,0,1,255,0)
	highlighted_rooms = highlighted_rooms or {}
	table.insert(highlighted_rooms, room.id)
end

function mapper_odznaczaj_func()
	highlighted_rooms = highlighted_rooms or {}
	for _, v in ipairs(highlighted_rooms) do
		unHighlightRoom(v)
	end
	highlighted_rooms = {}
end