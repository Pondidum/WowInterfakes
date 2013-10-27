local ns = ...

local templates = {}

local templateManager = {

	addTemplate = function(name, decorator)
		templates[name] = decorator
	end,

	apply = function(name, target)

		local decorator = templates[name]

		if decorator then
			decorator(target)
		end

	end,

}

ns.templateManager = templateManager
