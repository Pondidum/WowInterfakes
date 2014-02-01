local ns = ...
local log = ns.log:new("widgetBuilder")


local baseConfig = {
	name = "",
	extends = { },
	build = function(target) end,
	initInstance = function(target) end,
}

local widgetBuilder = {

	new = function()

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

		local builder = {}

		builder.addType = function(config)
			typeBuilders[config.name] = setmetatable(config, { __index = baseConfig })
		end

		builder.init = function()

			metas = {}
			initialisers = {}

			for name, builder in pairs(typeBuilders) do

				local target = {}
				local name = string.lower(name)

				recurseTypes(builder, target)

				metas[name] = { __index = target }
				initialisers[name] = builder.initInstance

			end

		end

		builder.get = function(type)
			return metas[string.lower(type)]
		end

		builder.getInitialiser = function(type)
			return initialisers[string.lower(type)]
		end

		builder.listBuilders = function()
			return typeBuilders
		end

		builder.listMetas = function()
			return metas
		end

		return builder

	end,
}



ns.widgetBuilder = widgetBuilder
