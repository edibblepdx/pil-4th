--[[
Write a function loadwithprefix that accepts chunks represented
as both strings and reader functions. Even in the case that the
originalchunk is a string loadwithprefix should not actually
concatenate the prefix with the chunk. Instead it should call
load with a proper reader function that first returns the prefix 
then returns the original chunk.
]]

-- assuming prefix is always a string
function loadwithprefix (prefix, chunk)
    local reader

    -- create or reuse the chunk reader
    if type(chunk) == "string" then
        local done = false
        reader = function ()
            if not done then
                done = true
                return chunk
            else
                return nil
            end
        end
    elseif type(chunk) == "function" then
        reader = chunk
    end

    -- combined reader function
    -- returns the prefix then the chunk
    local prefix_done = false
    local combined_reader = function () 
        if not prefix_done then
            prefix_done = true
            return prefix
        else
            return reader()
        end
    end

    return load(combined_reader)
end

f = loadwithprefix("print(yippee)", io.lines("16-temp", "*L"))

f = loadwithprefix("return ", "a + b + c")
a = 5; b = 10; c = 15   -- must be global
print(f())
