-- create and iterator uniquewords that returns all
-- words from a given file without repetitions

function uniquewords ()
    local line = io.read()              -- current line
    local pos = 1                       -- current position in the line
    local uwords = {}                   -- unique words
    return function ()                  -- iterator function
        while line do                   -- repeat while there are lines
            local w, e = string.match(line, "(%w+)()", pos)
            if w then                   -- found a word?
                pos = e                 -- next position is after this word
                if not uwords[w] then   -- check for unique word
                    uwords[w] = true    -- add word
                    return w            -- return the word
                end
            else
                line = io.read()        -- word not found; try next line
                pos = 1                 -- restart from first position
            end
        end
        return nil                      -- no more lines: end of traversal
    end
end

for word in uniquewords() do
    print(word)
end
