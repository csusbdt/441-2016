local textures  = require('res.textures')
local anims     = require('res.anims')

local x = 100
local y = 100
local x_speed = 1
local y_speed = 1

local sprite = textures.image('sprites/Cara_walking.png')

local walkleft = anims.create()
walkleft:add_frame(sprite,   0, 0, 64, 64)
walkleft:add_frame(sprite,  64, 0, 64, 64)
walkleft:add_frame(sprite, 128, 0, 64, 64)
walkleft:add_frame(sprite, 192, 0, 64, 64)

local walkright = anims.create()
walkright:add_frame(sprite,   0, 64, 64, 64)
walkright:add_frame(sprite,  64, 64, 64, 64)
walkright:add_frame(sprite, 128, 64, 64, 64)
walkright:add_frame(sprite, 192, 64, 64, 64)

local walkfront = anims.create()
walkfront:add_frame(sprite,   0, 192, 64, 64)
walkfront:add_frame(sprite,  64, 192, 64, 64)
walkfront:add_frame(sprite, 128, 192, 64, 64)
walkfront:add_frame(sprite, 192, 192, 64, 64)

local walkback = anims.create()
walkback:add_frame(sprite,   0, 128, 64, 64)
walkback:add_frame(sprite,  64, 128, 64, 64)
walkback:add_frame(sprite, 128, 128, 64, 64)
walkback:add_frame(sprite, 192, 128, 64, 64)

local idlefront = anims.create()
idlefront:add_frame(sprite,  0, 192, 64, 64)

local idleback = anims.create()
idleback:add_frame(sprite,   0, 128, 64, 64)

local idleleft = anims.create()
idleleft:add_frame(sprite,   0,   0, 64, 64)

local idleright = anims.create()
idleright:add_frame(sprite,  0,  64, 64, 64)

local anim = walkleft

local function draw()
	set_draw_color(25, 25, 25, 255)
	render_clear()
	anim:draw(x, y)
	render()
end

function on_update()
	local dx = 0
	local dy = 0
	if w_key_down and not s_key_down then dy = -y_speed end
	if s_key_down and not w_key_down then dy =  y_speed end
	if a_key_down and not d_key_down then dx = -x_speed end
	if d_key_down and not a_key_down then dx =  x_speed end
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

