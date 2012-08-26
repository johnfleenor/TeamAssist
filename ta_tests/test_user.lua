require "ta.resources.constants"
require "ta.TeamManager"
require "ta.user"
require "ta_tests.lib.lunity"

module( "user", package.seeall, lunity )

INVALID_FLAG = "&"

function test_getTeam_returns_current_team()
    expectedTeam = TEAM_ONE
    newuser = User:new{team=expectedTeam}
    assertEqual(expectedTeam, newuser:getTeam(), "User should be on expected team")
end

function test_newuser_default_access_is_ADMIN_NONE()
    newuser = User:new()
    assertEqual(newuser['access'], ADMIN_NONE, "New user access defaults to none")
end

function test_newuser_default_id_is_STEAM_ID_UNK()
    newuser = User:new()
    assertEqual(newuser['id'], STEAM_ID_UNKNOWN, "New user id defaults to STEAM_ID_UNKNOWN")
end

function test_newuser_default_team_is_READYROOM()
    newuser = User:new()
    assertEqual(newuser['team'], TEAM_READYROOM, "New user id defaults to TEAM_READYROOM")
end

function test_newuser_default_id_is_nil_when_only_team_is_passed_into_ctor()
    newuser = User:new{team=TEAM_ONE}
    assertEqual(newuser['id'], nil, "New user id should be nil")
end

function test_newuser_ctor_access_parameter_sets_access_correctly()
    flags = ADMIN_KICK..ADMIN_BAN..ADMIN_MAP
    newuser = User:new{access=flags}
    assertEqual(newuser['access'], flags, "New user access set to abc")
end

function test_newuser_ctor_id_parameter_sets_id_correctly()
    testid = "STEAM_TEST"
    newuser = User:new{id=testid}
    assertEqual(newuser['id'], testid, "New user steamid set to STEAM_TEST")
end

function test_hasflag_returns_true_when_user_has_flag()
    flags = ADMIN_KICK..ADMIN_BAN
    testuser = User:new{access=flags}
    assertTrue(testuser:hasflag(ADMIN_KICK,"Hasflag - should have ADMIN_KICK"))
end

function test_hasflag_returns_false_when_user_does_not_have_flag()
    flags = ADMIN_KICK..ADMIN_CHAT
    testuser = User:new{access=flags}
    assertFalse(testuser:hasflag(ADMIN_RCON,"Hasflag - should not have ADMIN_RCON"))
end

function test_addflag_adds_flag_to_user()
    testuser = User:new{access=ADMIN_KICK}
    testuser:addflag(ADMIN_BAN)
    assertTrue(testuser:hasflag(ADMIN_BAN,"Hasflag - should have ADMIN_BAN"))
end

function test_addflag_does_not_add_invalid_flag_to_user()
    testuser = User:new{access=ADMIN_KICK}
    testuser:addflag(INVALID_FLAG)
    assertFalse(testuser:hasflag(INVALID_FLAG,"Hasflag - should not have INVALID_FLAG"))
end

function test_removeflag_results_in_user_without_specified_flag_when_user_had_flag()
    testuser = User:new{access=ADMIN_KICK}
    testuser:removeflag(ADMIN_KICK)
    assertFalse(testuser:hasflag(ADMIN_KICK),"Hasflag - should not have flag")
end

function test_removeflag_results_in_user_without_specified_flag_when_user_did_not_have_flag()
    testuser = User:new{access=ADMIN_KICK}
    testuser:removeflag(ADMIN_BAN)
    assertFalse(testuser:hasflag(ADMIN_BAN),"Hasflag - should not have flag")    
end

function test_removeflag_results_in_user_without_specified_invalid_flag()
    testuser = User:new{access=ADMIN_KICK}
    testuser:removeflag(INVALID_FLAG)
    assertFalse(testuser:hasflag(INVALID_FLAG),"Hasflag - should not have flag")    
end

function test_isflag_returns_true_when_flag_is_valid()
    testuser = User:new{}
    assertTrue(testuser:isflag(ADMIN_KICK),"isflag - ADMIN_KICK should be valid flag")
    assertTrue(testuser:isflag(ADMIN_BAN),"isflag - ADMIN_BAN should be valid flag")
    assertTrue(testuser:isflag(ADMIN_MAP),"isflag - ADMIN_MAP should be valid flag")
    assertTrue(testuser:isflag(ADMIN_RCON),"isflag - ADMIN_RCON should be valid flag")
    assertTrue(testuser:isflag(ADMIN_CHAT),"isflag - ADMIN_CHAT should be valid flag")
end

function test_isflag_returns_false_when_flag_is_invalid()
    testuser = User:new{}
    assertFalse(testuser:isflag(INVALID_FLAG),"isflag - INVALID_FLAG should not be valid flag")
end

function test_getAuthId()
    TEST_AUTHID = "xyz"
    testUser = User:new{id=TEST_AUTHID}
    assertEqual(testUser:getAuthId(), TEST_AUTHID, "getAuthId should return the user's authid value")
end

function test_getName()
    TEST_NAME = "xyz"
    testUser = User:new{name=TEST_NAME}
    assertEqual(testUser:getName(), TEST_NAME, "getName should return the user's name value")
end

runTests{useANSI = false}