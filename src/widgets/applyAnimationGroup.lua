local ns = ...
local builder = ns.builder

ns.widgetMetaBuilder.addType({
	name = "AnimationGroup",
	extends = { "ScriptObject", "ParentedObject" },
	build = function(target)

		target.Play = function(self)

		end

	end,
})
