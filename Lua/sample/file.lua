--file_op
-- [[--替换文本
	local notice_path = 'sample/file_eg_notice.xml'
	local file = io.open(notice_path, 'r')
	if file then
		local version = "1.9.5.1"
		local version_str = ('&gt;v%s&lt'):format(version)
		t = file:read("*all") -- read the whole file
		local new_t = string.gsub(t, '&gt;v[%d%.]+&lt',version_str) -- do the job
		file:close()
		if t ~= new_t then
			print('change version:'..version)
			local file = io.open(notice_path, 'w')
			file:write(new_t)
			file:close()
		end
	end
--]]

--[[--去重排序
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
	file:write(table.concat(values, '\n'))
	file:close()
end
print( 'test==============over')

--]]