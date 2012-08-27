Script.Load("ta/ns2/engine.lua")

clientGreeter={}

function clientGreeter.GreetClient(self, client) 
    engine:printToClientConsole(client, "Team Assist 0.0.0.1")
end