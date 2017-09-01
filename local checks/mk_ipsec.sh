#!/bin/bash
#set -x
#
# small script to monitor ipsec sa in check_mk
# - runs on vpn gateway (e.g. ipfire):
#   /usr/lib/check_mk_agent/local/mk_ipsec.sh
# - creates a main status check and one service check per sa
# - does not monitor "real" traffic flow, only state
# - warns if sa state is not ESTABLISHED
# - errors if less than 2 iptables rules associated to the network,
#   (might happen on ipfire when reestablishing)
#
# - needs sudo for check user:
#   check_mk ALL=(ALL) NOPASSWD:/usr/sbin/ipsec status
#   check_mk ALL=(ALL) NOPASSWD:/usr/sbin/ipsec status *
#   check_mk ALL=(ALL) NOPASSWD:/sbin/iptables -L -n -v
#
# 0.1 initial ttr@mh (https://github.com/tretbar/check_mk)
# 0.2 ttr@mh support for appended SA
#


#
# get config in a list:
#  <SA1> <networks>
#  <SA2> <network1,network2>
#  ...
#
CONFIG=$(awk -F '[ =]' '/^conn [^%]/ { printf $2" " }; /rightsubnet/ { print $2}' /etc/ipsec*conf)

#
# get firewall state
#
IPTABLESOUT=`sudo /sbin/iptables -L -n -v`

#
# get ipsec status, wait 5 secs if currently reconnecting
#
IPSECOUT=`sudo /usr/sbin/ipsec status`

if ! echo "${IPSECOUT}" | grep -q " 0 connecting"
then
  sleep 5
  IPSECOUT=`sudo /usr/sbin/ipsec status`
fi

# main status
STATUS=`echo "${IPSECOUT}" | sed -n 's/^Security Associations (\([^)]*\)).*$/\1/p'`
if echo "${IPSECOUT}" | grep -q " 0 connecting"
then
  echo "0 IPsec - Security Associations: "${STATUS}
else
  echo "1 IPsec - Security Associations: "${STATUS}"(!)"
fi



#
# loop thru CONFIG by line
#
echo "${CONFIG}" | while read SA NETWORKS
do

  EXITCODE=0

  #
  # read SA status
  #
  OUT=$(sudo /usr/sbin/ipsec status ${SA})

  #
  # get status
  #
  STATUS=$(echo "${OUT}" | sed -n 's/^[ ]*\([^\[]*\)\[.*ESTABLISHED \([^,]*\),.*$/SA \"\1\": ESTABLISHED \2/p')

  #
  # if $STATUS is empty we are not established
  #
  if [ -z "${STATUS}" >/dev/null ]
  then

    #
    # drop an error and the first error line
    #
    EXITCODE=2
    STATUS=$(echo "${OUT}" | sed -n 's/^.*: \([^,]*\),.*$/status NOT ESTABLISHED(!!): \1/p' | head -1)

  else

    #
    # check for an appended SA
    #
    #echo "${STATUS}" | egrep -q ' $SA ' && STATUS="appended to "${STATUS}
    echo "${STATUS}" | grep  -vq \"$SA\" && STATUS="appended to "${STATUS}

    STATUS=${STATUS}", net:"${NETWORKS}
  fi

  #
  # make $NETWORKS a regex
  #
  NETWORKS=$(echo ${NETWORKS} | tr "," "|")

  #
  # check for iptables rules
  #
  RULES=`echo "${IPTABLESOUT}" | egrep ${NETWORKS} | wc -l | xargs echo`
  if [ ${RULES} -ge 2 ]
  then
    STATUS=${STATUS}", iptables: "${RULES}" rules"
  else
    STATUS=${STATUS}", iptables: "${RULES}" rules (!!)"
    EXITCODE=2
  fi

  echo ${EXITCODE}" IPsec_"$SA" - "${STATUS}

done
