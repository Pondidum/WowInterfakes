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

		local content = xml.eval([[<Frame></Frame>]])
		local sanitised = ns.wow.xmlConverter.parse(content)

		should.beEmpty(sanitised.elements)
		should.equal("Frame", sanitised.tag)

	end,

	when_parsting_single_element_with_a_single_child = function()

		local content = xml.eval([[<Frame><Script></Script></Frame>]])
		local sanitised = ns.wow.xmlConverter.parse(content)

		should.haveCount(1, sanitised.elements)
		should.equal("Frame", sanitised.tag)

	end,

	when_parsing_a_single_element_with_two_children = function()

		local content = xml.eval([[<Ui><Frame name="One"></Frame><Frame name="Two"></Frame></Ui>]])
		local sanitised = ns.wow.xmlConverter.parse(content)

		should.haveCount(2, sanitised.elements)
		should.equal("Ui", sanitised.tag)
		should.equal("One", sanitised.elements[1].attributes.name)
		should.equal("Two", sanitised.elements[2].attributes.name)

	end,

	when_parsing_problem_xml = function()

		local input = [[
			<Frame name="ScriptInheritanceTemplate" virtual="true">
			</Frame>

			<Frame name="ScriptInheritanceInstance" inherits="ScriptInheritanceTemplate">
				<Scripts>
					<OnLoad function="InstanceExec">
				</Scripts>
			</Frame>
		]]

		local content = xml.eval("<Ui>" .. input .. "</Ui>")
		local sanitised = ns.wow.xmlConverter.parse(content)

		should.haveCount(2, sanitised.elements)
		should.equal("Ui", sanitised.tag)
		should.equal("ScriptInheritanceTemplate", sanitised.elements[1].attributes.name)
		should.equal("ScriptInheritanceInstance", sanitised.elements[2].attributes.name)

	end,

})
