--[[
require "admin.ClientManager"
require "tests.lunity"
require "lib.lemock"
require "util.util"
require "util.messages"
module("clientManager", package.seeall, lunity)


local playerSlot = 1
function setup()
    mc = lemock.controller()
end


function test_print_message_to_specific_player_chat
    clientManager = new ClientManager()
    clientManager:print(playerSlot,PRINT_CHAT,"message to player")
end

function test_print_message_to_all_players_chat
    clientManager = new ClientManager()
    clientManager:print(PRINT_ALL_PLAYERS,PRINT_CHAT,"message to players")
end

function test_print_message_to_specific_player_console
    clientManager = new ClientManager()
    clientManager:print(playerSlot,PRINT_CONSOLE,"message to player")
end

function test_print_message_to_all_players_console
    clientManager = new ClientManager()
    clientManager:print(PRINT_ALL_PLAYERS,PRINT_CONSOLE,"message to players")
end

function test_print_message_to_specific_player_center
    clientManager = new ClientManager()
    clientManager:print(playerSlot,PRINT_CENTER,"message to player")
end

function test_print_message_to_all_players_center
    clientManager = new ClientManager()
    clientManager:print(PRINT_ALL_PLAYERS,PRINT_CENTER,"message to center of  players screen")
end

runTests{useANSI = false}
--]]