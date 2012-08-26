require "ta.helpers.strings"
require "ta.PlayerManager"
require "ta.resources.messages"
require "ta_tests.lib.lunity"
require "ta_tests.lib.lemock"
module("playerManager", package.seeall, lunity)

function setup()
    mc = lemock.controller()
    engine_mock = mc:mock()
    user_mock = mc:mock()
    user1_mock = mc:mock()
    user2_mock = mc:mock()
end

--[[

function test_banPlayer_tells_engine_to_ban_player_and_kick_player()
    engine_mock:banPlayer(user_mock)
    engine_mock:kickPlayer(user_mock)
    mc:replay()
    playerManager = PlayerManager:new{ engine = engine_mock }
    playerManager:banPlayer(user_mock)
    mc:verify()
end

function test_banPlayer_with_invalid_duration_throws_error()
    playerManager = PlayerManager:new()
    local success, error = pcall(PlayerManager.banPlayer, playerManager, mc:mock(), "apple")
    assertTrue(endsWith(error, ERR_DURATION_INVALID), "banPlayer with invalid duration should throw expected error")
end

function test_banPlayer_passes_duration_to_engine_call()
    duration = 30
    engine_mock:banPlayer(mc.ANYARGS, duration)
    engine_mock:kickPlayer(mc.ANYARGS)
    mc:replay()
    playerManager = PlayerManager:new{ engine = engine_mock }
    playerManager:banPlayer(mc:mock(), duration)
    mc:verify()
end

function test_banPlayer_with_nil_user_throws_error()
    playerManager = PlayerManager:new()
    local success, error = pcall(PlayerManager.banPlayer, playerManager, nil)
    assertTrue(endsWith(error, ERR_USER_NIL), "banPlayer with nil user should throw expected error")
end

function test_kickPlayer_with_nil_user_throws_error()
    playerManager = PlayerManager:new()
    local success, error = pcall(PlayerManager.kickPlayer, playerManager, nil)
    assertTrue(endsWith(error, ERR_USER_NIL), "kickPlayer with nil user should throw expected error")
end

function test_kickPlayer_tells_engine_to_kick_player()
    engine_mock:kickPlayer(user_mock)
    mc:replay()
    playerManager = PlayerManager:new{ engine = engine_mock }
    playerManager:kickPlayer(user_mock)
    mc:verify()
end

--]]
function test_findPlayerByAuthId_returns_player_matching_authId()
    FIRST_AUTHID_TO_FIND = "xyz"
    engine_mock:getMaxPlayers();mc:returns(32)
    engine_mock:getPlayerByIndex(1);mc:returns(user1_mock)
    user1_mock:getAuthId()
    engine_mock:getPlayerByIndex(2);mc:returns(user2_mock)
    user2_mock:getAuthId();mc:returns(FIRST_AUTHID_TO_FIND)
    mc:replay()
    playerManager = PlayerManager:new{ engine = engine_mock }
    result = playerManager:findPlayerByAuthId(FIRST_AUTHID_TO_FIND)
    assertEqual(user2_mock, result, "findPlayerByAuthId should return player matching authid")
    mc:verify()
end

function test_findPlayerByAuthId_returns_nil_when_no_player_matches_authId()
    FIRST_AUTHID_TO_FIND = "xyz"
    engine_mock:getMaxPlayers();mc:returns(32)
    engine_mock:getPlayerByIndex(mc.ANYARGS);mc:anytimes()
    user1_mock:getAuthId();mc:anytimes()
    mc:replay()
    playerManager = PlayerManager:new{ engine = engine_mock }
    local result = "randomValueThatIsNotNil"
    result = playerManager:findPlayerByAuthId(FIRST_AUTHID_TO_FIND)
    assertNil(result, "findPlayerByAuthId should return nil when no player matches authId")
    mc:verify()
end

function test_findPlayerByAuthId_with_nil_authId_throws_error()
    playerManager = PlayerManager:new()
    local success, error = pcall(PlayerManager.findPlayerByAuthId, playerManager, nil)
    assertTrue(endsWith(error, ERR_AUTHID_NIL), "findPlayerByAuthId with nil authId should throw expected error")
end

function test_findPlayerByName_returns_player_matching_name()
    FIRST_NAME_TO_FIND = "xyz"
    engine_mock:getMaxPlayers();mc:returns(32)
    engine_mock:getPlayerByIndex(1);mc:returns(user1_mock)
    user1_mock:getName()
    engine_mock:getPlayerByIndex(2);mc:returns(user2_mock)
    user2_mock:getName();mc:returns(FIRST_AUTHID_TO_FIND)
    mc:replay()
    playerManager = PlayerManager:new{ engine = engine_mock }
    result = playerManager:findPlayerByName(FIRST_NAME_TO_FIND)
    assertEqual(user2_mock, result, "findPlayerByName should return player matching authid")
    mc:verify()
end

function test_findPlayerByName_with_nil_name_throws_error()
    playerManager = PlayerManager:new()
    local success, error = pcall(PlayerManager.findPlayerByName, playerManager, nil)
    assertTrue(endsWith(error, ERR_NAME_NIL), "findPlayerByName with nil name should throw expected error")
end

function test_findPlayerByName_returns_player_matching_name()
    FIRST_NAME_TO_FIND = "xyz"
    engine_mock:getMaxPlayers();mc:returns(32)
    engine_mock:getPlayerByIndex(1);mc:returns(user1_mock)
    user1_mock:getName();mc:returns("")
    engine_mock:getPlayerByIndex(2);mc:returns(user2_mock)
    user2_mock:getName();mc:returns(FIRST_NAME_TO_FIND)
    engine_mock:getPlayerByIndex(mc.ANYARGS);mc:times(30)
    mc:replay()
    playerManager = PlayerManager:new{ engine = engine_mock }
    result = playerManager:findPlayerByName(FIRST_NAME_TO_FIND)
    assertEqual(user2_mock, result, "findPlayerByName should return player matching name")
    mc:verify()
end

function test_findPlayerByName_returns_player_matching_partialname()
    FIRST_NAME_TO_FIND = "xyz"
    engine_mock:getMaxPlayers();mc:returns(32)
    engine_mock:getPlayerByIndex(1);mc:returns(user1_mock)
    user1_mock:getName();mc:returns("")
    engine_mock:getPlayerByIndex(2);mc:returns(user2_mock)
    user2_mock:getName();mc:returns(FIRST_NAME_TO_FIND..FIRST_NAME_TO_FIND)
    engine_mock:getPlayerByIndex(mc.ANYARGS);mc:times(30)
    mc:replay()
    playerManager = PlayerManager:new{ engine = engine_mock }
    result = playerManager:findPlayerByName(FIRST_NAME_TO_FIND)
    assertEqual(user2_mock, result, "findPlayerByName should return player matching partial name")
    mc:verify()
end

function test_findPlayerByName_raises_error_when_multiple_players_exist_with_same_name()
    FIRST_NAME_TO_FIND = "xyz"
    engine_mock:getMaxPlayers();mc:returns(32)
    engine_mock:getPlayerByIndex(1);mc:returns(user1_mock)
    user1_mock:getName();mc:returns(FIRST_NAME_TO_FIND)
    engine_mock:getPlayerByIndex(2);mc:returns(user2_mock)
    user2_mock:getName();mc:returns(FIRST_NAME_TO_FIND)
    mc:replay()
    playerManager = PlayerManager:new{ engine = engine_mock }
    local result, error = pcall(playerManager.findPlayerByName,playerManager,FIRST_NAME_TO_FIND)
    assertTrue(endsWith(error, ERR_MULTIPLE_PLAYERS), "findPlayerByName should return an error when multiple players match")
    mc:verify()
end

runTests{useANSI = false}