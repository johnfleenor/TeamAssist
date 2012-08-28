require "ta.notifications.clientGreeter"
require "ta_tests.lib.lunity"
require "ta_tests.lib.lemock"
module("clientGreeter", package.seeall, lunity)

function setup()
    mc = lemock.controller()
    engine_mock = mc:mock()
end

function test_GreetClient_prints_message_to_client_screen()
    local message = "Team Assist 0.0.0.1"
    clientGreeter = ClientGreeter:new()
    clientGreeter:GreetClient(message)
    assertNotNil(cvarCreated, "Cvar should have been created")
end

runTests{useANSI = false}
