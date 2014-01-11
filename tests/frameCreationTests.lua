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

	when_loading_a_frame_with_no_children_and_a_blank_template = function()

		parseXml([[
			<Frame name="TestTemplate" virtual="true">
			</Frame>

			<Frame name="Test" inherits="TestTemplate">
			</Frame>
		]])

		should.haveKey("Test", store)
		should.haveCount(1, store)

	end,

	when_loading_a_frame_with_a_child_and_a_blank_template = function()

		parseXml([[
			<Frame name="TestTemplate" virtual="true">
			</Frame>

			<Frame name="Test" inherits="TestTemplate">
				<Frames>
					<Frame name="$parentChild"></Frame>
				</Frames>
			</Frame>
		]])

		should.haveKey("Test", store)
		should.haveKey("TestChild", store)
		should.haveCount(2, store)

	end,

	when_loading_a_frame_with_no_children_and_a_template_with_a_child = function()

		parseXml([[
			<Frame name="TestTemplate" virtual="true">
				<Frames>
					<Frame name="$parentTemplateChild"></Frame>
				</Frames>
			</Frame>

			<Frame name="Test" inherits="TestTemplate">
			</Frame>
		]])

		should.haveKey("Test", store)
		should.haveKey("TestTemplateChild", store)
		should.haveCount(2, store)

	end,

	when_loading_a_frame_with_a_child_and_a_template_with_a_child = function()

		parseXml([[
			<Frame name="TestTemplate" virtual="true">
				<Frames>
					<Frame name="$parentTemplateChild"></Frame>
				</Frames>
			</Frame>

			<Frame name="Test" inherits="TestTemplate">
				<Frames>
					<Frame name="$parentChild"></Frame>
				</Frames>
			</Frame>
		]])

		should.haveKey("Test", store)
		should.haveKey("TestChild", store)
		should.haveKey("TestTemplateChild", store)
		should.haveCount(3, store)

	end,

	when_loading_a_frame_with_a_template_with_a_sub_template_all_with_children = function()

		parseXml([[
			<Frame name="TestSubTemplate" virtual="true">
				<Frames>
					<Frame name="$parentSubTemplateChild"></Frame>
				</Frames>
			</Frame>

			<Frame name="TestTemplate" virtual="true" inherits="TestSubTemplate">
				<Frames>
					<Frame name="$parentTemplateChild"></Frame>
				</Frames>
			</Frame>

			<Frame name="Test" inherits="TestTemplate">
				<Frames>
					<Frame name="$parentChild"></Frame>
				</Frames>
			</Frame>
		]])

		should.haveKey("Test", store)
		should.haveKey("TestChild", store)
		should.haveKey("TestTemplateChild", store)
		should.haveKey("TestSubTemplateChild", store)
		should.haveCount(4, store)

	end,

	when_loading_a_frame_with_a_child_and_the_child_has_a_template = function()

		local content = xml.eval([[
			<Ui>

				<Button name="UIDropDownMenuButtonTemplate" virtual="true">
					<Scripts>
						<OnLoad>
							local x = 1
						</OnLoad>
					</Scripts>
				</Button>

				<Button name="UIDropDownListTemplate" virtual="true">
					<Frames>
						<Button name="$parentButton1" inherits="UIDropDownMenuButtonTemplate" />
					</Frames>
				</Button>


				<Button name="DropDownList1" inherits="UIDropDownListTemplate">
				</Button>

			</Ui>
		]])

		local sanitised = ns.wow.xmlConverter.parse(content)
		local parser = ns.wow.parsers.xml

		parser.parse("", sanitised)

		should.haveKey("DropDownList1", store)
		should.haveKey("DropDownList1Button1", store)
		should.notBeNil(store["DropDownList1Button1"]:GetScript("OnLoad"))
		should.beNil(store["DropDownList1"]:GetScript("OnLoad"))
		should.haveCount(2, store)

	end,

	when_creating_a_frame_scripts_should_be_parsed_last = function()

		function OptionsListButton_OnLoad (self)
			self.text = store["ScriptTestFrameText"];
		end

		parseXml([[
			<Button name="ScriptTestFrame">
				<Scripts>
					<OnLoad>
						OptionsListButton_OnLoad(self);
					</OnLoad>
				</Scripts>
				<ButtonText name="$parentText" justifyH="LEFT" />
			</Button>
		]])

		should.haveKey("ScriptTestFrame", store)
		should.haveKey("ScriptTestFrameText", store)
		should.notBeNil(store["ScriptTestFrame"].text)

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
})
