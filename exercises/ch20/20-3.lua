-- implement readOnly with the __index metamethod as a function 
-- so that proxy tables can share a metatable

function readOnly (t)
    local proxy = {}
    local mt = {        -- create metatable
        __index = t,
        __newindex = function (t, k, v)
            error("attempt to update a read-only table", 2)
        end
    }
    setmetatable(proxy, mt)
    return proxy
end

local mt = {      -- create metatable
    __index = function (t, k) return t.___[k] end,
    __newindex = function (t, k, v)
        error("attempt to update a read-only table", 2)
    end
}

function newReadOnly (t)
    local proxy = {}
    proxy.___ = t
    setmetatable(proxy, mt)
    return proxy
end

local t = {1, 2, 3}
t = newReadOnly(t)

print(t[1])
t[1] = 2
