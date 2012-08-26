require "ta.helpers.comparisons"
require "ta.helpers.collections"
require "ta.user"
require "ta.ns2.engine"
require "ta.resources.constants"
require "ta.resources.messages"

TeamManager = {}

--- Create a new team manager instance
-- @param engine (OPTIONAL) engine instance to use
-- @param utl (OPTIONAL) util instance to use
function TeamManager.new (self,init)
    init = init or { engine=engine, util=util }
    setmetatable(init,self)
    self.__index = self
    return init
end

--- Retrieve a table of all the users on a specific team
-- @param team Team index to retrieve users from, see constants.TEAM_*
-- @return Table containing a list of User objects for everyone on that team
function TeamManager.getUsersByTeam (self, team)
    assert(contains(validTeams,team), ERR_TEAM_INVALID)
    local result = {}
    for i=1,self['engine']:getMaxPlayers() do
        currentPlayer = self['engine']:getPlayerByIndex(i)
        if currentPlayer ~= nil and currentPlayer:getTeam() == team then
            table.insert(result,currentPlayer)
        end     
    end
    return result
end

--- Send a user to a specific team
-- @param user User who's team should be changed
-- @team team Team index to send the user to, see constants.TEAM_*
function TeamManager.sendToTeam(self, user, team)
    assert(contains(validTeams,team), ERR_TEAM_INVALID)
    assert(user~=nil, ERR_USER_NIL)
    self['engine']:sendToTeam(user,team)
end

--- Send a user to a random team
-- @param user User who should be assigned to a random team
function TeamManager.sendToRandom(self, user)
    assert(user~=nil, ERR_USER_NIL)
    teamOneSize = self['engine']:getTeamSize(TEAM_ONE)
    teamTwoSize = self['engine']:getTeamSize(TEAM_TWO)
    result = self['util'].compareTo(teamOneSize,teamTwoSize )
    if( result == COMPARETO_FIRST_IS_SMALLER) then
        destinationTeam = TEAM_ONE
    elseif ( result == COMPARETO_FIRST_IS_BIGGER) then
        destinationTeam = TEAM_TWO
    elseif ( result == COMPARETO_FIRST_AND_SECOND_ARE_EQUAL) then
        destinationTeam = self['util'].getRandomFrom({ TEAM_ONE, TEAM_TWO })
    end
    self:sendToTeam(user,destinationTeam)
end