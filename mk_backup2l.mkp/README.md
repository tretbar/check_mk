each backup srclist gets 3 perfdata (slashes in srclist are replaced by "_"):
```
    _<srclist>-files
    _<srclist>-errors
    _<srclist>-size (in Bytes)
```
for nice graphing edit:
```
~/local/share/check_mk/web/plugins/metrics/check_mk.py (CEE only)
````
use "optional_metrics" when different srclists are used.
    
Example for *-files:

```

metric_info["_etc-files"] = {
    "title" : _("/etc"),
    "unit"  : "count",
    "color" : "#CC00FF",
}

metric_info["_var_log-files"] = {
    "title" : _("/var/log"),
    "unit"  : "count",
    "color" : "#FFD600",
}

metric_info["_home-files"] = {
    "title" : _("/home"),
    "unit"  : "count",
    "color" : "#00CF00",
}

metric_info["_var_www-files"] = {
    "title" : _("/var/www"),
    "unit"  : "count",
    "color" : "#2175D9",
}


graph_info.append({
    "title"     : _("backup2l Files"),
    "metrics"   : [ ("_etc-files", "area"),
                    ("_var_log-files", "stack"),
                    ("_home-files", "stack"),
                    ("_var_www-files", "stack"),
                ],
    "optional_metrics" : [ "_var_log-files",
                           "_home-files",
                           "_var_www-files",
                         ]
})
```
  
