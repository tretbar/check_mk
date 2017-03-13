## apc_rackpdu_temp

This check monitors the data of temperature sensors of an APC Rack-PDU. It uses snmp to gather the sensor data. Per default the check uses the upper warning and critical levels extracted from the device to calculate the state of the service. Alternatively, limits can be configured via a rule. Set the name of the sensor in the PDU GUI before inventoring (any sensor will default to "SensorName")
