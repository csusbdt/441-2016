local dotchar  = require('char.dot')

local dots = {}

function on_touch(x, y)
	dots[#dots + 1] = dotchar.create{x = x, y = y}
end

on_touch(300, 100)

function draw()
	set_draw_color(25, 25, 25, 255)
	render_clear()
	for i = 1, #dots do dots[i]:draw() end
	render()
end

function on_update()
	draw()
end

collectgarbage()

