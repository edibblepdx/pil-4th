-- 25.1 Modify getvarvalue to work with difference coroutines

function getvarvalue(co, name, level, isenv)
  local value
  local found = false
  local thread = false

  -- coroutines run in a different stack
  if type(co) == "thread" then
    thread = true
    level = level or 1
  else
    name, level = co, name
    level = (level or 1) + 1
  end

  -- try local variables
  for i = 1, math.huge do
    local n, v
    if thread then
      n, v = debug.getlocal(co, level, i)
    else
      n, v = debug.getlocal(level, i)
    end
    if not n then break end
    if n == name then
      value = v
      found = true
    end
  end
  if found then return "local", value end

  -- try non-local variables
  local func
  if thread then
    func = debug.getinfo(co, level, "f").func
  else
    func = debug.getinfo(level, "f").func
  end
  for i = 1, math.huge do
    local n, v = debug.getupvalue(func, i)
    if not n then break end
    if n == name then return "upvalue", v end
  end

  if isenv then return "noenv" end -- avoid loop

  -- not found; get value from the environment
  local env
  if thread then
    _, env = getvarvalue(co, "_ENV", level, true)
  else
    _, env = getvarvalue("_ENV", level, true)
  end
  if env then
    return "global", env[name]
  else -- no _ENV available
    return "noenv"
  end
end

local a = 42; print(getvarvalue("a")) --> local 42

local co = coroutine.create(function()
  local x = 10
  coroutine.yield()
  local y = 20
end)

coroutine.resume(co)
print(getvarvalue(co, "x")) --> local 10
print(getvarvalue(co, "y")) --> global nil
