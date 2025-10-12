-- write a function fileAsArray that returns a proxy to a file
-- after t = fileAsArray("filename")
-- t[i] returns the i-th byte in the file
-- an assignment to t[i] updates the i-th byte in the file
--
-- add __pairs and __len

function fileAsArray (filename)
    local file = assert(io.open(filename, "r+"))
    local proxy = {
        close = function ()
            if file then file:close() end
        end
    }

    mt = {
        __index = function (_, k)
            file:seek("set", k - 1)
            return file:read(1)
        end,

        __newindex = function (_, k, v)
            file:seek("set", k - 1)
            file:write(string.char(v))
        end,

        __pairs = function ()
            file:seek("set")
            local k = 0
            return function ()
                k, v = k+1, file:read(1) or nil
                return v and k, v
            end
        end,

        __len = function ()
            return file:seek("end")
        end
    }
    
    setmetatable(proxy, mt)
    return proxy
end

t = fileAsArray("20-4-file")

t[1] = 67
t[2] = 65
t[3] = 84

print()
print(t[1])
print(t[2])
print(t[3])

print()
print(#t)

print()
for k, v in pairs(t) do print(k, v) end

t.close()
