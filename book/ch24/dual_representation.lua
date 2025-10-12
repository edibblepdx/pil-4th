-- Accounts class using dual representation chapter 21.3
-- comparable cost as the original in terms of time and memory
-- allows the balance to be private and keep inheritance
-- requires more work from the garbage collector as old
-- accounts will not be removed from the balances table

local balance = {}

Account = {}

function Account:withdraw(v)
  balance[self] = balance[self] - v
end

function Account:deposit(v)
  balance[self] = balance[self] + v
end

function Account:balance()
  return balance[self]
end

function Account:new(o)
  o = o or {}   -- create table if user does not provide one
  setmetatable(o, self)
  self.__index = self
  balance[o] = 0   -- initial balance
  return o
end

a = Account:new()
a:deposit(100.0)
print(a:balance())
