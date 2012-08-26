require "ta.resources.constants"

User = { }

--- Create a new User object
-- @param access Access level to assign this user (defaults to ADMIN_NONE
-- @param id SteamID of this user (defaults to STEAM_ID_UNKNOWN)
-- @param team Team that this user is on (defaults to TEAM_READYROOM) 
function User.new (self,init)
    init = init or { access=ADMIN_NONE, id=STEAM_ID_UNKNOWN, team=TEAM_READYROOM }
    setmetatable(init,self)
    self.__index = self
    return init
end

function User.__tostring (self)
    return string.format("user %s: flags %s ",self.id,self.access)
end

--- Determine if the user has a specific access flag
-- @param flag Access flag to check for, see constants.ADMIN_*
-- @return boolean
function User.hasflag (self,flag)
    return self['access']:find(flag) ~= nil
end

--- Get the user's team
-- @return Team index, see constants.TEAM_*
function User.getTeam (self)
    return self['team']
end

-- Do not use this to change a users team.  It is only meant to be called from TeamManager:sendToTeam
function User._setTeam (self, newteam)
    self['team'] = newteam
end

--- Add an access flag to this user
-- @param flag Access flag to add, see constants.ADMIN_*
function User.addflag (self,flag)
    -- TODO throw exception on bad flag?
    local result = false
    if self:isflag(flag) then 
        if not self:hasflag(flag) then
            self['access'] = self['access']..flag
            result = true
        end
    end
    return result
end

--- Remove an access flag from this user
-- @param flag Access flag to remove, see constants.ADMIN_*
function User.removeflag (self,flag)
    self['access'] = self['access']:gsub(flag, "")
end

function User.isflag (self,flag)
    return contains(AllFlags,flag)
end

function User.getAuthId(self)
    return self['id']
end

function User.getName(self)
    return self['name']
end