local ns = ...

local effects = {
	"accuracy",
	"auraabilityid",
	"auraid",
	"basechancetosucceed",
	"bonuspoints",
	"bonusstate",
	"boost",
	"casterimmunestate",
	"casterstate",
	"casterstatevalue",
	"chainfailure",
	"chance",
	"dontmiss",
	"duration",
	"duration2",
	"evenmorepoints",
	"healthpercentage",
	"healthpercentthreshold",
	"increasepertoss",
	"index",
	"isperiodic",
	"lockduration",
	"maxallowed",
	"maxpoints",
	"morepoints",
	"newduration",
	"none",
	"overrideindex",
	"percentage",
	"points",
	"pointsincreaseperuse",
	"pointsmax",
	"reportfailsasimmune",
	"requiredcasterpettype",
	"requiredcasterstate",
	"requiredtargetpettype",
	"requiredtargetstate",
	"state",
	"statechange",
	"statemax",
	"statemin",
	"statepoints",
	"statetomultiplyagainst",
	"statetotriggermaxpoints",
	"statevalue",
	"targetimmunestate",
	"targetstate",
	"targetstatevalue",
	"targetteststate",
	"targetteststatevalue",
	"turnstoadvance",
	"unused",
	"weatherstate",
}

local petBattles = {

	GetAllEffectNames = function()
		return unpack(effects)
	end,

	GetAllStates = function()

	end,
	
}

ns.api.export("C_PetBattles", petBattles)