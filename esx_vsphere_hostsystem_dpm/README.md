## esx_vsphere_hostsystem_dpm

This package extends esx_vsphere_hostsystem.cpu_usage, esx_vsphere_hostsystem.mem_usage, esx_vsphere_hostsystem.state from esx_vsphere_hostsystem to support DPM.

The check script overrides static OMD - "esx_vsphere_hostsystem" with script in local file hierarchy, but imports and executes original one to be update-save.
