_G.Util = {}
function Util.SafeIndex(tb, ...)
	local param_num = select("#", ...)
	for i=1,param_num do
		if type(tb) ~= 'table' then
			return nil
		end
		tb = tb[select(i, ...)]
	end
	return tb
end

function Util.Sort(tb, ...)
	local param_num = select("#", ...)
	local param = {...}
	table.sort(tb, function(a, b)
		for i = 1, param_num, 2 do
			local key = param[i]
			local value = param[i+1]
			local a_key = a[key]
			local b_key = b[key]
			if a_key ~= b_key then
				if value then
					return a_key > b_key
				else
					return a_key < b_key
				end
			end
		end
		return false
	end)
end


function Util.TimeCost(fun, times)
	times = times or 1
	local old = os.time()
	for i = 1, times do
		fun()
	end
	local dTime = os.time() - old
	print('TimeCost======all,per', dTime, dTime/times, debug.traceback())
end


function Util.SpaceCost(fun, times)
	times = times or 1
	collectgarbage("stop")
	local old = collectgarbage("count")
	for i = 1, times do
		fun()
	end
	collectgarbage("restart")
	local dSpace = collectgarbage("count") - old
	print('SpaceCost======all,per', dSpace, dSpace/times, debug.traceback())
end

--[[
Util.SpaceCost(function( ... )
	local a = {
		{1, 2},
		{2, 1},
		{2, 2},
	}
	Util.Sort(a, 1, true, 2, false)
end, 20)
]]