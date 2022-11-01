require "constants"
require "misc"
require "vector"
require "board"
require "player"
require "shape"
require "camera"
require "shake"

function love.load()
	setupWindow()
	setupVariables()
end

function love.update(dt)
	if player.pause == false then
		player:update(dt)
		camera:update(dt)
	end
end

function love.draw()
	camera:set()
		board:draw()
	camera:unset()
	
	if player.pause == true then
		lg.setFont(font_large)
		lg.print("[Paused]", lg.getWidth()/2-(font_large:getWidth("[Paused]")/2), lg.getHeight()/2-(font_large:getHeight("Paused")/2), 0)
		lg.setFont(font_small)
		lg.print("Press P to unpause.", lg.getWidth()/2-(font_small:getWidth("Press P to unpause.")/2), lg.getHeight()/2+40, 0)
	end
end

function love.keypressed(key)
	if key == "escape" then le.quit() end
	if key == "p" then player.pause = not player.pause end
	if key == "r" then setupVariables() end
end

function setupWindow()
	lw.setTitle(WINDOW_TITLE)
	lw.setMode((BOARD_WIDTH+2)*SCALE, (BOARD_HEIGHT+2)*SCALE)
	lg.setLineStyle("rough")
	lg.setDefaultFilter("nearest", "nearest")
	
	font_small = lg.newFont(16)
	font_large = lg.newFont(64)
	lg.setFont(font_small)
end

function setupVariables()
	camera = Camera()
	player = Player()
	board  = Board(BOARD_WIDTH, BOARD_HEIGHT)
end