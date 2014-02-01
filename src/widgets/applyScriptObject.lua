local ns = ...
local builder = ns.builder

ns.builder.addType({
	name = "ScriptObject",
	extends = {},
	build = function(target)

		target.SetScript = function(self, scriptType, handler)
			self.__storage.scripts = self.__storage.scripts or {}
			self.__storage.scripts[scriptType] = handler
		end

		target.HookScript = function(self, scriptType, handler)
			self.__storage.hooks = self.__storage.hooks or {}
			self.__storage.hooks[scriptType] = handler
		end

		target.GetScript = function(self, scriptType)

			self.__storage.scripts = self.__storage.scripts or {}
			self.__storage.hooks = self.__storage.hooks or {}

			return self.__storage.scripts[scriptType] or self.__storage.hooks[scriptType]

		end

		target.HasScript = function(self, scriptType)
			return self:GetScript(scriptType) ~= nil
		end

	end,
})
