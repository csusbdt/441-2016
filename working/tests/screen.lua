local name_font = open_font('fonts/CaviarDreams.ttf', 80)

local function load_textures()
end

local on_render_targets_reset_counter = 0

local function draw()
	set_draw_color(125, 125, 125, 255)
	render_clear()
	set_draw_color(125, 0, 0, 0)
        fill_rect(0, 0, 20, 20)
        fill_rect((design_width - 20) / 2.0, (design_height - 20) / 2.0, 20, 20)
        fill_rect(design_width - 20, design_height - 20, 20, 20)

	local s = 'on_render_targets_reset_counter = ' .. on_render_targets_reset_counter
	local t = texture_from_font(name_font, s, 255, 255, 255, 255)
	render_texture(t, 100, 100)

	render()
end

function on_render_targets_reset()
	on_render_targets_reset_counter = on_render_targets_reset_counter + 1
	draw()
end

function on_update()
	if on_render_targets_reset_counter == 2 then
		dofile('tests/screen1.lua')
	end
end

function on_touch(mx, my)
	if not app_fullscreen then 
		fullscreen()
		app_fullscreen = true
	else
		windowed()
		app_fullscreen = false
	end
end

function on_keydown(key)
	if key == 102 then      -- F key
		fullscreen()
	elseif key == 119 then  -- W key
		windowed()
	end
end

draw()
set_window_position(100, 100)

