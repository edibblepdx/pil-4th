magic_characters = "().%+-*?[]^$"

-- replace each sequence of two delimiters with one
function reduce_delimiter(s1, delimiter)
    s2 = string.gsub(s1, delimiter .. delimiter, delimiter)
    if s1 == s2 then return s1 else return reduce_delimiter(s2, delimiter) end
end

-- split the string
function split (s, delimiter)
    s = s .. delimiter

    -- check for magic delimiter
    if string.find(magic_characters, delimiter) then
        delimiter = "%" .. delimiter
    end

    -- fix the delimiters
    s = reduce_delimiter(s, delimiter)

    -- finally split the string
    words = {}
    for w in string.gmatch(s, "(.-)" .. delimiter) do
        words[#words + 1] = w
    end

    return words
end

-- formatted output
function print_table_formatted(t)
    io.write("{")
    for i, w in ipairs(t) do
        if i < #t then
            io.write('"' .. w .. '", ')
        else
            io.write(w .. '"}')
        end
    end
    print()
end

t = split("a  whole new    world", " ")
-- t = {"a", "whole", "new", "world"}
print_table_formatted(t)

t = split("a)whole)new)world", ")")
print_table_formatted(t)

t = split("a-whole-new-world", "-")
print_table_formatted(t)



