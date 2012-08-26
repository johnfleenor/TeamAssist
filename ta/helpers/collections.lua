math.randomseed(os.time()) -- TODO this is inefficient? It's executed once per object that loads this script

--- Check if a table contains a certain object
-- @param list Table to search through
-- @param candidate Object to look for
-- @return boolean
function contains(list, candidate)
    for _,v in pairs(list) do
        if v == candidate then    
            return true
        end
    end
       return false
end

--- Determine the size of of a table
-- @param table Table to get the size of
-- return Integer Number of elements in the table
function size(list)
    if type(list)~="table" then
        error("argument '"..list.."' is not a table")
    end
    local count = 0
    for _,_ in pairs(list) do
        count = count+1
    end
    return count
end

function getRandomFrom(candidates)
    return candidates[math.random(1, #candidates)]
end
