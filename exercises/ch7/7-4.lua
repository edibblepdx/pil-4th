
file = arg[1] and assert(io.open(arg[1], 'r'), "Not a valid file") or io.stdin

-- start at offset -2 because the last character could be a '\n'
for offset = 2, math.huge do
    file:seek("end", -offset)
    if file:read(1) == '\n' then break end
end

print(file:read("L"))
