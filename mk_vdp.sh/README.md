## mk_vdp.sh



# 1. install script in VDP appliance: /usr/lib/check_mk_agent/plugins/600
# 2. /etc/sudoers:
#    check_mk ALL = (root) NOPASSWD: /usr/local/avamar/bin/mccli
#
#
# for VDP appliance maintenance put all services "VDP" of affected VMs in check_mk Downtime
#
#
# - scripts generates one check per VM (all that are protected by jobs of this local appliance)
#
# - states:
#   OK:   - check age less than 5min
#         - and - errorcode for last VM backup is 0
#         - and - last backup not older 90000secs (25h)
#   WARN: - last backup older 90000secs (25h)
#   CRIT  - last backup older 176400sec (49h)
#         - or - errorcode for last VM backup is not 0
#   UNKN: - check age older 5min
#
# - perfstat:
#         - transferred bytes
#         - duration in seconds
#
# - example status detail:
#         OK - vSphere Data Protection Backup, VM: <name>, Appliance: <name>, last run: 2017-01-05 18:36 CET (status: Completed, transferred 1.4% of 73.5GB)
