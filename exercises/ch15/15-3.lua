-- 15-2: indent sub tables and safer ["key"]=value syntax

function basicSerialize (o)
    local t = type(o)
    -- %q only works for numbers nil and booleans in Lua 5.3.3 or later
    -- %q surrounds the string with double quotes and escapes existing
    -- double quotes, newlines, and some other characters inside the string
    if t == "number" or t == "string" or t == "boolean" or t == "nil" then
        return string.format("%q", o)
    else
        error("cannot serialize a " .. type(o))
    end
end

-- supports tables without cycles
function serialize (o, level)
    local level = level or 0
    local indent = string.rep("  ", level)
    if type(o) == "table" then
        io.write("{\n")
        for k, v in pairs(o) do
            -- Check for a valid identifier. 
            -- A valid identifier is any string of letters, digits, 
            -- and underscores, not beginning with a digit.
            -- ^ matches beginning; $ matches end.
            -- [_%a] matches letters and underscores; 
            -- [_%w]* matches 0 or more alphanumeric and underscores.
            -- %q option surrounds the value with quotes so we check that
            -- To improve, check also for reserved words.
            local res = basicSerialize(k)
            if res:match("^\"[_%a][_%w]*\"$") then
                io.write(indent, string.format("  %s = ", res))
            else
                io.write(indent, string.format("  [%s] = ", res))
            end
            serialize(v, level + 1)
            io.write(",\n")
        end
        io.write(indent, "}")
    else
        io.write(basicSerialize(o))
    end
end

serialize{a=12, b='Lua', key='another "one"', {{1, 2, 3}, 2, 3}}

