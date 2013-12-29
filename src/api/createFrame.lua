local ns = ...
local builder = ns.builder 

local createFrame = function(type, name, parent, templates)
	return builder.createFrame(type, name, parent, templates)
end

ns.api.export("CreateFrame", createFrame)



