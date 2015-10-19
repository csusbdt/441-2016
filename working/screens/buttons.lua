local fonts     = require('res.fonts')
local textures  = require('res.textures')
local buttons   = require('res.buttons')

local bg
local b1
local b2
local b3

function load_textures()
	bg = textures.image('bg/schoolFiller.jpg')
	local t1 = textures.image('images/Cara.png') 
	local f1 = fonts.create("fonts/DroidSansMono.ttf", 24)
	local t2 = f1:text("Hello in some color.", {r=0, g=200, b=255})
	local t3 = f1:text("Back", app_black)
	--[[
	Five possible ways to create a button from a texture:
		buttons.create_from_texture(t) 
		buttons.create_from_texture(t, dst_x, dst_y) 
		buttons.create_from_texture(t, dst_x, dst_y, dst_w, dst_h) 
		buttons.create_from_texture(t, src_x, src_y, src_w, src_h, dst_x, dst_y) 
		buttons.create_from_texture(t, src_x, src_y, src_w, src_h, dst_x, dst_y, dst_w, dst_h) 
	--]]
	b1 = buttons.create_from_texture(t1, 0, 0)
	b2 = buttons.create_from_texture(t2, 300, 50)
	b3 = buttons.create_from_texture(t3, 100, 150)
end

-- You can also create an invisible button to define a clickable rectangle.

local b4  = buttons.create_from_rect(700, 768 - 300, 324, 300)

function draw()
	set_draw_color(25, 25, 25, 255)
	render_clear()
        bg:draw()
        b1:draw()
        b2:draw()
        b3:draw()
	render()
end

function on_touch(x, y)
	if b1:contains(x, y) then msgbox('x = ' .. x .. '  y = ' .. y) 
	elseif b3:contains(x, y) then 
		dofile('screens/title.lua')
	elseif b4:contains(x, y) then
		msgbox('You clicked the corner.')
	end
end

load_textures()
draw()
collectgarbage()

