local ns = ...
local builder = ns.builder

ns.widgetMetaBuilder.addType({
	name = "FontInstance",
	extends = { "UIObject" },
	build = function(target)

		target.GetFont = function(self)

			local data = self.__storage.font

			if not data then
				return nil
			end

			return data.name, data.height, data.flags

		end

		target.SetSpacing = function(self, spacing)
			self.__storage.spacing = spacing
		end

	end,
})