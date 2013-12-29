local ns = ...
local log = ns.log:new("frameRegistry")


local frameStore = _G

local frameRegistry = {
	
	setStore = function(store)
		frameStore = store
	end,

	register = function(name, frame)

		if name == nil or name == "" then
			return
		end

		frameStore[name] = frame

	end,

	get = function(name)

		if name == nil or name == "" then
			return
		end

		return frameStore[name]

	end,

}

ns.frameRegistry = frameRegistry