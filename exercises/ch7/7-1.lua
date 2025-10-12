function sort_file ()
    -- read the lines
    local lines = {}
    for line in io.lines() do
        lines[#lines + 1] = line
    end

    -- sort the lines
    table.sort(lines)

    -- print the sorted lines
    for _, line in ipairs(lines) do
        io.write(line, "\n")
    end
end

-- open files
if #arg == 1 then
    io.input(arg[1])
elseif #arg == 2 then
    io.input(arg[1])
    io.output(arg[2])
end

-- sort file
sort_file()

-- close files
if #arg == 1 then
    io.input():close()
elseif #arg == 2 then
    io.input():close()
    io.output():close()
end

