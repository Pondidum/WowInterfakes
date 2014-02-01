local ns = ...
local builder = ns.builder
local eventRegistry = ns.eventRegistry

ns.builder.addType({
	name = "Button",
	extends = { "Frame" },
	build = function(target)

		target.IsEnabled = function(self)
			return self.__storage.isEnabled
		end

		target.Enable = function(self)
			self.__storage.isEnabled = true
		end

		target.Disable = function(self)
			self.__storage.isEnabled = false
		end

		target.RegisterForClicks = function(self, ...)

			local allowed  = {}

			if ... ~= nil then

				for i,v in ipairs({...}) do
					allowed[v] = true
				end

			end

			self.__storage.clicks = allowed

		end

		target.SetText = function(self, text)
			self.__storage.text = text
		end

		target.GetFontString = function(self)
			return self.__storage.textFontString
		end

		target.SetNormalTexture = function(self, texture)
			self.__storage.normalTexture = texture
		end

		target.SetPushedTexture = function(self, texture)
			self.__storage.pushedTexture = texture
		end

		target.SetHighlightTexture = function(self, texture)
			self.__storage.highlightTexture = texture
		end

		target.GetHighlightTexture = function(self)
			return self.__storage.highlightTexture
		end

		target.SetDisabledTexture = function(self, texture)

			if type(texture) == "string" then
				self.__storage.disabledTexture:SetTexture(texture)
			else
				self.__storage.disabledTexture = builder.createTexture(self)
			end

		end

		target.GetDisabledTexture = function(self)
			return self.__storage.disabledTexture
		end

		target.SetNormalFontObject = function(self, font)
			self.__storage.normalFont = font
		end

		target.SetHighlightFontObject = function(self, font)
			self.__storage.highlightFont = font
		end

		target.SetDisabledFontObject = function(self, font)
			self.__storage.disabledFont = font
		end

		target.UnlockHighlight = function(self)
			self.__storage.highlightLocked = nil
		end

		target.LockHighlight = function(self)
			self.__storage.highlightLocked = true
		end

	end,

	initInstance = function(target)
		target:Enable()

		target.__storage.textFontString = builder.createFontString(target)
		target.__storage.highlightTexture = builder.createTexture(target)
		target.__storage.disabledTexture = builder.createTexture(target)

	end,
})
