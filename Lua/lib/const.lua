--time
_G.SECOND = 1
_G.TIME_RANGE = 60
_G.MINUTE = _G.TIME_RANGE * _G.SECOND
_G.HOUR = _G.TIME_RANGE * _G.MINUTE
_G.DAY_HOUR = 24
_G.DAY = _G.DAY_HOUR * _G.HOUR 
_G.WEEK_DAY = 7
_G.WEEK = _G.WEEK_DAY * _G.DAY


--empty
_G.EMPTY_TABLE = {}
setmetatable(_G.EMPTY_TABLE, {
	__newindex = function()
		error('EMPTY_TABLE can not add value')
	end
})
_G.EMPTY_FUNTION = function()
end


