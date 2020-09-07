-- freeswitch.consoleLog('INFO', event:serialize())
if (event:getHeader('verto_login') == nil) then return end
freeswitch.API():execute(
    'curl',
    string.format(
        '%s post %s',
        freeswitch.getGlobalVariable('curl_gateway_url'),
        string.format(
            'hostname=%s&action=verto_client_disconnect&client_id=%s',
            event:getHeader('FreeSWITCH-Hostname'),
            event:getHeader('verto_login')
        )
    )
)
