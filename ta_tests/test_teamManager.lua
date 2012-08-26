require "ta.helpers.strings"
require "ta.TeamManager"
require "ta.TeamManager"
require "ta.resources.constants"
require "ta.resources.messages"
require "ta_tests.lib.lunity"
require "ta_tests.lib.lemock"
module("teamManager", package.seeall, lunity)

function setup()
    mc = lemock.controller()
    user_mock = mc:mock()
    engine_mock = mc:mock()
    util_mock = mc:mock()
    user1_mock = mc:mock()
    user2_mock = mc:mock()
end

function test_sendToRandom_gets_destination_team_from_util_when_team_sizes_are_equal()
    destinationTeam = TEAM_ONE
    engine_mock:getTeamSize(mc.ANYARGS);mc:times(2)
    util_mock.compareTo(mc.ANYARGS);mc:returns(COMPARETO_FIRST_AND_SECOND_ARE_EQUAL)
    util_mock.getRandomFrom(mc.ANYARGS);mc:returns(destinationTeam)
    engine_mock:sendToTeam(user_mock, destinationTeam)
    mc:replay()
    teamManager = TeamManager:new{ engine = engine_mock, util = util_mock }
    teamManager:sendToRandom(user_mock)
    mc:verify()
end

function test_sendToRandom_tells_engine_to_send_player_to_TEAM_ONE_if_TEAM_ONE_is_smaller_team()
    engine_mock:getTeamSize(mc.ANYARGS);mc:times(2)
    util_mock.compareTo(mc.ANYARGS);mc:returns(COMPARETO_FIRST_IS_SMALLER)
    engine_mock:sendToTeam(user_mock, TEAM_ONE)
    mc:replay()
    teamManager = TeamManager:new{ engine = engine_mock, util = util_mock }
    teamManager:sendToRandom(user_mock)
    mc:verify()
end

function test_sendToRandom_tells_engine_to_send_player_to_TEAM_TWO_if_TEAM_TWO_is_smaller_team()
    engine_mock:getTeamSize(mc.ANYARGS);mc:times(2)
    util_mock.compareTo(mc.ANYARGS);mc:returns(COMPARETO_FIRST_IS_BIGGER)
    engine_mock:sendToTeam(user_mock, TEAM_TWO)
    mc:replay()
    teamManager = TeamManager:new{ engine = engine_mock, util = util_mock }
    teamManager:sendToRandom(user_mock)
    mc:verify()
end

function test_sendToRandom_with_nil_user_throws_error()
    teamManager = TeamManager:new()
    local success, error = pcall(TeamManager.sendToRandom, teamManager, nil)
    assertTrue(endsWith(error, ERR_USER_NIL), "sendToRandom with nil user should throw expected error")
end

function test_getUsersByTeam_asks_the_engine_for_users_for_team()
    engine_mock:getMaxPlayers();mc:returns(32)
    engine_mock:getPlayerByIndex(1);mc:returns(user1_mock)
    user1_mock:getTeam();mc:returns(TEAM_ONE)
    engine_mock:getPlayerByIndex(2);mc:returns(user2_mock)
    user2_mock:getTeam();mc:returns(TEAM_TWO)
    engine_mock:getPlayerByIndex(mc.ANYARGS);mc:times(30)
    mc:replay()
    teamManager = TeamManager:new{ engine = engine_mock }
    users = teamManager:getUsersByTeam(TEAM_ONE)
    assertTrue(contains(users, user1_mock), "getUsersByTeam should have included user in returned list")
    assertFalse(contains(users, user2_mock), "getUsersByTeam should not have included user in returned list")
    assertEqual(#users, 1, "getUsersByTeam should return only players on specified team")
    mc:verify()
end

function test_getUsersByTeam_with_invalid_team_throws_error()
    teamManager = TeamManager:new()
    local success, error = pcall(TeamManager.getUsersByTeam, teamManager, nil)
    assertTrue(endsWith(error, ERR_TEAM_INVALID), "getUsersByTeam with invalid team should throw expected error")
end

function test_sendToTeam_with_nil_user_throws_expected_error()
    teamManager = TeamManager:new()
    local success, error = pcall(TeamManager.sendToTeam, teamManager, nil, TEAM_ONE)
    assertTrue(endsWith(error, ERR_USER_NIL), "sendToTeam with nil user should throw expected error")
end

function test_sendToTeam_with_invalid_team_throws_error()
    testUser = User:new()
    teamManager = TeamManager:new()
    local success, error = pcall(TeamManager.sendToTeam, teamManager, testUser, nil)
    assertTrue(endsWith(error, ERR_TEAM_INVALID), "sendToTeam with invalid team should throw expected error")
end

function test_sendToTeam_tells_engine_to_send_player_to_team()
    destinationTeam = TEAM_ONE
    engine_mock:sendToTeam(user_mock, destinationTeam);mc:returns(true)
    mc:replay()
    teamManager = TeamManager:new{ engine = engine_mock }
    teamManager:sendToTeam(user_mock, destinationTeam)
    mc:verify()
end

runTests{useANSI = false}