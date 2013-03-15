
local spellData = {}

spellData[115798] = { Name = "Weakened Blows" }





local getSpellInfo = function(id)
	
	local spell = spellData[id]

	return spell.Name

end

Api.export("GetSpellInfo", getSpellInfo)
