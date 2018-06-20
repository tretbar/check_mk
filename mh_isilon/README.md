## mh_isilon

consider this pre-beta.

## local/share/check_mk/agents/check_mk_agent.isilon 

# This is modified FreeBSD agent to run from ifs filesystem (which
# is mounted "noexec") with access restricted to the homedir of a
# special user.
#
# - Prepare an Isilon user, e.g. "check_mk" in "LOCAL:System" provider
# - Homedir "/ifs/home/check_mk"
# - assign role "AuditAdmin"
#
# - prepare directory structure:
#    /ifs/home/check_mk/etc
#    /ifs/home/check_mk/var/run/check_mk/cache
#    /ifs/home/check_mk/local
#    /ifs/home/check_mk/plugins
#
# - if you want to query agent by SSH-Login:
#     - additional dirs:
#    /ifs/home/check_mk/.ssh
#    /ifs/home/check_mk/bin
#    - deploy SSH public key for login and put this agent into ~/bin/check_mk_agent
#    - WATO rule "datasource_programs"
#      ("Individual program call instead of agent access"):
#      /usr/bin/ssh -o "StrictHostKeyChecking no" check_mk@<IP> "/usr/local/bin/bash /ifs/home/check_mk/bin/check_mk_agent"
#
# - deploy plugins

