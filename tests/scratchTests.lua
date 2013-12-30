local ns = ...
local should = ns.should

local store = {}

ns.tests.add("scratch tests", {

	before = function()
		store = {}
		ns.wow.frameRegistry.setStore(store)
	end,

	scratch = function()

		local content = xml.eval([[
			<Ui>

				<Button name="UIDropDownMenuButtonTemplate" virtual="true">
					<Scripts>
						<OnLoad>	
							print("UIDropDownMenuButtonTemplate", self:GetName(), self:GetParent())
							self:SetFrameLevel(self:GetParent():GetFrameLevel()+2);
						</OnLoad>
					</Scripts>

					<ButtonText name="$parentNormalText">
						<Anchors>
							<Anchor point="LEFT">
								<Offset x="-5" y="0"/>
							</Anchor>
						</Anchors>
					</ButtonText>

				</Button>

				<Button name="UIDropDownListTemplate" virtual="true">
					<Frames>

						<Frame name="$parentBackdrop">
							<Backdrop bgFile="Interface\DialogFrame\UI-DialogBox-Background-Dark" edgeFile="Interface\DialogFrame\UI-DialogBox-Border" tile="true">
							</Backdrop>
						</Frame>
						
						<Frame name="$parentMenuBackdrop">
							<Backdrop bgFile="Interface\Tooltips\UI-Tooltip-Background" edgeFile="Interface\Tooltips\UI-Tooltip-Border" tile="true">
							</Backdrop>
							<Scripts>
								<OnLoad>
									print("MenuBackdrop", self:GetName())
								</OnLoad>
							</Scripts>
						</Frame>

						<Button name="$parentButton1" inherits="UIDropDownMenuButtonTemplate" id="1"/>

					</Frames>
				</Button>


				<Button name="DropDownList1" inherits="UIDropDownListTemplate" hidden="true">
					<Scripts>
						<OnLoad>
							print("DropDownList1", self:GetName(), _G["DropDownList1Button1NormalText"])
						</OnLoad>
					</Scripts>
				</Button>

			</Ui>
		]])

		local sanitised = ns.wow.xmlConverter.parse(content)
		local parser = ns.wow.parsers.xml

		parser.parse("", sanitised)

	end,

})
