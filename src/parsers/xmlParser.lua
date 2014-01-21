local ns = ...
local log = ns.log:new("xmlParser")

local decoratorData = {

	new = function(self, config)

		return setmetatable(config, { __index = self })

	end,
	tag = "",
	stepOut = false,
	file = {},
	element = ns.xmlConverter.newElement(),
	build = function() end,
}

local tagNotFound = function(t, k)
	return t.__default
end

local tags = setmetatable({}, { __index = tagNotFound })

local xmlParser = {

	addTag = function(name, tag)
		tags[name] = tag
	end,

	getTag = function(name)
		return tags[name]
	end,

	parse = function(root, xmlTable)

		local isVirtual = function(element)
			--check name doesnt contain $parent due to blizzard bug #4
			return element.attributes.virtual == "true" and not element.attributes.name:find("$parent")
		end

		-- args object, may get expanded later
		local file = {
			root = root
		}

		local function recurseTree(parent, chain)

			local currentChain = chain
			local virtual = isVirtual(parent)


			if virtual then
				currentChain = {}
			end

			if not parent.tag then
				log.warn("No Tag on", parent)
			else

				local tag = parent.tag
				local handler = tags[tag]

				local data = decoratorData:new({
					tag = tag,
					file = file,
					element = parent,
					build = function(...)
						return handler:build(...)
					end,
				})

				table.insert(currentChain, data)

				if handler.processChildren and #parent.elements > 0 then

					for i, element in ipairs(parent.elements) do
						recurseTree(element, currentChain)
					end

				end

				if handler.createsElement then
					table.insert(currentChain, decoratorData:new({
						stepOut = true,
						build = function(file, element, target)

							if virtual then
								return
							end

							if target.finalize then
								target.finalize()
								target.finalize = nil
							end

						end,
					}))
				end

			end

			if virtual then
				ns.templateManager.addTemplate(parent.attributes.name, currentChain)
			end

		end

		log.debug("building chain")

		local handlerChain = {}
		recurseTree(xmlTable, handlerChain)

		log.debug("executing chain")

		local stack = ns.stack.new()

		for i, handler in ipairs(handlerChain) do

			local result = handler.build(handler.file, handler.element, stack.tip())

			if result then
				stack.push(result)
			elseif handler.stepOut then
				stack.pop()
			end

		end

	end,

}

ns.parsers.xml = xmlParser
