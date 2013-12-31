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

	end,
})
