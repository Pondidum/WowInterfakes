
local classMap = {}

classMap["DEATHKNIGHT"] = { male = "Death Knight", 	female = "Death Knight" }
classMap["DRUID"] 		= { male = "Druid", 		female = "Druid" }
classMap["HUNTER"] 		= { male = "Hunter", 		female = "Hunter" }
classMap["MAGE"] 		= { male = "Mage", 			female = "Mage" }
classMap["MONK"] 		= { male = "Monk", 			female = "Monk" }
classMap["PALADIN"] 	= { male = "Paladin", 		female = "Paladin" }
classMap["PRIEST"] 		= { male = "Priest", 		female = "Priest" }
classMap["ROGUE"] 		= { male = "Rogue", 		female = "Rogue" }
classMap["SHAMAN"] 		= { male = "Shaman", 		female = "Shaman" }
classMap["WARLOCK"] 	= { male = "Warlock", 		female = "Warlock" }
classMap["WARRIOR"] 	= { male = "Warrior", 		female = "Warrior" }

local fillList = function(table, female)
	
	local key = "male"

	if female then 
		key = "female" 
	end

	for tag, pair in pairs(classMap) do
		table[tag] = pair[key]
	end
		
end

Api.export("FillLocalizedClassList", fillList)