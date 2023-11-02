local list = {
	'const.lua',
	'math.lua',
	'string.lua',
	'table.lua',
	'util.lua',

}
for i,v in ipairs(list) do
	dofile('lib/'..v)
end