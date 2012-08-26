require "ta.resources.messages"

PlayerManager = { }

--- Create a new PlayerManager object
function PlayerManager.new (self,init)
    init = init or { engine = engine }
    setmetatable(init,self)
    self.__index = self
    return init
end

function PlayerManager.findPlayerByAuthId(self, authId)
    assert(authId ~= nil, ERR_AUTHID_NIL)
    local result = nil
    for i=1,self['engine']:getMaxPlayers() do
        currentPlayer = self['engine']:getPlayerByIndex(i)
        if currentPlayer ~= nil and currentPlayer:getAuthId() == authId then
            result = currentPlayer
            break
        end     
    end
    return result
end

function PlayerManager.findPlayerByName(self, name)
    assert(name ~= nil, ERR_NAME_NIL)
    local result = nil
    for i=1,self['engine']:getMaxPlayers() do
        currentPlayer = self['engine']:getPlayerByIndex(i)
        if currentPlayer ~= nil and currentPlayer:getName():find(name) ~= nil then
            if result == nil then    
                result = currentPlayer
            else
                error(ERR_MULTIPLE_PLAYERS)
            end   
        end     
    end
    return result
end