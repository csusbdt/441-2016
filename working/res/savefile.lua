local m  = {} -- module
local bt = {} -- backing table
local mt = {} -- the module's metatable

mt.__index = bt -- look up keys in the backing table

local function file_exists(filename)
	local file = io.open(filename, 'r')
	if not file then return false end
	io.close(file)
	return true
end

local function read_backing_table()
	local filename = save_dir .. path_separator .. 'savefile', 'r'
	if not file_exists(filename) then return end
	local k = nil
	for line in io.lines(filename) do
		if k then 
			bt[k] = line
			k = nil
		else
			k = line
		end
	end
end

local function write_backing_table()
	local filename = save_dir .. path_separator .. 'savefile', 'r'
	local file, err = io.open(filename, 'w')
	if err then
		msgbox('Error in save_file.write_backing_table:\n' .. err)
		quit()
	end
	for k, v in pairs(bt) do
		if string.find(k, '\n') or string.find(v, '\n') then
			msgbox('Can not store newline characters in savefile.')
			quit()
		end
		file:write(k .. '\n')
		file:write(v .. '\n')
	end
	file:close()
end

function m.clear()
	for k,v in pairs(bt) do bt[k] = nil end
	write_backing_table()
end

function mt.__newindex(self, k, v)
	bt[k] = v
	write_backing_table()
end

setmetatable(m, mt)

read_backing_table()

return m

