local ns = ...

local registerStaticConstants = function()
	LE_LFG_CATEGORY_LFD = 1
	LE_LFG_CATEGORY_LFR = 2
	LE_LFG_CATEGORY_RF = 3
	LE_LFG_CATEGORY_SCENARIO = 4

	NUM_LE_LFG_CATEGORYS = 4		--? needs to be checked in wow
	NUM_LE_RAID_BUFF_TYPES = 8
end

ns.api.export("RegisterStaticConstants", registerStaticConstants)
