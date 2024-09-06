
n = arg[1] and tonumber(arg[1]) or 1
file = arg[2] and assert(io.open(arg[2], 'r'), "Not a valid file") or io.stdin

-- start at offset -2 because the last character could be a '\n'
count = 0
for offset = 2, math.huge do
    file:seek("end", -offset)
    c = file:read(1) 
    if c == '\n' then 
        count = count + 1
    end
    
    if c == nil then file:seek("set"); break end
    if count >= n then break end
end

print(file:read("a"))
