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
function serialize (o)
    if type(o) == "table" then
        io.write("{\n")
        for k, v in pairs(o) do
            io.write(string.format("  [%s] = ", basicSerialize(k)))
            serialize(v)
            io.write(",\n")
        end
        io.write("}\n")
    else
        io.write(basicSerialize(o))
    end
end

-- supports tables with cycles
-- ** table constructors cannot create tables with cycles
function save (name, value, saved)
    saved = saved or {}                     -- initial value
    io.write(name, " = ")
    if type(value) == "number" or type(value) == "string" then
        io.write(basicSerialize(value), "\n")
    elseif type(value) == "table" then
        if saved[value] then                -- value already saved?
            io.write(saved[value], "\n")    -- use its previous name
        else
            saved[value] = name             -- save name for next time
            io.write("{}\n")                -- create a new table
            for k, v in pairs(value) do     -- save its fields
                k = basicSerialize(k)
                local fname = string.format("%s[%s]", name, k)
                save(fname, v, saved)
            end
        end
    else
        error("cannot save a " .. type(value))
    end
end

serialize{a=12, b='Lua', key='another "one"'}

a = {{"one", "two"}, 3}
b = {k = a[1]}
local t = {}
save("a", a, t)
save("b", b, t)
