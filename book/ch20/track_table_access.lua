-- tracking table accesses chapter 20.2
--
-- t:       the table we want to track
-- proxy:   the table was have
-- mt:      proxy metatable
--
-- t is wrapped in a closure with proxy. We create t and pass it to track(t) and
-- receive proxy. proxy is always empty, when we attempt to update proxy those 
-- indices do not exist. Because they do not exist __index and __newindex are
-- called and update t, the original table. The _ is throwing away proxy, or
-- syntactically saying that we don't want it.

function track (t)
    local proxy = {}        -- proxy table for 't'

    -- create metatable for the proxy
    local mt = {
        -- interpreter looks for this for all index non-existing table accesses
        __index = function (_, k)
            print("*access to element " .. tostring(k))
            return t[k]     -- access the original table
        end,

        -- interpreter looks for this for all index non-existing table updates
        __newindex = function (_, k)
            print("*update of element " .. tostring(k) ..
                  " to " .. tostring(v))
            t[k] = v        -- update original table
        end,

        -- proxy is empty, we want to iterate over t
        __pairs = function ()
            return function (_, k)  -- iteration function
                local nextkey, nextvalue = next(t, k)
                if nextkey ~= nil then
                    print("*traversing element " .. tostring(nextkey))
                end
                return nextkey, nextvalue
            end
        end,

        -- proxy is empty, we want the length of t
        __len = function () return #t end
    }

    setmetatable(proxy, mt)

    return proxy
end
