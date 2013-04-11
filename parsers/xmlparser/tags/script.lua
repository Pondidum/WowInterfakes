Api.parsers.xml.addTag("Script", function(this) 

	this.processChildren = false
	this.run = function(self, builder, parent, element, extra)
		
		local fileFragment = element.file

		if not fileFragment then
			return
		end

		local directory = io.path.getDirectory(extra.path)
		local path = io.path.combine(directory, fileFragment)
		local fileParser = Api.parsers.get(path)
		
		--fileParser(path, addonName, namespace)

	end

end)
