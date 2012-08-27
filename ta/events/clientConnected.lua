Script.Load("ta/notifications/clientGreeter.lua")
Script.Load("ta/ns2/engine.lua")

function OnClientConnect(client)
    clientGreeter:GreetClient(client)
end

local function BindHandlers()
    engine:bindHandler("ClientConnect", OnClientConnect)
end

BindHandlers()
