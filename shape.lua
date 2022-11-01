function Shape(blocks)
	local s = {}
	s.blocks    = blocks
	s.position  = Vector(0, 0)
	s.lowest    = {}
	s.rightest  = {}
	s.leftest   = {}
	
	function s:rotate()
		self.blocks = rotateTable(self.blocks, 1)
		self:getlowest()
		self:getrightest()
		self:getleftest()
	end
	
	function s:getcolour()
		for i=1, #self.blocks do
			for j=1, #self.blocks[i] do
				if self.blocks[i][j] ~= 0 then
					return self.blocks[i][j]
				end
			end
		end
	end
	
	function s:getlowest()
		self.lowest = {}
		for i=1, #self.blocks[1] do
			local low = 0 
			for j=1, #self.blocks do
				if self.blocks[j][i] ~= 0 then
					low = j
				end
			end
			table.insert(self.lowest, low)
		end
	end
	
	function s:getrightest()
		self.rightest = {}
		for i=1, #self.blocks do
			local right = 0
			for j=1, #self.blocks[i] do
				if self.blocks[i][j] ~= 0 then
					right = j
				end
			end
			table.insert(self.rightest, right)
		end	
	end
	
	function s:getleftest()
		self.leftest = {}
		for i=1, #self.blocks do
			local left = 0
			for j=#self.blocks[i], 1, -1 do
				if self.blocks[i][j] ~= 0 then
					left = j
				end
			end
			table.insert(self.leftest, left)
		end	
	end
	
	return s
end