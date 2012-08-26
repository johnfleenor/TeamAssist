Cvar= {}

--- Create a new cvar object
-- @param name Name of the cvar to be created (defaults to unknown_cvar)
-- @param value Value to initalize the cvar to (defaults to "")
function Cvar.new (self,init)
	init = init or { name="unknown_cvar", value="" }
	setmetatable(init,self)
	self.__index = self
	return init
end

--- Set the value of this cvar
-- @param newvalue Value to set this to
function Cvar.set (self, newvalue)
    self["value"] = newvalue
end

--- Get the value of this cvar
-- @return Value of this cvar, typically in string format
function Cvar.get (self)
    return self["value"]
end    