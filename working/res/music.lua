local waves = require('res.waves')

local music_filename
local music_instance

-- Pass in nil to stop music.
local function set(filename)
	if music_filename == filename then return end

	if music_instance then
		music_instance:stop()
		music_instance = nil
	end

	music_filename = filename

	if music_filename == nil then return end
	
	local wave = waves.get(music_filename)
	if wave then
		music_instance = wave:loop()
	else
		msgbox('Unknown music: ' .. music_filename)
		music_filename = nil
	end
end

return {
	set = set
}
	
