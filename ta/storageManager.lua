require "ta.lib.Json"
require "ta.resources.messages"

StorageManager = {}

--- Create a new StorageManager instance
-- @param json JSON parser to be used, or default to create a new instance of one
function StorageManager.new (self,init)
    init = init or { json = Json }
    setmetatable(init,self)
    self.__index = self
    if (self['json'] == nil) then
        self['json'] = Json
    end
    return init
end

--- Load a JSON format file from disk and return a dict from it
-- @param filename Filename of the file to load
-- @return Dict of values from the JSON file
function StorageManager.load(self,filename)
    assert(filename ~= nil, ERR_FILENAME_NIL)
    file_handle, errorMessage, errorNumber = io.open(filename, "r")
    if (file_handle == nil) then
        error(ERR_FILE_OPEN_ERROR..": "..errorMessage)
    end
    local result = file_handle:read("*all")
    file_handle:close()
    if (result) then
        result = self['json'].Decode(result)
    end
    return result
end

--- Store a table to a JSON format file on disk
-- This will overwrite an existing file.
-- @param filename Filename of the file to write to
-- @param objectToBeStore Object that should be written to disk
function StorageManager.store(self,filename, objectToBeStored) 
  assert(filename ~= nil, ERR_FILENAME_NIL) 
  assert(objectToBeStored ~= nil, ERR_OBJECT_NIL) 
  jsonEncodedObject = self['json'].Encode({objectToBeStored})  
  file_handle, errorMessage, errorNumber = io.open(filename, "w")  
  if (file_handle == nil) then
      error(ERR_FILE_OPEN_ERROR..": "..errorMessage)
  end  
  local result = file_handle:write(jsonEncodedObject)
  file_handle:close()  
  
end

