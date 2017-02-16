# check_mk 

Some stuff I wrote for check_mk

## apc_rackpdu_power
  
This check monitors the amperage of an APC Rack-PDU and is capable of monitoring one- and three-phase PDU.

**WARNING: This check supersedes existing one! You'll need to reinventarize any APC Rack-PDU!**

## apc_rackpdu_temp
  
This check monitors the data of temperature sensors of an APC Rack-PDU. If there are any, it should inventorize all sensors on the PDU. Mine only have one sensor.

## dell_chassis_slots

This check monitors the blade slots of the chassis of Dell PowerEdge/FX2 Servers.  The check returns {OK} when a slot is in the {basic} state. It returns {WARN} otherwise (can be overwritten by a WATO rule).  No limits are set in the check.  In addition to the state, the check displays the following other parameters of the server: drsServerServiceTag, drsServerSlotName

## esx_vsphere_vm_annotation

 For a virtual machine running on ESX this check just reports the annotation. The check always returns {OK} state. It can be used to aggregate VMs in several views according to their annotations. See "Monitoring VMWare ESX with Check_MK" in the online documentation as well. The check script overwrites orignal "esx_vsphere_vm" in local file hierarchy, but imports and executes original one to be update-save.
