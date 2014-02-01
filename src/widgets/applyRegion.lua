local ns = ...
local builder = ns.builder
local log = ns.log:new("apply.region")

ns.builder.addType({
	name = "Region",
	extends = { "ParentedObject" },
	build = function(target)

		target.GetWidth = function(self)
			return self.__storage.width
		end

		target.GetHeight = function(self)
			return self.__storage.height
		end

		target.GetSize = function(self)
			return self.__storage.width, self.__storage.height
		end

		target.SetWidth = function(self, value)
			self.__storage.width = value
		end

		target.SetHeight = function(self, value)
			self.__storage.height = value
		end

		target.SetSize = function(self, w, h)
			self.__storage.width = w
			self.__storage.height = h
		end

		target.ClearAllPoints = function(self, value)
			self.__storage.points = {}
		end

		target.SetPoint = function(self, anchor, other, otherAnchor, x, y)
			self.__storage.points = self.__storage.points or {}

			local points = self.__storage.points

			local index = nil

			for i, point in ipairs(points) do
				if point.anchor == anchor then
					index = i
				end
			end

			if type(other) == "string" then
				local frame = ns.frameRegistry.get(other)

				if frame == nil then
					log.warn("Unable to find a frame called " .. other)
				end

				other = frame
			end

			local data = {
				anchor = anchor,
				other = other,
				otherAnchor = otherAnchor,
				x = x,
				y = y
			}

			if index == nil then
				table.insert(points, data)
			else
				points[index] = data
			end

		end

		target.SetAllPoints = function(self, otherRegion)
			self:SetPoint("TOPLEFT", otherRegion, "TOPLEFT", 0, 0)
			self:SetPoint("BOTTOMRIGHT", otherRegion, "BOTTOMRIGHT", 0, 0)
		end

		target.GetNumPoints = function(self)

			if self.__storage.points == nil then
				return 0
			end

			local count = 0

			-- it is indexed, but use pairs() so we dont miss keys
			for k,v in pairs(self.__storage.points) do
				count = count + 1
			end

			return count

		end

		target.GetPoint = function(self, index)
			self.__storage.points = self.__storage.points or {}

			local data = self.__storage.points[index]

			if data == nil then
				return nil
			else
				return data.anchor, data.other, data.otherAnchor, data.x, data.y
			end

		end

		target.SetParent = function(self, target)
			self.__storage.parent = target
		end

		target.CreateAnimationGroup = function(self, name, inherits)
			return builder.createAnimationGroup(self, name, inherits)
		end

	end,
})
