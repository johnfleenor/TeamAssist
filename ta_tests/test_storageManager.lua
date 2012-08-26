require "ta.helpers.strings"
require "ta.StorageManager"
require "ta_tests.lib.lunity"
require "ta_tests.lib.lemock"
require "ta.resources.messages"
module("storageManager", package.seeall, lunity)

VALID_FILENAME = "storageManagerTest.dat"

local saved_io = {}

function setup()
    mc = lemock.controller()
    file_handle_mock = mc:mock()
    json_mock = mc:mock()
    io_mock = mc:mock()
    saved_io = _G.io
end


function test_store_writes_all_of_file()
    _G.io = io_mock      
    io_mock.open(VALID_FILENAME, "w");mc:returns(file_handle_mock)
    file_handle_mock:write(mc.ANYARGS)
    file_handle_mock:close()
    mc:replay()
    storageManager = StorageManager:new()
    storageManager:store(VALID_FILENAME,{})
    _G.io = saved_io
    mc:verify()
end


function test_store_tells_Json_to_encode_data_it_writes_to_file()
    _G.io = io_mock    
    json_mock.Encode(mc.ANYARGS)
    io_mock.open(mc.ANYARGS);mc:returns(file_handle_mock)
    file_handle_mock:write(mc.ANYARGS)
    file_handle_mock:close()
    mc:replay()    
    storageManager = StorageManager:new{ json = json_mock }
    storageManager:store(VALID_FILENAME, mc.ANYARGS)
    _G.io = saved_io
    mc:verify()
end

function test_store_with_open_error_throws_error()
    _G.io = io_mock
    openErrorMessage = "Whatever error message open() hands back"
    io_mock.open(mc.ANYARGS);mc:returns(nil, openErrorMessage, mc.ANYARGS)
    mc:replay()
    storageManager = StorageManager:new()
    local success, error = pcall(StorageManager.store, storageManager, VALID_FILENAME,{})
    _G.io = saved_io
    assertTrue(endsWith(error, ERR_FILE_OPEN_ERROR..": "..openErrorMessage), "storageManager with open error should throw expected error")
    mc:verify()
end


function test_store_with_nil_filename_parameter_throws_error()
    storageManager = StorageManager:new()
    local success, error = pcall(StorageManager.store, storageManager, nil, {})
    assertTrue(endsWith(error, ERR_FILENAME_NIL), "storageManager with nil filename should throw expected error")
end

function test_store_with_nil_object_parameter_throws_error()
    storageManager = StorageManager:new()
    local success, error = pcall(StorageManager.store, storageManager, VALID_FILENAME, nil)
    assertTrue(endsWith(error, ERR_OBJECT_NIL), "storageManager with nil filename should throw expected error")
end

function test_store_with_open_error_throws_error()
    _G.io = io_mock
    openErrorMessage = "Whatever error message open() hands back"
    io_mock.open(mc.ANYARGS);mc:returns(nil, openErrorMessage, mc.ANYARGS)
    mc:replay()
    storageManager = StorageManager:new()
    local success, error = pcall(StorageManager.store, storageManager, VALID_FILENAME,{})
    _G.io = saved_io
    assertTrue(endsWith(error, ERR_FILE_OPEN_ERROR..": "..openErrorMessage), "storageManager with open error should throw expected error")
    mc:verify()
end


function test_load_tells_Json_to_decode_data_it_reads_from_file()
    _G.io = io_mock
    json = "{\"name1\":\"value1\",\"name3\":null,\"name2\":[1,false,true,23.54,\"a \u0015 string\"]}"    
    io_mock.open(mc.ANYARGS);mc:returns(file_handle_mock)
    file_handle_mock:read(mc.ANYARGS);mc:returns(json)
    file_handle_mock:close()
    json_mock.Decode(json)
    mc:replay()
    storageManager = StorageManager:new{ json = json_mock }
    storageManager:load(VALID_FILENAME)
    _G.io = saved_io
    mc:verify()
end

function test_load_returns_decoded_JSON_object()
    _G.io = io_mock
    json = "{\"name1\":\"value1\",\"name3\":null,\"name2\":[1,false,true,23.54,\"a \u0015 string\"]}"    
    decoded_json_object = {}
    io_mock.open(mc.ANYARGS);mc:returns(file_handle_mock)
    file_handle_mock:read(mc.ANYARGS);mc:returns(json)
    file_handle_mock:close()
    json_mock.Decode(mc.ANYARGS);mc:returns(decoded_json_object)
    mc:replay()
    storageManager = StorageManager:new{ json = json_mock }
    local result = storageManager:load(VALID_FILENAME)
    _G.io = saved_io
    mc:verify()
    assertEqual(result, decoded_json_object, "load should return decoded JSON object")
end



function test_load_reads_all_of_file()
    _G.io = io_mock
    io_mock.open(VALID_FILENAME, "r");mc:returns(file_handle_mock)
    file_handle_mock:read("*all")
    file_handle_mock:close()
    mc:replay()
    storageManager = StorageManager:new()
    storageManager:load(VALID_FILENAME)
    _G.io = saved_io
    mc:verify()
end

function test_load_returns_nil_for_nil_file()
    _G.io = io_mock
    json = nil    
    io_mock.open(mc.ANYARGS);mc:returns(file_handle_mock)
    file_handle_mock:read(mc.ANYARGS);mc:returns(json)
    file_handle_mock:close()    
    mc:replay()
    storageManager = StorageManager:new{ json = json_mock }
    local result = storageManager:load(VALID_FILENAME)
    _G.io = saved_io
    mc:verify() 
    assertNil(result, "Explect load should return nil for nil file")
end


function test_load_with_nil_filename_parameter_throws_error()
    storageManager = StorageManager:new()
    local success, error = pcall(StorageManager.load, storageManager, nil)
    assertTrue(endsWith(error, ERR_FILENAME_NIL), "storageManager with nil filename should throw expected error")
end

function test_load_with_open_error_throws_error()
    _G.io = io_mock
    openErrorMessage = "Whatever error message open() hands back"
    io_mock.open(mc.ANYARGS);mc:returns(nil, openErrorMessage, mc.ANYARGS)
    mc:replay()
    storageManager = StorageManager:new()
    local success, error = pcall(StorageManager.load, storageManager, VALID_FILENAME)
    _G.io = saved_io
    assertTrue(endsWith(error, ERR_FILE_OPEN_ERROR..": "..openErrorMessage), "storageManager with open error should throw expected error")
    mc:verify()
end


runTests{useANSI = false}