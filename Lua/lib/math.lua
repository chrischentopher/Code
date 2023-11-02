function math.clamp(v, min, max)
	if v < min then
		return min
	elseif v > max then
		return max
	end
	return v
end