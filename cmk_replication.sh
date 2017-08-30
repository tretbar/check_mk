#!/bin/bash
#set -x
# 
# 1,16,31,46 * * * * /home/vi-admin/cmk_replication.sh >/tmp/cmk_replication.cmk.out && mv /tmp/cmk_replication.cmk.out /var/lib/check_mk_agent/spool/1800_cmk_replication
#

# bash sucks:
declare -i number

# human readable bytes
bytestohumanreadable(){
multiplier="0"
number="$1"
while [ "$number" -ge 1024 ] ; do
  multiplier=$(($multiplier+1))
  number=$(($number/1024))
done
case "$multiplier" in
  1)
   echo "$number KB"
  ;;
  2)
   echo "$number MB"
  ;;
  3)
   echo "$number GB"
  ;;
  4)
   echo "$number TB"
  ;;
  *)
   echo "$1 B"
  ;;
esac
}

# human readable seconds (no precision needs for values >1d)
secstohumanreadable(){
  number="$1"
  if [ $number -gt 86399 ]
  then
    echo ">$(($number/86399)) d"
  else
    date -d@$number -u +%H:%M" hr:min"
  fi
}


# enter vSphere host with access to all datastores:
export VI_SERVER=myhost

# parse password file:
. /home/vi-admin/passwd.cfg

# local file
LOCALFILE="/tmp/cmk_replication.$$"
NOWTIME=`date +%s`

# on every vifs sleep a while
VIFSSLEEP=2

# vMA sucks:
export PERL_LWP_SSL_VERIFY_HOSTNAME=0
VIFS="/usr/bin/vifs"


# loop thru datastores: enter egrep pattern for datastores names:
sleep ${VIFSSLEEP}
${VIFS} -S | egrep '^[I]' | while read DS
do
  # loop thru directories: enter egrep pattern for VM names:
  sleep ${VIFSSLEEP}
  ${VIFS} -D "[$DS]" | egrep '^d' | while read VM
  do
    # look for hbrgrp*txt files: enter egrep pattern for these files
    sleep ${VIFSSLEEP}
    ${VIFS} -D "[$DS] $VM" | egrep 'txt' | while read FILE
    do

      # reset LOCALFILE
      > ${LOCALFILE}

      # get file:
      sleep ${VIFSSLEEP}
      ${VIFS} -g "[$DS] $VM${FILE}" ${LOCALFILE} >/dev/null 2>&1 || { echo "download failure" >&2; continue; }

      # normalize and parse it:
      sed -i '/wwww3org/d; /DOCTYPE/d; /encoding/d; /^$/d; /^#/d; s/^/export /g; s/ = /=/g; s/\.//g' ${LOCALFILE}
      . ${LOCALFILE}

      # extract info:
      RPOMIN=${grouprpo}
      PAUSED=${grouppaused}
      LASTRUN=${statecreated}
      BYTES=${instance0transferBytes}
      DURATION=${instance0complete}

      OUT="vSphere Replication"

      # make times comparable
      let AGE=${NOWTIME}-$LASTRUN
      let RPOSEC=${RPOMIN}*60

      # human readable output
      RPOHUMAN=$(secstohumanreadable ${RPOSEC})
      AGEHUMAN=$(secstohumanreadable ${AGE})
      BYTESHUMAN=$(bytestohumanreadable ${instance0transferBytes})

      #check for RPO violation
      if [ $AGE -gt $RPOSEC ]
      then
        EXITCODE=1
        AGEHUMAN=$AGEHUMAN"(!)"
      else
        EXITCODE=0
      fi

      # check if paused (pausing will always be WARN)
      if [ ${PAUSED} == "0" ]
      then
        OUT=${OUT}" active, age "${AGEHUMAN}", RPO "${RPOHUMAN}", Size "$BYTESHUMAN", Duration "${DURATION}" sec"
      else
        OUT=${OUT}" paused, age "${AGEHUMAN}
        EXITCODE=1
      fi

      # piggybacking check_mk local checks:
      echo "<<<<"${VM}">>>>" | sed 's?/??'
      echo "<<<local>>>"
      echo ${EXITCODE}" Replication - "${OUT}
      echo

    done
  done
done

# delete local file
rm  ${LOCALFILE}

exit

