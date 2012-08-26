--- Return values based on a boolean value
-- @param condition Boolean value to compare
-- @param a Value to return if condition is true
-- @param b Value to return if condition is false
-- @return a or b depending on condition
function iif(condition,a,b)
        if condition then
                return a
        else
                return b
        end
end
