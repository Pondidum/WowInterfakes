local ns = ...
local should = ns.should

local store = {}

local parseXml = function(input)

	local framework = ns.wow

	local content = xml.eval("<Ui>" .. input .. "</Ui>")
	local sanitised = framework.xmlConverter.parse(content)

	framework.parsers.xml.parse("", sanitised)

end

ns.tests.add("script execution order tests", {

	before = function()
		store = {}
		ns.wow.frameRegistry.setStore(store)
	end,

	template_with_onload_child_with_onload = function()

		local instanceRan = false
		local templateRan = false

		function InstanceExec(self)
			instanceRan = true
		end

		function TemplateExec(self)
			templateRan = true
		end

		parseXml([[
			<Frame name="ScriptInheritanceTemplate" virtual="true">
				<Scripts>
					<OnLoad>
						TemplateExec(self)
					</OnLoad>
				</Scripts>
			</Frame>

			<Frame name="ScriptInheritanceInstance" inherits="ScriptInheritanceTemplate">
				<Scripts>
					<OnLoad>
						InstanceExec(self)
					</OnLoad>
				</Scripts>
			</Frame>
		]])

		should.beTrue(instanceRan, "The instance script didn't run, it should have.")
		should.beFalse(templateRan, "The template script ran, it shouldn't have.")

	end,

	template_with_onload_child_with_nothing = function()

		local templateRan = false

		function TemplateExec(self)
			templateRan = true
		end

		parseXml([[
			<Frame name="ScriptInheritanceTemplate" virtual="true">
				<Scripts>
					<OnLoad function="TemplateExec">
				</Scripts>
			</Frame>

			<Frame name="ScriptInheritanceInstance" inherits="ScriptInheritanceTemplate">
			</Frame>
		]])

		should.beTrue(templateRan, "The template script didn't run, it should have.")

	end,

	template_with_nothing_child_with_onload = function()

		local instanceRan = false

		function InstanceExec(self)
			instanceRan = true
		end

		parseXml([[
			<Frame name="ScriptInheritanceTemplate" virtual="true">
			</Frame>

			<Frame name="ScriptInheritanceInstance" inherits="ScriptInheritanceTemplate">
				<Scripts>
					<OnLoad function="InstanceExec">
				</Scripts>
			</Frame>
		]])

		should.beTrue(instanceRan, "The instance script didn't run, it should have.")

	end,

	frame_with_onload_and_no_template = function()

		local instanceRan = false

		function InstanceExec(self)
			instanceRan = true
		end

		parseXml([[
			<Frame name="ScriptInheritanceInstance">
				<Scripts>
					<OnLoad function="InstanceExec">
				</Scripts>
			</Frame>
		]])

		should.beTrue(instanceRan, "The instance script didn't run, it should have.")

	end,

	create_frame_should_run_template_onload = function()

		local templateRan = false

		function TemplateExec(self)
			templateRan = true
		end

		parseXml([[
			<Frame name="ScriptInheritanceTemplate" virtual="true">
				<Scripts>
					<OnLoad function="TemplateExec">
				</Scripts>
			</Frame>
		]])

		local f = CreateFrame("Frame", "ScriptInheritanceInstance", nil, "ScriptInheritanceTemplate")

		should.beTrue(templateRan, "The template script didn't run, it should have.")

	end,

})
