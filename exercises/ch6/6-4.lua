-- 6.4 write a function to shuffle a given list
-- make sure all permutations are equally probably

math.randomseed() -- weak random
local function shuffle(t)
  local len = #t
  for i = 1, len - 1 do
    local j = math.random(i, len)
    t[i], t[j] = t[j], t[i]
  end
  return t
end

for _, v in ipairs(shuffle { "fish", "flee", "can", "cat", "dot", "bee", "carpenter" }) do
  io.write(v, " ")
end
io.write("\n")
