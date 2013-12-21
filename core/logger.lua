local ns = ...
local print = print -- incase something re-assigns print (*cough* restrictedInfrastructure.lua *cough*)

local write = function(config, level, prefix, ...)

	if not config.enabled then
		return
	end

	for i, filter in ipairs(config.filters) do

		if not filter(config, level, prefix, ...) then
			return
		end

	end

	print(string.format("%s: %s:", level, prefix), ...)

end

local filterBuilders = {}

local logFactory = {

	config = {

		filters = {},
		level = "debug",

		addFilter = function(self, filter)
			table.insert(self.filters, filter)
		end,

		addFilters = function(self, ...)

			for i, filter in ipairs({...}) do
				self:addFilter(filter)
			end
		end,

	},

	filterFactory = {

		register = function(name, filterBuilder)

			assert(name ~= nil, "filter names must not be nil.")
			assert(type(filterBuilder) == "function", "filter builders must be functions.")

			filterBuilders[string.lower(name)] = filterBuilder

		end,

		new = function(name, args)

			assert(name ~= nil, "you must specifiy a builder name")

			local builder = filterBuilders[string.lower(name)]

			assert(builder, "No builder found called " .. name)

			local filter = builder(args)

			return filter

		end,

	},

	new = function(self, prefix)

		assert(type(self) == "table", "you must call :new('<name>').")
		assert(prefix ~= nil, "name must not be nil.")
		
		local wrapAndCall = function(t, k) 

			return function(...)
				write(self.config, k, prefix, ...)
			end

		end

		return setmetatable({}, { __index = wrapAndCall })

	end,
}

--setup some defaults:

logFactory.filterFactory.register("level", function(args)

	local levels = {
		debug = 0,
		info = 5,
		warn = 10,
		error = 15,
	}

	local filter = function(config, level, prefix, ...)
		return levels[level] >= levels[config.level]
	end

	return filter

end)

logFactory.filterFactory.register("whitelist", function(args)

	local list = {}

	for i,v in ipairs(args) do
		list[v] = true
	end

	return function(config, level, prefix, ...)
		return list[prefix]
	end

end)

logFactory.filterFactory.register("blacklist", function(args)

	local list = {}

	for i,v in ipairs(args) do
		list[v] = true
	end

	return function(config, level, prefix, ...)
		return not list[prefix]
	end

end)


logFactory.config:addFilter(logFactory.filterFactory.new("level"))

ns.log = logFactory
