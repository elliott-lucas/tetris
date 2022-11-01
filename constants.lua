lw = love.window
lg = love.graphics
le = love.event
lk = love.keyboard
lm = love.mouse
lf = love.filesystem
lt = love.timer

WINDOW_TITLE = "Tetris"
BOARD_WIDTH  = 10
BOARD_HEIGHT = 20
SCALE        = 35

COLOURS = {
	[1] = {219/255, 130/255,  15/255}, -- Orange (L)
	[2] = {16/255,   30/255, 232/255}, -- Blue   (J)
	[3] = { 16/255, 206/255,  35/255}, -- Green  (S)
	[4] = {239/255,  20/255,  20/255}, -- Red    (Z)
	[5] = {133/255,  20/255, 239/255}, -- Purple (T)
	[6] = {239/255, 232/255,  21/255}, -- Yellow (O)
	[7] = { 16/255, 217/255, 232/255}, -- Cyan   (I)
	[8] = {102/255, 102/255, 102/255}, -- Grey   (Grid Color)
}

SHAPES = {"L", "J", "S", "Z", "T", "O", "I"}

BLOCKS = {
	["L"] = {{1, 0},
			 {1, 0},
			 {1, 1}},
	
	["J"] = {{0, 2},
			 {0, 2},
			 {2, 2}},
	
	["S"] = {{3, 0},
			 {3, 3},
			 {0, 3}},
			 
	["Z"] = {{0, 4},
			 {4, 4},
			 {4, 0}},
	
	["T"] = {{0, 5},
			 {5, 5},
			 {0, 5}},
	
	["O"] = {{6, 6},
			 {6, 6}},
	
	["I"] = {{7},
			 {7},
			 {7},
			 {7}},
}