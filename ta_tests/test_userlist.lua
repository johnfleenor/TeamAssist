require "ta.user"
require "ta.userlist"
require "ta_tests.lib.lunity"

module( "userlist", package.seeall, lunity )

function setup()
    Userlist:fromfile("userlist_tests.ini")
end

function test_userlisthasuser()
    assertNotNil(Userlist['STEAM_0:1:1234'],"STEAM_0:1:1234 is not a user")
    assertNotNil(Userlist['STEAM_0:2:1234'],"STEAM_0:2:1234 is not a user")
end

function test_userlistnouser()
    assertNil(Userlist['STEAM_0:3:1234'],"STEAM_0:3:1234 is a user")
    assertNil(Userlist['STEAM_0:4:1234'],"STEAM_0:4:1234 is a user")
end

function test_userlistaccess()
    assertTrue(Userlist['STEAM_0:1:1234']:hasflag(ADMIN_KICK),"STEAM_0:1:1234 does not have kick access")
    assertFalse(Userlist['STEAM_0:1:1234']:hasflag(ADMIN_RCON),"STEAM_0:1:1234 has rcon access")
    assertTrue(Userlist['STEAM_0:2:1234']:hasflag(ADMIN_KICK),"STEAM_0:2:1234 does not have kick access")
end  

runTests{useANSI = false}