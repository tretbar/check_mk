## dell_chassis_slots

This check monitors the blade slots of the chassis of Dell PowerEdge/FX2 Servers.  The check returns {OK} when a slot is in the {basic} state. It returns {WARN} otherwise (can be overwritten by a WATO rule).  No limits are set in the check.  In addition to the state, the check displays the following other parameters of the server: drsServerServiceTag, drsServerSlotName.

This checks extends existing one to a WATO rule, so that states can be overwritten. This is especially helpful if you have vSphere hosts powered down by DPM, which would be {WARN}, or if you have full-width blades (expansion slot will throw error).
