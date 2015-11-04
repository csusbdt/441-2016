local textures  = require('res.textures')
local anims     = require('res.anims')

local x = 100
local y = 100

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

local idlefront = anims.create()
idlefront:add_frame(sprite,   0, 192, 64, 64)

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

local anim = walkleft

local function draw()
	set_draw_color(25, 25, 25, 255)
	render_clear()
	anim:draw(x, y)
	render()
end

function on_update()
	draw()
end

function on_keydown(key)
	if     key == 119 then anim = walkback       -- w
	elseif key ==  97 then anim = walkleft       -- a
	elseif key == 115 then anim = walkfront      -- s
	elseif key == 100 then anim = walkright end  -- d
end

function on_touch(x, y)
	dofile('screens/title.lua')	
end

function on_render_targets_reset()
        draw()
end

draw()
collectgarbage()

