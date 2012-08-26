require "ta.helpers.strings"
require "ta_tests.lib.lunity"
require "ta.resources.constants"
module("strings", package.seeall, lunity)

function test_split_breaks_string_into_array_based_on_delimiter()
    delimiter = ","
    numbers = "1"..delimiter.."2"..delimiter.."3"
    fields = split(numbers,delimiter)
    assertEqual(#fields, 3, "Split should return correct array")
end

function test_endswith_returns_false_if_either_parameter_is_nil()
    assertion = "endswith should return false if either parameter is nil"
    assertFalse(endsWith(nil, ""), assertion)
    assertFalse(endsWith("", nil), assertion)
end

runTests{useANSI = false}