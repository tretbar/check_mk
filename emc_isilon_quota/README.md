## emc_isilon_quota

 Checks the configured quotas in EMC Isilon storage devices. The logic of the check is identical with filesystem checking. The hard thresholds of the quota is treated as the size. If this is missing, then the soft- or advisory thresholds are being used instead.

This checks extends existing one to a WATO rule, so that Quota value can be adjusted (sometimes reported wrong on SNMP)
