local variableIndex = 0 
local handlerBase = {
			
	processChildren = true,

	run = function(self, builder, parent, element)
	end,

	buildName = function(element)
		
		if element.name == nil then
			return "nil"
		elseif element.name:find("$parent") then
			return string.format('"%s%s"',  element.variable, element.name:gsub("$parent", ""))
		else
			return string.format('"%s"', element.name)
		end

	end,

	
	buildVariable = function(element)
		
		local var

		if element.name then
			var = string.lower(element:tag()) .. element.name:gsub("$parent", "")
		else
			variableIndex = variableIndex + 1
			var = string.lower(element:tag()) .. variableIndex
		end

		element.variable = var
		return var

	end,
}

local handlerMeta = { __index = handlerBase }

local unknownTagHandler = {
	run = function(self, builder, parent, element)
		--Api.debug.write("xmlParser", string.format("No handler defined for tag '%s'", element:tag()))
	end,
}

local proxyHandler = {
	run = function(self, builder, parent, element)
		element.variable = parent.variable
	end,
}


local luaFromXml = {
	
	new = function()

		local handlers = setmetatable({}, { __index = function(t, k) return unknownTagHandler end})
		local recurse

		recurse = function(builder, parent, extra)

			for i, element in ipairs(parent) do

				if not element.tag then
					Api.debug.write("xmlParser", string.format("no tag on '%s'", element))
				end

				local tag = element:tag()
				local handler = handlers[tag]

				handler:run(builder, parent, element, extra)

				if handler.processChildren then
					recurse(builder, element, extra)
				end

			end

		end

		local this = {}
		local proxy = setmetatable(proxyHandler, handlerMeta)

		this.addTag = function(tag, handler)
			handlers[tag] = setmetatable(handler, handlerMeta)
		end

		this.addProxy = function(tag)
			handlers[tag] = proxy
		end

		this.build = function(template, extra)

			local builder = Api.stringBuilder.new()

			recurse(builder, {template}, extra)

			return builder.toString()

		end

		return this 

	end,
	
}


local instance = luaFromXml.new()

local canHandle = function(path)
	return string.sub(path, #path - 2) == "xml"
end

local parse = function(path, addonName, namespace)

	Api.debug.write("xmlParser", "BeginParse", path)

	local xmlFile = xml.load(path)
	local directory = io.path.getDirectory(path)
	
	local extra = { 
		path = path, 
		addonName = addonName, 
		namespace = namespace
	}

	for i, element in ipairs(xmlFile) do

		instance.build(element, extra)

	end

end


Api.parsers.xml = instance
Api.parsers.add(canHandle, parse)