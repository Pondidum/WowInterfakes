local ns = ...
local builder = ns.builder

ns.widgetMetaBuilder.addType({
	name = "FontString",
	extends = { "FontInstance", "LayeredRegion" },
	build = function(target)

		target.SetText = function(self, text)
			self.__storage.text = text
		end

	end,

	initInstance = function(target)
		target:SetSize(0, 0)
	end,
})
