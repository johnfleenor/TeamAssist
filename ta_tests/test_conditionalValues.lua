require "ta.helpers.conditionalValues"
require "ta_tests.lib.lunity"
module("conditionalValues", package.seeall, lunity)

function test_iif_returns_second_argument_when_first_argument_is_true()
    testvalue = "foo"
    iif_result = iif(true, testvalue, nil)
    assertEqual(iif_result, testvalue, "iif should have returned correct value")
end

function test_iif_returns_third_argument_when_first_argument_is_false()
    testvalue = "foo"
    iif_result = iif(false, nil, testvalue)
    assertEqual(iif_result, testvalue, "iif should have returned correct value")
end

runTests{useANSI = false}