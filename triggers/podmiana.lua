function podmiana_postepow_func()

	local kolor_postepow = "gold"

	local postepy = {
		["znikome"] = 0,
		["minimalne"] = 1,
		["nieznaczne"] = 2,
		["malutkie"] = 3,
		["male"] = 4,
		["nieduze"] = 5,
		["spore"] = 6,
		["znaczne"] = 7,
		["pokazne"] = 8,
		["duze"] = 9,
		["wielkie"] = 10,
		["wspaniale"] = 11,
		["wysmienite"] = 12,
		["ogromne"] = 13,
		["gigantyczne"] = 14,
		["kolosalne"] = 15,
		["niesamowite"] = 16,
		["fantastyczne"] = 17
	}

	local postepy_wartosc = postepy[matches[3]]

	selectString(matches[3], 1)
	fg(kolor_postepow)
	replace(matches[3].. " (" ..postepy_wartosc.."/17)")
	resetFormat()

end

function colorizeSkillLevel()
    local level = matches[2]
    local levels = {
        ["ledwo"] = 1, ["mizernie"] = 2, ["slabo"] = 3, ["powierzchownie"] = 4,
        ["znosnie"] = 5, ["poprawnie"] = 6, ["umiejetnie"] = 7, ["swietnie"] = 8,
        ["wspaniale"] = 9, ["fenomenalnie"] = 10
    }
    local ipoz = levels[level]
    local max = 10  -- Maksymalna wartość

    if ipoz then
        selectCaptureGroup(2)

        local greenValue = math.min(255, ipoz * 255 / max)  -- Zwiększa się z poziomem umiejętności
        local redValue = math.max(0, 255 - ipoz * 255 / max)  -- Zmniejsza się z poziomem umiejętności
        local blueValue = 0  -- Stała niska wartość, można dostosować

        setFgColor(redValue, greenValue, blueValue)
    end

    resetFormat()
end