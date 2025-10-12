-- A simple module for sets, chapter 20.1
-- modified with a metatable mt

local mt    = {}    -- metatable for sets
local Set   = {}

-- create a new set with the values of a given list
function Set.new (l)
    local set = {}
    setmetatable(set, mt)   -- set the metatable
    for _, v in ipairs(l) do set[v] = true end
    return set
end

function Set.union (a, b)
    -- should raise error messages like this
    if getmetatable(a) ~= mt or getmetatable(b) ~= mt then
        -- message and level 2 in the calling hierarchy; level 1 is your own function
        error("attempt to 'add' a set with a non-set value", 2)
    end
    local res = Set.new{}
    for k in pairs(a) do res[k] = true end
    for k in pairs(b) do res[k] = true end
    return res
end

function Set.intersection (a, b)
    local res = Set.new{}
    for k in pairs(a) do
        res[k] = b[k]
    end
    return res
end

-- presents a set as a string
function Set.tostring (set)
    local l = {}    -- list to put all elements from the set
    for e in pairs(set) do
        l[#l + 1] = tostring(e)
    end
    return "{" .. table.concat(l, ", ") .. "}"
end

mt.__add = Set.union
mt.__mul = Set.intersection

mt.__le = function (a, b)   -- subset
    for k in pairs(a) do
        if not b[k] then return false end
    end
    return true
end

mt.__lt = function (a, b)   -- proper subset
    return a <= b and not (b <= a)
end

mt.__eq = function (a, b)   -- set containment
    return a <= b and b <= a
end

mt.__tostring = Set.tostring

--[[
mt.__sub    subtraction
mt.__div    float division
mt.__idiv   floor division
mt.__unm    negation
mt.__mod    modulo
mt.__pow    exponentiation

mt.__band   bitwise AND
mt.__bor    bitwise OR
mt.__bxor   bitwise exclusive OR
mt.__bnot   bitwise NOT
mt.__shl    left shift
mt.__shr    right shift

mt.__concat concatenation
]]

-- when looking for a metamethod for mixed types Lua
-- first checks the first type for a metamethod
-- second checks the second type for a metamethod
-- third raises an error

-- test code
-- require calls the loader passing the module name as the
-- first argument. The vararg expression '...' results in
-- that name. If we run this module standalone the '...'
-- should result in a nil value
if ... == nil then
    local s1 = Set.new{10, 20, 30, 50}
    local s2 = Set.new{30, 1}

    -- could throw asserts in here for tests
    assert(getmetatable(s1) == getmetatable(s2), "different metatables")
    print(getmetatable(s1))
    print(getmetatable(s2))

    local s3 = s1 + s2
    print(Set.tostring(s3))

    print(Set.tostring((s1 + s2) * s1))

    s1 = Set.new{2, 4}
    s2 = Set.new{4, 10, 2}
    print(s1 <= s2)         --> true
    print(s1 < s2)          --> true
    print(s1 >= s1)         --> true
    print(s1 > s1)          --> false
    print(s1 == s2 * s1)    --> true

    print(s1)
end

return Set
