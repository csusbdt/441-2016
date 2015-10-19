local textures = require('res.textures')
local buttons  = require('res.buttons')

local bg
local cara
local cara2


local function image(filename, x, y)
	return buttons.create_from_texture(textures.image(filename), x, y)
end

local function load_textures()
	bg = textures.image('bg/schoolFiller.jpg')
	cara  = image('images/Cara.png', 150, 50)
	cara2 = image('images/Cara.png', 350, 50)
end

local function draw()
	set_draw_color(225, 225, 225, 255)
	render_clear()
	bg    : draw()
	cara  : draw()
	cara2 : draw()
	
	blendmode_none()
	set_draw_color(120, 80, 50, 255)
	fill_rect(100, 100, 100, 100)
	
	blendmode_blend()
	set_draw_color(120, 80, 50, 100)
	fill_rect(220, 100, 100, 100)
	render()
end

function on_touch(x, y)
	dofile('screens/title.lua')
end

load_textures()
draw()
collectgarbage()

