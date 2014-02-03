local ns = ...

ns.builder.addType({
	name = "GameTooltip",
	extends = { "Frame" },
	build = function(target)

		target.IsOwned = function(self)
			return self.__storage.owner ~= nil
		end

		target.GetOwner = function(self)
			return self.__storage.owner
		end

	end,
})
