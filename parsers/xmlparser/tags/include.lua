Api.parsers.xml.addTag("Include", function(this) 

	this.processChildren = false
	this.run = function(parent, element, extra)
		
		local fileFragment = element.file

		if not fileFragment then
			return
		end

		local directory = io.path.getDirectory(extra.path)
		local path = io.path.combine(directory, fileFragment)
		local xmlParser = Api.parsers.get(path)
		
		xmlParser(path, addonName, namespace)

	end

end)
