-- a homemade package.searchpath from chapter 17.1

-- search for module in path
-- return module filename if found
-- return nil and failed search paths if not found
function search (modname, path)
    modname = string.gsub(modname, "%.", "/")
    local msg = {}
    -- for sequences of 1+ characters not semicolons
    for c in string.gmatch(path, "[^;]+") do
        -- replace '?' with the module name and store in fname
        local fname = string.gsub(c, "?", modname)
        -- attempt to open the file
        local f = io.open(fname)
        if f then
            f:close()
            return fname
        else
            msg[#msg + 1] = string.format("\n\tno file '%s'", fname);
        end
    end
    return nil, table.concat(msg)       -- not found
end
