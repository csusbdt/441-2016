local textures  = require('res.textures')
local input     = require('eng.input')
local anim      = require('eng.anim')

local cara = {
	 x = 100
	 y = 100
	 x_speed = 1
	 y_speed = 1
}

local sprite = textures.image('sprites/Cara_walking.png')

local walkleft = anim.create()
walkleft:add_frame(sprite,   0, 0, 64, 64)
walkleft:add_frame(sprite,  64, 0, 64, 64)
walkleft:add_frame(sprite, 128, 0, 64, 64)
walkleft:add_frame(sprite, 192, 0, 64, 64)

local walkright = anim.create()
walkright:add_frame(sprite,   0, 64, 64, 64)
walkright:add_frame(sprite,  64, 64, 64, 64)
walkright:add_frame(sprite, 128, 64, 64, 64)
walkright:add_frame(sprite, 192, 64, 64, 64)

local walkfront = anim.create()
walkfront:add_frame(sprite,   0, 192, 64, 64)
walkfront:add_frame(sprite,  64, 192, 64, 64)
walkfront:add_frame(sprite, 128, 192, 64, 64)
walkfront:add_frame(sprite, 192, 192, 64, 64)

local walkback = anim.create()
walkback:add_frame(sprite,   0, 128, 64, 64)
walkback:add_frame(sprite,  64, 128, 64, 64)
walkback:add_frame(sprite, 128, 128, 64, 64)
walkback:add_frame(sprite, 192, 128, 64, 64)

local idlefront = anim.create()
idlefront:add_frame(sprite,  0, 192, 64, 64)

local idleback = anim.create()
idleback:add_frame(sprite,   0, 128, 64, 64)

local idleleft = anim.create()
idleleft:add_frame(sprite,   0,   0, 64, 64)

local idleright = anim.create()
idleright:add_frame(sprite,  0,  64, 64, 64)

cara.anim = walkleft

local function draw()
	set_draw_color(25, 25, 25, 255)
	render_clear()
	cara.anim:draw(x, y)
	render()
end

function on_update()
	local dx = 0
	local dy = 0
	if input.is_w_key_down() and not input.is_s_key_down() then dy = -y_speed end
	if input.is_s_key_down() and not input.is_w_key_down() then dy =  y_speed end
	if input.is_a_key_down() and not input.is_d_key_down() then dx = -x_speed end
	if input.is_d_key_down() and not input.is_a_key_down() then dx =  x_speed end
	if dx == 0 and dy == 0 then
		if     anim == walkleft  then anim = idleleft 
		elseif anim == walkright then anim = idleright
		elseif anim == walkback  then anim = idleback
		elseif anim == walkfront then anim = idlefront end
	end
	if     dx < 0            then anim = walkleft
	elseif dx > 0            then anim = walkright
	elseif dy < 0            then anim = walkback
	elseif dy > 0            then anim = walkfront
	elseif anim == walkleft  then anim = idleleft 
	elseif anim == walkright then anim = idleright
	elseif anim == walkback  then anim = idleback
	elseif anim == walkfront then anim = idlefront end
	y = y + dy
	x = x + dx
	draw()
end

function on_touch(x, y)
	dofile('screens/title.lua')	
end

function on_render_targets_reset()
        draw()
end

draw()
collectgarbage()

