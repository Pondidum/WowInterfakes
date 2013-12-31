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

		for name, builder in pairs(typeBuilders) do
			
			local target = {}

			recurseTypes(builder, target)

			metas[name] = { __index = target }

		end

	end,

	get = function(type)
		return metas[type]
	end,

}

ns.widgetMetaBuilder = builder
