---wiekszosc kodu pobrana z https://github.com/tjurczyk/arkadia, przerobione na potrzeby warlocka
scripts["licznik_postepow"] = scripts["licznik_postepow"] or {ver = "2.0 by Haldir",
    opisy_postepow = 
    {
        [0] = "znikome",
        [1] = "minimalne",
        [2] = "nieznaczne",
        [3] = "malutkie",
        [4] = "male",
        [5] = "nieduze",
        [6] = "spore",
        [7] = "znaczne",
        [8] = "pokazne",
        [9] = "duze",
        [10] = "wielkie",
        [11] = "wspaniale",
        [12] = "wysmienite",
        [13] = "ogromne",
        [14] = "gigantyczne",
        [15] = "kolosalne",
        [16] = "niesamowite",
        [17] = "fantastyczne"
    },
    postepy_w_sesji = 0,
    poprzednie_postepy = 0,
    postepy_dzisiaj = 0
    }
scripts.licznik_postepow["db_improvee"] = db:create("improvee", {
    improvee = {
        year = 0,
        month = 0,
        day = 0,
        hour = "",
        val = 0,
        character = "",
    }
})
scripts.licznik_postepow["current_improve_level"] = scripts.licznik_postepow["current_improve_level"] or 0
scripts.licznik_postepow["level_snapshots"] = scripts.licznik_postepow["level_snapshots"] or {}
scripts.licznik_postepow["improve2_enabled"] = true
scripts.licznik_postepow["improve_start_timestamp"] = getEpoch()

function scripts.licznik_postepow:print_improve()
    local time = getTime(true, "dd/MM hh:mm:ss")
    local average = scripts.licznik_postepow:calculate_average()
    local average_str = "             "
    if average > 0 then
        average_str = " : sred " .. scripts.licznik_postepow:seconds_to_formatted_string(average)
    end

    cecho("+---------------------------------- <green>Postepy<grey> ---------------------------------+\n")
    cecho("|                                                                            |\n")
    cecho("| <yellow>Aktualny czas   : " .. time .. "<grey>   " .. scripts.licznik_postepow:str_pad(average_str, 20) .. "                    |\n")
    cecho("|                                                                            |\n")

    local sum_me_killed = 0
    local sum_all_killed = 0
    local last_time_stamp = scripts.licznik_postepow["improve_start_timestamp"]

    for k, v in pairs(scripts.licznik_postepow["level_snapshots"]) do
        local when_got = string.sub(v["time"] .. "                    ", 1, 18)
        sum_me_killed = v["me_killed"]
        sum_all_killed = v["all_killed"]

        -- fix timestamp if /expstart was used
        if k > 1 and scripts.licznik_postepow.level_snapshots[k]["timestamp"] < scripts.licznik_postepow.level_snapshots[k - 1]["timestamp"] then
            scripts.licznik_postepow.level_snapshots[k]["timestamp"] = scripts.licznik_postepow.level_snapshots[k - 1]["timestamp"] + scripts.licznik_postepow.level_snapshots[k]["timestamp"]
        end

        last_time_stamp = v.timestamp
        local time_str = v["time_passed"]

        local killed_str = nil
        if k == 1 then
            killed_str = tostring(v["me_killed"]) .. "/" .. tostring(v["all_killed"])
        else
            killed_str = tostring(v["me_killed"] - scripts.licznik_postepow.level_snapshots[k - 1]["me_killed"]) .. "/" .. tostring(v["all_killed"] - scripts.licznik_postepow.level_snapshots[k - 1]["all_killed"])
        end

      

        local name = string.sub(scripts.licznik_postepow["opisy_postepow"][v["level"]] .. "                ", 1, 16)
        local sep = ": "
        local details_time = string.sub("czas " .. time_str .. "                ", 1, 14)
        local details_killed = string.sub(" zabici " .. killed_str .. "                ", 1, 14)

        cecho("| " .. scripts.licznik_postepow:str_pad(tostring(k), 2, "right") .. ". " .. name .. sep .. when_got .. sep .. details_time .. sep .. details_killed .. "   |\n")
    end
    if scripts.counter.killed_amount[scripts.character_name] == nil then
        scripts.counter.killed_amount[scripts.character_name] = 0
    end

    local since_last_str = nil;
    if last_time_stamp then
        local seconds_since_last = getEpoch() - last_time_stamp
        since_last_str = string.format("Od ostatniego postepu: %s : zabici: %s/%s",
        scripts.licznik_postepow:seconds_to_formatted_string(seconds_since_last),
        tostring(scripts.counter.killed_amount[scripts.character_name] - sum_me_killed),
        tostring(scripts.counter.all_kills - sum_all_killed))
    end
    

    cecho("|                                                                            |\n")
    cecho("| <orange>ZABITYCH<grey>                                                                   |\n")
    cecho("| <LawnGreen>JA<grey> ... : <orange>" .. string.sub(tostring(sum_me_killed) .. "      ", 1, 6) .. "<grey>                                                            |\n")
    cecho("| <LawnGreen>WSZYSCY<grey>: <orange>" .. string.sub(tostring(sum_all_killed) .. "      ", 1, 6) .. "<grey>                                                            |\n")
    cecho("|                                                                            |\n")

    if since_last_str then
        cecho("| <SlateBlue>".. string.sub(since_last_str .."                                ", 1, 74) .. " <reset>|\n")
        cecho("|                                                                            |\n")
    end
    cecho("+----------------------------------------------------------------------------+\n")
end

function scripts.licznik_postepow:calculate_average()
    local sum_of_time = 0
    for k, v in pairs(scripts.licznik_postepow["level_snapshots"]) do
        if v.seconds_passed == nil then
            return 0
        end
        sum_of_time = sum_of_time + v.seconds_passed
    end
    return scripts.licznik_postepow:math_round(sum_of_time / table.size(scripts.licznik_postepow["level_snapshots"]))
end

function scripts.licznik_postepow:improve_reset()
    scripts.licznik_postepow["current_improve_level"] = 0



    scripts.licznik_postepow["level_snapshots"] = {}
    scripts.licznik_postepow["improve_start_timestamp"] = getEpoch()
    scripts:print_log("Licznik zresetowany")
end
function scripts.licznik_postepow:real_len(str)
    str = str:gsub("<[^<]*>", "")
    return string.len(str)
end
function scripts.licznik_postepow:str_pad(str, length, align)
    local total_pad = length - scripts.licznik_postepow:real_len(str:gsub("<[%a_]+>", ""))
    local prepad = align == "center" and math.floor(total_pad / 2) or (align == "right" and total_pad or 0)
    local postpad = total_pad - prepad
    return string.rep(" ", prepad) .. str .. string.rep(" ", postpad)
end
function scripts.licznik_postepow:math_round(x)
    if x % 2 ~= 0.5 then
        return math.floor(x + 0.5)
    end
    return x - 0.5
end

function scripts.licznik_postepow:round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function scripts.licznik_postepow:seconds_to_formatted_string(seconds)
    local minutes = math.floor(seconds / 60)
    local minutes_string = ""

    if minutes > 60 then
        hours = math.floor(minutes / 60)
        if hours < 10 then
            minutes_string = "0" .. tostring(hours)
        else
            minutes_string = tostring(hours)
        end
        minutes_string = minutes_string .. ":"
        minutes = minutes - (hours * 60)
    end

    if minutes < 10 then
        minutes_string = minutes_string .. "0" .. tostring(minutes)
    else
        minutes_string = minutes_string .. tostring(minutes)
    end

    local seconds = math.floor(seconds % 60)

    if seconds < 10 then
        return minutes_string .. ":0" .. tostring(seconds)
    else
        return minutes_string .. ":" .. tostring(seconds)
    end
end
function scripts.licznik_postepow:improve_reset()
    scripts.licznik_postepow["current_improve_level"] = 0



    scripts.licznik_postepow["level_snapshots"] = {}
    scripts.licznik_postepow["improve_start_timestamp"] = getEpoch()
    scripts:print_log("Licznik zresetowany")
end