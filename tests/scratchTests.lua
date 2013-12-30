local ns = ...
local should = ns.should

local store = {}

ns.tests.add("scratch tests", {

	before = function()
		store = {}
		ns.wow.frameRegistry.setStore(store)
	end,

	scratch = function()

	end,

})
