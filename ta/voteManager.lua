--voteManager
require "ta.helpers.collections"
require "ta.resources.messages"
require "ta.resources.constants"
VoteManager = { }
Vote = { }
Vote["active"] = false
MIN_ANSWERS = 2

--- Create a new VoteManager object
function VoteManager.new (self,init)
    init = init or { engine = engine, client = client }
    setmetatable(init,self)
    self.__index = self
    Vote["active"] = false
    return init
end

--- Start a new vote
-- @param user User object of who sent the command
-- @param question question to ask
-- @param answers table of possible answers (must have at least MIN_ANSWERS)
function VoteManager.startvote(self, user, question, answers)
    assert(Vote["active"] == false, ERR_VOTE_ALREADY_UNDERWAY)
    assert(question ~= nil, ERR_QUESTION_NIL)
    --print(answers ~= nil and #answers >= MIN_ANSWERS)
    assert(answers ~= nil and #answers >= MIN_ANSWERS, ERR_NOT_ENOUGH_ANSWERS)
    Vote["active"] = true
    Vote["user_initiated"] = user
    Vote["question_asked"] = question
    Vote["answers_provided"] = answers
    Vote["time_started"] = os.time()
    Vote["uservotes"] = {}
    Vote["poll"]= {}
    self['client']:print(PRINT_ALL_PLAYERS,PRINT_CHAT,question.."?")
    for i,answer in ipairs(answers) do
        self['client']:print(PRINT_ALL_PLAYERS,PRINT_CHAT,i..")".." "..answer)
    end
end

--- Cast a vote
-- @param user User object of who sent the command
-- @param selection Users answer for current question
function VoteManager.castvote(self, user, selection)
    assert(selection ~= nil, ERR_BAD_VOTE_CHOICE)
    assert(contains(Vote["answers_provided"], selection), ERR_BAD_VOTE_CHOICE)
    username = user:getName()
    userslot = self['engine']:getPlayerByName(username)
    currentChoice = Vote["uservotes"][userslot]
    if ( currentChoice ~= nil ) then
        if ( selection == currentChoice ) then
            return
        else
            Vote["poll"][currentChoice] = Vote["poll"][currentChoice]  - 1
        end
    end
    Vote["uservotes"][userslot] = selection
    if ( Vote["poll"][selection] == nil ) then
        Vote["poll"][selection] =  1
    else
        Vote["poll"][selection] = Vote["poll"][selection]  + 1
    end
end
