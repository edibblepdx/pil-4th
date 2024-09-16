-- sort the lines of the file alphabetically
function sort_file (filein, fileout)
    -- read the lines
    local lines = {}
    for line in filein:lines() do
        lines[#lines + 1] = line
    end

    -- sort the lines
    table.sort(lines)

    -- print the sorted lines
    for _, line in ipairs(lines) do
        fileout:write(line, "\n")
    end
end

-- check if a file exists
function file_exists(filename)
    file = io.open(filename, 'r')
    if file then io.close(file) return true else return false end
end

-- main body
local in_filename = nil
local out_filename = nil

if #arg == 1 then
    in_filename = arg[1]

elseif #arg == 2 then
    in_filename, out_filename = arg[1], arg[2]

    if file_exists(arg[2]) then
        while overwrite ~= 'y' and overwrite ~= 'n' do
            io.write(string.format("Do you want to overwrite %s? [Y/n]\n", arg[2]))
            overwrite = io.read():lower()
        end
    end

    if overwrite == 'n' then out_filename = nil end

elseif #arg ~= 0 then
    io.stderr:write("Error: Expected 0, 1, or 2 arguments")
    os.exit(1)
end

-- open files
filein = in_filename and assert(io.open(arg[1], 'r'), "Not a valid file") or io.stdin
fileout = out_filename and assert(io.open(arg[2], 'w'), "Not a valid file") or io.stdout

sort_file(filein, fileout)

-- close files
if filein ~= io.stdin then filein:close() end
if fileout ~= io.stdout then fileout:close() end

