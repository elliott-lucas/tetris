function Board(w, h)
	local b = {}
	b.map = setupMap(w, h)
	b.shapes = {}
	
	function b:clear()
		for j=1, #self.map do 
			for i=1, #self.map[j] do
				self.map[j][i] = 0
			end
		end
	end
	
	function b:delete(shape, x, y)
		for i=1, #shape do 
			for j=1, #shape[i] do
				if shape[i][j] ~= 0 then
					self.map[y+i][x+j] = 0
				end
			end
		end
	end
	
	function b:place(shape, x, y)
		for i=1, #shape do 
			for j=1, #shape[i] do
				if shape[i][j] ~= 0 then
					self.map[y+i][x+j] = shape[i][j]
				end
			end
		end
	end
	
	function b:checkrows()
		for j=1, #self.map do
			local full = true
			for i=1, #self.map[j] do
				if self.map[j][i] == 0 then
					full = false
				end
			end
			if full == true then
				for i=1, #self.map[j] do
					self.map[j][i] = 0
				end
				self:fall(j)
			end
		end
	end
	
	function b:fall(row)
		for j=row, 2, -1 do
			self.map[j] = self.map[j-1]
		end
		
		local blank = {}
		for i=1, BOARD_WIDTH do
			table.insert(blank, 0)
		end
		self.map[1] = blank
	end
	
	function b:draw()
		for j=1, #self.map do 
			for i=1, #self.map[j] do
				if self.map[j][i] == 0 then
					lg.setColor(COLOURS[player.shape:getcolour()][1]-0.2, COLOURS[player.shape:getcolour()][2]-0.2, COLOURS[player.shape:getcolour()][3]-0.2)
					lg.rectangle("line", i*SCALE, j*SCALE, SCALE, SCALE)
					lg.setColor(1, 1, 1)
				end
			end
		end
		
		for j=1, #self.map do 
			for i=1, #self.map[j] do
				local b = self.map[j][i]
				if b ~= 0 then
					lg.setColor(COLOURS[b][1]-0.2, COLOURS[b][2]-0.2, COLOURS[b][3]-0.2)
					lg.rectangle("fill", i*SCALE, j*SCALE+0.3*SCALE, SCALE+1, SCALE)
					lg.setColor(COLOURS[b][1], COLOURS[b][2], COLOURS[b][3])
					lg.rectangle("fill", (i*SCALE)+0.5, (j*SCALE)+0.5, SCALE, SCALE)
					lg.setColor(COLOURS[b][1]+0.1, COLOURS[b][2]+0.1, COLOURS[b][3]+0.1)
					lg.rectangle("line", (i*SCALE)+1, (j*SCALE)+1, SCALE, SCALE)
				end
				lg.setColor(1, 1, 1)
				-- lg.print(b, i*SCALE, j*SCALE)
				-- lg.print(tostring(i)..",", (i+0.05)*SCALE, (j+0.6)*SCALE)
				-- lg.print(j, (i+0.7)*SCALE, (j+0.6)*SCALE)
			end
		end
	end
	
	return b
end

function setupMap(w, h)
	map = {}
	for i=1, h do
		table.insert(map, {})
		for j=1, w do
			table.insert(map[i], 0)
		end
	end
	
	return map
end

function displayMap(map)
	for y=1, #map do
		print()
		for x=1, #map[1] do
			io.write(tostring(map[y][x]..", "))
		end
	end
end
