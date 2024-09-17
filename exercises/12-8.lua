-- produce system timezone

-- this is how we cheat
function timezone ()
    os.execute("date +%Z")
end

timezone()
