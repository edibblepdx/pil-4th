function insert (s, position, to_insert)
    return string.sub(s, 1, utf8.offset(s, position)) 
            .. to_insert 
            .. string.sub(s, utf8.offset(s, position), -1)
end

print(insert("Hello world", 6, "happy"))
print(insert("ação", 5, "!"))
