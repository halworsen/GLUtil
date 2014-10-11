local glutil = {}

--[[
	Actual utility stuff
]]

-- Gets all hooks for an event that originate from a specified source
function glutil.GetHooksBySource(event, source)
	local matching_hooks = {}
	for k,v in pairs(hook.GetTable()[event]) do
		if string.find(string.lower(debug.getinfo(v)["source"]), string.lower(source), 1, true) then
			matching_hooks[k] = v
		end
	end

	return matching_hooks
end

-- Compiles a function as a string and returns it
function glutil.CompileStringFunction(code)
	return CompileString("return "..code, "CompileStringFunction function")()	
end
-- Opposite of lerp, speed increases as it closes on its target value
function glutil.AntiLerp(fract, val, target)
	return math.Clamp(val*(1+fract), 0, target)
end

-- Given an origin and a size, it returns a value that would center an object on the origin
function glutil.GetCenterPos(origin, size)
	return origin/2 - size/2
end

-- Gets a player's name, minus all of their (community) tags
function glutil.GetTagLessName(player)
	local name = player:Name()
	name = string.gsub(name, "%[.+%]%s", "")
	name = string.gsub(name, "%s%[.+%]", "")
	name = string.gsub(name, "%(.+%)%s ", "")
	name = string.gsub(name, "%s%(.+%)", "")

	return name
end

-- Concatenates a table's keys, provided they are strings, numbers or booleans
function glutil.ConcatTableKeys(tbl, joiner)
	local concatenated = ""
	local count = table.Count(tbl)
	local counter = 1

	for k,v in pairs(tbl) do
		if type(k) == "string" or type(k) == "number" or type(k) == "boolean" then
			concatenated = concatenated..k..(counter ~= count and joiner or "")
		end
		counter = counter + 1
	end
end

-- Draws an outlined rect with a specified thickness
function glutil.DrawOutlinedThickRect(x, y, w, h, t)
	for i=0,t-1 do
		surface.DrawOutlinedRect(x+i, y+i, w-i*2, h-i*2)
	end
end

--[[
		Everything else
		Cool stuff, etc.
]]

-- Given a direct link to a version tracker, it checks if the provided version matches with the one in the tracker
function glutil.CheckVersion(tracker, version)
	MsgC(Color(236, 240, 241), "-> Version: "..version.."\n")
	MsgC(Color(236, 240, 241), "-> Checking if current version matches newest version...\n")
	http.Fetch(tracker, function(body)
		if body == version then
			MsgC(Color(46, 204, 113), "-> The current version is up to date!\n")
		else
			MsgC(Color(231, 76, 60), "! The current version is out of date!\n")
			MsgC(Color(236, 240, 241), "-> Current version: "..version.."\n")
			MsgC(Color(236, 240, 241), "-> Newest version: "..body.."\n")
		end
	end, function()
		MsgC(Color(231, 76, 60), "! Failed to fetch version tracker!\n")
	end)
end

-- Prettily prints a file's contents to the console
function glutil.PrintFile(path, rel)
	if file.Exists(path, rel) then
		local lines = string.Explode(file.Read(path, rel), "\n")
		local path_parts = string.Explode("/", path, false)

		MsgC(Color(236, 240, 241), "●─── Printing "..path_parts[#path_parts]:sub(1,#path_parts[#path_parts]-4)..".\n")
		for k,v in pairs(lines) do
			MsgC(Color(236, 240, 241), "| "..k.." | "..v)
		end
		MsgC(Color(236, 240, 241), "└──●\n")
	else
		MsgC(Color(231, 76, 60), "! File doesn't exist!\n")
	end
end

return glutil