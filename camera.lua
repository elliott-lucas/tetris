function Camera()
	local c = {}
	c.position = Vector(0, 0)
	c.scale    = Vector(1, 1)
	c.angle    = 0
	c.shaking  = nil
	c.shaken   = Vector(0, 0)
	
	function c:set()
		if self.shaking ~= nil then
			self.shaken.x, self.shaken.y = self.shaking:shake() 
			self:moveTo(self.shaken.x, self.shaken.y)
		end
		lg.push()
		lg.rotate(-self.angle)
		lg.scale(1 /self.scale.x, 1/self.scale.y)
		lg.translate(-self.position.x, -self.position.y)
	end
	
	function c:unset()
		lg.pop()
	end
	
	function c:moveBy(dx, dy)
		self.position.x = self.position.x + dx
		self.position.y = self.position.y + dy
	end
	
	function c:moveTo(dx, dy)
		self.position.x = dx
		self.position.y = dy
	end
	
	function c:scaleBy(dx, dy)
		self.scale.x = self.scale.x * dx
		self.scale.y = self.scale.y * dy
	end
	
	function c:scaleTo(dx, dy)
		self.scale.x = dx
		self.scale.y = dy
	end
	
	function c:shake(duration, magnitude)
		self.shaking = Shake(duration, magnitude)
	end
	
	function c:update(dt)
		if self.shaking ~= nil then
			self.shaking:update(dt)
		end
	end
	
	return c
end