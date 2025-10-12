-- dynamically generated code
-- load, loadfile, and dofile
-- load does not compile with lexical scoping
-- I believe this is Lua versions greater than 5.1 only
-- In Lua 5.1, the function loadstring did load for strings

print "enter function to be plotted (with variable 'x'):"
local line = io.read()

--[[ --old version
local f = assert(load("return " .. line))
for i = 1, 20 do
    x = i   -- global 'x' (to be visible from the chunk)
    print(string.rep("*", f()))
end
]]

-- new version avoids global variable
local f = assert(load("local x = ...; return " .. line))
for i = 1, 20 do
    print(string.rep("*", f(i)))
end

print()
print([[
-- when loading a chunk Lua will compile functions but not define them
-- function definitions are assignments and happen at runtime

-- assume foo has a function foo()
f = loadfile("foo.lua")
print(foo)  --> nil
f()         -- run the chunk
print(foo)  --> valid

-- what dofile does is essentially
function dofile (filename)
    local f = assert(loadfile(filename))
    return f()  -- runs the chunk
end

-- what if you only want to run files with the name of your cat?
-- create a closure
do
    local oldDofile = dofile
    dofile = function (filename)
        if filename == "Scotty.lua" then
            oldDofile(filename)
        else
            return nil, "meow"
        end
    end
end

-- then the original dofile is private outside of the new closure
]])
