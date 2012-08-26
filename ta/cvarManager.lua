require "ta.cvar"

CvarManager = {}

--- Create a new CvarManager instance
function CvarManager.new (self,init)
    init = init or {}
    setmetatable(init,self)
    self.__index = self
    return init
end

--- Register a new cvar
-- @param name Name of new cvar to register
-- @return Cvar object of newly created cvar, or nil if cvar already exists
function CvarManager.register (self, name)
    if (self[name:lower()] ~= nil) then
        return nil
    end
    self[name:lower()] = Cvar:new{name=name, value=""}
    return self[name:lower()]    
end

--- Retrieve a cvar from the list
-- @param name Name of cvar to retrieve
-- @return Cvar object or nil if cvar does not exist
function CvarManager.get (self, name)
    return self[name:lower()]
end

-- Set the value of a cvar.  Equivilent to getting a cvar object, and setting the value on it
-- @param name Name of the cvar to setup
-- @param newvalue Value to set the cvar to
function CvarManager.set (self, name, newvalue)
    var = self:get(name)
    if var == nil then
        return false
    end
    var:set(newvalue)
    return true    
end