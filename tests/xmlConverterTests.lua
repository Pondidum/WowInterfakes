local ns = ...
local should = ns.should

local store = {}

local parseXml = function(input)

	local framework = ns.wow

	local content = xml.eval("<Ui>" .. input .. "</Ui>")
	local sanitised = framework.xmlConverter.parse(content)

	framework.parsers.xml.parse("", sanitised)

end

ns.tests.add("xml converter tests", {

	when_parsing_single_element_with_no_children = function()

	end,

	when_parsting_single_element_with_a_single_child = function()

	end,

	when_parsing_a_single_element_with_two_children = function()

	end,

})
