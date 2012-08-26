require "ta.helpers.strings"
require "ta.MapManager"
require "ta.resources.messages"
require "ta_tests.lib.lunity"
require "ta_tests.lib.lemock"
module("mapManager", package.seeall, lunity)

function setup()
    mc = lemock.controller()
end

function test_changeLevel_with_nil_level_throws_error()
    mapManager = MapManager:new()
    local success, error = pcall(MapManager.changeLevel, mapManager, nil)
    assertTrue(endsWith(error, ERR_MAP_NIL), "changeLevel with nil level should throw expected error")
end

function test_changeLevel_tells_engine_to_change_level()
    destinationLevel = "ns_veil"
    engine_mock = mc:mock()
    engine_mock:changeLevel(destinationLevel)
    mapManager = MapManager:new{ engine = engine_mock }
    mapManager:changeLevel(destinationLevel)
    mc:verify()    
end

runTests{useANSI = false}