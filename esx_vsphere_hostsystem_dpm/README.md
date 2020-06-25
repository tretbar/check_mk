## esx_vsphere_hostsystem_dpm

This package extends esx_vsphere_hostsystem.cpu_usage, esx_vsphere_hostsystem.mem_usage, esx_vsphere_hostsystem.state from esx_vsphere_hostsystem to support DPM.
The check script overrides static "esx_vsphere_hostsystem" with script in local file hierarchy, but imports and executes original one to be update-save. 

You want to:
* query both ESXi hosts and vCenter Server
* get host power state from vCenter
* set "host check command" to "Overall state" for DPM hosts
* disable services "HostSystem" and "Disk IO SUMMARY" for DPM hosts

A host in DPM stays OK, CPU and Memory will show an appropriate message.
