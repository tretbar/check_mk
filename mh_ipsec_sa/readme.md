title: IPsec Security Association
agents: linux
catalog: app/ipsec
license: GPL
distribution: check_mk
description:
 This check monitors ipsec connections. It reads SA connections from the
 config files {/etc/ipsec*conf} and gets info from {ipsec} and {iptables}
 commands. Because you do not want the check_mk agent to run as root, you 'll
 have to provide {sudo} for these, see plugin for details.

 The SA will be {CRIT}, if status is not {ESTABLISHED}. The SA will be {CRIT},
 if there are less than {2} iptables rules for associated networks found, since
 this usually shows problems. Both can be overwritten by a WATO rule
 (e.g. for on-demand connections).

 The check will perfstat in- and outbound bandwidth, and will perfstat connection
 status (1-established, 0-otherwise) for graphical overview. CEE graphing templates
 are provided.

 A perfometer is provided, that shows either bandwidth or red "Down".

 The check is able to detect appended SAs.

inventory:
 One service per SA is created.

item:
 IPsec SA <SA name>
