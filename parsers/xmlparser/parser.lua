local variableIndex = 0 
local handlerBase = {

	buildName = function(element)
		
		if element.name == nil then
			return "nil"
		end

		if element.name:find("$parent") then
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

		var = var:gsub("-", "")

		element.variable = var
		return var

	end,
}

local handlerMeta = { __index = handlerBase }

local proxy = function(this) 
	this.run = function(parent, element)
		element.variable = parent.variable		
	end
end

local unknown = function(this)
	this.run = function(parent, element)
		Api.log.write("xmlParser", "No handler", string.format("tag: '%s'", element:tag()))
	end
end



local luaFromXml = {
	
	new = function()

		local handlers = {}
		setmetatable(handlers, { __index = function(t, k) return unknown end})
		
		local this = {}

		this.addTag = function(tag, customise)
			handlers[tag] = customise
		end

		this.addProxy = function(tag)
		 	handlers[tag] = proxy
		end

		this.getTag = function(tag)

			local base = { 
				processChildren = true, 
				run = function() end
			}

			local handler = setmetatable(base, handlerMeta)
			local customise = handlers[tag]

			customise(handler)

			return handler

		end


		local recurse
		recurse = function(builder, parent, extra)

			for i, element in ipairs(parent) do

				if not element.tag then
					Api.log.warn("xmlParser", string.format("no tag on '%s'", element))
				else

					local tag = element:tag()
					local handler = this.getTag(tag)

					handler.builder = builder

					handler.run(parent, element, extra)

					if handler.processChildren then
						recurse(builder, element, extra)
					end

				end
				
			end

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

	Api.log.info("xmlParser", "BeginParse", path)

	local xmlFile = xml.load(path)
	local directory = io.path.getDirectory(path)
	
	local extra = { 
		path = path, 
		addonName = addonName, 
		namespace = namespace
	}

	for i, element in ipairs(xmlFile) do

		local luaText = instance.build(element, extra)

		if luaText ~= "" then
			
			Api.log.debug("xmlParser", "Executing Generated Lua", element.name or "")

			local wrapped = "return function()\n\n" .. luaText .. "\n\nend"
			local loadFunc, errorMessage = loadstring(wrapped)

			local cache = io.open(Api.root .. "cache\\" .. io.path.getFilename(path) .. ".lua", "w")
			cache:write(wrapped)
			cache:close()

			if loadFunc == nil then
				Api.log.warn("xmlParser", "Execute", errorMessage)
			end

			local runFunc = loadFunc()
			runFunc()

		end

	end

end


Api.parsers.xml = instance
Api.parsers.add(canHandle, parse)