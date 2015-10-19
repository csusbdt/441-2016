local textures = {}
setmetatable(textures, { __mode = 'v' })

local texture_mt = {}

texture_mt.__index = texture_mt;

function texture_mt:__gc()
	if app_print_gc then 
		if self.name then 
			print('Garbage collecting ' .. self.name)
		elseif self.text then 
			print('Garbage collecting ' .. self.text) 
		end
	end
	destroy_texture(self.ud)
	if self.name then textures[self.name] = nil end
end

function texture_mt:draw(a1, a2, a3, a4, a5, a6, a7, a8)
	if     a8 then render_texture(self.ud, a1, a2, a3, a4, a5, a6, a7, a8)
	elseif a6 then render_texture(self.ud, a1, a2, a3, a4, a5, a6)
	elseif a4 then render_texture(self.ud, a1, a2, a3, a4)
	elseif a2 then render_texture(self.ud, a1, a2)
	else           render_texture(self.ud)
	end
end

local function image(filename)
	if textures[filename] then 
		return textures[filename]
	end
	local o = { name = filename }
	local result
	result, o.ud, o.w, o.h = pcall(texture_from_file, filename)
	if not result then
		msgbox('texture_from_file failed with ' .. filename .. '\n' .. o.ud)
		os.exit()
	end
	setmetatable(o, texture_mt)
	textures[filename] = o
	return o
end

local function text(font, text, color)
	local c = {
		r = color and color.r or 0,
		g = color and color.g or 0,
		b = color and color.b or 0,
		a = color and color.a or 255
	}
	local o = { text = text }
	o.ud, o.w, o.h = texture_from_font(font, text, c.r, c.g, c.b, c.a)
	setmetatable(o, texture_mt)
	return o
end

-- If the device lost the graphics state (app going to background and then shutdown),
-- then we need to discard texture userdata.
local function discard_userdata()
	for k in pairs(textures) do textures[k] = nil end
end

return {
	image = image,
	text  = text,
	discard_userdata
}

