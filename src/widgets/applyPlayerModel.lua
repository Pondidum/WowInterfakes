local ns = ...
local builder = ns.builder
local eventRegistry = ns.eventRegistry

ns.widgetMetaBuilder.addType({
	name = "PlayerModel",
	extends = { "Model" },
	build = function(target)

		target.SetRotation = function(self, facing)
			self.__storage.facing = facing
		end

	end,
})
