---
title: logman create trace
description: Reference article for the logman create trace command, which creates an event trace data collector.
ms.topic: reference
ms.assetid: 1b4dfecd-6f56-4c51-b622-c2054b4aabd7
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# logman create trace

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Create an event trace data collector.

## Syntax

```
logman create trace <[-n] <name>> [options]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| -s `<computer name>` | Performs the command on the specified remote computer. |
| -config `<value>` | Specifies the settings file containing command options. |
| -ets | Sends commands to Event Trace Sessions directly without saving or scheduling. |
| [-n] `<name>` | Name of the target object. |
| -f `<bin|bincirc>` | Specifies the log format for the data collector. |
| -[-]u `<user [password]>` | Specifies the user to Run As. Entering an `*` for the password produces a prompt for the password. The password is not displayed when you type it at the password prompt. |
| -m `<[start] [stop] [[start] [stop] [...]]>` | Changes to manual start or stop instead of a scheduled begin or end time. |
| -rf `<[[hh:]mm:]ss>` | Runs the data collector for the specified period of time. |
| -b `<M/d/yyyy h:mm:ss[AM|PM]>` | Begins collecting data at the specified time. |
| -e `<M/d/yyyy h:mm:ss[AM|PM]>` | Ends data collection at the specified time. |
| -o `<path|dsn!log>` | Specifies the output log file or the DSN and log set name in a SQL database. |
| -[-]r | Repeats the data collector daily at the specified begin and end times. |
| -[-]a | Appends an existing log file. |
| -[-]ow | Overwrites an existing log file. |
| -[-]v `<nnnnnn|mmddhhmm>` | Attaches file versioning information to the end of the log file name. |
| -[-]rc `<task>` | Runs the command specified each time the log is closed. |
| -[-]max `<value>` | Maximum log file size in MB or maximum number of records for SQL logs. |
| -[-]cnf `<[[hh:]mm:]ss>` | When time is specified, creates a new file when the specified time has elapsed. When time is not specified, creates a new file when the maximum size is exceeded. |
| -y | Answers yes to all questions without prompting. |
| -ct `<perf|system|cycle>` | Specifies the Event Trace Session clock type. |
| -ln `<logger_name>` | Specifies the logger name for Event Trace Sessions. |
| -ft `<[[hh:]mm:]ss>` | Specifies the Event Trace Session flush timer. |
| -[-]p `<provider [flags [level]]>` | Specifies a single Event Trace provider to enable. |
| -pf `<filename>` | Specifies a file listing multiple Event Trace providers to enable. The file should be a text file containing one provider per line. |
| -[-]rt | Runs the Event Trace Session in real-time mode. |
| -[-]ul | Runs the Event Trace Session in user. |
| -bs `<value>` | Specifies the Event Trace Session buffer size in kb. |
| -nb `<min max>` | Specifies the number of Event Trace Session buffers. |
| -mode `<globalsequence|localsequence|pagedmemory>` | Specifies the event trace session logger mode, including:<ul><li>**Globalsequence** - Specifies that the event tracer add a sequence number to every event it receives irrespective of which trace session received the event.</li><li>**Localsequence** - Specifies that the event tracer add sequence numbers for events received at a specific trace session. When this option is used, duplicate sequence numbers can exist across all sessions but will be unique within each trace session.</li><li>**Pagedmemory** - Specifies that the event tracer use paged memory rather than the default non-paged memory pool for its internal buffer allocations.</li></ul> |
| /? | Displays context-sensitive help. |

#### Remarks

- Where [-] is listed, adding an extra hyphen (-) negates the option.

### Examples

To create an event trace data collector called *trace_log*, using no fewer than 16 and no more than 256 buffers, with each buffer being 64kb in size, putting the results in c:\logfile, type:

```
logman create trace trace_log -nb 16 256 -bs 64 -o c:\logfile
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [logman update trace command](logman-update-trace.md)

- [logman command](logman.md)
