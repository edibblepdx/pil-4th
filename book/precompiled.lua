print([[
Lua precompiles source code before running it.
It can also be used to distribute binary chunks.

Lua comes standard with luac to produce precompiled files

$ luac -o prog.lc prog.lua

loadfile and load accept precompile code

Minimal luac example:
p = loadfile(arg[1])
f = io.open(arg[2], "wb")   -- write binary
f:write(string.dump(p))     -- precompiled code as a string
f:close()

lookup lua opcodes if you care
]])
