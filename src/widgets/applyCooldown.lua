local ns = ...

ns.builder.addType({
	name = "Cooldown",
	extends = { "Frame" },
	build = function(target)

		target.SetCooldown = function(self, start, duration)
			self.__storage.start = start
			self.__storage.duration = duration
		end

	end,
})
