local textures  = require('res.textures')
local input     = require('eng.input')

local x_speed = 1
local y_speed = 1

local cara = require('char.cara').create{x = 200, y = 200}

local function draw()
	set_draw_color(25, 25, 25, 255)
	render_clear()
	cara:draw()
	render()
end

function on_update()
	draw()
end

function on_touch(x, y)
	dofile('screens/title.lua')	
end

collectgarbage()

