require "ta.ServerManager"
require "ta.resources.messages"
require "ta_tests.lib.lunity"
require "ta_tests.lib.lemock"
module("serverManager", package.seeall, lunity)

function setup()
    mc = lemock.controller()
end

function test_serverCommand_with_nil_command_throws_error()
    serverManager = ServerManager:new()
    local success, error = pcall(ServerManager.serverCommand, serverManager, nil)
    assertTrue(errorReportsMessage(error, ERR_COMMAND_NIL), "serverManager with nil command should throw expected error")
end

function test_serverCommand_passes_engine_command()
    command = "restart"
    engine_mock = mc:mock()
    engine_mock:execute(command)
    mc:replay()    
    serverManager = ServerManager:new{ engine = engine_mock }
    serverManager:serverCommand(command)
    mc:verify()
end

runTests{useANSI = false}