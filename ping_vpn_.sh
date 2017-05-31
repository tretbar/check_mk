#!/bin/bash
#
# - nagios based check used to produce check_mk local check syntax
# - this script is just a check_mk wrapper to check_icmp
# - provide check_icmp to host and allow sudo:
#   check_mk ALL=(ALL) NOPASSWD:/usr/sbin/check_icmp
# - enter target in TARGET (below) and place script in
#   /usr/lib/check_mk_agent/local
# - you'll need multiple scripts for multiple targets
# - hint: name script according to target:
#   ping_vpn_dd.sh, ping_vpn_bx.sh
#
# 0.1 initial ttr@mh (https://github.com/tretbar/check_mk)
#


# specify target and options:
TARGET=172.16.3.6
CHECK_ICMP="sudo /usr/sbin/check_icmp"
OPTIONS=""

# do the check, keep exitcode
OUT=`${CHECK_ICMP} ${TARGET} ${OPTIONS}`
EXITCODE=$?

# start output
echo -n ${EXITCODE}" VPN-${TARGET} "

# convert and reposition performance data, need to convert ms to sec
PERF=`echo $OUT | sed 's/^\([^|]*\)|\(.*\)$/\2/; s/ /|/g'`


echo $PERF | tr "=;|" " " | sed -s 's/ms//g' | while read A RTA RTAW RTAC B C D E F G RTMAX H RTMIN
do
  RTA=`printf '%1.6f\n' $(bc<<<"scale=6; $RTA/1000")`
  RTAW=`printf '%1.6f\n' $(bc<<<"scale=6; $RTAW/1000")`
  RTAC=`printf '%1.6f\n' $(bc<<<"scale=6; $RTAC/1000")`
  RTMAX=`printf '%1.6f\n' $(bc<<<"scale=6; $RTMAX/1000")`
  RTMIN=`printf '%1.6f\n' $(bc<<<"scale=6; $RTMIN/1000")`
  echo -n $A=$RTA"s;"$RTAW"s;"$RTAC"s;"$B"s;|"$C"="$D";"$E";"$F";;|"$G=$RTMAX"s;;;;|"$H=$RTMIN"s;;;;"
done


# finish output

CMKOUT=`echo $OUT | sed 's/^[^-]*- \([^|]*\)|\(.*\)$/\1/'`
echo " ping "${CMKOUT}

exit
