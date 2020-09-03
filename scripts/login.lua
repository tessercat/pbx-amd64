-- freeswitch.consoleLog('INFO', event:serialize())
local client_id = event:getHeader('verto_login')
local gateway = freeswitch.getGlobalVariable('curl_gateway_url')
local args_tpl = '%s post %s'
local data_tpl = 'action=verto_client_login&client_id=%s&result=%s'
if (client_id ~= event:getHeader('verto_sessid')) then
    freeswitch.consoleLog('WARNING', string.format('Login denied - bad sessid %s.', client_id))
    freeswitch.API():execute('verto_punt', event:getHeader('verto_sessid'))
    local data = string.format(data_tpl, client_id, 'bad_sessid')
    freeswitch.API():execute('curl', string.format(args_tpl, gateway, data))
else
    local data = string.format(data_tpl, client_id, 'success')
    local reply = freeswitch.API():execute('curl', string.format(args_tpl, gateway, data))
    if (reply == 'punt') then
        freeswitch.consoleLog('WARNING', string.format('Login denied - channel full %s.', client_id))
        freeswitch.API():execute('verto_punt', event:getHeader('verto_sessid'))
    end
end
