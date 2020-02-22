At boot,
the switch reads config document sections
from `freeswitch.xml`.


# Config document sections


## Vars

The document includes variables in `vars.xml`.
Variables must include:

    <include>
      <X-PRE-PROCESS cmd="set" data="hostname=<hostname>"/>
      <X-PRE-PROCESS cmd="set" data="curl_gateway_url=<curl_gateway_url>"/>
      <X-PRE-PROCESS cmd="set" data="rtp_port_start=<rtp_port_start>"/>
      <X-PRE-PROCESS cmd="set" data="rtp_port_end=<rtp_port_end>"/>
    </include>


## Configuration section

At boot,
modules in `modules/modules.conf.xml`
are loaded in order,
except for `mod_event_socket`,
which always loads last.
The `mod_event_socket` module
must be listed in `modules/modules.conf.xml`
or it doesn't load at all.

Note that `modules/modules.conf.xml` loads
[`mod_xml_curl`](https://freeswitch.org/confluence/display/FREESWITCH/mod_xml_curl).
Once `mod_xml_curl` loads,
the switch starts making requests
to gateway URLs
including for module config
for modules that load after `mod_xml_curl`.

The switch loads config files
`acl.conf.xml` and `post_load_switch.conf.xml`,
after all other modules have loaded
and just before `mod_event_socket` loads,
so `mod_xml_curl` always asks for config for all three.

According to the `mod_xml_curl` docs,
the content of `post_load_switch.conf.xml`
should be an exact copy of `switch.conf.xml`
except for the configuration section name,
which should be `post_load_switch.conf`.

NHote that module config is loaded only at boot
and on module reload,
and reloading modules affects service.


## Dialplan and directory sections

Dialplans and directories
are configured entirely by requests to
the XML curl gateway URL in `vars.xml`.
There are no file-system overrides.


## Languages section

The switch does not make XML curl requests
for language config,
so the config in `lang` is version controlled here,
and applying changes requires a switch restart.
