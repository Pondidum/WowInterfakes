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

local applyScriptHandlers = function(frame)
	
	local scripts = {}

	frame.SetScript = function(self, name, handler) 
		scripts[name] = handler
	end

	frame.GetScript = function(self, name)
		return scripts[name]
	end

	frame.HasScript = function(self, name)
		return scripts[name] ~= nil
	end

	return frame

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

	local frame = makeVisibleRegion()
	applyScriptHandlers(frame)

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

	local flash = button:CreateTexture()
	local border = button:CreateTexture()
	local count = button:CreateFontString()
	local nameText = button:CreateFontString()
	local hotKey = button:CreateFontString()
	local normalTexture = button:CreateTexture()
	local icon = button:CreateTexture()

	if name then 
		_G[name.."Flash"] = flash
		_G[name.."Border"] = border
		_G[name.."Count"] = count
		_G[name.."Name"] = nameText
		_G[name.."HotKey"] = hotKey
		_G[name.."NormalTexture"] = normalTexture
		_G[name.."Icon"] = icon
	end
	
	button.RegisterForClicks = function(self, value) end

	return button

end

local makeStatusbar = function(type, name, parent, templates)

	local bar = makeFrame(type, name, parent, templates)

	bar.SetStatusBarTexture = function(self, texture) end
	bar.SetMinMaxValues = function(self, min, max) end
	return bar

end


local createFrame = function(type, name, parent, template)
	
	local type = string.lower(type)

	if type == "button" then
		return makeButton(type, name, parent, template)
	elseif type == "statusbar" then
		return makeStatusbar(type, name, parent, template)
	end

	return makeFrame(type, name, parent, template)

end

Api.export("CreateFrame", createFrame)



