require "ta.resources.constants"
require "ta.helpers.conditionalValues"
require "ta.helpers.collections"
require "ta_tests.lib.lunity"
module("collections", package.seeall, lunity)

ItemOne = 1
ItemTwo = 2
ItemFive = 5
TestList = { ItemOne, ItemTwo }

function test_contains_returns_true_when_list_contains_object()
    assertTrue(contains(TestList, ItemTwo), "List should contain object")
end

function test_contains_returns_false_when_list_does_not_contain_object()
    assertFalse(contains(TestList, ItemFive), "List should not contain object")
end

function test_getRandomFrom_returns_unpredictable_result()
    results = {}
    for i=1, 100 do
        randomTeam = getRandomFrom({ TEAM_ONE, TEAM_TWO })
        results[randomTeam] = iif(results[randomTeam] == nil, 0, results[randomTeam]) + 1
    end
    assert(results[TEAM_ONE] > 0 and results[TEAM_TWO] > 0, "getRandomFrom should return unpredictable result")
end

function test_size_returns_error_if_parameter_is_not_a_table()
    assertTrue(1==0, "This test still needs to be written.")
end

function test_size_returns_numeric_value()
    assertTrue(1==0, "This test still needs to be written.")
end

runTests{useANSI = false}