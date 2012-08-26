require "ta.VoteManager"
require "ta.resources.messages"
require "ta.resources.constants"
require "ta.helpers.strings"
require "ta_tests.lib.lunity"
require "ta_tests.lib.lemock"
module("voteManager", package.seeall, lunity)

question = "Restart Match"
answers = {"Yes", "No"}
function setup()
    mc = lemock.controller()
    engine_mock = mc:mock()
    client_mock = mc:mock()
    user_mock = mc:mock()
    user1_mock = mc:mock()
    user2_mock = mc:mock()
end

--vote can be initiated
--only one vote exists at a time
--vote can time out
--questions need to me managed
--question needs to exist
--answers need to be managed
--answers need to exist and have at least two options
-- answers can be specified on vote creation
-- bad answers ignored/error out with user feedback
--votes need to be recorded
--votes need to be one per user
--users should get feedback on votes (later)
--existing votes get overwritten if a user has already cast a vote
--ties need to be handled
--restart vote
--votes end when threshholds are met
--votes can take actions/callbacks

function test_startvote_vote_initiation_creates_new_vote_object()
    --other stuff

   client_mock:print(PRINT_ALL_PLAYERS,PRINT_CHAT,mc.ANYARGS);mc:anytimes()
    mc:replay()
    voteManager = VoteManager:new{ engine = engine_mock, client = client_mock }
    voteManager:startvote(user_mock, question, answers)
    mc:verify()
end

function test_startvote_checks_to_see_if_a_vote_is_already_underway()

   client_mock:print(PRINT_ALL_PLAYERS,PRINT_CHAT,mc.ANYARGS);mc:anytimes()
    mc:replay()
    voteManager = VoteManager:new{ engine = engine_mock, client = client_mock }
    voteManager:startvote(user_mock, question, answers)
    local success, error = pcall(VoteManager.startvote, voteManager,  mc.ANYARGS)
    assertTrue(endsWith(error, ERR_VOTE_ALREADY_UNDERWAY), "startvote when vote underway should throw expected error")
    mc:verify()
end

function test_startvote_with_nil_question_throws_error()
    mc:replay()
    voteManager = VoteManager:new{ engine = engine_mock, client = client_mock }
    local success, error = pcall(VoteManager.startvote, voteManager,user_mock,nil,answers)
    assertTrue(endsWith(error, ERR_QUESTION_NIL), "startvote when question nil should throw expected error")
    mc:verify()
end

function test_startvote_with_not_at_least_two_answers_throws_error()
    mc:replay()
    voteManager = VoteManager:new{ engine = engine_mock, client = client_mock }
    local success, error = pcall(VoteManager.startvote, voteManager,user_mock,question,nil)
    assertTrue(endsWith(error, ERR_NOT_ENOUGH_ANSWERS), "startvote when not enough answers should throw expected error")
    local success, error = pcall(VoteManager.startvote, voteManager,user_mock,question,{})
    assertTrue(endsWith(error, ERR_NOT_ENOUGH_ANSWERS), "startvote when not enough answers should throw expected error")
    local success, error = pcall(VoteManager.startvote, voteManager,user_mock,question,{"just one answer"})
    assertTrue(endsWith(error, ERR_NOT_ENOUGH_ANSWERS), "startvote when not enough answers should throw expected error")

    mc:verify()
end


function test_startvote_ask_client_to_display_questions_and_answers()

   client_mock:print(PRINT_ALL_PLAYERS,PRINT_CHAT,question.."?")
   client_mock:print(PRINT_ALL_PLAYERS,PRINT_CHAT,mc.ANYARGS);mc:times(#answers)
   mc:replay()
   voteManager = VoteManager:new{ engine = engine_mock, client = client_mock }
   voteManager:startvote(user_mock, question, answers)
   mc:verify()
end

function test_castvote_raises_error_if_selection_is_nil()
   client_mock:print(PRINT_ALL_PLAYERS,PRINT_CHAT,mc.ANYARGS);mc:anytimes()
   mc:replay()
   voteManager = VoteManager:new{ engine = engine_mock, client = client_mock }
   voteManager:startvote(user_mock, question, answers)
   local success, error = pcall(VoteManager.castvote, voteManager,user_mock,nil)
   assertTrue(endsWith(error, ERR_BAD_VOTE_CHOICE), "castvote should throw expected exception when choice is nil")
   mc:verify()
end

function test_castvote_raises_error_if_selection_is_not_in_answer_list()
   client_mock:print(PRINT_ALL_PLAYERS,PRINT_CHAT,mc.ANYARGS);mc:anytimes()
   mc:replay()
   voteManager = VoteManager:new{ engine = engine_mock, client = client_mock }
   voteManager:startvote(user_mock, question, answers)
   local success, error = pcall(VoteManager.castvote, voteManager,user_mock,"monkeys")
   assertTrue(endsWith(error, ERR_BAD_VOTE_CHOICE), "castvote should throw expected exception when choice is not in list")
   mc:verify()
end

function test_castvote_increases_poll_for_given_answer()
    client_mock:print(PRINT_ALL_PLAYERS,PRINT_CHAT,mc.ANYARGS);mc:anytimes()
   user1_mock:getName();mc:returns("fred")
   engine_mock:getPlayerByName("fred");mc:returns(1)
   user2_mock:getName();mc:returns("fred2")
   engine_mock:getPlayerByName("fred2");mc:returns(2)

   mc:replay()
   voteManager = VoteManager:new{ engine = engine_mock, client = client_mock }
   voteManager:startvote(user_mock, question, answers)
   voteManager:castvote(user1_mock,"Yes")
   currentYesTotal = Vote["poll"]["Yes"]
   assertEqual(currentYesTotal,1, "castvote should have incremented the total")
   voteManager:castvote(user2_mock,"Yes")
   currentYesTotal = Vote["poll"]["Yes"]
   assertEqual(currentYesTotal,2, "castvote should have incremented the total")
   mc:verify()
end

function test_castvote_increases_poll_for_given_answer()
    client_mock:print(PRINT_ALL_PLAYERS,PRINT_CHAT,mc.ANYARGS);mc:anytimes()
   user_mock:getName();mc:returns("fred")
   engine_mock:getPlayerByName("fred");mc:returns(1)
   user_mock:getName();mc:returns("fred")
   engine_mock:getPlayerByName("fred");mc:returns(1)

   mc:replay()
   voteManager = VoteManager:new{ engine = engine_mock, client = client_mock }
   voteManager:startvote(user_mock, question, answers)
   voteManager:castvote(user_mock,"Yes")
   currentYesTotal = Vote["poll"]["Yes"]
   assertEqual(currentYesTotal,1, "castvote should have gone from zero to 1")
   voteManager:castvote(user_mock,"Yes")
   currentYesTotal = Vote["poll"]["Yes"]
   assertEqual(currentYesTotal,1, "castvote should not  have incremented the total")
   mc:verify()
end

function test_castvote_changes_poll_for_given_answer_when_same_player_changes_vote()
   client_mock:print(PRINT_ALL_PLAYERS,PRINT_CHAT,mc.ANYARGS);mc:anytimes()
  user_mock:getName();mc:returns("fred") 
  engine_mock:getPlayerByName("fred");mc:returns(1)
  user_mock:getName();mc:returns("fred") 
  engine_mock:getPlayerByName("fred");mc:returns(1)
 
  mc:replay()
  voteManager = VoteManager:new{ engine = engine_mock, client = client_mock }
  voteManager:startvote(user_mock, question, answers)
  voteManager:castvote(user_mock,"Yes")
  currentYesTotal = Vote["poll"]["Yes"]
  assertEqual(currentYesTotal,1, "castvote should have gone from zero to 1")
  voteManager:castvote(user_mock,"No")
  currentNoTotal = Vote["poll"]["No"]
  assertEqual(currentNoTotal,1, "castvote should have change the total")
  currentYesTotal = Vote["poll"]["Yes"]
  assertEqual(currentYesTotal,0, "castvote should have change the total")

  mc:verify()
end

runTests{useANSI = false}
