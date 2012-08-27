Script.Load("lua/Globals.lua")
Script.Load("lua/NetworkMessages.lua")
Script.Load("lua/ServerAdminCommands.lua")

engine = { players = { } }

--- Get maximum player count
-- @return Integer with the maximum number of players allowed on the server
function engine.getMaxPlayers(self)
    return 32
end

--- Get a player based on their entity index
-- @param playerNum Entity index of player to retrieve
-- @return User object, or nil
function engine.getPlayerByIndex(self, playerNum)
    assert(playerNum<=self.getMaxPlayers(),"Invalid player index")
    return self['players'][playerNum]
end

--- Get a player based on their name.
-- If multiple names match the one passed in, return nil
-- @return User object, or nil
function engine.getPlayerByName(self, playerName)
    assert(#playerName>0,"Player name empty")
    
end

--- Assign a player to a specific team
-- @param player User object of the player who's team is changing
-- @param newteam New team that that user will be on, see constants.TEAM_*
-- @return boolean
function engine.sendToTeam(self, player, newteam)
    player:_setTeam(newteam)
    return true
end

function engine.printToClientConsole(self, client, message)
    --mlh 8/27 this line works, showing that the Globals.lua was imported successfully: Shared.Message("kNeutralTeamType: " .. kNeutralTeamType)
    --mlh 8/27 this line works, showing that we /can/ get a client's User ID: Shared.Message("client:GetUserId(): " .. client:GetUserId())
    -- todo mlh find person and send message only to her console
    Shared.Message("CLIENT MESSAGE: " .. message)
--    local player = GetPlayerMatchingSteamId(client:GetUserId())
--    Server.SendNetworkMessage(player, "Chat", BuildChatMessage(false, "Team Assist", -1, nil, kNeutralTeamType, message), true)
end

function engine.bindHandler(self, eventName, handler)
    --mlh 8/27 Event.Hook works here when you cite the right event string
    Event.Hook(eventName, handler)
end
