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
            io.write(indent, string.format("  [%s] = ", basicSerialize(k)))
            serialize(v, level + 1)
            io.write(",\n")
        end
        io.write(indent, "}")
    else
        io.write(basicSerialize(o))
    end
end

serialize{a=12, b='Lua', key='another "one"', {{1, 2, 3}, 2, 3}}
