local ns = ...

ns.widgetMetaBuilder.addType({
	name = "GameTooltip",
	extends = { "Frame" },
	build = function(target)

		target.IsOwned = function(self)
			return self.__storage.owner ~= nil
		end

	end,
})
