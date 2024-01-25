---
title: logman create alert
description: Reference article for the logman create alert command, which creates an alert data collector.
ms.topic: reference
ms.assetid: 93e6fc2b-5bf5-413b-84b4-be8b9dd3a57d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# logman create alert

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creates an alert data collector.

## Syntax

```
logman create alert <[-n] <name>> [options]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| -s `<computer name>` | Perform the command on the specified remote computer. |
| -config `<value>` | Specifies the settings file containing command options. |
| [-n] `<name>` | Name of the target object. |
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
| -[-]cnf `<[[hh:]mm:]ss>` | When time is specified, creates a new file when the specified time has elapsed. When time is not specified, creates a new file when the maximum size is exceeded. |
| -y | Answers yes to all questions without prompting. |
| -cf `<filename>` | Specifies the file listing performance counters to collect. The file should contain one performance counter name per line. |
| -[-]el | Enables or disables Event Log reporting. |
| -th `<threshold [threshold [...]]>` | Specify counters and their threshold values for an alert. |
| -[-]rdcs `<name>` | Specifies the Data Collector Set to start when an alert fires. |
| -[-]tn `<task>` | Specifies the task to run when an alert fires. |
| -[-]targ `<argument>` | Specifies the task arguments to be used with the task specified using -tn. |
| /? | Displays context-sensitive help. |

#### Remarks

- Where [-] is listed, adding an extra hyphen (-) negates the option.

### Examples

To create a new alert called, *new_alert*, which fires when the performance counter % Processor time in the Processor(_Total) counter group exceeds the counter value of 50, type:

```
logman create alert new_alert -th \Processor(_Total)\% Processor time>50
```

> [!NOTE]
> The defined threshold value is based on the value collected by the counter, so in this example, the value of 50 equates to 50% Processor time.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [logman update alert command](logman-update-alert.md)

- [logman command](logman.md)
