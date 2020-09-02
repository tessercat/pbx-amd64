This repo doesn't contain the `vars.xml` file
referenced in `freeswitch.xml`.
The file must be installed separately
by hand or by a config managment tool.
The file provides values for global variables
referenced in default module config,
and it must include values for variables
`hostname`,
`curl_gateway_url`,
`rtp_port_start`
and `rtp_port_end`.
