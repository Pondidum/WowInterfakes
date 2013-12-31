local ns = ...
local log = ns.log:new("widgetMetaBuilder")

local typeBuilders = {}
local metas = {}

local function recurseTypes(builder, target)

	builder.build(target)

	for i, builderName in ipairs(builder.extends) do

		local subBuilder = typeBuilders[builderName]

		recurseTypes(subBuilder, target)

	end

end

local builder = {

	addType = function(config)
		typeBuilders[config.name] = config
	end,

	init = function()

		metas = {}

		for name, builder in pairs(typeBuilders) do

			local target = {}

			recurseTypes(builder, target)

			metas[string.lower(name)] = { __index = target }

		end

	end,

	get = function(type)
		return metas[string.lower(type)]
	end,

	listBuilders = function()
		return typeBuilders
	end,

	listMetas = function()
		return metas
	end,

}

ns.widgetMetaBuilder = builder
