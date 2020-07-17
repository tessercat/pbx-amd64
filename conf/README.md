# FreeSWITCH configuration


## Config document sections

At boot,
the switch reads config document sections
from `freeswitch.xml`.

Note that
[`mod_xml_curl`](https://freeswitch.org/confluence/display/FREESWITCH/mod_xml_curl)
is configured to
bind to all sections, including
`dialplan`,
`directory`,
`configuration`
and `phrases`.
There are no file-system overrides.


### Vars

The repo doesn't contain the `vars.xml` file
referenced in `freeswitch.xml`.
Variables must include:

    <include>
      <X-PRE-PROCESS cmd="set" data="hostname=<hostname>"/>
      <X-PRE-PROCESS cmd="set" data="curl_gateway_url=<curl_gateway_url>"/>
      <X-PRE-PROCESS cmd="set" data="rtp_port_start=<rtp_port_start>"/>
      <X-PRE-PROCESS cmd="set" data="rtp_port_end=<rtp_port_end>"/>
      <X-PRE-PROCESS cmd="set" data="chat_ws_port=<chat_ws_port>"/>
      <X-PRE-PROCESS cmd="set" data="chat_debug_level=<chat_debug_level>"/>
    </include>


### Module load order notes

At boot,
modules in `modules/modules.conf.xml`
are loaded in order,
except `mod_acl` and `mod_event_socket`,
which load last.
(Though `mod_event_socket`
must be listed in `modules/modules.conf.xml`
or it doesn't load at all.)

Once `mod_xml_curl` loads,
the switch starts making requests
to gateway URLs
to configure modules that load after `mod_xml_curl`.

Judging by `mod_xml_curl` logs,
the switch loads
`post_load_modules.conf`,
`post_load_switch.conf`
after all other modules have loaded.
In order, requests are for
`post_load_modules.conf`,
`acl.conf`,
`event_socket.conf`
and `post_load_switch.conf`.

According to `mod_xml_curl` docs,
the content of `post_load_switch.conf.xml`
should be an exact copy of `switch.conf.xml`
except for the configuration section name,
which should be `post_load_switch.conf`.
