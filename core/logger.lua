local ns = ...
local print = print -- incase something re-assigns print (*cough* restrictedInfrastructure.lua *cough*)

local levelMap = {
	debug = 0,
	info = 5,
	warn = 10,
	error = 15,
}

local write = function(self, level, prefix, ...)

	if not self.enabled then
		return
	end

	for i, filter in ipairs(self.filters) do

		if not filter(self, level, prefix, ...) then
			return
		end

	end

	print(string.format("%s: %s:", level, prefix), ...)

end

local logger = {

	enabled = false,
	filters = {},

	addFilter = function(self, filter)

		if filter == nil then
			return
		end

		assert(type(filter) == "function")

		table.insert(self.filters, filter)

	end,

	addFilters = function(self, ...)

		for i, filter in ipairs(...) do
			self.addFilter(self, filter)
		end

	end,

	new = function(self, prefix)

		assert(type(self) == "table", "you must call :new('<name>').")
		assert(prefix ~= nil, "name must not be nil.")
		
		local wrapAndCall = function(t, k) 

			return function(...)
				write(self, k, prefix, ...)
			end

		end

		return setmetatable({}, { __index = wrapAndCall })

	end
	
}

ns.log = logger
