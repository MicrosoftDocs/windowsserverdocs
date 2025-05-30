---
title: logman create counter
description: Reference article for the logman create counter command, which creates a counter data collector.
ms.topic: reference
ms.assetid: 1e214c32-b704-43c1-b548-e1cf43b583c3
ms.author: alalve
author: xelu86
manager: mtillman
ms.date: 10/16/2017
---

# logman create counter



Creates a counter data collector.

## Syntax

```
logman create counter <[-n] <name>> [options]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| -s `<computer name>` | Perform the command on the specified remote computer. |
| -config `<value>` | Specifies the settings file containing command options. |
| [-n] `<name>` | Name of the target object. |
| -f `<bin|bincirc|csv|tsv|sql>` | Specifies the log format for the data collector. The maximum log file size will be limited to 2 GB if `csv` is specified |
| -[-]u `<user [password]>` | Specifies the user to Run As. Entering an `*` for the password produces a prompt for the password. The password is not displayed when you type it at the password prompt. |
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
| -[-]cnf `<[[hh:]mm:]ss>` | When time is specified, create a new file when the specified time has elapsed. When time is not specified, create a new file when the maximum size is exceeded. |
| -y | Answers yes to all questions without prompting. |
| -cf `<filename>` | Specifies the file listing performance counters to collect. The file should contain one performance counter name per line. |
| -c `<path [path [ ]]>` | Specifies performance counter(s) to collect. |
| -sc `<value>` | Specifies the maximum number of samples to collect with a performance counter data collector. |
| /? | Displays context-sensitive help. |

#### Remarks

- Where [-] is listed, adding an extra hyphen (-) negates the option.

### Examples

To create a counter called *perf_log* using the % Processor time counter from the Processor(_Total) counter category, type:

```
logman create counter perf_log -c \Processor(_Total)\% Processor time
```

To create a counter called *perf_log* using the % Processor time counter from the Processor(_Total) counter category, creating a log file with a maximum size of 10 MB, and collecting data for 1 minute and 0 seconds, type:

```
logman create counter perf_log -c \Processor(_Total)\% Processor time -max 10 -rf 01:00
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [logman update counter command](logman-update-counter.md)

- [logman command](logman.md)
