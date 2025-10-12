-- 20-2 define a __len metamethod for set size

local mt    = {}    -- metatable for sets
local Set   = {}

-- create a new set with the values of a given list
function Set.new (l)
    local set = {}
    setmetatable(set, mt)   -- set the metatable
    for _, v in ipairs(l) do set[v] = true end
    return set
end

-- set difference
function Set.difference(a, b)
    local res = Set.new{}
    for k in pairs(a) do
        res[k] = not b[k] or nil    -- nil for garbage collection
    end
    return res
end

-- set size
function Set.size (a)
    count = 0
    for k in pairs(a) do
        count = count + 1
    end
    return count
end

-- presents a set as a string
function Set.tostring (set)
    local l = {}    -- list to put all elements from the set
    for e in pairs(set) do
        l[#l + 1] = tostring(e)
    end
    return "{" .. table.concat(l, ", ") .. "}"
end

mt.__sub = Set.difference
mt.__len = Set.size

-- test code
-- require calls the loader passing the module name as the
-- first argument. The vararg expression '...' results in
-- that name. If we run this module standalone the '...'
-- should result in a nil value
if ... == nil then
    local s1 = Set.new{10, 20, 30, 50}
    local s2 = Set.new{30, 1}

    local s3 = s1 - s2
    print(Set.tostring(s3))

    print(#s3)
end

return Set
