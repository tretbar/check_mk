#!/bin/bash
#set -x
#
# gets lun perf data of VNX:
# stores old data in /dev/shm
#
#
#

#echo ${@} >>/tmp/ttr.out



function usage()
{
  echo "usage: "${SCRIPT##*/}" -h <storage name (NOT SP)> -u <username> -p <password> -l <LUN ID>"
  exit 1
}

SCRIPT=`echo ${0%% *}`

# parse args
while [ ! -z $1 ]
do
  case $@ in
    -h*)
      shift; ARRAY=$1 ;;
    -u*)
      shift; USER=$1 ;;
    -p*)
      shift; PASS=$1 ;;
    -l*)
      shift; LUNID=$1 ;;
    *)
      shift ;;
  esac
done

#
# configure your arrays here
#
# get SPs
case ${ARRAY} in
  <enter first array name here>)
    SPA=<enter IP of SPA>
    SPB=<enter IP of SPB>
  ;;
  <enter second array name here>)
    SPA=<enter IP of SPA>
    SPB=<enter IP of SPB>
  ;;
  *)
    echo did not find Storage Processor IP Info. Adjust script!
    exit 1
  ;;
esac

# exit on wrong usage
[ ! -z ${SPA} -o -z ${SPB} -o -z ${USER} -o -z ${PASS} -o -z ${LUNID} ] 2>/dev/null || usage

# define SHMFILE and parse it
[ -d /dev/shm/$OMD_SITE/${ARRAY} ] ||  mkdir -p /dev/shm/$OMD_SITE/${ARRAY}

SHM=/dev/shm/$OMD_SITE/${ARRAY}/${SCRIPT##*/}.LUN.${LUNID}
. ${SHM}




# do the stuff, change this to fit your needs

# check SP A
INF=`/opt/Navisphere/bin/naviseccli -h ${SPA} -User ${USER} -Password ${PASS} -Scope 1 lun -list -l ${LUNID} -all | tr "%" " "`


# check SP B

#INF=`cat lun0.all | tr "%" " "`
if ! echo "${INF}" | grep "LOGICAL UNIT NUMBER"  >/dev/null
then
  INF=`/opt/Navisphere/bin/naviseccli -h ${SPB} -User ${USER} -Password ${PASS} -Scope 1 lun -list -l ${LUNID} -all | tr "%" " "`
  [ $? == 0 ] || { echo "cannot connect to ${ARRAY}"; exit 2; }
  SPWARN=" ATTENTION: tried SP B. SP A down? - "
fi



# stamp
STAMP=`date +%s`
echo "OLDSTAMP=$STAMP" >${SHM}

let DELTA=$STAMP-$OLDSTAMP

#set -x
OUT=`awk '/^Read Requests:/ { READREQ=$3 }
     /^Write Requests:/ { WRITEREQ=$3 }
     /^Blocks Read:/ { READBLK=$3 }
     /^Blocks Written:/ { WRITEBLK=$3 }
     /^Current Owner/ { CO=$4 }
     /^Default Owner/ { DO=$4 }
     /^Allocation Owner/ { AO=$4 }
     /^Performance/ { PERF=$2 }
     /^Capacity/ { CAPA=$2 }

     END {

       # check ownership:
       if (CO==DO && CO==AO) {
         OWNERSHIP="Ownership: OK (SP "CO")"
         OWNERSHIPCORRECT=1
       }
       else {
         OWNERSHIP="Ownership: WARNING (Default owner: "DO", Current owner: "CO", Allocation owner: "AO")(!)"
         OWNERSHIPCORRECT=0
       }


       READIOPS=(READREQ-'${OLDREADREQ}')/'${DELTA}'
       WRITEIOPS=(WRITEREQ-'${OLDWRITEREQ}')/'${DELTA}'
       RBLOCKIOPS=(READBLK-'${OLDREADBLK}')/'${DELTA}'
       WBLOCKIOPS=(WRITEBLK-'${OLDWRITEBLK}')/'${DELTA}'

       printf "LUN %s, Reads: %d/s, Writes: %d/s, Blocks read: %d/s, Blocks written: %d/s, %s, Performance tier setsize: %d%%, Capacity tier setsize: %d%%", '${LUNID}', READIOPS, WRITEIOPS, RBLOCKIOPS, WBLOCKIOPS, OWNERSHIP, PERF, CAPA

       printf " | "

       printf "Requests_per_second_Read=%d Requests_per_second_Write=%d Blocksread_per_second=%d Blockswritten_per_second=%d Ownership_correct=%d Tier_performance_percentage=%d Tier_capacity_percentage=%d", READIOPS, WRITEIOPS, RBLOCKIOPS, WBLOCKIOPS, OWNERSHIPCORRECT, PERF, CAPA

     }' <<<"${INF}"`

awk '/^Read Requests:/  { print "OLDREADREQ="$3 }
     /^Write Requests:/ { print "OLDWRITEREQ="$3 }
     /^Blocks Read:/    { print "OLDREADBLK="$3 }
     /^Blocks Written:/ { print "OLDWRITEBLK="$3 }' >>${SHM} <<<"${INF}"



if echo ${OUT} | grep WARNING >/dev/null
then
  EXITCODE=1
  OUT="WARN - "${SPWARN}${OUT}
else
  EXITCODE=0
  OUT="OK - "${SPWARN}${OUT}
fi

echo ${OUT}
exit ${EXITCODE}
