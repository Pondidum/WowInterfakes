local ns = ...
local builder = ns.builder
local eventRegistry = ns.eventRegistry

ns.builder.addType({
	name = "PlayerModel",
	extends = { "Model" },
	build = function(target)

		target.SetRotation = function(self, facing)
			self.__storage.facing = facing
		end

		target.SetPortraitZoom = function(self, value)
			self.__storage.zoom = value
		end

	end,
})
