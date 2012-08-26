require "ta.helpers.strings"

Userlist = { }

--- Populate the userlist by loading all the users from file.
-- Will raise a "file not found" error if the file does not exist.
-- @param filename Name of the file to load
function Userlist.fromfile (self,filename)
    f = io.open(filename,"r")
    if f == nil then
        error("file not found")
    end     
    curline = f:read("*line")
    while curline do
        fields = split(curline,",")
        usr = User:new{access=fields[2], id=fields[1]}
        self[usr['id']] = usr
        curline = f:read("*line")
    end
end

