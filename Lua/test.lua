dofile"lib/lib_list.lua"
--[[
local before_path = 'version.txt'
local after_path = 'version_unique_sort.txt'
local file = io.open(before_path, 'r')
if file then
	t = file:read("*all") -- read the whole file
	local tbs = string.split(t, '\n') -- do the job
	local values = table.unique_array_values(tbs)
	table.sort(values)
	file:close()
	local file = io.open(after_path, 'w')
	file:write(table.concat(values, ','))
	file:close()
end
--]]
local S = "XDOYEZODEYXNZ"
local T = "YEZ"
local tb = {}
for i=1,string.len(T) do
	tb[T:sub(i,i)] = 0
end

local findAll = function(tb)
	for k,v in pairs(tb) do
		if v==0 then
			return false
		end
	end
	return true
end

local res
local len = string.len(S)
local min = string.len(S)
local left = 0
local right = 0
while left <= len and right <= len do
	if findAll(tb) then
		local d = right - left
		if d < min then
			res = S:sub(left, right)
			min = d
		end
		local now = S:sub(left, left)
		if tb[now] then
			tb[now] = tb[now] - 1
		end
		left = left + 1
	else
		local now = S:sub(left, left)
		if not tb[now] then
			left = left + 1
		else
			right = right + 1
			local now = S:sub(right, right)
			if tb[now] then
				tb[now] = tb[now] + 1
			end
		end
	end
end
print(res, 'res=====================')
print( 'test==============over')
--42309
