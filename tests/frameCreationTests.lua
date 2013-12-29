local ns = ...
local should = ns.should

local store = {}

ns.tests.add("frame creation tests", {
		
	before = function()
		store = {}
		ns.wow.frameRegistry.setStore(store)
	end,

	when_loading_a_non_templated_frame = function()

		local framework = ns.wow
		local content = xml.eval('<Ui><Frame name="test"></Frame></Ui>')

		local sanitised = framework.xmlConverter.parse(content)
		local parser = framework.parsers.xml

		parser.parse("", sanitised)

		should.haveKey("test", store)
		should.haveCount(1, store)

	end,

})
