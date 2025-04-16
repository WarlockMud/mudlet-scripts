-- Czat

-- Pokazuje odpowiednie okienko czatu
function scripts.windows:showContainerByName(name)
	for k, w in pairs(mainChatContainer.windowList) do
		if(w.name ~= name and w.name:ends("Container")) then
			w:hide()
			w.buttonActivate:setColor("navy_blue")
			w.buttonActivate:setFgColor("white")
		end	
		if(w.name == name) then
			w.buttonActivate:setColor("steel_blue")
			w.buttonActivate:setFgColor("black")
			w:show()
		end
	end
end

-- Mruga zakladka od czatu
function scripts.windows:flashMe(container, delay, num)
	container:flash(delay)
	num = num - 1
	if(num == 0) then return end
	tempTimer(delay * 2, function() scripts.windows:flashMe(container, delay, num) end)
end

function scripts.windows:flashChatContainerButton(container, show)
	scripts.windows:flashMe(container.buttonActivate, 0.2, 10)
	if(show == true) then
		scripts.windows:showContainerByName(container.name)
	end
end

function scripts.windows:createChatWindows(window)
	mainChatContainer = Geyser.Container:new({
		name = "mainChatContainer",
		--x = "-104c", y = "1c",
  		--width="101c", height="10c",
    x = "10px", y = "5px", height = "100%-10px", width = "100%-5px"
	}, window)
	chatContainer = Geyser.Container:new({
		name = "chatContainer",
		x = "10", y = "0",
  		width="98%", height="100%",
	}, mainChatContainer)
	wizContainer = Geyser.Container:new({
		name = "wizContainer",
		x = "10", y = "0",
  		width="98%", height="100%",
	}, mainChatContainer)
	chatConsole = Geyser.MiniConsole:new({
  		name="chat_rozmowy", x = "1px", y = "1px",
  		width="-1px", height="-1px",
		autoWrap = true,
		fontSize = getFontSize("main"),
		font = getFont("main"),
	}, chatContainer)
	scripts.windows:createBox(chatContainer, "chatBox", "2px", "gray")
	chatConsole:setColor(0, 10, 0)
	setTextFormat("rozmowy", 0, 10, 0, 255, 255, 255, 0, 0, 0)
	setBgColor("rozmowy", 0, 10, 0)

	wizConsole = Geyser.MiniConsole:new({
  		name="chat_wizline", x = "1px", y = "1px",
  		width="-1px", height="-1px",
		wrapAt=100,
	}, wizContainer)
	scripts.windows:createBox(wizContainer, "wizBox", "2px", "gray")
	wizConsole:setColor(0, 0, 10)
	setTextFormat("wizline", 0, 0, 10, 255, 255, 255, 0, 0, 0)
	setBgColor("wizline", 0, 0, 10)

	chatContainer.buttonActivate = Geyser.Label:new({
		name = "activate_chat",
		x = 0, y = 0, width = 14, height = 12,
		color="steel_blue", fgColor="black", message = "<center>C</center>"
	}, mainChatContainer);
	chatContainer.buttonActivate:setClickCallback("showContainerByName", chatContainer.name)

	wizContainer.buttonActivate = Geyser.Label:new({
		name = "activate_wiz",
		x = 0, y = 15, width = 14, height = 12,
		color="navy_blue", fgColor="white", message = "<center>W</center>"
	}, mainChatContainer);
	wizContainer.buttonActivate:setClickCallback("showContainerByName", wizContainer.name)

	wizContainer:hide() -- ukryte domyslnie, po co ono...
end