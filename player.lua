function Player()
	local p = {}
	p.shape    = Shape(BLOCKS[SHAPES[math.random(1, #SHAPES)]])
	p.position = Vector(round(BOARD_WIDTH/2)-1, 0)
	p.cooldown = {move=0.08, fall=0.5, fastfall=0.005, rotate=false}
	p.pause    = false
	
	function p:pickshape()
		return SHAPES[math.random(1, #SHAPES)]
	end

	function p:collision(side)
		if side == "down" then
			for i=1, #self.shape.lowest do
				local l = self.shape.lowest[i]
				local t = Vector(self.position.x + i, self.position.y + l + 1)
				if math.clamp(1, t.y, BOARD_HEIGHT + 1) == t.y and math.clamp(1, t.x, BOARD_WIDTH + 1) == t.x then
					if board.map[t.y][t.x] ~= 0 then
						return true
					end
				end
			end
			return false
		end
		if side == "right" then
			for i=1, #self.shape.rightest do
				local l = self.shape.rightest[i]
				local t = Vector(self.shape.position.x + l + 1, self.shape.position.y + i)
				if t.y < BOARD_HEIGHT + 1 and t.x < BOARD_WIDTH + 1 then
					if board.map[t.y][t.x] ~= 0 then
						return true
					end
				end
			end
			return false
		end
		if side == "left" then
			for i=1, #self.shape.leftest do
				local l = self.shape.leftest[i]
				local t = Vector(self.shape.position.x + l - 1, self.shape.position.y + i)
				if t.y < BOARD_HEIGHT + 1 and t.x > 0 then
					if board.map[t.y][t.x] ~= 0 then
						return true
					end
				end
			end
			return false
		end
	end
	
	function p:update(dt)
		self.cooldown.move     = math.max(self.cooldown.move     - dt, 0)
		self.cooldown.fall     = math.max(self.cooldown.fall     - dt, 0)
		self.cooldown.fastfall = math.max(self.cooldown.fastfall - dt, 0)
		
		board:delete(self.shape.blocks, self.position.x, self.position.y)
		
		if self.cooldown.fall == 0 then
			if not lk.isDown("s", "down") then
				self.position.y    = math.min(self.position.y + 1, BOARD_HEIGHT-#self.shape.blocks)
				self.cooldown.fall = 1
			end
		end
		
		if self.cooldown.fastfall == 0 then
			if lk.isDown("s", "down") then
				self.position.y        = math.min(self.position.y + 1, BOARD_HEIGHT-#self.shape.blocks)
				self.cooldown.fastfall = 0.005
			end
		end
		
		if self.cooldown.move == 0 then
			if lk.isDown("a", "d", "left", "right") then
				if lk.isDown("a", "left") and self:collision("left") == false then
					self.position.x = math.max(self.position.x - 1, 0)
				end
				if lk.isDown("d", "right") and self:collision("right") == false then
					self.position.x = math.min(self.position.x + 1, BOARD_WIDTH - #self.shape.blocks[1])
				end
			self.cooldown.move = 0.08
			end
		end
		
		if lk.isDown("w", "up") then
			if self.cooldown.rotate == false then
				self.shape:rotate()
				for i=1, #self.shape.blocks do
					for j=1, #self.shape.blocks[i] do
						if board.map[self.position.y+i][self.position.x+j] == 1 then
							for i=1, 3 do self.shape:rotate() end
						end
					end
				end
				self.position.x = math.clamp(0, self.position.x, BOARD_WIDTH - #self.shape.blocks[1])
			end
			self.cooldown.rotate = true
		else
			self.cooldown.rotate = false
		end
		
		self.shape.position.x = self.position.x
		self.shape.position.y = self.position.y
		
		self.shape:getlowest()
		self.shape:getrightest()
		self.shape:getleftest()
		
		if (self.position.y == BOARD_HEIGHT-#self.shape.blocks or self:collision("down") == true) and (self.cooldown.fall < dt or self.cooldown.fastfall == 0.005) then
			board:place(self.shape.blocks, self.shape.position.x, self.shape.position.y)
			board:checkrows()
			camera:shake(0.5, 10)
			self.shape = Shape(BLOCKS[self:pickshape()])
			self.position = Vector(round(BOARD_WIDTH/2)-1, 0)
		end
		
		board:place(self.shape.blocks, self.position.x, self.position.y)
	end
	
	function p:draw()
		lg.rectangle("fill", (self.position.x+1)*SCALE, (self.position.y+1)*SCALE, SCALE*0.5, SCALE*0.5 )
		for i=1, #self.shape.lowest do
			local l = self.shape.lowest[i]
			local t = Vector(self.shape.position.x + i, self.shape.position.y + l + 1)
			lg.setColor(1, 0, 0, 0.6)
			lg.rectangle("fill", t.x*SCALE, t.y*SCALE, SCALE, SCALE)
			lg.setColor(1, 1, 1, 1)
		end
		
		for i=1, #self.shape.rightest do
			local l = self.shape.rightest[i]
			local t = Vector(self.shape.position.x + l + 1, self.shape.position.y + i)
			lg.setColor(0, 1, 0, 0.6)
			lg.rectangle("fill", t.x*SCALE, t.y*SCALE, SCALE, SCALE)
			lg.setColor(1, 1, 1, 1)
		end
		
		for i=1, #self.shape.leftest do
			local l = self.shape.leftest[i]
			local t = Vector(self.shape.position.x + l - 1, self.shape.position.y + i)
			lg.setColor(0, 0, 1, 0.6)
			lg.rectangle("fill", t.x*SCALE, t.y*SCALE, SCALE, SCALE)
			lg.setColor(1, 1, 1, 1)
		end
	end
	
	return p
end