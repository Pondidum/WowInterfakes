local ns = ...
local should = ns.should

local store = {}

local parseXml = function(input)

	local framework = ns.wow

	local content = xml.eval("<Ui>" .. input .. "</Ui>")
	local sanitised = framework.xmlConverter.parse(content)

	framework.parsers.xml.parse("", sanitised)

end

ns.tests.add("frame creation tests", {

	before = function()
		store = {}
		ns.wow.frameRegistry.setStore(store)
	end,

	when_loading_a_non_templated_frame = function()

		parseXml('<Frame name="Test"></Frame>')

		should.haveKey("Test", store)
		should.haveCount(1, store)

	end,

	when_loading_a_frame_with_a_child = function()

		parseXml([[
			<Frame name="Test">
				<Frames>
					<Frame name="$parentChild"></Frame>
				</Frames>
			</Frame>
		]])

		should.haveKey("Test", store)
		should.haveKey("TestChild", store)
		should.haveCount(2, store)

	end,

})
