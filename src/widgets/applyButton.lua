local ns = ...
local builder = ns.builder
local eventRegistry = ns.eventRegistry

ns.widgetMetaBuilder.addType({
	name = "Button",
	extends = { "Frame" },
	build = function(target)

		target.IsEnabled = function(self)
			return self.__storage.isEnabled
		end

		target.RegisterForClicks = function(self, ...)

			local allowed  = {}

			if ... ~= nil then

				for i,v in ipairs({...}) do
					allowed[v] = true
				end

			end

			self.__storage.clicks = allowed

		end

	end,
})
