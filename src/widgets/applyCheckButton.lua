local ns = ...
local builder = ns.builder
local eventRegistry = ns.eventRegistry

ns.widgetMetaBuilder.addType({
	name = "CheckButton",
	extends = { "Button" },
	build = function(target)

		target.SetChecked = function(self, enable)
			self.__storage.checked = enable
		end

	end,
})