---
title: logman update api
description: Reference article for the logman update api command, which updates the properties of an existing API tracking data collector.
ms.topic: reference
ms.assetid: 6f322e52-0f9f-42b1-bd64-8b8f8fe086fc
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# logman update api

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Updates the properties of an existing API tracing data collector.

## Syntax

```
logman update api <[-n] <name>> [options]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| -s `<computer name>` | Performs the command on the specified remote computer. |
| -config `<value>` | Specifies the settings file containing command options. |
| [-n] `<name>` | Name of the target object. |
| -f `<bin|bincirc>` | Specifies the log format for the data collector. |
| -[-]u `<user [password]>` | Specifies the user to Run As. Entering a `*` for the password produces a prompt for the password. The password is not displayed when you type it at the password prompt. |
| -m `<[start] [stop] [[start] [stop] [...]]>` | Changed to manual start or stop instead of a scheduled begin or end time. |
| -rf `<[[hh:]mm:]ss>` | Run the data collector for the specified period of time. |
| -b `<M/d/yyyy h:mm:ss[AM|PM]>` | Begin collecting data at the specified time. |
| -e `<M/d/yyyy h:mm:ss[AM|PM]>` | End data collection at the specified time. |
| -si `<[[hh:]mm:]ss>` | Specifies the sample interval for performance counter data collectors. |
| -o `<path|dsn!log>` | Specifies the output log file or the DSN and log set name in a SQL database. |
| -[-]r | Repeat the data collector daily at the specified begin and end times. |
| -[-]a | Append an existing log file. |
| -[-]ow | Overwrite an existing log file. |
| -[-]v `<nnnnnn|mmddhhmm>` | Attaches file versioning information to the end of the log file name. |
| -[-]rc `<task>` | Run the command specified each time the log is closed. |
| -[-]max `<value>` | Maximum log file size in MB or maximum number of records for SQL logs. |
| -[-]cnf `<[[hh:]mm:]ss>` | When time is specified, creates a new file when the specified time has elapsed. When time is not specified, creates a new file when the maximum size is exceeded. |
| -y | Answer yes to all questions without prompting. |
| -mods `<path [path [...]]>` | Specifies the list of modules to log API calls from. |
| -inapis` <module!api [module!api [...]]>` | Specifies the list of API calls to include in logging. |
| -exapis `<module!api [module!api [...]]>` | Specifies the list of API calls to exclude from logging. |
| -[-]ano | Log (-ano) API names only, or do not log only (-ano) API names. |
| -[-]recursive | Log (-recursive) or do not log (-recursive) APIs recursively beyond the first layer. |
| -exe `<value>` | Specifies the full path to an executable for API Tracing. |
| /? | Displays context-sensitive help. |

#### Remarks

- Where [-] is listed, adding an extra hyphen (-) negates the option.

### Examples

To update an existing API trace counter called *trace_notepad*, for the executable file c:\windows\notepad.exe, by excluding the API call TlsGetValue produced by the module kernel32.dll, type:

```
logman update api trace_notepad -exe c:\windows\notepad.exe -exapis kernel32.dll!TlsGetValue
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [logman create api command](logman-create-api.md)

- [logman command](logman.md)
