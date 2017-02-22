# 1.0
  
Basic version.

# 1.1

 For a virtual machine running on ESX this check just reports the annotation. The check always returns {OK} state. It can be used to aggregate VMs in several views according to their annotations. See "Monitoring VMWare ESX with Check_MK" in the online documentation as well. The check script overwrites orignal "esx_vsphere_vm" in local file hierarchy, but imports and executes original one to be update-save. It replaces "special/agent_vsphere", so use only on Check_MK 1.2.8p17.
