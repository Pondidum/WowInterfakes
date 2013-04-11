local customise = function(this)

	this.run = function(self, builder, parent, element)
	
		self.buildVariable(element)
		
	end

end

Api.parsers.xml.addTag("FontString", customise)
Api.parsers.xml.addTag("ButtonText", customise)