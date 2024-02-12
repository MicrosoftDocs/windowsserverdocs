---
title: logman create cfg
description: Reference article for the logman create cfg command, which creates a configuration data collector.
ms.topic: reference
ms.assetid: bfc87093-3ff5-4e19-aa93-d185fb8e2239
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# logman create cfg

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creates a configuration data collector.

## Syntax

```
logman create cfg <[-n] <name>> [options]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| -s `<computer name>` | Performs the command on the specified remote computer. |
| -config `<value>` | Specifies the settings file containing command options. |
| [-n] `<name>` | Name of the target object. |
| -[-]u `<user [password]>` | Specifies the user to Run As. Entering a \* for the password produces a prompt for the password. The password is not displayed when you type it at the password prompt. |
| -m `<[start] [stop] [[start] [stop] [...]]>` | Changes to manual start or stop instead of a scheduled begin or end time. |
| -rf `<[[hh:]mm:]ss>` | Runs the data collector for the specified period of time. |
| -b `<M/d/yyyy h:mm:ss[AM|PM]>` | Begins collecting data at the specified time. |
| -e `<M/d/yyyy h:mm:ss[AM|PM]>` | Ends data collection at the specified time. |
| -si `<[[hh:]mm:]ss>` | Specifies the sample interval for performance counter data collectors. |
| -o `<path|dsn!log>` | Specifies the output log file or the DSN and log set name in a SQL database. |
| -[-]r | Repeats the data collector daily at the specified begin and end times. |
| -[-]a | Appends an existing log file. |
| -[-]ow | Overwrites an existing log file. |
| -[-]v `<nnnnnn|mmddhhmm>` | Attaches file versioning information to the end of the log file name. |
| -[-]rc `<task>` | Runs the command specified each time the log is closed. |
| -[-]max `<value>` | Maximum log file size in MB or maximum number of records for SQL logs. |
| -[-]cnf `<[[hh:]mm:]ss>` | When time is specified, creates a new file when the specified time has elapsed. When time is not specified, creates a new file when the maximum size is exceeded. |
| -y | Answers yes to all questions without prompting. |
| -[-]ni | Enables (-ni) or disable (-ni) network interface query. |
| -reg `<path [path [...]]>` | Specifies registry value(s) to collect. |
| -mgt `<query [query [...]]>` | Specifies WMI object(s) to collect using SQL query language. |
| -ftc `<path [path [...]]>` | Specifies the full path to the file(s) to collect. |
| /? | Displays context-sensitive help. |

#### Remarks

- Where [-] is listed, adding an extra hyphen (-) negates the option.

### Examples

To create a configuration data collector called cfg_log, using the registry key `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\Currentverion\`, type:

```
logman create cfg cfg_log -reg HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\Currentverion\\
```

To create a configuration data collector called cfg_log, which records all WMI objects from `root\wmi` in the database column `MSNdis_Vendordriverversion`, type:

```
logman create cfg cfg_log -mgt root\wmi:select * FROM MSNdis_Vendordriverversion
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [logman update cfg command](logman-update-cfg.md)

- [logman command](logman.md)
