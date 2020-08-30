if (event:getHeader("verto_login") ~= event:getHeader("verto_sessid")) then
    freeswitch.consoleLog("WARNING", string.format("Punting bad client %s.", event:getHeader("verto_login")))
    freeswitch.API():execute("verto_punt", event:getHeader("verto_sessid"))
end
