-- write a function to return the day of the week
-- (coded as an integer, on is Sunday) of the given date

days_of_week = {
    "Sunday"
    , "Monday"
    , "Tuesday"
    , "Wednesday"
    , "Thursday"
    , "Friday"
    , "Saturday"
}

function day_of_week (t)
    return os.date("*t", t).wday
end

local t = os.time()
local day = day_of_week(t)
print(day, days_of_week[day])

