Account = {balance = 0}

-- create a new Account object 
-- and set Account as it's metatable
-- Account:new (o) == Account.new (self, o)
function Account:new (o)
    o or {}
    self.__index = self
    setmetatable(o, self)
    return o
end

-- increase an Account's balance
function Account:deposit (v)
    self.balance = self.balance + v
end

-- decrease an Account's balance
function Account:withdraw (v)
    if v > self.balance then error"insufficient funds" end
    self.balance = self.balance - v
end
