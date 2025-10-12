-- 22.1 modify the function getfield to accept only single dots as name separators

-- invalid: math?sin, string!!!gsub

function getfield(f)
  local v = _G
  for w, d in string.gmatch(f, "([%a_][%w_]*)(%W*)") do
    if d ~= "." and d ~= "" then
      error("invalid delimiter", 2)
    end
    v = v[w]
  end
  return v
end

a = {}; a.b = {}; a.b.c = {}; a.b.c.d = 5

print(getfield("math.sin"))
print(getfield("a.b.c.d"))
--print(getfield("a..b.c.d"))      --> invalid
--print(getfield("math?sin"))      --> invalid
--print(getfield("string!!!gsub")) --> invalid
