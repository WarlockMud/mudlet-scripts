---wiekszosc kodu pobrana z https://github.com/tjurczyk/arkadia, przerobione na potrzeby warlocka
scripts.counter.utils = scripts.counter.utils or {}

function scripts.counter.utils:is_rare(type)
    local first_letter = type:sub(1, 1)
    return string.upper(first_letter) == first_letter
end