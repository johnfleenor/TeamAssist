require "ta.cvarManager"
require "ta_tests.lib.lunity"
module("cvarmanager", package.seeall, lunity)

blankString = ""
nonExistentCvarName = "xxxxxxxxxxx"
maxPlayersCvarName = "sv_maxplayers"
maxPlayersValidValue = 16


function test_register_returns_true_when_cvar_does_not_exist()
    local testSpecific_nonExistentCvarName = "NameOfCvarThatDoesNotExist"
    cvarManager = CvarManager:new()
    cvarCreated = cvarManager:register(testSpecific_nonExistentCvarName)
    assertNotNil(cvarCreated, "Cvar should have been created")
end    

function test_register_returns_nil_when_cvar_exists()
    cvarManager = CvarManager:new()
    assertNotNil(cvarManager:register(maxPlayersCvarName),"Unable to create inital maxplayers")
    cvarCreated = cvarManager:register(maxPlayersCvarName)
    assertNil(cvarCreated, "Cvar should not have been created")    
end

function test_register_returns_message_when_cvar_does_exist()
    cvarManager = CvarManager:new()
    cvarCreated, message = cvarManager:register(maxPlayersCvarName)
    assertEqual(message, MESSAGE_CVAR_REGISTRATION_FAILED_CVAR_EXISTS, "Correct message should have been returned")
end

function test_set_modifies_cvar_value()
    cvarManager = CvarManager:new()
    assertNotNil(cvarManager:register(maxPlayersCvarName),"Unable to create inital maxplayers")
    maxPlayersVar = cvarManager:get(maxPlayersCvarName)
    initialCvarValue = maxPlayersVar:get()
    assertNotEqual(initialCvarValue, maxPlayersValidValue, "Initial cvar value should not equal test cvar value")
    cvarManager:set(maxPlayersCvarName, maxPlayersValidValue)    
    modifiedCvarValue = maxPlayersVar:get()
    assertEqual(modifiedCvarValue, maxPlayersValidValue, "Modified cvar value should equal test cvar value")
end

function test_set_returns_true_when_cvar_value_is_set()
    cvarManager = CvarManager:new()
    assertNotNil(cvarManager:register(maxPlayersCvarName),"Unable to create inital maxplayers")
    cvarSetSuccess = cvarManager:set(maxPlayersCvarName, maxPlayersValidValue)    
    assertTrue(cvarSetSuccess, "Cvar value should have been set")
end

function test_set_returns_false_when_cvar_does_not_exist()
    cvarManager = CvarManager:new()
    cvarSetSuccess = cvarManager:set(nonExistentCvarName, maxPlayersValidValue)    
    assertFalse(cvarSetSuccess, "Cvar value should not have been set for nonexistent cvar")
end

function test_get_returns_value_for_existent_cvar()
    cvarManager = CvarManager:new()
    assertNotNil(cvarManager:register(maxPlayersCvarName),"Unable to create inital maxplayers")
    cvarValue = cvarManager:get(maxPlayersCvarName)
    assertNotNil(cvarValue)
end

function test_get_returns_nil_for_nonexistent_cvar()
    cvarManager = CvarManager:new()
    cvarValue = cvarManager:get(nonExistentCvarName)
    assertNil(cvarValue)
end

runTests{useANSI = false}