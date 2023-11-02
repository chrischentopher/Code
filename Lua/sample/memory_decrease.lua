
--[[--home_shadow_vertex_cfg.lua
local lua_mem = collectgarbage("count")
print('lua_mem bf:', lua_mem)
local config_data = dofile"home_shadow_vertex_cfg.lua"
local lua_mem = collectgarbage("count")
print('lua_mem af1:', lua_mem)

collectgarbage("collect")
local lua_mem = collectgarbage("count")
print('lua_mem af2:', lua_mem)
do
	local map = {}
	for k, v in pairs(config_data) do
		if k == 'vertex_exports' or k == 'vertex_colors' then
			for kk,vv in pairs(v) do
				for kkk,vvv in pairs(vv) do
					local key = table.concat(vvv, ',')
					local m = map[key]
					if m then
						vv[kkk] = m
					else
						map[key] = vvv
					end
				end
			end
		end
	end
end
local lua_mem = collectgarbage("count")
print('lua_mem bf3:', lua_mem)
collectgarbage("collect")
local lua_mem = collectgarbage("count")
print('lua_mem af3:', lua_mem)
--]]
--[[
lua_mem bf:     22.8525390625
lua_mem af1:    7121.00390625
lua_mem af2:    4668.26171875
lua_mem bf3:    6846.064453125
lua_mem af3:    4520.8662109375
4668 -> 4520 148k 暂不处理
]]



--[[ --配置表dofile内存排序
dofile"D:\\Projects\\Trunk\\Azure\\Output\\Lua\\cfg\\helper.lua"
_G.FASHIONTYPE_BEGIN 			= 		cfg.TYPE_FASHION.FASHION_HAIR

_G.FASHIONTYPE_HAIR 			= 		cfg.TYPE_FASHION.FASHION_HAIR
_G.FASHIONTYPE_CLOTH 			= 		cfg.TYPE_FASHION.FASHION_CLOTH
_G.FASHIONTYPE_COAT 			= 		cfg.TYPE_FASHION.FASHION_COAT
_G.FASHIONTYPE_UP 				= 		cfg.TYPE_FASHION.FASHION_UP
_G.FASHIONTYPE_DOWN 			= 		cfg.TYPE_FASHION.FASHION_DOWN
_G.FASHIONTYPE_SOCK 			=		cfg.TYPE_FASHION.FASHION_SOCK
_G.FASHIONTYPE_SHOES 			= 		cfg.TYPE_FASHION.FASHION_SHOES
_G.FASHIONTYPE_HAT 				= 		cfg.TYPE_FASHION.FASHION_HAT
_G.FASHIONTYPE_HEAD_DRESS 		= 		cfg.TYPE_FASHION.FASHION_HEAD_DRESS
_G.FASHIONTYPE_FACIAL_ORNAMENT 	= 		cfg.TYPE_FASHION.FASHION_FACIAL_ORNAMENT
_G.FASHIONTYPE_EARRING 			= 		cfg.TYPE_FASHION.FASHION_EARRING
_G.FASHIONTYPE_NECKLACE 		= 		cfg.TYPE_FASHION.FASHION_NECKLACE
_G.FASHIONTYPE_COLLAR 			= 		cfg.TYPE_FASHION.FASHION_COLLAR
_G.FASHIONTYPE_BRACELET			= 		cfg.TYPE_FASHION.FASHION_BRACELET
_G.FASHIONTYPE_GLOVE 			= 		cfg.TYPE_FASHION.FASHION_GLOVE
_G.FASHIONTYPE_RING 			= 		cfg.TYPE_FASHION.FASHION_RING
_G.FASHIONTYPE_CARRY 			= 		cfg.TYPE_FASHION.FASHION_CARRY
_G.FASHIONTYPE_WING 			= 		cfg.TYPE_FASHION.FASHION_WING
_G.FASHIONTYPE_TAIL 			= 		cfg.TYPE_FASHION.FASHION_TAIL
_G.FASHIONTYPE_BACK_ORNAMENT 	= 		cfg.TYPE_FASHION.FASHION_BACK_ORNAMENT
_G.FASHIONTYPE_SHOULDER_TATTOO 	= 		cfg.TYPE_FASHION.FASHION_SHOULDER_TATTOO
_G.FASHIONTYPE_EYE_SHADOW 		= 		cfg.TYPE_FASHION.FASHION_EYE_SHADOW
_G.FASHIONTYPE_EYE_LINER 		= 		cfg.TYPE_FASHION.FASHION_EYE_LINER
_G.FASHIONTYPE_ANKLE 			= 		cfg.TYPE_FASHION.FASHION_ANKLE
_G.FASHIONTYPE_CROSS_BODY 		= 		cfg.TYPE_FASHION.FASHION_CROSS_BODY
_G.FASHIONTYPE_HOVER 			= 		cfg.TYPE_FASHION.FASHION_HOVER
_G.FASHIONTYPE_EYEBROW 			= 		cfg.TYPE_FASHION.FASHION_EYEBROW
_G.FASHIONTYPE_MAKEUP 			= 		cfg.TYPE_FASHION.FASHION_MAKEUP
_G.FASHIONTYPE_EYELASH 			= 		cfg.TYPE_FASHION.FASHION_EYELASH
_G.FASHIONTYPE_EYE_ORNAMENT	 	= 		cfg.TYPE_FASHION.FASHION_EYE_ORNAMENT
_G.FASHIONTYPE_LIPSTICK 		= 		cfg.TYPE_FASHION.FASHION_LIPSTICK
_G.FASHIONTYPE_HEAD_TATTOO 		= 		cfg.TYPE_FASHION.FASHION_HEAD_TATTOO
_G.FASHIONTYPE_NAIL 			= 		cfg.TYPE_FASHION.FASHION_NAIL
_G.FASHIONTYPE_BLUSHER 			= 		cfg.TYPE_FASHION.FASHION_BLUSHER
_G.FASHIONTYPE_CAR 	 			= 		cfg.TYPE_FASHION.FASHION_CAR

_G.FASHIONTYPE_END 				= 		_G.FASHIONTYPE_CAR

_G.FASHIONTYPE_MAKEUP_SUIT		= 		100
_G.FASHIONTYPE_FASHION_SUIT		= 		101

_G.COMMON_REWARD_TYPE =
{
	BIND_MONEY 	= "BindMoney",
	BIND_CASH 	= "BindCash",
	CASH 		= "Cash",
	REPU		= "Repu",
	ITEM 		= "Item",
}
_G.Color={}
Color.Color = function()
	return ''
end

local lfs = require("lfs")
local all = {}
local function traverse_directory(path)
    for filename in lfs.dir(path) do  -- 遍历目录中的每个文件
        if filename ~= "." and filename ~= ".." then
            local filepath = path .. "/" .. filename  -- 文件的全路径
            local mode = lfs.attributes(filepath, "mode")  -- 获取文件类型
            if mode == "file" then  -- 如果是文件，则输出文件名
                if string.find(filepath, '%.lua') then
					all[#all + 1] = filepath
				end
            elseif mode == "directory" then  -- 如果是目录，则递归遍历子目录
            	if not string.find(filepath, '%.svn') then
            		print(filepath)
                	traverse_directory(filepath)
                end
            end
        end
    end
end
local path = 'D:\\Projects\\Trunk\\Azure\\Output\\Configs'
traverse_directory(path)
local error_list = {
	['announcement/announcement_reader.lua'] = true,
	['announcement/forbidden_reader.lua'] = true,
	['customface_cfg.lua'] = true,
	['diy_fashion_cfg.lua'] = true,
	['fashion_atlas_cfg.lua'] = true,
	['friend_option_player_cfg.lua'] = true,
	['gameforce_extrabuy.lua'] = true,
	['guide_macro.lua'] = true, 
	['home_cfg.lua'] = true,
	['identity_cfg.lua'] = true,
	['memory_decrease.lua'] = true,
	['minigame_cfg.lua'] = 'Color',
	['open_card_cfg.lua'] = 'RESPATH', 
	['pet_britishshorthair.lua'] = 'PET_CUSTOM_TYPE',
	['pet_britishshorthair_baby.lua'] = 'PET_CUSTOM_TYPE',
	['pet_custom_cfg.lua'] = 'Utility.Enum',
	['pet_gloden.lua'] = 'PET_CUSTOM_TYPE',
	['pet_ragdoll.lua'] = 'PET_CUSTOM_TYPE',
	['pet_ragdoll_baby.lua'] = 'PET_CUSTOM_TYPE',
	['pet_samoyed.lua'] = 'PET_CUSTOM_TYPE',
	['pet_samoyed_baby.lua'] = 'PET_CUSTOM_TYPE',
	['quality_cfg.lua'] = 'Configs/PlatformDef.lua',
	['scene_style.lua'] = 'init',
	['shop_cfg.lua'] = 'require_config',
	['shop_cfg.lua'] = 'require_config',
}
collectgarbage("stop")
print(#all, '==================1')
local new = {}
for i=1,#all do
	filepath = string.sub(all[i], string.len(path) + 2)
	if not error_list[filepath] then
		local lua_mem = collectgarbage("count")
		dofile(filepath)
	    new[#new+1] = {filepath, collectgarbage("count") - lua_mem}
	    if filepath == 'fashion.lua' then
	    	print(new[#new][2], 'new===========================')
	    end
    end
end
print(#new, '==================1')
table.sort(new, function(a, b)
	return a[2] > b[2]
end)

for i,v in ipairs(new) do
	print(v[1], v[2], 'file, mem----------------')
	if i >= 20 then
		break
	end
end
--]]


--[[ --打印dofile内存排行，放项目LuaPatch.lua里，可能有gc影响
local memTB = {}
function _G.dofile (path, ...)
	local old = collectgarbage('count')
	local f, err = loadfile(path)

	memTB[path] = math.max(collectgarbage('count')- old, memTB[path] or 0)

	if f then
		return f(...)
	else
		error(err)
	end
end

function _G.printMemTB (count)
	count = count or 10
	local sortTb= {}
	for i, v in pairs(memTB) do
		sortTb[#sortTb+1] = {i, v}
	end
	table.sort(sortTb, function (a, b)
		return a[2] > b[2]
	end)
	for i, v in ipairs(sortTb) do
		print(v[1], v[2], 'dofile==========================')
		if i >= count then
			break
		end
	end
	end
--]]


--[[--fashion.lua
local lua_mem = collectgarbage("count")
print('lua_mem bf:', lua_mem)
local config_data = dofile"fashion.lua"
local lua_mem = collectgarbage("count")
print('lua_mem af1:', lua_mem)

collectgarbage("collect")
local lua_mem = collectgarbage("count")
print('lua_mem af2:', lua_mem)
--car_param,MakeupToTimeCalcType,SuitIdToTimeCalcType,ItemIdToTimeCalcType,exclusive_group,hair_exclusive_group
local function tb_to_key( tb )
	local keys = {}
	for k,v in pairs(tb) do
		keys[#keys+1] = k
	end
	table.sort(keys)
	local key = ''
	for i,k in ipairs(keys) do
		key= k..'='..tb[k]..',' 
	end
	return key
end

local map = {}
for k, v in pairs(config_data) do
	if k == 'MakeupToTimeCalcType' or id == 'SuitIdToTimeCalcType' or id == 'ItemIdToTimeCalcType' then
		for kk,vv in pairs(v) do
			local key = tb_to_key(vv)
			local m = map[key]
			if m then
				v[kk] = m
			else
				map[key] = vv
			end
		end
	elseif k == 'exclusive_group' or k == 'hair_exclusive_group' then
		for kk,vv in pairs(v) do
			for kkk,vvv in pairs(vv) do
				local key = table.concat(vvv, ',')
				local m = map[key]
				if m then
					vv[kkk] = m
				else
					map[key] = vvv
				end
			end
		end
	end
end
map = nil
local lua_mem = collectgarbage("count")
print('lua_mem bf3:', lua_mem)
collectgarbage("collect")
local lua_mem = collectgarbage("count")
print('lua_mem af3:', lua_mem)
--]]
--[[
lua_mem bf:     25.052734375
lua_mem af1:    6843.861328125
lua_mem af2:    4535.66015625
lua_mem bf3:    5148.0146484375
lua_mem af3:    3562.580078125
]]




--[[--headdress_socket.lua
local lua_mem = collectgarbage("count")
print('lua_mem bf:', lua_mem)
local headdress_socket_data = dofile"headdress_socket.lua"
local lua_mem = collectgarbage("count")
print('lua_mem af1:', lua_mem)

collectgarbage("collect")
local lua_mem = collectgarbage("count")
print('lua_mem af2:', lua_mem)
do
	local map = {}
	for _, v in pairs(headdress_socket_data.head_dress_socket) do
		for kk,vv in pairs(v) do
			local key_all = ''
			for iii,vvv in ipairs(vv) do
				if type(vvv) == 'table' then
					local key = table.concat( vvv, ",")..','
					local m = map[key]
					if m then
						vv[iii] = m
					else
						map[key] = vvv
					end
					key_all = key_all..'{'..key..'},'
				else
					key_all = key_all..vvv..','
				end
			end
			local m = map[key_all]
			if m then
				v[kk] = m
			else
				map[key_all] = vv
			end
		end
	end
end
local lua_mem = collectgarbage("count")
print('lua_mem bf3:', lua_mem)
collectgarbage("collect")
local lua_mem = collectgarbage("count")
print('lua_mem af3:', lua_mem)

local lua_mem = collectgarbage("count")
print('lua_mem bf4:', lua_mem)
collectgarbage("collect")
local lua_mem = collectgarbage("count")
print('lua_mem af4:', lua_mem)
--]]

--[[
lua_mem bf:     23.3837890625
lua_mem af1:    8564.38671875
lua_mem af2:    5790.013671875
lua_mem bf3:    6442.802734375
lua_mem af3:    1469.1455078125
lua_mem bf4:    1469.1767578125
lua_mem af4:    1445.1455078125
5790->1469,4M
]]



--[[--hat_socket.lua
local lua_mem = collectgarbage("count")
print('lua_mem bf:', lua_mem)
local hat_socket_data = dofile"hat_socket.lua"
local lua_mem = collectgarbage("count")
print('lua_mem af1:', lua_mem)

collectgarbage("collect")
local lua_mem = collectgarbage("count")
print('lua_mem af2:', lua_mem)
local map = {}
for k, v in pairs(hat_socket_data) do
	if type(k) == 'number' then
		for kk,vv in pairs(v) do
			local key = table.concat( vv, ",")
			local m = map[key]
			if m then
				v[kk] = m
			else
				map[key] = vv
			end
		end
	end
end
map = nil
local lua_mem = collectgarbage("count")
print('lua_mem bf3:', lua_mem)
collectgarbage("collect")
local lua_mem = collectgarbage("count")
print('lua_mem af3:', lua_mem)
--]]
--[[
lua_mem bf:     22.6787109375
lua_mem af1:    9956.2861328125
lua_mem af2:    6817.458984375
lua_mem bf3:    7302.1904296875
lua_mem af3:    2584.052734375

6817->2584,4M多
]]


--[[--badwords.lua
local lua_mem = collectgarbage("count")
print('lua_mem bf:', lua_mem)
local badwords = dofile"badwords.lua"
local lua_mem = collectgarbage("count")
print('lua_mem af1:', lua_mem)

collectgarbage("collect")
local lua_mem = collectgarbage("count")
print('lua_mem af2:', lua_mem)
for k,v in pairs(badwords) do
    if type(v) == 'table' then
        local map = {}
        local count = 0
        local showone = false
        for ii,vv in ipairs(v) do
            if not map[vv] then
                map[vv] = 0
                count = count + 1
            else
                if not showone then
                    print(k, ii, vv, 'iiiiiiiiiii')
                    showone = true
                end
                map[vv] = map[vv] + 1
            end
        end
        print(k, #v, count, 'count=================')
        if #v ~= count then
            local newt = {}
            for kk, num in pairs(map) do
                newt[#newt+1] = kk
            end
            map = nil
            badwords[k] = newt
        end
    end
end
local lua_mem = collectgarbage("count")
print('lua_mem bf3:', lua_mem)
collectgarbage("collect")
local lua_mem = collectgarbage("count")
print('lua_mem af3:', lua_mem)
--]]
--[[
lua_mem bf:     23.0751953125
lua_mem af1:    5793.9775390625
lua_mem af2:    2545.4189453125
specwords       44      绺悎  iiiiiiiiiii
specwords       2542    2067    count=================
badwords        354     澹瑰懆鍒        iiiiiiiiiii
badwords        32307   24053   count=================
bulletbadwords  3       3       count=================
badnames        38      绺悎  iiiiiiiiiii
badnames        44322   31342   count=================
socialbadwords  14      14      count=================
punctuation     3       3       count=================
lua_mem bf3:    4106.248046875
lua_mem af3:    2377.4189453125

2545->2377,200多K
]]

