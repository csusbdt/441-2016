local textures  = require('res.textures')
local anim      = require('eng.anim')

local sprite = textures.image('sprites/box.png')

local idle = anim.create()
idle:addframe{ sprite = sprite }
idle:addframe{ sprite = sprite, x =  64, t = 8 }
idle:addframe{ sprite = sprite, x = 128, t = 8 }
idle:addframe{ sprite = sprite, x = 192, t = 8 }
local anim = idle

local dot_mt = {
	x = 100,
	y = 100
}
dot_mt.__index = dot_mt

function dot_mt:draw()
	self.loop(self.x - 32, self.y - 32)
end

local function create(o)
	local o = o or {}
	setmetatable(o, dot_mt)
	o.loop = idle:loop()
	return o
end

return {
	create = create
}

