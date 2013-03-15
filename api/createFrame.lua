local makeRegion = function()
	
	local region = {}
	local width, height = 0, 0

	region.GetWidth = function(self)
		return width
	end

	region.GetHeight = function(self)
		return height
	end

	region.SetWidth = function(self, value)
		width = value
	end

	region.SetHeight = function(self, value)
		height = value
	end

	region.SetSize = function(self, w, h)
		width = w
		height = h
	end

	region.SetPoint = function(self, anchor, other, otherAnchor, x, y) end
	region.SetAllPoints = function(self, value) end
	region.ClearAllPoints = function(self, value) end

	return region 

end

local makeVisibleRegion = function()
	
	local region = makeRegion()

	local alpha, visible

	region.GetAlpha = function(self) return alpha end
	region.SetAlpha = function(self, value) alpha = value end

	region.Hide = function(self) visible = false end
	region.Show = function(self) visible = true end
	region.IsShown = function(self) return visible end
	region.IsVisible = function(self) return visible end

	return region 

end

local makeScriptObject = function()
	
	local scriptObject = {}
	local scripts = {}

	scriptObject.SetScript = function(self, name, handler) 
		scripts[name] = handler
	end

	scriptObject.GetScript = function(self, name)
		return scripts[name]
	end

	scriptObject.HasScript = function(self, name)
		return scripts[name] ~= nil
	end

	return scriptObject

end

local makeTexture = function()
	
	local texture = makeVisibleRegion()

	texture.SetTexture = function(self, t) end
	texture.SetTexCoord = function(self) end

	return texture 

end

local makeFontString = function()

	local font = makeVisibleRegion()
	local text = nil

	font.SetFont = function(...) end
	font.SetJustifyH = function(...) end
	font.SetShadowColor = function(...) end
	font.SetShadowOffset = function(...) end
	font.GetTextColor = function(...) return 1, 1, 1, 1 end
	font.SetTextColor = function(self, r, g, b, a) end

	font.GetText = function(self) return text end
	font.SetText = function(self, value) text = value end
	return font

end

local makeFrame = function(type, name, parent, templates)

	local scriptObject = makeScriptObject()
	local frame = setmetatable(makeVisibleRegion(), { __index = scriptObject})

	frame.GetName = function(self)
		return name
	end

	frame.RegisterEvent = function(self, eventName) 
		Api.registerEvent(eventName, frame)
	end


	frame.SetAttribute = function(self, value) end

	frame.SetBackdrop = function(self, value) end
	frame.SetBackdropColor = function(self, value) end
	frame.SetBackdropBorderColor = function(self, value) end

	frame.GetFrameLevel = function(self) end
	frame.SetFrameLevel = function(self) end
	frame.GetFrameStrata = function(self) end
	frame.SetFrameStrata = function(self, value) end


	frame.CreateTexture = function(self)
		return makeTexture()
	end

	frame.CreateFontString = function(self, ...)
		return makeFontString()
	end

	if name then
		_G[name] = frame
	end

	return frame

end

local makeButton = function(type, name, parent, templates)
	
	local button = makeFrame(type, name, parent, templates)
	local pushed = button:CreateTexture()
	local highlight = button:CreateTexture()

	button.SetNormalTexture = function(self, ...) end
	button.GetPushedTexture = function(self) return pushed end
	button.GetHighlightTexture = function(self) return highlight end

	_G[name.."Flash"] = button:CreateTexture()
	_G[name.."Border"] = button:CreateTexture()
	_G[name.."Count"] = button:CreateFontString()
	_G[name.."Name"] = button:CreateFontString()
	_G[name.."HotKey"] = button:CreateFontString()
	_G[name.."NormalTexture"] = button:CreateTexture()
	_G[name.."Icon"] = button:CreateTexture()


	button.RegisterForClicks = function(self, value) end

	return button

end

local makeStatusbar = function(type, name, parent, templates)

	local bar = makeFrame(type, name, parent, templates)

	bar.SetStatusBarTexture = function(self, texture) end
	bar.SetMinMaxValues = function(self, min, max) end
	return bar

end


local createFrame = function(type, ...)
	
	local type = string.lower(type)

	if type == "button" then
		return makeButton(type, ...)
	elseif type == "statusbar" then
		return makeStatusbar(type, ...)
	end

	return makeFrame(type, ...)

end

Api.export("CreateFrame", createFrame)



