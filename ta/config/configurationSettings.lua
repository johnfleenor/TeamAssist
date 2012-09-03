--This file holds TeamAssist variables intended to be set by the server admin

--This is the message a user sees when unable to connect to the server because
-- they don't have a reserved slot, and no public slots are available.
RESERVEDSLOTS_PUBLIC_CANT_CONNECT = "This server currently has no public slots.  For information on reserved slots, see instructions on our website."

--This is the message a user sees when unable to connect to the server when they
-- ARE a reserved slot holder, but there just aren't slots to be had.
RESERVEDSLOTS_MEMBER_CANT_CONNECT = "This server currently has no open slots. Man, what a great problem to have."

--This is the message a user sees when kicked from the server for a user with
-- a reserved slot.
RESERVEDSLOTS_USER_REMOVED_FOR_MEMBER = "You have been kicked to make room for a user with a reserved slot.  For information on reserved slots, see instructions on our website."

--This setting makes it so ONLY users with a reserved slot can connect.
-- This will essentially make the server private for members only.
-- Valid values are:
--  true
--  false
RESERVEDSLOTS_MEMBERS_ONLY_MODE = false

--This is the number of slots to keep open for reserved slot processing.
-- The server will effective have a maximum count of the REAL maxPlayers minus this number.
RESERVEDSLOTS_NUMBER_OF_SLOTS_FOR_PROCESSING = 2

--When choosing a player for kicking, should we try to protect commanders for getting kicked?
-- (moving them essentially to one of the last considered)
-- Valid values are:
--  true
--  false
RESERVEDSLOTS_KEEP_COMMANDERS_IF_POSSIBLE = true

--When choosing a player for kicking, should we go for the person connected longest, or shortest?
-- Or maybe we don't care?
-- Valid values are:
--  "longest"
--  "shortest"
--  "random"
RESERVEDSLOTS_KICK_PLAYER_SERVER_DURATION = "longest"