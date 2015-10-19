_ENV = {
	require = require,
	setmetatable = setmetatable,
	error = error
}

textures = require('res.textures')

button_mt = {}

button_mt.__index = button_mt;

function button_mt.draw(self)
	if self.t then 
		self.t:draw(self.a1, self.a2, self.a3, self.a4, self.a5, self.a6, self.a7, self.a8) 
	end
end

function button_mt.contains(self, x, y)
	return x >= self.x and x <= self.x + self.w and y >= self.y and y <= self.y + self.h
end

local function create_from_rect(x, y, w, h)
	local o = { x = x, y = y, w = w, h = h }
	setmetatable(o, button_mt)
	return o
end

local function create_from_texture(t, a1, a2, a3, a4, a5, a6, a7, a8)
	if not t then error("create_from_texture called with nil texture", 2) end
	local o = { t=t, a1=a1, a2=a2, a3=a3, a4=a4, a5=a5, a6=a6, a7=a7, a8=a8 }
	if     a8 then o.x = a5; o.y = a6; o.w = a7; o.h = a8 
	elseif a6 then o.x = a5; o.y = a6; o.w = t.w; o.h = t.h
	elseif a4 then o.x = a1; o.y = a2; o.w = a3; o.h = a4
	elseif a2 then o.x = a1; o.y = a2; o.w = t.w; o.h = t.h
	else           o.x =  0; o.y =  0; o.w = app_width; o.h = app_height
	end
	setmetatable(o, button_mt)
	return o
end

return {
	create_from_texture = create_from_texture ,
	create_from_rect    = create_from_rect
}

