-- freeswitch.consoleLog('INFO', event:serialize())
if (event:getHeader('verto_success') ~= '1') then return end
local reply = freeswitch.API():execute(
    'curl',
    string.format(
        '%s post %s',
        freeswitch.getGlobalVariable('curl_gateway_url'),
        string.format(
            'hostname=%s&action=verto_client_login&client_id=%s&session_id=%s',
            event:getHeader('FreeSWITCH-Hostname'),
            event:getHeader('verto_login'),
            event:getHeader('verto_sessid')
        )
    )
)
if (reply == 'punt') then
    freeswitch.consoleLog(
        'WARNING',
        string.format(
            'Login denied for session %s.',
            event:getHeader('verto_sessid')
        )
    )
    freeswitch.API():execute(
        'verto_punt',
        event:getHeader('verto_sessid')
    )
end
