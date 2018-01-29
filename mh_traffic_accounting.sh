#!/bin/bash
#
# script counts total traffic of a specific service/customer/...
# out from network interface rrd databases and
# calculates daily and monthly (30d) total summary,
# honours in/out and multiple network devices (when using LAG/VPC)
#
# adjust "FILES" to match your rrd databases
#   hint: use proper naming convention to find them
#     - set a proper port description on network device
#     - "Use alias as service name for network interface checks"
#     - use $PATTERN of this script to finally identify the rrd files
#
# output is local check for localhost
#
# put this into your OMD_USER's crontab (but uncomment command :o):
# ------------------------------------------------------------
# OMD_USER must be able to write/create spool file
#0 7 * * * $OMD_ROOT/local/bin/mh_traffic_accounting.sh <pattern> >/var/lib/check_mk_agent/spool/90000_mh_traffic_accounting.sh-<pattern>

# ------------------------------------------------------------

#
# thomas.tretbar@gmx.de, 201703
#

# identify the wanted files
PATTERN=$1

# enter a command that lists all relevant rrd files, or list all files directly:
FILES=`find ${OMD_ROOT}/var/pnp4nagios/perfdata/ -regextype posix-egrep -regex '.*de-bx-bbr-100.*'"${PATTERN}"'.*_(in|out)\.rrd*'`
FILESCOUNT=`echo "${FILES}" | wc -l | xargs echo`

HOSTS=`echo "$FILES" | sed -n 's?^.*/\([^/]*\)/[^/]*$?\1?p' | sort | uniq | while read i; do echo -n $i" "; done`


# syntax: avg_traffic <start_time> <end_time>, timeformat: "HH:MM YYYYmmdd"
# this function sums all averages out of $FILES
function avg_traffic()
{
  echo "${FILES}" | grep $k".rrd$" | while read FILE
  do
    rrdtool graph dummy -s "00:00 ${1}" -e "00:00 ${2}" DEF:test=$FILE:1:AVERAGE PRINT:test:AVERAGE:'%.0lf' \
    | tail -1 | sed 's/ -nan$/ 0/'
  done | awk '{ total += $1 } END { print total }'
}


# this is a helper variable: the first day of the actual month
# later, we use this to calculate the last months' information.
THISMONTHFIRST=`date +%Y%m01`

# this is today:
TODAY=`date +%Y%m%d`

# this was yesterday:
YESTERDAY=`date +%Y%m%d -d "-1 day"`
YESTERDAYNICE=`date +%d.%m.%Y -d "-1 day"`

# the last month, nice for human reading
LASTMONTH=`date -d "${THISMONTHFIRST} -1 month" +%B" "%Y`

# first day of last month
FIRST=`date -d "${THISMONTHFIRST} -1 month" +%Y%m%d`

# yesterday average, MBit/s
BITSYESTERDAY=`avg_traffic "${YESTERDAY}" "${TODAY}"`
MBITSYESTERDAY=`echo ${BITSYESTERDAY} | awk ' { printf "%.1f\n", $1/131072 }'`

# last month average, TByte/mo
BITSLASTMONTH=`avg_traffic $FIRST $THISMONTHFIRST`
TBYTESLASTMONTH=`echo ${BITSLASTMONTH} | awk ' { printf "%.3f\n", ($1/131072)*0.3285 }'`


# make a check_mk local check
echo "<<<local>>>"
echo -n "0 DC_Traffic_"${PATTERN}
echo -n " lastday_bitspersecond="${BITSYESTERDAY}"|lastmonth_bitspersecond="${BITSLASTMONTH}
#echo -n " "${PATTERN}" Datacenter network traffic - yesterday ("$YESTERDAYNICE"): "${MBITSYESTERDAY} "MBit/s avg., last month ("$LASTMONTH"): "${TBYTESLASTMONTH}" TByte/mo"
echo -n " " ${TBYTESLASTMONTH}" TByte/mo ("${LASTMONTH}"), "${MBITSYESTERDAY}" MBit/s avg. yesterday ("$YESTERDAYNICE")"
echo ", summarized "${FILESCOUNT}" rrd-databases, hosts: "${HOSTS}

exit
