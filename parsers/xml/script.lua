local ns = ...

local tag = {
	processChildren = false,

	build = function(element)

		local decorator = function(target)

			local file = element.file
			

		end	

		return decorator

	end,
}

ns.parsers.xml.addTag("Script", tag)
