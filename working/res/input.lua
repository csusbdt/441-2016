local w_key_down = false
local a_key_down = false
local s_key_down = false
local d_key_down = false

function on_keydown(key)
        if key == 119 then w_key_down = true
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

return {
	is_w_key_down = function() return w_key_down end,
	is_a_key_down = function() return a_key_down end,
	is_s_key_down = function() return s_key_down end,
	is_d_key_down = function() return d_key_down end
}

