local glutil = {}

-- Gets all hooks for an event that originate from a specified source
function glutil.GetHooksBySource(event, source)
	local match_hooks = {}
	for k,v in pairs(hook.GetTable()[event]) do
		if string.find(string.lower(debug.getinfo(v)["source"]), string.lower(source), 1, true) then
			match_hooks[k] = v
		end
	end
	return match_hooks
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

-- Compiles a function as a string and returns it
function glutil.CompileStringFunction(code)
	return CompileString("return "..code, "CompileStringFunction function")()	
end
-- Opposite of lerp, speed increases as it closes on its target value
function glutil.AntiLerp(fract, val, target)
	return math.Clamp(val * (1+fract), 0, target)
end

return glutil