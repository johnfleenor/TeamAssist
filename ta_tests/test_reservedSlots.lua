require "ta.reservedSlots"
require "ta.resources.messages"
require "ta_tests.lib.lunity"
require "ta_tests.lib.lemock"
module("reservedSlots", package.seeall, lunity)

function setup()
    mc = lemock.controller()
    engine_mock = mc:mock()
end

function test_loadReservedSlots_loads_file_into_array()
    assertTrue(1==0, "This test still needs to be written.")
end

function test_loadReservedSlots_throws_error_if_any_key_is_non_numeric()
    assertTrue(1==0, "This test still needs to be written.")
end

function test_loadReservedSlots_throws_error_if_file_is_not_present()
    assertTrue(1==0, "This test still needs to be written.")
end

function test_loadReservedSlots_gives_message_with_empty_file()
    assertTrue(1==0, "This test still needs to be written.")
end

function test_findPublicPlayerToKick_returns_nil_if_no_public_players_are_on_server()
    assertTrue(1==0, "This test still needs to be written.")
end

function test_findPublicPlayerToKick_returns_player_object_if_a_public_player_is_on_server()
    assertTrue(1==0, "This test still needs to be written.")
end

function test_findPublicPlayerToKick_skips_commanders_if_configurations_says_to()
    assertTrue(1==0, "This test still needs to be written.")
end

function test_findPublicPlayerToKick_finds_proper_player_based_on_duration_configuration()
    assertTrue(1==0, "This test still needs to be written.")
end

runTests{useANSI = false}