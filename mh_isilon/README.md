Description:  check_mk EMC Isilon

Version:      0.2d_mk

Usage:
- check_mk agent and plugin with WATO rules and cee metric graphs
- see agent for installation instructions

Features:
- CPU load, filesystem, disk status, temperature, memory and uptime of every node
- Cluster status, firmware level, capacity and NTP info
- Performance statistics incl. IOps, net and disk throughput
- Quota usage incl. summary, configurable thresholds
- SyncIQ delay, configurable thresholds
			  
Update:
- redeploy agent when updating from any earlier version

Changelog:    0.2.d
- fixed a crash when a node is in maintenance or reboot
- added WATO option to ignore network packet errors
- statistics CEE metrics now have friendly names
- reworked memory CEE metrics graph

How to:

- Prepare an Isilon user, e.g. "check_mk" in "LOCAL:System" provider
- Homedir "/ifs/home/check_mk"
- assign role "AuditAdmin"
- sudoers: check_mk ALL=(ALL) NOPASSWD:/usr/bin/isi_for_array *

- prepare directory structure:
   $HOME/etc
   $HOME/var/run/check_mk/cache
   $HOME/local
   $HOME/plugins

- you want to query agent by SSH-Login:
   - additional dirs:
   $HOME/.ssh
   $HOME/bin
   - deploy SSH public key for login and put agent into ~/bin/check_mk_agent
   - WATO rule "datasource_programs"
     ("Individual program call instead of agent access"):
     /usr/bin/ssh -o "StrictHostKeyChecking no" check_mk@<IP> "/usr/local/bin/bash /ifs/home/check_mk/bin/check_mk_agent"

- Configure only one host object: the Isilon cluster address. Nodes are
  automagically integrated.

- You do not want to query agent more often than every 5 minutes, isi says.

- You want to deploy plugin, Tom says:
  - plugins/mh_isilon
    - do NOT cache this plugin! caching is integrated.
    - isi could be slow. reinventory after some minutes
      if something is missing.
