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

		local instanceRan = 0
		local templateRan = 0

		function InstanceExec(self)
			instanceRan = instanceRan + 1
		end

		function TemplateExec(self)
			templateRan = templateRan + 1
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

		should.equal(1, instanceRan, "The instance script should have run %s times, but ran %s times.")
		should.equal(0, templateRan, "The template script should have run %s times, but ran %s times.")

	end,

	template_with_onload_child_with_nothing = function()

		local templateRan = 0

		function TemplateExec(self)
			templateRan = templateRan + 1
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

		should.equal(1, templateRan, "The template script should have run %s times, but ran %s times.")

	end,

	template_with_nothing_child_with_onload = function()

		local instanceRan = 0

		function InstanceExec(self)
			instanceRan = instanceRan + 1
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

		should.equal(1, instanceRan, "The instance script should have run %s times, but ran %s times.")

	end,

	frame_with_onload_and_no_template = function()

		local instanceRan = 0

		function InstanceExec(self)
			instanceRan = instanceRan + 1
		end

		parseXml([[
			<Frame name="ScriptInheritanceInstance">
				<Scripts>
					<OnLoad function="InstanceExec">
				</Scripts>
			</Frame>
		]])

		should.equal(1, instanceRan, "The instance script should have run %s times, but ran %s times.")

	end,

	create_frame_should_run_template_onload = function()

		local templateRan = 0

		function TemplateExec(self)
			templateRan = templateRan + 1
		end

		parseXml([[
			<Frame name="ScriptInheritanceTemplate" virtual="true">
				<Scripts>
					<OnLoad function="TemplateExec">
				</Scripts>
			</Frame>
		]])

		local f = CreateFrame("Frame", "ScriptInheritanceInstance", nil, "ScriptInheritanceTemplate")

		should.equal(1, templateRan, "The template script should have run %s times, but ran %s times.")

	end,

})
