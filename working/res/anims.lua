_ENV = {
	require = require,
	setmetatable = setmetatable,
	error = error
}

local anim_mt = {}

anim_mt.__index = anim_mt

function anim_mt.draw(self, x, y)
	if not self.n then self.n = 0 end
	if self.n == 15 then 
		self.n = 1
		self.frame = self.frame.next
	else
		self.n = self.n + 1
	end
	self.frame.t:draw(self.frame.x, self.frame.y, self.frame.w, self.frame.h, x, y)
end

-- Maintain frames in a circular list.
function anim_mt.add_frame(self, t, x, y, w, h)
	local f = { t = t, x = x, y = y, w = w, h = h }
	if not self.frame then 
		self.frame = f
		f.next = f
	else
		f.next = self.frame.next
		self.frame.next = f
		self.frame = f
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

