local ns = ...

local resolutions = {
	"800x600",
	"1024x768",
	"1920x1080",
	"1920x1200",
}

local getScreenResolutions = function()
	return unpack(resolutions)
end

ns.api.export("GetScreenResolutions", getScreenResolutions)
