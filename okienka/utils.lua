-- Okienka::utils
-- cala obsluga okienek, robienia i usuwania elementow etc

function scripts.windows:addElementToPool(element, kind)
	local key = kind or element.kind or element.type
	local ep = scripts.windows.elementsPool[key] or {}
	scripts.windows:debugmsg("* Returning " .. key .. " to pool.")
	table.insert(ep, element)
	scripts.windows.elementsPool[key] = ep
end

-- pobiera element z puli istniejacych... lub go tworzy na bierzaco.
-- type: Geyserowy typ jaki nalezy tutaj utworzyc
-- ctorfp: funkcja wskazujaca na konstruktor ktory ma utworzyc nam element
-- args: tablica arguemntow dla ctorfp
function scripts.windows:getElementFromPool(kind, ctorfp, args, parent)
	
	local ep = scripts.windows.elementsPool[kind] or {}
	if table.size(ep) > 0 then
		scripts.windows:debugmsg("* Returning "..kind.." from pool")
		local ret = table.remove(ep, 1)
		scripts.windows.elementsPool[kind] = ep
		if (parent ~= nil) then parent:add(ret) end
		return ret
	else
		scripts.windows:debugmsg("* Creating new " .. kind .. ", " .. (args.name or "(no name)"))
		local ret = nil
		if(ctorfp[1] ~= nil) then
			ret = ctorfp[2](ctorfp[1], args, parent)
		else								
			ret = ctorfp[2](args, parent)
		end
		ret.kind = args.kind or kind -- upewnijmy sie ze dobrze sie ustawil rodzaj
		return ret
	end
end

function scripts.windows:removeElement(element, recursive)
	if (element == nil) then return end
	if recursive then
		for i, w in pairs(element.windowList) do
			scripts.windows:removeElement(w, recursive)
		end
	end
	scripts.windows:debugmsg("* Removing element " .. element.name)
	scripts.windows:addElementToPool(element)
	element:hide()
	element.container:remove(element)
	element.container = nil
end

function scripts.windows:tableMerge(a, b)
   for k, v in pairs(b) do
		if(type(k) == "number") then
			table.insert(a, v)
		else
			a[k] = v
		end
	end
   return a
end

function scripts.windows:findElementsByAttribute(attr_name, attr_value, container)
	local ret = {}
	for i, v in pairs(container.windowList) do
		if(v[attr_name] ~= nil and tostring(v[attr_name]) == tostring(attr_value)) then table.insert(ret, v) end
		local sub = scripts.windows:findElementsByAttribute(attr_name, attr_value, v)
		if(sub ~= nil) then ret = scripts.windows:tableMerge(ret, sub) end
	end
	return ret
end
function scripts.windows:findAllElementsWithId(container)
	local tableToRet = {}
	for i,v in pairs(container.windowList) do		
		if v.id ~= nil then						
			table.insert(tableToRet,v)
		else
			local sub = scripts.windows:findAllElementsWithId(v)
			if sub ~= nil and table.getn(sub) > 0 then
				for k,v in pairs(sub) do				
					table.insert(tableToRet,v)	
				end
			end
		end
	end
	
	return tableToRet
end
function scripts.windows:cleanContainerStatsUpForNums()
	local allEnemyContainers = scripts.windows:findAllElementsWithId(containerStats)	
	for k,v in pairs(allEnemyContainers) do
		if not table.contains(scripts.walka.nums, tonumber(v.id)) then						
			local row = v.container			
			scripts.windows:removeElement(v)
			row:reposition()
		end
	end
end
function scripts.windows:findElementById(id, container)
	for i, v in pairs(container.windowList) do						
		if(v.id ~= nil and tostring(v.id) == tostring(id)) then 			
			return v 
		end
		local sub = scripts.windows:findElementById(id, v)
		if(sub ~= nil) then return sub end
	end
	--display("Nothing with id " .. id .. " found in " .. container.name)
	return nil
end

function scripts.windows:createNewLabel(args, parent)
	local ctor = {Geyser.Label, Geyser.Label.new}
	return scripts.windows:getElementFromPool("label", ctor, args, parent)
end

function scripts.windows:createNewLayout(args, parent)
	local ctor = {Geyser.LayoutBox, Geyser.LayoutBox.new}
	return scripts.windows:getElementFromPool("layout_container", ctor, args, parent)
end

--- testy
function scripts.windows:testuj_ou()
	local ctor = {Geyser.Label, Geyser.Label.new} -- <self>, function
	local v = getElementFromPool("test_label", ctor, {name = "test label 1", x = 100, y = 100, height = 20, thickness = 20, bgColor = "red", type = "test_label"}, nil)
	display(v.name)
	scripts.windows:removeElement(v)
	display(v.container == nil)
end
--------------------------------------------------------------------------------------------------------------------------------------
--Tworzy ramke dla kontenera
function scripts.windows:createBox(parent, name, thickness, color)
	local borders = {nil, nil, nil, nil}
	borders[1] = scripts.windows:createNewLabel({name=name.."b1", x = 0, y = 0, width = "100%", height = thickness, bgColor = color}, parent)
	borders[2] = scripts.windows:createNewLabel({name=name.."b2", x = 0, y = "100%", width = "100%", height = thickness,	bgColor = color}, parent)
	borders[3] = scripts.windows:createNewLabel({name=name.."b3", x = 0, y = 0, width = thickness, height = "100%",	bgColor = color}, parent)
	borders[4] = scripts.windows:createNewLabel({name=name.."b4", x = "100%", y = 0, width = thickness, height = "100%",	bgColor = color}, parent)
	return borders
end