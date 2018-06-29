group = "checkparams"

register_check_parameters(
    subgroup_networking,
    "mh_synciq",
    "Isilon SyncIQ acceptable delay",
    Dictionary(
        elements = [
            ("synciq_delay",
            Integer(
                title = "SyncIQ acceptable delay in minutes",
                default_value = 360,
                elements = [
                    Integer(title = "SyncIQ acceptable delay in minutes: "),
                ],
                help = _("State will be Warn if age of last successful sync is not within schedule plus delay."),
                )),
        ]),
    TextAscii(
        title = _("Isilon SyncIQ"),
    ),
    "dict"
)


register_check_parameters(
    subgroup_networking,
    "mh_isi_quota",
    "Isilon Quota Thresholds",
    Dictionary(
        elements = [
            ("quota_warn",
            Integer(
                title = "Quota Warning Threshold",
                default_value = 97,
                elements = [
                    Integer(title = "Warning Threshold: "),
                ],
                help = _("State will be Warn if used capacity percentage of any quota is equal or greater."),
                )),
            ("quota_crit",
            Integer(
                title = "Quota Critical Threshold",
                default_value = 99,
                elements = [
                    Integer(title = "Critical Threshold: "),
                ],
                help = _("State will be Crit if used capacity percentage of any quota is equal or greater."),
                )),
        ]),
    TextAscii(
        title = _("Isilon Quota"),
    ),
    "dict"
)


register_check_parameters(
    subgroup_networking,
    "mh_isilon_node",
    "Isilon Node Temperatures",
    Dictionary(
        elements = [
            ("psu_temp_warn",
            Integer(
                title = "PSU Warning Temperature (Celsius)",
                default_value = 60,
                elements = [
                    Integer(title = "PSU Warning Temperature"),
                ],
                help = _("State will be Warn if any of the PSU temperatures is above that limit."),
                )),
            ("isi_temp_warn",
            Integer(
                title = "Node Warning Temperature (Celsius)",
                default_value = 40,
                elements = [
                    Integer(title = "Node Warning Temperature"),
                ],
                help = _("State will be Warn if the node temperature is above that limit."),
                )),
        ]),
    TextAscii(
        title = _("Isilon Node"),
    ),
    "dict"
)

