function trigger_mowienie_func()
	local kto = matches[2]
	local co = matches[3]
	local jak = matches[4]
	local cel = matches[6]
	local tekst = matches[7]
	--display(matches)
	selectCurrentLine()
	if(co == "szepcze") then
		fg("dodger_blue")
	else
		fg("cyan")
	end

	if(cel == "ciebie") then
		selectCaptureGroup(6)
		fg("white")
	end
	chatConsole:cecho("[" .. getTime(true, "HH:mm") .. "] <cyan>" .. kto .. jak .. (cel ~= "" and (" do " .. cel) or ("")) .. ": <white>" .. tekst .. "<reset>\n")
	scripts.windows:flashChatContainerButton(chatContainer)
	resetFormat()
end

function trigger_ja_mowie_func()
	selectCurrentLine()
	--display(matches)

	local co = matches[2]
	local jak = matches[3]
	local cel = matches[5]
	local tekst = matches[6]
	if(co == "Szepczesz") then
		fg("dodger_blue")
	else
		fg("cyan")
	end
	chatConsole:cecho("[" .. getTime(true, "HH:mm") .. "] <cyan>" .. co .. jak .. (cel ~= "" and (" do " .. cel) or ("")) .. ": <white>" .. tekst .. "<reset>\n")
	scripts.windows:flashChatContainerButton(chatContainer)
	resetFormat()
end