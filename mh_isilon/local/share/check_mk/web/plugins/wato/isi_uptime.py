#!/usr/bin/python
# -*- encoding: utf-8; py-indent-offset: 4 -*-
# +------------------------------------------------------------------+
# |             ____ _               _        __  __ _  __           |
# |            / ___| |__   ___  ___| | __   |  \/  | |/ /           |
# |           | |   | '_ \ / _ \/ __| |/ /   | |\/| | ' /            |
# |           | |___| | | |  __/ (__|   <    | |  | | . \            |
# |            \____|_| |_|\___|\___|_|\_\___|_|  |_|_|\_\           |
# |                                                                  |
# | Copyright Mathias Kettner 2014             mk@mathias-kettner.de |
# +------------------------------------------------------------------+
#
# This file is part of Check_MK.
# The official homepage is at http://mathias-kettner.de/check_mk.
#
# check_mk is free software;  you can redistribute it and/or modify it
# under the  terms of the  GNU General Public License  as published by
# the Free Software Foundation in version 2.  check_mk is  distributed
# in the hope that it will be useful, but WITHOUT ANY WARRANTY;  with-
# out even the implied warranty of  MERCHANTABILITY  or  FITNESS FOR A
# PARTICULAR PURPOSE. See the  GNU General Public License for more de-
# tails. You should have  received  a copy of the  GNU  General Public
# License along with GNU Make; see the file  COPYING.  If  not,  write
# to the Free Software Foundation, Inc., 51 Franklin St,  Fifth Floor,
# Boston, MA 02110-1301 USA.

import cmk.defines as defines

# Rules for configuring parameters of checks (services)

register_rulegroup("checkparams", _("Parameters for discovered services"),
    _("Levels and other parameters for checks found by the Check_MK service discovery.\n"
      "Use these rules in order to define parameters like filesystem levels, "
      "levels for CPU load and other things for services that have been found "
      "by the automatic service discovery of Check_MK."))
group = "checkparams"

subgroup_networking =   _("Networking")
subgroup_storage =      _("Storage, Filesystems and Files")
subgroup_os =           _("Operating System Resources")
subgroup_printing =     _("Printers")
subgroup_environment =  _("Temperature, Humidity, Electrical Parameters, etc.")
subgroup_applications = _("Applications, Processes & Services")
subgroup_virt =         _("Virtualization")
subgroup_hardware =     _("Hardware, BIOS")
subgroup_inventory =    _("Discovery - automatic service detection")

register_check_parameters(
    subgroup_os,
    "isi_uptime",
    _("EMC Isilon node uptime since last reboot"),
    Dictionary(
        elements = [
            ( "min",
              Tuple(
                  title = _("Minimum required uptime"),
                  elements = [
                      Age(title = _("Warning if below")),
                      Age(title = _("Critical if below")),
                  ]
            )),
            ( "max",
              Tuple(
                  title = _("Maximum allowed uptime"),
                  elements = [
                      Age(title = _("Warning at")),
                      Age(title = _("Critical at")),
                  ]
            )),
        ]
    ),
    None,
    match_type = "dict",
)

