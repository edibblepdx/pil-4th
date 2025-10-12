function insert (s, position, to_insert)
    return string.sub(s, 1, position) .. to_insert .. string.sub(s, position, -1)
end

print(insert("Hello world", 6, "happy"))
