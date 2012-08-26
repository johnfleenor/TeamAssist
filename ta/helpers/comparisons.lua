COMPARETO_FIRST_IS_SMALLER = -1
COMPARETO_FIRST_IS_BIGGER = 1
COMPARETO_FIRST_AND_SECOND_ARE_EQUAL = 0

--- Compare two values, determine which is bigger
-- @param first First value
-- @param second Second value
-- @return COMPARETO_FIRST_IS_SMALLER if the first is smaller, COMPARETO_FIRST_IS_BIGGER if the first is bigger, COMPARETO_FIRST_AND_SECOND_ARE_EQUAL if they are equal
function compareTo(first, second)
    local result = COMPARETO_FIRST_AND_SECOND_ARE_EQUAL
    if first < second then
        result = COMPARETO_FIRST_IS_SMALLER
    end
    if first > second then
        result = COMPARETO_FIRST_IS_BIGGER;
    end
    return result
end
