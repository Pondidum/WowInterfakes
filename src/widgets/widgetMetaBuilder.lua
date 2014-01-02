local ns = ...
local log = ns.log:new("widgetMetaBuilder")

local typeBuilders = {}
local metas = {}
local initialisers = {}

local function recurseTypes(builder, target)

	builder.build(target)

	for i, builderName in ipairs(builder.extends) do

		local subBuilder = typeBuilders[builderName]

		recurseTypes(subBuilder, target)

	end

end

local baseConfig = {
	name = "",
	extends = { },
	build = function(target)
	end,
	initInstance = function(target)
	end,
}

local builder = {

	addType = function(config)

		setmetatable(config, { __index = baseConfig })

		typeBuilders[config.name] = config

	end,

	init = function()

		metas = {}
		initialisers = {}

		for name, builder in pairs(typeBuilders) do

			local target = {}
			local name = string.lower(name)

			recurseTypes(builder, target)

			metas[name] = { __index = target }
			initialisers[name] = builder.initInstance

		end

	end,

	get = function(type)
		return metas[string.lower(type)]
	end,

	getInitialiser = function(type)
		return initialisers[string.lower(type)]
	end,

	listBuilders = function()
		return typeBuilders
	end,

	listMetas = function()
		return metas
	end,

}

ns.widgetMetaBuilder = builder
