function Shake(duration, magnitude)
	local s = {}
	s.duration  = duration
	s.magnitude = magnitude
	s.decay     = 0.8
	
	function s:shake()
		if self.duration > 0 then
			return math.random(-self.magnitude, self.magnitude), math.random(-self.magnitude, self.magnitude)
		else
			return 0, 0
		end
	end
	
	function s:update(dt)
		if self.duration > 0 then
			self.duration = math.max(self.duration - dt, 0)
			self.magnitude = self.magnitude * self.decay
		end
	end
	
	return s
end