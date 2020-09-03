-- freeswitch.consoleLog('INFO', event:serialize())
-- The verto_login field is nil when a client disconnects without logging in first.
local client_id = event:getHeader('verto_login')
local gateway = freeswitch.getGlobalVariable('curl_gateway_url')
local args_tpl = '%s post %s'
local data_tpl = 'action=verto_client_disconnect&client_id=%s'
local data = string.format(data_tpl, client_id)
freeswitch.API():execute('curl', string.format(args_tpl, gateway, data))
