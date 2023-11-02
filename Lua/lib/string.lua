function string.split(str, reps)
    local resultStrList = {}
    string.gsub(str, '[^' .. reps .. ']+', function(w)
        table.insert(resultStrList, w)
    end)
    return resultStrList
end

function string.start_with(str, prefix)
    if str and prefix then
        local start_len = string.len(prefix)
        return (start_len > 0) and (string.sub(str, 1, start_len) == prefix)
    else
        return false
    end
end

function string.over_with(str, suffix)
    if str and suffix then
        local over_len = string.len(suffix)
        local str_len = string.len(str)
        return (over_len > 0) and (string.sub(str, str_len - over_len + 1) == suffix)
    else
        return false
    end
end