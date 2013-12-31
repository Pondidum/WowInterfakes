local ns = ...
local should = ns.should

local map = {
	["ScriptObject"] = {},
	["Animation"] = { "ScriptObject", "ParentedObject" },
	["AnimationGroup"] = { "ScriptObject", "ParentedObject" },
	["Frame"] = { "ScriptObject", "VisibleRegion" },
	["UIObject"] = {},
	["ParentedObject"] = { "UIObject" },
	["FontInstance"] = { "UIObject" },
	["ControlPoint"] = { "ParentedObject" },
	["Region"] = { "ParentedObject" },
	["Alpha"] = { "Animation" },
	["Path"] = { "Animation" },
	["Rotation"] = { "Animation" },
	["Scale"] = { "Animation" },
	["Translation"] = { "Animation" },
	["Font"] = { "FontInstance"},
	["FontString"] = { "FontInstance", "LayeredRegion" },
	["EditBox"] = { "Frame", "FontInstance" },
	["MessageFrame"] = { "Frame", "FontInstance" },
	["ScrollingMessageFrame"] = { "Frame", "FontInstance" },
	["VisibleRegion"] = { "Region" },
	["LayeredRegion"] = { "VisibleRegion" },
	["Texture"] = { "LayeredRegion" },
	["ArchaeologyDigSiteFrame"] = { "Frame" },
	["Button"] = { "Frame" },
	["ColorSelect"] = { "Frame" },
	["Cooldown"] = { "Frame" },
	["GameTooltip"] = { "Frame" },
	["Minimap"] = { "Frame" },
	["Model"] = { "Frame" },
	["MovieFrame"] = { "Frame" },
	["QuestPOIFrame"] = { "Frame" },
	["ScenarioPOIFrame"] = { "Frame" },
	["ScrollFrame"] = { "Frame" },
	["SimpleHTML"] = { "Frame" },
	["Slider"] = { "Frame" },
	["StatusBar"] = { "Frame" },
	["CheckButton"] = { "Button" },
	["PlayerModel"] = { "Model"},
	["DressUpModel"] = { "PlayerModel" },
	["TabardModel"] = { "PlayerModel" },
}

ns.tests.add("WidgetMetaBuilder Tests", {
	
	before = function()
		ns.wow.widgetMetaBuilder.init()
	end,

	all_builders_should_extend_the_correct_builders = function()

		local builders = ns.wow.widgetMetaBuilder.listBuilders()

		for widgetName, baseWidgets in pairs(map) do
			
			for i, base in ipairs(baseWidgets) do
				
				local builder = builders[widgetName]

				if builder then
					should.haveValue(base, builder.extends)
				end

			end

		end

	end,
})