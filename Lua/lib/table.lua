-- table
local function _is_array(tb)
	local count = 0
	for k, v in pairs(tb) do
		count = count + 1
	end
	return count == #tb
end

local function _is_no_quotation(rules, parent_key)
    local no_quotation = false
    if rules then
        if type(rules["no_quotation"]) == "boolean" then
            no_quotation = rules["no_quotation"]
        elseif type(rules["no_quotation"]) == "table" then
            if parent_key then
                no_quotation = rules["no_quotation"][parent_key] or false
            end
        end
    end
    return no_quotation
end

local function _is_force_array(rules, parent_key)
    local force_array = false
    if rules then
        if type(rules["force_array"]) == "boolean" then
            force_array = rules["force_array"]
        elseif type(rules["force_array"]) == "table" then
            if parent_key then
                force_array = rules["force_array"][parent_key] or false
            end
        end
    end
    return force_array
end

local function _list_table(tb, table_list, level, rules, parent_key)
    local ret = ""
    local indent = string.rep(" ", level*4)

	local force_array = _is_force_array(rules, parent_key)
    local no_quotation = _is_no_quotation(rules, parent_key)
    for k, v in pairs(tb) do
		if force_array and _is_array(tb) then
            ret = ret .. indent
        else
			if type(k) == "string" and tonumber(k) == nil and no_quotation then
				ret = ret .. indent .. tostring(k) .. " = "
			else
                local quo = type(k) == "string" and "\"" or ""
                ret = ret .. indent .. "[" .. quo .. tostring(k) .. quo .. "] = "
			end
		end

        if type(v) == "table" then
            local t_name = table_list[v]
            if t_name then
                ret = ret .. tostring(v) .. " -- > [\"" .. t_name .. "\"]\n"
            else
                table_list[v] = tostring(k)
                ret = ret .. "{\n"
                ret = ret .. _list_table(v, table_list, level+1, rules, k)
                ret = ret .. indent .. "},\n"
            end
        elseif type(v) == "string" then
            ret = ret .. "\"" .. tostring(v) .. "\",\n"
        else
            ret = ret .. tostring(v) .. ",\n"
        end
    end

    return ret
end

function table_tostring(tb, dump_mt, rules)
    if type(tb) ~= "table" then
        error("Sorry, it's not table, it is " .. type(tb) .. ".")
        return tostring(tb)
    end

    local ret = "{\n"
    local table_list = {}
    table_list[tb] = "root table"
    ret = ret .. _list_table(tb, table_list, 1, rules)
    ret = ret .. "}"

    if dump_mt then
        local mt = getmetatable(tb)
        if mt then
            ret = ret .. "\n"
            local t_name = table_list[mt]
            ret = ret .. "<metatable> = "

            if t_name then
                ret = ret .. tostring(mt) .. " -- > [\"" .. t_name .. "\"]\n"
            else
                ret = ret .. "{\n"
                ret = ret .. _list_table(mt, table_list, 1)
                ret = ret .. "}\n"
            end
        end
    end

    return ret
end

function table.dump(tb, dump_mt, rules)
    print(tostring(tb) .. " = " .. table_tostring(tb, dump_mt, rules))
end

function table.copy(t, ignoreKeys, old)
    if type(t) ~= "table" then return t end
    local meta = getmetatable(t)
    local target = {}

    --print("------> CopyTable: t")
   	old = old or {}
   	old[t] = target
    for k, v in pairs(t) do
    	--print("  --- k, v = ", k, v)
        if type(v) == "table" then
        	--print("__ type(v) == table!", v)
        	local bCopy = true
        	if ignoreKeys then
        		--print("__Has ignoreKeys!", #ignoreKeys)
        		for i = 1, #ignoreKeys do
        			--print("__CopyTable: i, k, ignoreKeys[i] = ", i, k, ignoreKeys[i], k == ignoreKeys[i])
        			if k == ignoreKeys[i] then
        				bCopy = false
        				--print("__NotCopy: k ", k)
        				break
        			end
        		end
        	end
        	if old[v] then
        		bCopy = false
        		v = old[v]
        	end
        	if bCopy then
            	target[k] = table.copy(v, ignoreKeys, old)
            else
            	target[k] = v
            end
            old[v] = target[k]
        else
             target[k] = v
        end
    end
    setmetatable(target, meta)
    return target
end

function table.compare(t1, t2, ignore_mt, old)
	local ty1 = type(t1)
	local ty2 = type(t2)
	old = old or {}
	if ty1 ~= ty2 then return false end
	-- non-table types can be directly compared
	if ty1 ~= 'table' and ty2 ~= 'table' then return t1 == t2 end
	-- as well as tables which have the metamethod __eq
	local mt = getmetatable(t1)
	if not ignore_mt and mt and mt.__eq then return t1 == t2 end
	if old[t1] then
		return old[t1] == t2
	end
	old[t1] = t2
	for k1,v1 in pairs(t1) do
		local v2 = t2[k1]
		if v2 == nil or not table.compare(v1, v2, false, old) then return false end
	end
	for k2,v2 in pairs(t2) do
		local v1 = t1[k2]
		if v1 == nil or not table.compare(v1, v2,false, old) then return false end
	end
	return true
end

function table.count(tbl)
	if not tbl then return 0 end
	local count = 0
	for k, v in pairs(tbl) do
		count = count + 1
	end
	return count
end

function table.is_array(tbl)
	return table.count(tbl) == #tbl
end

function table.array(num, fun)
	local tb = {}
	for i=1,num do
		tb[i] = fun and fun(i) or i
	end
	return tb
end

function table.shuffle(tbl)
	for i = #tbl, 2, -1 do
		local j = math.random(i)
		tbl[i], tbl[j] = tbl[j], tbl[i]
	end
	return tbl	
end

function table.unique_values(tbl, keys)
    values = values or {}
    for k, v in pairs(tbl) do
        values[v] = true
    end
    return values  
end

function table.unique_array_values(tbl)
    local values = {}
    for k, v in pairs(table.unique_values(tbl)) do
        values[#values+1] = k
    end
    return values
end



--[[
local v = {}
local tb = {
	k = {v = 12},
	v = v,
}
v.tb = tb
table.dump(tb)
local co = table.copy(tb)
table.dump(co)
print(table.compare(tb, co), 'test==============table.compare')
print(table.count(tb), 'test==============table.count')
print(table.is_array(tb), 'test==============table.is_array')

local array = table.array(10, function(i)
	return i * 2
end)
table.dump(array)
table.shuffle(array)
table.dump(array)
]]