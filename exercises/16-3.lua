--[[
write a function that, given n, returns a specialized function
stringrep_n. Instead of using a closure your function should build 
the text of a lua function with the proper instructions then use
load to produce the final function. Time stringrep and stringrep_n.
]]

function stringrep (s, n)
    local r = ""
    if n > 0 then
        while n > 1 do
            if n % 2 ~= 0 then r = r .. s end
            s = s .. s
            n = math.floor(n / 2)
        end
        r = r .. s
    end
    return r
end

function stringrepbuild (n)
    local header = false
    local done = false

    local reader = function ()
        if done then return nil end

        if not header then
            header = true
            return [[
            return function (s)
                local r = ""
            ]]
        end

        if n > 0 then
            if n > 1 then
                if n % 2 ~= 0 then 
                    n = n - 1
                    return [[
                        r = r .. s
                    ]]
                else
                    n = math.floor(n / 2)
                    return [[
                        s = s .. s
                    ]]
                end
            else
                done = true
                return [[
                    r = r .. s
                    return r
                end
                ]]
            end
        end
        return nil
    end

    -- use assert or you won't get an error message that makes sense
    return assert(load(reader))()
end

-- there is like zero performance difference

stringrep_5 = stringrepbuild(5)
stringrep_n = stringrepbuild(999999)

x = os.clock()
print(stringrep_5("x"))
stringrep_n("x")
print(string.format("stringrep_n elapsed time: %.2f\n", os.clock() - x))

x = os.clock()
print(stringrep("x", 5))
stringrep("x", 999999)
print(string.format("stringrep elapsed time: %.2f\n", os.clock() - x))
