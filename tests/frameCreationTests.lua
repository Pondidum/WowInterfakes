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

	when_anchoring_frames_on_creation = function()

		parseXml([[
			<Frame name="ExampleButtonFrame">
				<Frames>
					<Button name="ExampleButtonFrameBtn1">
						<Anchors>
							<Anchor point="BOTTOMRIGHT" />
						</Anchors>
					</Button>
					<Button name="ExampleButtonFrameBtn2">
						<Anchors>
							<Anchor point="TOPRIGHT" relativeTo="ExampleButtonFrameBtn1" relativePoint="TOPLEFT" />
						</Anchors>
					</Button>
				</Frames>
			</Frame>
		]])

		local button1 = store["ExampleButtonFrameBtn1"]
		local button2 = store["ExampleButtonFrameBtn2"]

		local point, relativeTo, relativePoint, offsetX, offsetY = button2:GetPoint(1)

		should.equal(button1, relativeTo)

	end,

	when_creating_a_frame_hierarchy = function()

		parseXml([[
			<Frame name="UltimateParent">
				<Frames>
					<Frame name="ParentFrame">
						<Frames>
							<Frame name="ChildOne">
							</Frame>
							<Frame name="ChildTwo">
							</Frame>
						</Frames>
					</Frame>
				</Frames>
			</Frame>
		]])

		local ultimate = store["UltimateParent"]
		local parent = store["ParentFrame"]
		local child1 = store["ChildOne"]
		local child2 = store["ChildTwo"]

		should.equal(ultimate, parent:GetParent())
		should.equal(parent, child1:GetParent())
		should.equal(parent, child2:GetParent())
		should.equal(ultimate, child1:GetParent():GetParent())
		should.equal(ultimate, child2:GetParent():GetParent())

	end,

	when_creating_a_complex_hierarchy = function()

		parseXml([[
			<Frame name="AudioOptionsVoicePanel">
				<Frames>
					<Frame name="$parentChatMode1">
						<Frames>
							<Button name="$parentKeyBindingButton">
							</Button>
							<CheckButton name="AudioOptionsVoicePanelPushToTalkSound">
							</CheckButton>
						</Frames>
					</Frame>
				</Frames>
			</Frame>
		]])


		should.haveKey("AudioOptionsVoicePanel", store)
		should.haveKey("AudioOptionsVoicePanelChatMode1", store)
		should.haveKey("AudioOptionsVoicePanelChatMode1KeyBindingButton", store)
		should.haveKey("AudioOptionsVoicePanelPushToTalkSound", store)

		local check = store["AudioOptionsVoicePanelPushToTalkSound"]

		should.notBeNil(check:GetParent(), "Grandchild element should not have a nil parent.")
		should.notBeNil(check:GetParent():GetParent(), "Grandchild element should not have a nil GrandParent.")

	end,
})
