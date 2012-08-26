require "ta.helpers.comparisons"
require "ta_tests.lib.lunity"
require "ta.resources.constants"
module("comparisons", package.seeall, lunity)

function test_compareTo_returns_COMPARETO_FIRST_IS_SMALLER_when_first_parameter_is_smaller_than_second_paramter()
    assertEqual(compareTo(0,1), COMPARETO_FIRST_IS_SMALLER, "compareTo should return COMPARETO_FIRST_IS_SMALLER")
end

function test_compareTo_returns_COMPARETO_FIRST_IS_BIGGER_when_first_parameter_is_bigger_than_second_paramter()
    assertEqual(compareTo(1,0), COMPARETO_FIRST_IS_BIGGER, "compareTo should return COMPARETO_FIRST_IS_BIGGER")
end

function test_compareTo_returns_COMPARETO_FIRST_AND_SECOND_ARE_EQUAL_when_first_parameter_is_equal_to_second_paramter()
    assertEqual(compareTo(1,1), COMPARETO_FIRST_AND_SECOND_ARE_EQUAL, "compareTo should return COMPARETO_FIRST_AND_SECOND_ARE_EQUAL")
end

runTests{useANSI = false}