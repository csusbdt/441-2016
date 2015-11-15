local textures  = require('res.textures')

local frame_mt = {
	sprite = textures.image("sprites/box.png"),
	x = 0,
	y = 0,
	w = 64,
	h = 64,
	t = 10 -- ticks
}
frame_mt.__index = frame_mt
function frame_mt:draw(x, y)
	self.sprite:draw(self.x, self.y, self.w, self.h, x, y)	
end

local anim_mt = {}
anim_mt.__index = anim_mt

function anim_mt:addframe(o)
	o = o or {}
	setmetatable(o, frame_mt)
	if not rawget(self, 'frames') then self.frames = {} end
	self.frames[#self.frames + 1] = o
end

anim_mt:addframe()

function anim_mt:draw(frame_index, x, y)
	if frame_index > #self.frames then mdgbox('Invalid frame index') end
	self.frames[frame_index]:draw(x, y)
end

function anim_mt:loop()
	local frame = 1
	local ticks = self.frames[frame].t
	return function(x, y)
		ticks = ticks - 1
		if ticks < 1 then 
			frame = frame + 1
			if frame > #self.frames then frame = 1 end
			ticks = self.frames[frame].t
		end
		self.frames[frame]:draw(x, y)
	end
end

local function create()
	local o = {}
	setmetatable(o, anim_mt)
	return o
end

return {
	create = create
}

