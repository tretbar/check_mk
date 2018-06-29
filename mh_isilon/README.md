## mh_isilon

A check_mk check for EMC Isilon. Consider this to be pre-beta.

## Features

- CPU load of every node
- local filesystem of every node
- Isilon cluster information incl. OneFS information
- Node information incl. used raw disk capacity and temperature
- Quota checks
- SyncIQ checks
- several statistics incl. IOps, troughputs and network packets
- Memory of every node
- NTP time sync
- Uptime of every node


## Installation instructions:

for up-to-date info see local/share/check_mk/agents/check_mk_agent.isilon 

```
# How to:
#
# - Prepare an Isilon user, e.g. "check_mk" in "LOCAL:System" provider
# - Homedir "/ifs/home/check_mk"
# - assign role "AuditAdmin"
# - sudoers: check_mk ALL=(ALL) NOPASSWD:/usr/bin/isi_for_array *
#
# - prepare directory structure:
#    /ifs/home/check_mk/etc
#    /ifs/home/check_mk/var/run/check_mk/cache
#    /ifs/home/check_mk/local
#    /ifs/home/check_mk/plugins
#
# - if you want to query agent by SSH-Login:
#    - additional dirs:
#    /ifs/home/check_mk/.ssh
#    /ifs/home/check_mk/bin
#    - deploy SSH public key for login and put agent into ~/bin/check_mk_agent
#    - WATO rule "datasource_programs"
#      ("Individual program call instead of agent access"):
#      /usr/bin/ssh -o "StrictHostKeyChecking no" check_mk@<IP> "/usr/local/bin/bash /ifs/home/check_mk/bin/check_mk_agent"
#
# - Configure only one host object: the Isilon cluster address. Nodes are
#   automagically integrated.
#
# - You do not want to query agent more often than every 5 minutes, isi says.
#
# - You want to deploy plugins, Tom says.
#   - plugins/1800/mh_isilon
#   - plugins/300/isilon_pstat_nfs (not only for NFS)
#
#
#                        \m/ >_< \m/
#
#  EMC Isilon adaptions: Tom Tretbar <thomas.tretbar@managedhosting.de>
```

