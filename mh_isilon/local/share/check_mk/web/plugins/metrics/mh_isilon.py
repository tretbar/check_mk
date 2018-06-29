# NFS
metric_info["nfsv3_ios"] = {
    "title" : _( "Isilon NFSv3 Operations"),
    "unit"  : "1/s",
    "color" : "31/a",
}

# Disk
metric_info["isi_disk_ios"] = {
    "title" : _( "Isilon Disk Operations"),
    "unit"  : "1/s",
    "color" : "31/a",
}

metric_info["isi_disk_write_throughput"] = {
    "title" : _("Isilon Disk Write"),
    "unit"  : "bytes/s",
    "color" : "#60A0E0",
}

metric_info["isi_disk_read_throughput"] = {
    "title" : _("Isilon Disk Read"),
    "unit"  : "bytes/s",
    "color" : "#60E0A0",
}

graph_info.append({
    "title"     : _("Isilon Disk Througput"),
    "metrics"   : [ ("isi_disk_write_throughput", "-area"),
                    ("isi_disk_read_throughput", "area"),
                ],
})





# OneFS
metric_info["isi_ifs_in_bps"] = {
    "title" : _("OneFS Write Throughput"),
    "unit"  : "bytes/s",
    "color" : "#4080C0",
}

metric_info["isi_ifs_out_bps"] = {
    "title" : _("OneFS Read Throughput"),
    "unit"  : "bytes/s",
    "color" : "#40C080",
}

graph_info.append({
    "title"     : _("OneFS Throughput"),
    "metrics"   : [ ("isi_ifs_in_bps", "-area"),
                    ("isi_ifs_out_bps", "area"),
                ],
})

# Network
metric_info["isi_outucast"] = {
    "title" : _("Isilon Output unicast packets"),
    "unit"  : "1/s",
    "color" : "#00C0FF",
}

metric_info["isi_inucast"] = {
    "title" : _("Isilon Input unicast packets"),
    "unit"  : "1/s",
    "color" : "#00FFC0",
}
graph_info.append({
    "title" : _("Isilon Network Packets"),
    "metrics" : [
        ( "isi_inucast",      "area" ),
        ( "isi_outucast",     "-area" ),
                ],
})

metric_info["isi_outerr"] = {
    "title" : _("Isilon Network Output Errors"),
    "unit"  : "1/s",
    "color" : "#FF0080",
}

metric_info["isi_inerr"] = {
    "title" : _("Isilon Network Input Errors"),
    "unit"  : "1/s",
    "color" : "#FF0000",
}
graph_info.append({
    "title" : _("Isilon Network Error Packets"),
    "metrics" : [
        ( "isi_inerr",      "area" ),
        ( "isi_outerr",     "-area" ),
                ],
})


metric_info["isi_if_out_bps"] = {
    "title" : _("Isilon Network Traffic Out"),
    "unit"  : "bits/s",
    "color" : "#0080e0",
}

metric_info["isi_if_in_bps"] = {
    "title" : _("Isilon Network Traffic In"),
    "unit"  : "bits/s",
    "color" : "#00e060",
}
graph_info.append({
    "title" : _("Isilon Network Bandwidth"),
    "metrics" : [
        ( "isi_if_in_bps",      "area" ),
        ( "isi_if_out_bps",     "-area" ),
                ],
})


# Temperature
metric_info["isi_temp"] = {
    "title" : _("Isilon Temperature Sensor"),
    "unit"  : "c",
    "color" : "#E2BC7F",
}


metric_info["isi_psu_temp"] = {
    "title" : _("Isilon PSU Temperature"),
    "unit"  : "c",
    "color" : "#E04341",
}


graph_info.append({
    "title" : _("EMC Isilon Node Temperature"),
    "metrics" : [
        ( "isi_psu_temp",      "area" ),
        ( "isi_temp",      "area" ),
                ],
})


# memory
metric_info["isi_mem_avail"] = {
    "title" : _("Isilon Available Memory"),
    "unit"  : "bytes",
    "color" : "#51BC58",
}

metric_info["isi_mem_total"] = {
    "title" : _("Isilon Total Memory"),
    "unit"  : "bytes",
    "color" : "#E1AE00",
}

graph_info.append({
    "title" : _("EMC Isilon Node Memory"),
    "metrics" : [
        ( "isi_mem_total",      "area" ),
        ( "isi_mem_avail",      "area" ),
                ],
})


