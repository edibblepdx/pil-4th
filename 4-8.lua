function ispali(s)
    s = s:gsub("[%s%p]", "")
    return s:lower() == string.reverse(s:lower())
end

print(ispali("step! on nopets"))
print(ispali("banana"))
