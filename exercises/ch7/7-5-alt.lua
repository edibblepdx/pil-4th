
n = arg[1] and tonumber(arg[1]) or 1
file = arg[2] and assert(io.open(arg[2], 'r'), "Not a valid file") or io.stdin

lines = {}
for line in file:lines() do
    lines[#lines + 1] = line
end

if n > #lines then n = #lines end

tail = {}
for i = 0, n do
    tail[n - i] = lines[#lines - i]
end

for _, line in ipairs(tail) do
    print(line)
end
