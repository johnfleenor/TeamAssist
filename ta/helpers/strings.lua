--- Split a string based on a certain delimiter
-- @param str String to split
-- @param delim Delimiter to split on
-- @param maxNb Maximum number of times to split, or nil
-- @return Table containing split string
function split(str, delim, maxNb)
    -- Eliminate bad cases...
    if string.find(str, delim) == nil then
        return { str }
    end
    if maxNb == nil or maxNb < 1 then
        maxNb = 0    -- No limit
    end
    local result = {}
    local pat = "(.-)" .. delim .. "()"
    local nb = 0
    local lastPos
    for part, pos in string.gfind(str, pat) do
        nb = nb + 1
        result[nb] = part
        lastPos = pos
        if nb == maxNb then break end
    end
    -- Handle the last field
    if nb ~= maxNb then
        result[nb + 1] = string.sub(str, lastPos)
    end
    return result
end

--- Determine if a string ends with a specific value
-- @param stringToSearchIn String to look for the value in
-- @param stringToSearchFor String to search for.  This can optionally be a table of values to look for
-- @return boolean
function endsWith(stringToSearchIn, stringToSearchFor)
    local result = false
    if (stringToSearchIn ~= nil and stringToSearchFor ~= nil) then
        if type(stringToSearchFor) == "table" then
            for key,value in ipairs(stringToSearchFor) do
                if string.sub(stringToSearchIn, string.len(stringToSearchIn) - string.len(value) + 1) == value then
                    result = true
                    break
                end
            end
        else
            result = string.sub(stringToSearchIn, string.len(stringToSearchIn) - string.len(stringToSearchFor) + 1) == stringToSearchFor
        end
    end
    return result
end
