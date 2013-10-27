local customise = function(this) 

	this.processChildren = false

end

Api.parsers.xml.addTag("Font", customise)
Api.parsers.xml.addTag("HighlightFont", customise)
Api.parsers.xml.addTag("NormalFont", customise)
Api.parsers.xml.addTag("DisabledFont", customise)
