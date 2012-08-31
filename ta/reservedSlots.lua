require 'ta.storageManager'
require 'ta.config.configurationSettings'

local reservedSlotsPath = ""
local reservedSlotsFileName = "reservedSlots.json"

function onClientConnect(client)
    //Is the connecting client in the reserved slot list?
        //If Yes
            //Is the server "full"?
                //If No, allow client to connect normally
                //If Yes
                    //Are there any non-members on the server?
                        //If No, kick with message RESERVEDSLOTS_MEMBER_CANT_CONNECT
                        //If Yes
                            //Find non-member with longest time who isn't commanding, kick with message RESERVEDSLOTS_USER_REMOVED_FOR_MEMBER
                            //Allow client to complete connection
        //If No
            //Is the server in Members Only Mode?
                //If Yes, kick with message RESERVEDSLOTS_PUBLIC_CANT_CONNECT
                //If No
                    //Is the server "full"?  (maxPlayers - RESERVEDSLOTS_NUMBER_OF_SLOTS_FOR_PROCESSING)
                        //If Yes, kick with message RESERVEDSLOTS_PUBLIC_CANT_CONNECT
                        //If no, allow client to connect normally
end

local function findPublicPlayerToKick()
    //Find a non-reserved slot player that meets criteria.
    //Get non-members (return nil if none exist), find one with RESERVEDSLOTS_KICK_PLAYER_SERVER_DURATION (longest, shortest, random)
    //Return that player
end