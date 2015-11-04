-- The following is needed for dofile to run correctly for installed OS X apps.
local org_dofile = dofile
function dofile(file)
	if string.sub(file, 1, 1) == '/' then 
		org_dofile(file)
	else
		org_dofile(resource_dir .. file)
	end
end

black = { r = 0, g = 0, b = 0 }

function on_window_size_changed()
	if on_render_targets_reset then on_render_targets_reset() end
end

print('resource_dir = ' .. resource_dir)
print('save_dir = ' .. save_dir)
print('path_separator = ' .. path_separator)

w_key_down = false
a_key_down = false
s_key_down = false
d_key_down = false

function on_keydown(key)
        if     key == 119 then w_key_down = true
        elseif key ==  97 then a_key_down = true
        elseif key == 115 then s_key_down = true
        elseif key == 100 then d_key_down = true end
end

function on_keyup(key)
        if     key == 119 then w_key_down = false
        elseif key ==  97 then a_key_down = false
        elseif key == 115 then s_key_down = false
        elseif key == 100 then d_key_down = false end
end

--[[
dofile('tests/fonts.lua')
dofile('tests/textures.lua')
dofile('tests/audio.lua')
dofile('tests/screen.lua')
--]]

dofile('screens/title.lua')
--dofile('screens/anim.lua')

