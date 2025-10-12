function remove (s, pos, len)
    return s:sub(1, utf8.offset(s, pos - 1)) 
            .. s:sub(utf8.offset(s, pos + len), -1)
end

print(remove("ação", 2, 2))
