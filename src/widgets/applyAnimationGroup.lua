local ns = ...
local builder = ns.builder

ns.builder.addType({
	name = "AnimationGroup",
	extends = { "ScriptObject", "ParentedObject" },
	build = function(target)

		target.Play = function(self)

		end

	end,
})
