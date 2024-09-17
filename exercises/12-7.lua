-- if there is any difference it should be between converting table to numeric
-- and back again

t1 = os.time()
t2 = t1

-- adding 1 to month then day
t1 = os.date("*t", t1)
t1.month = t1.month + 1
t1 = os.date("*t", os.time(t1))
t1.day = t1.day + 1
t1 = os.time(t1)

-- adding 1 to day then month
t2 = os.date("*t", t2)
t2.day = t2.day + 1
t2 = os.date("*t", os.time(t2))
t2.month = t2.month + 1
t2 = os.time(t2)

print(t1 == t2) --> true
