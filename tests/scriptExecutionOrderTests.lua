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

	when_creating_a_frame_onload_scripts_should_override_base_onload = function()

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
					<OnLoad function="TemplateExec">
				</Scripts>
			</Frame>

			<Frame name="ScriptInheritanceInstance" inherits="ScriptInheritanceTemplate">
				<Scripts>
					<OnLoad function="InstanceExec">
				</Scripts>
			</Frame>
		]])

		should.beTrue(instanceRan, "The instance script didn't run, it should have.")
		should.beFalse(templateRan, "The template script ran, it shouldn't have.")

	end,

	when_creating_a_frame_template_onload_should_run_if_there_is_no_child_onload = function()

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

		should.beFalse(templateRan, "The template script didn't run, it should have.")

	end,

	when_creating_a_frame_instance_onload_should_run_if_no_template_onload = function()

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

	when_creating_a_frame_instance_onload_should_run_if_no_template = function()

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

})
