function remove (s, pos, len)
    return s:sub(1, pos - 1) .. s:sub(pos + len, -1)
end

print(remove("hello world", 7, 4))
