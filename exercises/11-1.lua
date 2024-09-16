-- chapter 11 word frequency program
-- exercise: modify to ignore words less than 4 letters

-- step 1: count all words
local counter = {}

for line in io.lines() do
    for word in string.gmatch(line, "%w+") do -- sequences of one or more alphanumeric characters
        if word:len() >= 4 then
            counter[word] = (counter[word] or 0) + 1
        end
    end
end

-- step 2: collect all words
local words = {}    -- list of all words found in the text

for w in pairs(counter) do
    words[#words + 1] = w
end

-- step 3: sort all words
table.sort(words, function (w1, w2)
    -- return true if w1 has more occurances than w2
    -- else return false if w1 and w2 are not of equal length
    -- else return true if w1 is alphabetically less than w2
    return counter[w1] > counter[w2] or                        
    counter[w1] == counter[w2] and w1 < w2   
end)

-- number of words to print
local n = math.min(tonumber(arg[1]) or math.huge, #words)

-- print words and frequencies
for i = 1, n do
    io.write(words[i], "\t", counter[words[i]], "\n")
end
