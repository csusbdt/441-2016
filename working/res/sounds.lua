local waves = require('res.waves')

local function play(filename)
	local wave = waves.get(filename)
	if wave then
		wave:play()
	else
		msgbox('Unknown sound: ' .. music_filename)
	end
end

return {
	play = play
}
	
