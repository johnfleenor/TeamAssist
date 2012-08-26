require "ta.commandlist"
require "ta.userlist"
require "ta.user"
require "ta_tests.lib.lunity"

module( "commandlist", package.seeall, lunity )

function test_BasicSplitCommand()
    local result = CommandList:splitcommand("this is a test")
    
    assertEqual(#result,4,"Split didn't match expected result")
    assertEqual(result[1],"this","First result different")
    assertEqual(result[2],"is","Second result different")
    assertEqual(result[3],"a","Third result different")
    assertEqual(result[4],"test","Fourth result different")
end

function test_QuoteSplitCommand()
    local result = CommandList:splitcommand('now, a "test of quotes"')
    
    assertEqual(#result,3,"Quoted split didn't match expected result")
    assertEqual(result[1],"now,","First result different")
    assertEqual(result[2],"a","Second result different")
    assertEqual(result[3],"test of quotes","Third result different")
end

function test_RepeatedSpacesSplit()
    local result = CommandList:splitcommand("i  am   evil")
    
    assertEqual(#result,3,"Repeated spaces didn't match expected result")
    assertEqual(result[1],"i","First result different")
    assertEqual(result[2],"am","Second result different")
    assertEqual(result[3],"evil","Third result different")
end

function_called = false

function test_CallFunc()
    CommandList:register("test_callfunc",ADMIN_NONE,CallFunc_cb)
    CommandList:call("steam_test","test_callfunc")
    assertTrue(function_called,"Function not called")
end

function CallFunc_cb(user,args)
    function_called = true
end

runTests{useANSI = false}