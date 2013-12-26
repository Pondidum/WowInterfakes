local ns = ...

local store = {}

ns.tests.add("frame creation tests", {
		
	before = function()
		store = {}
		ns.wow.frameRegistry.setStore(store)
	end,

	when_loading_a_non_templated_frame = function()

		print("test")
		local framework = ns.wow.framework
		local content = xml.load('<Frame name="test"></Frame>')

		local sanitised = framework.xmlConverter.parse(content)
		local parser = framework.parsers.xml

		parser.parse("", sanitised)

	end,

})
