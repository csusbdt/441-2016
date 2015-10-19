local fonts     = require('res.fonts')
local textures  = require('res.textures')
local buttons   = require('res.buttons')
local music     = require('res.music')
local sounds    = require('res.sounds')
local sf        = require('res.savefile')

local bg
local title
local continue_button
local restart_button
local textures_button
local buttons_button
local fill_button
local full_button
local fonts_button
local exit_button

local x = 50
local y = 100
local dy = 40

local function create_title(text, x, y)
	local f = fonts.create('fonts/DroidSansMono.ttf', 32)
	local t = f:text(text, { r = 0, g = 100, b = 0 })
	return buttons.create_from_texture(t, x, y)
end

local function create_button(text, x, y)
	local f = fonts.create("fonts/DroidSansMono.ttf", 22)
	local t = f:text(text, app_black)
	return buttons.create_from_texture(t, x, y)
end

local function load_textures()
	bg = textures.image('bg/schoolFiller.jpg')
	title           = create_title ("CSE 441 Test Program", 120,  50)
	continue_button = create_button("Continue game"       , x, y); y = y + dy
	restart_button  = create_button("Restart game"        , x, y); y = y + dy
	textures_button = create_button("Textures demo"       , x, y); y = y + dy
	buttons_button  = create_button("Buttons demo"        , x, y); y = y + dy
	fill_button     = create_button("Fill"                , x, y); y = y + dy
	full_button     = create_button("Toggle fullscreen"   , x, y); y = y + dy
	fonts_button    = create_button("Test fonts"          , x, y); y = y + dy
	exit_button     = create_button("Exit"                , x, y); y = y + dy
end

local function draw()
	set_draw_color(25, 25, 25, 255)
	render_clear()
	bg              :draw()
	title           :draw()
	continue_button :draw()
	restart_button  :draw()
	textures_button :draw()
	buttons_button  :draw()
	fill_button     :draw()
	full_button     :draw()
	fonts_button    :draw()
	exit_button     :draw()
	render()
end

function on_update()
end

function on_touch(x, y)
	if continue_button:contains(x, y) then
		sounds.play('waves/door.wav')
		dofile('screens/play.lua')
	elseif restart_button:contains(x, y) then
		sf.clear()
		sf.current_node = 'start'
		dofile('screens/play.lua')
	elseif textures_button:contains(x, y) then
		dofile('screens/textures.lua')
	elseif buttons_button:contains(x, y) then
		dofile('screens/buttons.lua')
	elseif fill_button:contains(x, y) then
		dofile('screens/fill.lua')
	elseif full_button:contains(x, y) then
		if app_fullscreen then 
			windowed()
			app_fullscreen = false
		else 
			fullscreen()
			app_fullscreen = true 
		end
	elseif fonts_button:contains(x, y) then
		dofile('screens/fonts.lua')
	elseif exit_button:contains(x, y) then
		quit()
	end
end

function on_render_targets_reset()
        draw()
end

music.set('music/Overworld.wav')
load_textures()
draw()
collectgarbage()

