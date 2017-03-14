## dell_poweredge_mem

 This check monitors the state of the memory modules of Dell PowerEdge Servers. The state is extracted from the device via SNMP from the parameter {memoryDeviceStatus}. The state of the check is {OK} when the device returns a state of {OK}. The state of the check is {WARN} when the device returns a state of {other}, {unknown} or {nonCritical}. The state of the check is {CRIT} otherwise. No limits are set in the check. In addition to the state the following information of the PCI devices is retrieved and displayed in the check output: size, speed, manufacturer, part number and serial number.

This checks extends existing one to a WATO rule, so that states can be overwritten. This is especially helpful if you have vSphere hosts powered down by DPM, where the state would be {unknown} otherwise. 
