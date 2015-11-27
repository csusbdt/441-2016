local dotchar  = require('char.dot')
local boxchar  = require('char.box')

local cara = require('char.cara').create{x = 200, y = 200}

local dots = {}
local boxes = {}

local function create_dot(x, y)
	dots[#dots + 1] = dotchar.create{x = x, y = y}
end

local function create_box(x, y)
	boxes[#boxes + 1] = boxchar.create{x = x, y = y}
end

local function draw_dots()
	for i = 1, #dots do dots[i]:draw() end
end

local function draw_boxes()
	for i = 1, #boxes do boxes[i]:draw() end
end

for i = 50, 400, 50 do create_dot(i, 75) end
for i = 50, 800, 50 do create_dot(i, i) end

function on_enter_down()
	create_dot(cara.x, cara.y)
end

function on_spacebar_down()
	create_box(cara.x, cara.y)
end

function draw()
	set_draw_color(25, 25, 25, 255)
	render_clear()
	draw_dots()
	draw_boxes()
	cara:draw()
	render()
end

function on_update()
	draw()
end

collectgarbage()

