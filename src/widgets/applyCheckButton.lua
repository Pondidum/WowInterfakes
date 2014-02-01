local ns = ...
local builder = ns.builder
local eventRegistry = ns.eventRegistry

ns.builder.addType({
	name = "CheckButton",
	extends = { "Button" },
	build = function(target)

		target.SetChecked = function(self, enable)
			self.__storage.checked = enable
		end

		target.GetChecked = function(self)
			return self.__storage.checked
		end

	end,
})
