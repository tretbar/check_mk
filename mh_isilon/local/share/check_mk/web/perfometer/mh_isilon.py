def perfometer_mh_isilon_node(row, check_command, perf_data):
    isi_hdd_avail_bytes = perf_data[0][1]
    isi_hdd_used_bytes = perf_data[1][1]
    usedpercentage = isi_hdd_used_bytes * 100 / isi_hdd_avail_bytes
    return "%d %%" % usedpercentage, perfometer_linear(usedpercentage, '#EAAC00')

perfometers["check_mk-isilon_node"] = perfometer_mh_isilon_node


def perfometer_mh_isilon_cluster(row, check_command, perf_data):
    isi_hdd_avail_bytes = perf_data[0][1]
    isi_hdd_used_bytes = perf_data[1][1]
    usedpercentage = isi_hdd_used_bytes * 100 / isi_hdd_avail_bytes 
    return "%d %%" % usedpercentage, perfometer_linear(usedpercentage, '#519FFF')

perfometers["check_mk-isilon_cluster"] = perfometer_mh_isilon_cluster


def perfometer_mh_isilon_pstat_nfs(row, check_command, perf_data):
    nfsv3_iops = perf_data[0][1]
    return "NFS %d IO/s" % nfsv3_iops, perfometer_logarithmic(nfsv3_iops, 1000, 2, '#238923')

perfometers["check_mk-isilon_pstat_nfs"] = perfometer_mh_isilon_pstat_nfs

def perfometer_mh_isi_mem(row, check_command, perf_data):
    isi_mem_total = perf_data[0][1]
    isi_mem_avail = perf_data[1][1]
    isi_mem_used = isi_mem_total - isi_mem_avail
    usedpercentage = isi_mem_used * 100 / isi_mem_total
    return "%d %%" % usedpercentage, perfometer_linear(usedpercentage, '#7FFD3F')

perfometers["check_mk-isi_mem"] = perfometer_mh_isi_mem
