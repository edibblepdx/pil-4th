-- since (not not x) evaluates to a boolean with the same truth value as x
-- then x == x is true if and only if x is a boolean
function is_boolean (x)
	return not not x == x
end

function is_boolean (x)
	return x == true or x == false
end
