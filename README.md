**WARNING**: "overwrite" means, original check_mk files are overwritten or extended. Please doublecheck twice before installing to not mess up your installation.

## apc_rackpdu_power
  
(overwrite) Can now monitor three-phase PDUs (was only one-phase).

**WARNING: This check supersedes existing one by changing service description! You'll need to reinventarize any APC Rack-PDU!**

## apc_rackpdu_temp
  
Monitors the data of temperature sensors of an APC Rack-PDU.

## dell_chassis_slots

(overwrite) Can now be controlled by a WATO rule to set any desired state for a given slot state. Useful when using DPM (which would report {WARN} if powered down).

## dell_poweredge_mem

(overwrite) Can now be controlled by a WATO rule to set any desired state for a given DIMM state. Useful when using DPM (which would report {UNKNOWN} if powered down).

## emc_isilon_quota

(overwrite) This checks extends existing one to a WATO rule, so that Quota value can be adjusted (sometimes reported wrong on SNMP)

## esx_vsphere_hostsystem_dpm

(overwrite) Modifies host CPU, MEM and state information to support DPM (and not reporting errors if powered down).

## esx_vsphere_vm_annotation

(overwrite) Just reports vSphere annotation for a VM. Modifies special agent, so stick to correct version!

## vnx_lun_perf.sh

A Nagios script to report performance of VNX LUNs. Configure in WATO as classical check for the array (not SP), one per LUN. Configure SP IP addresses inside script. Needs naviseccli.

## cmk_replication.sh

Script runs on vMA and checks vSphere Replication status. Runs against an ESXi with access to all datastores, honors RPO and stopped replications.

## mk_vdp.sh ##

A small script that allows monitoring of VMware Data Protection Jobs. Runs on VDP Appliance.
