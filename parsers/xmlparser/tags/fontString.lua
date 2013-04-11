local customise = function(this)

	this.run = function(parent, element)
	
		this.buildVariable(element)
		
	end

end

Api.parsers.xml.addTag("FontString", customise)
Api.parsers.xml.addTag("ButtonText", customise)