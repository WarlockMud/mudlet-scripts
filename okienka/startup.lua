function scripts.windows:okienka_startup()
	if(not scripts.windows.win_created) then
		scripts.windows:createWindows();
		scripts.windows.win_created = true
	end
--	if(not stats_created) then
--		createStats();
--		stats_created = true
--	end
end

-- Tworzy glowne okno z dodatkowymi kontenerami po bokach.
function scripts.windows:createWindows()
	--setBorderTop(scripts.windows.borderTop)
	--setBorderBottom(scripts.windows.borderBottom)
  	--setBorderLeft(scripts.windows.borderLeft)
  	--setBorderRight(scripts.windows.borderRight)

  -- UserWindow do wszystkich elementow dodatkowych do przesuwania po ekranie
	chatWindow = Geyser.UserWindow:new({
		name = "Rozmowy",
		titleText = "Rozmowy",
		x = "0", y = "0",
		width="100%", height ="50%",
		docked = true,
		dockPosition = "top"
	})
	mapWindow = Geyser.UserWindow:new({
		name = "Mapper",
		titleText = "Mapper",
		x = "0", y = "0",
		width="33%", height ="33%",
		docked = true,
		dockPosition = "right"
	})
	statsWindow = Geyser.UserWindow:new({
		name = "Stats",
		titleText = "Stats",
		x = "0", y = "33%",
		width="33%", height ="33%",
		docked = true,
		dockPosition = "right"
	})
	okno_kondycji = Geyser.UserWindow:new({
		name = "Okno Kondycji",
		titleText = "Okno Kondycji",
		x = "0", y = "66%",
		width="33%", height ="33%",
		autoWrap = true,
		fontSize = getFontSize("main"),
		font = getFont("main"),
		docked = true,
		dockPosition = "right"
	})

	-- Okienko z pelna mapa
	mapper = Geyser.Mapper:new({
		name = "mapper",
		x = "0", y = "0",
		width = "100%", height = "100%",
		embedded = true,
	}, mapWindow)

	-- Dodatkowe paski po bokach i na dole

	containerBottom = Geyser.Container:new({
		name = "containerBottom", x = getBorderLeft(), y = -getBorderBottom(),
		width = "100%", height = getBorderBottom()*2
	})

	scripts.windows:createChatWindows(chatWindow);
	scripts.windows:createMinimap(containerBottom);
	scripts.windows:createSpecialExitsLine(containerBottom);
	scripts.windows:createStatsLayout(statsWindow)
end

function scripts.windows:createMinimap(parent)

	local ukryj_minimape = 1 -- hidden by default

	if ukryj_minimape == 1 then
		minimap = Geyser.MiniConsole:new({
			name="minimap", x = "0", y = "0",
			width = "0", height = "0",
			fontSize = 10
		}, parent)
	else
		minimap = Geyser.MiniConsole:new({
			name="minimap", x = "-10c", y = "-4c", -- right side, bottom border
			width = "5c", height = "4c",
			fontSize = 10
		}, parent)
	end
	--minimap:setTextFormat(10, 50, 10, 255, 255, 255, 1, 0, 0);
	return minimap
end

function scripts.windows:createSpecialExitsLine(parent)
	minimapExits = Geyser.MiniConsole:new({
  		name="wyjscia", x = "0", y = "-1c",
  		width="100%", height = "10c",
		autoWrap = true,
		fontSize = getFontSize("main"),
		font = getFont("main")
	}, parent)
	setTextFormat("wyjscia", 0, 20, 0, 200, 255, 200, 0, 0, 0)
	setBgColor("wyjscia", 0, 20, 0)
	return minimapExits
end

function userWindowResize()
    if scripts.windows.win_created then
      saveWindowLayout()
    end
end

if scripts.event_handlers["scripts/windows/startup/userWindowResize"] then
    killAnonymousEventHandler(scripts.event_handlers["scripts/windows/startup/userWindowResize"])
end

scripts.event_handlers["scripts/windows/startup/userWindowResize"] = registerAnonymousEventHandler("sysUserWindowResizeEvent", userWindowResize)

scripts.windows:okienka_startup()
loadWindowLayout()
