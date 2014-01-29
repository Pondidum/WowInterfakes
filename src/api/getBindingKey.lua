local ns = ...
local log = ns.log:new("api.getBindingKey")
local binds = ns.data.keybinds

local getBindingKey = function(command)

	log.debug(command, binds[command])

	return binds[command]

end

ns.api.export("GetBindingKey", getBindingKey)

