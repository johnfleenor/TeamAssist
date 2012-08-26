CommandList = { }

--- Register a new command
-- @param name Name of the command to register
-- @param access Access level required for this command.  See constants.ADMIN_* for acceptable values
-- @param my_callback Function to be called when this command is executed.  The callback will be called a user object, and a table of arguments
function CommandList.register (self,name,access,my_callback)
    --print("Registering "..name)
    self[name] = {access=access,callback=my_callback}
    --print(my_callback)
end

--- Call an existing command.
-- This function will ensure the command exists, and the user has access to execute it
-- @param user_id SteamID of the user executing the command
-- @param commandstring The full command string that the user typed in
function CommandList.call (self, user_id, commandstring)
    args = self:splitcommand(commandstring)
    
    if self[args[1]] == nil then
        print('Unknown command')
        return
    end

    curcmd = self[args[1]]
    curuser = Userlist[user_id] or User:new()

    if not (curcmd['access'] == ADMIN_NONE) and not (curuser:hasflag(curcmd['access'])) then
        print('Access Denied!')
        return
    end
    curcmd['callback'](user_id,args)
end

--- Split a command string
-- "why hello there, "i am" a turtle" becomes { "why", "hello", "there,", "i am", "a", "turtle" }
-- @param argstring Full text of the command string
-- @return Table containing the individual arguments in the command string
function CommandList.splitcommand (self, argstring)
    inQuote = false
    result = { }
    result[1] = ""
    curResult = 1
    for i=1,#argstring do
        char = argstring:sub(i,i)
        if inQuote and char ~= '"' then
            result[curResult] = result[curResult]..char
        elseif inQuote and char == '"' then
            curResult = curResult + 1
            result[curResult] = ""
            inQuote = false
        -- inQuote should always be false after this point  
        elseif char == '"' then
            inQuote = true
        elseif char == ' ' and #result[curResult] ~= 0 then
            curResult = curResult + 1
            result[curResult] = ""
        elseif char == ' ' then
            -- do nothing, swallow duplicate spaces    
        else
            result[curResult] = result[curResult]..char
        end    
    end
    if result[curResult] == "" then
        table.remove(result,curResult)
    end
    return result
end