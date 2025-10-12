function multiload (...)
    local arg = {...}

    local i = 0
    local reader = function ()
        i = i + 1
        local t = type(arg[i])
        if t == "string" then
            -- return a string as is and move to
            -- the next chunk
            return arg[i]
        elseif t == "function" then
            -- make sure we read all of this chunk
            -- readers should return nil when done
            -- so we check for that
            local res = arg[i]()
            if res ~= nil then 
                i = i - 1
                return res
            else return '\n' end
        else
            -- return nil when our reader finishes
            return nil
        end
    end
    
    return load(reader)
end

f = multiload("local x = 10;",
              io.lines("16-temp", "*L"),
              " print(x)")

print(f()) --> creates x, executes code from temp, then prints x
-- temp can modify or update x
