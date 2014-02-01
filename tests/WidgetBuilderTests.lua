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
		ns.wow.builder.init()
	end,

	all_builders_should_extend_the_correct_builders = function()

		local builders = ns.wow.builder.listBuilders()

		for widgetName, baseWidgets in pairs(map) do
			
			for i, base in ipairs(baseWidgets) do
				
				local builder = builders[widgetName]

				if builder then
					should.haveValue(base, builder.extends)
				end

			end

		end

	end,

	when_a_meta_is_built_the_constructors_should_get_chained = function()

		local firstCtor = 0
		local secondCtor = 0
		local thirdCtor = 0

		local first = { name = "First", initInstance = function(target) firstCtor = firstCtor + 1 end, }
		local second = { name = "Second", initInstance = function(target) secondCtor = secondCtor + 1 end, }
		local third = { name = "Third", extends = { "First", "Second" }, initInstance = function(target) thirdCtor = thirdCtor + 1 end, }

		local builder = ns.wow.widgetBuilder.new()

		builder.addType(first)
		builder.addType(second)
		builder.addType(third)

		builder.init()

		local meta = builder.getInitialiser("Third")
		meta({})

		should.equal(1, firstCtor, "Expected the first ctor to be called %s time, but was called %s times.")
		should.equal(1, secondCtor, "Expected the second ctor to be called %s time, but was called %s times.")
		should.equal(1, thirdCtor, "Expected the third ctor to be called %s time, but was called %s times.")

	end,

})
