if (event:getHeader("proto") == "verto" and event:getHeader("dest_proto") == "GLOBAL") then
    local data = [[verto|%s|%s@%s|%s]]
    data = string.format(
        data,
        event:getHeader("from_user"),
        event:getHeader("to"), event:getHeader("FreeSWITCH-Hostname"),
        event:getBody()
    )
    -- freeswitch.consoleLog('INFO', data)
    freeswitch.API():execute("chat", data)
end
