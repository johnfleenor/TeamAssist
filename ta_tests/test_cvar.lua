require "ta.cvar"
require "ta_tests.lib.lunity"
module("cvar", package.seeall, lunity)

function test_cvarcreate()
    newvar = Cvar:new()
    assertNotNil(newvar,"Created cvar is nil")
end

function test_cvar_defaults()
    var = Cvar:new()
    assertEqual(var["name"],"unknown_cvar","Incorrect cvar name")
    assertEqual(var["value"],"","Value not blank")
end

function test_cvar_get()
    var = Cvar:new{value="test"}
    assertEqual(var:get(),"test","Incorrect value returned")
end

function test_cvar_set()
    var = Cvar:new{value="old"}
    var:set("new")
    assertEqual(var:get(),"new","Value not set correctly")
end

runTests{useANSI = false}
