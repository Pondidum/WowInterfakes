local ns = ...
local log = ns.log.new("api")

local api = {
	
	export = function(name, action)
		log.debug("export", string.format("registering %s", name))
		_G[name] = action
	end,
}

ns.api = api