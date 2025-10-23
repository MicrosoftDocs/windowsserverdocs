---
title: netsh trace
description: The netsh trace command captures network traffic and trace events for network diagnostics and troubleshooting in Windows.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/06/2025
---

# netsh trace

The `netsh trace` command allows you to capture detailed network traffic and trace events, providing valuable data for diagnosing and troubleshooting network problems on Windows systems. It supports a range of options for filtering, exporting, and analyzing trace data.

## Syntax

```
netsh trace [convert | correlate | diagnose | dump | export | help | merge | postreset | show | start | ?]
```

```
netsh trace convert [input=]tracefilename.etl [output=]filename [dump=]CSV|XML|EVTX|TXT|No [report=]yes|no
                    [overwrite=]yes|no [metadata=]yes|no [tmfpath=]pathname [manpath=]pathname
```

```
netsh trace correlate [input=]tracefilename.etl [output=]newtracefilename.etl [filter=]Activity_ID
                      [overwrite=]yes|no [retaincorrelationevents=]yes|no [retainpii=]yes|no
                      [retainglobalevents=]yes|no
```

```
netsh trace diagnose [scenario=]<scenarioname> [namedAttribute=]<attributeValue>
                     [saveSessionTrace=]<yes|no> [report=]<yes|no> [capture=]<yes|no>
```

```
netsh trace dump
```

```
netsh trace export [scenario=]<scenarioname> [file=]<filename>
```

```
netsh trace merge
```

```
netsh trace postreset
```

```
netsh trace show <capturefilterhelp>
                 <globalkeywordsandlevels>
                 <helperclass> [name=]<helperclassname>
                 <interfaces>
                 <provider> [name=]<providerIdOrName>
                 <providerfilerhelp>
                 <providers>
                 <scenario> [name=]<scenarioname>
                 <scenarios>
                 <status>
```

```
netsh trace start [sessionname]=<sessionname> [scenario=]<scenario1,scenario2> [globalKeywords=]keywords
                  [globalLevel=]level [[capture=]yes|no] [capturetype=]physical|vmswitch|both
                  [report=]yes|no|disabled [persistent=]yes|no [traceFile=]path\filename
                  [maxSize=]filemaxsize [fileMode=]single|circular|append [overwrite=]yes|no
                  [correlation=]yes|no|disabled [capturefilters] [provider=]providerIdOrName
                  [keywords=]keywordMaskOrSet [level=]level [bufferSize=]<bufferSize>
                  [provider=]provider2IdOrName [providerFilter=]yes|no [keywords=]keyword2MaskOrSet
                  [perfMerge=]yes|no [level=]level2 ...
```

## Parameters

> [!NOTE]
> Certain commands and parameters might only function fully in previous versions of Windows and Windows Server, which are no longer in support.

| Command | Description |
|--|--|
| trace `convert` | Converts a trace file to an HTML report. <br><br> `input`: Specifies the input Event Trace Log (ETL) file. <br> `output`: Sets the output file name. If not specified, defaults to the input file name. <br> `dump`: Chooses the output format: `TXT` (default), `CSV`, `XML`, `EVTX`, or `No` (no dump). <br> `report`: Generates an HTML report if set to `yes`. Default is `no`. <br> `overwrite`: Overwrites existing files if set to `yes`. Default is `no`. <br> `metadata`: Includes metadata traces in the output if set to `yes`. Default is `no`. <br> `tmfpath`: Provides the path to the Trace Message Format (TMF) files for decoding the Windows Software Trace Preprocessor (WPP) traces. <br> `manpath`: Provides the path to manifest files for decoding Event Traces for Windows (ETW) traces. |
| trace `correlate` | Normalizes or filters a trace file, producing a new output file. You can filter by Activity ID (a GUID in the format `{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}`) to include only related events. The command can also retain correlation events, personal data (such as packet capture events), and global events. <br><br> `input`: Specifies the input ETL trace file. <br> `output`: Sets the output file name and path. <br> `filter`: Outputs only events related to the specified Activity GUID. Default is none. <br> `overwrite`: Overwrites existing files if set to `yes`. Default is `no`. <br> `retaincorrelationevents`: Retains correlation events if set to `yes`. Default is `no`. <br> `retainpii`: Retains events containing personal data if set to `yes` (default). <br> `retainglobalevents`: Retains global events if set to `yes` (default). |
| trace `diagnose` | Starts a diagnostic session. <br><br> `scenario`: Specifies a diagnostic scenario name (example, `InternetClient`). <br> `namedAttribute`: Supply the additional details or options for the scenario, which is dependent on the scenario chosen. <br> `saveSessionTrace`: If set to `yes`, saves the trace data from the session for later analysis. If `no`, the trace isn't saved. This option defaults to `yes` if `report=yes`. <br> `report`: If set to `yes`, generates a diagnostic report after running the scenario. If `no` (default), no report is created. <br> `capture`: If set to `yes`, captures network traffic during the diagnosis. If `no` (default), traffic isn't captured. |
| trace `dump` | Creates a script containing the current context configuration. The script can be saved to a file and used to restore settings if they're altered or need to be replicated on another system. |
| trace `export` | Exports a scenario to a Windows Performance Recorder (WPR) profile. <br><br> `scenario`: Specifies the name of the tracing scenario to export. <br> `file`: Sets the output file name and path for the exported WPR profile. |
| trace `merge` | Merges multiple trace files into one and enriches the output with symbol and PerfTrack metadata for improved analysis. |
| trace `postreset` | Restores the global tracing settings to default after a network stack reset. |
| trace `show` | Displays information for the following parameters: <br><br> `capturefilterhelp`: Lists all supported capture filters and provides usage examples. <br> `globalkeywordsandlevels`: Displays available global keywords and tracing levels for configuration. <br> `helperclass`: Provides information about helper classes used in tracing. <br> `interfaces`: Lists all network interfaces available for tracing. <br> `provider`: Displays detailed information about a specific trace provider. <br> `providerfilterhelp`: Lists supported provider filters and explains their usage. <br> `providers`: Shows all trace providers available on the system. <br> `scenario`: Displays details about a specific tracing scenario. <br> `scenarios`: Lists all available tracing scenarios. <br> `status`: Shows the current tracing configuration and session status. |
| trace `start` | Starts a trace session. <br><br> `sessionname`: Specifies the name of the trace session. <br> `scenario`: Specifies a predefined scenario (`LAN`, `InternetClient`, etc.) <br> `globalKeywords`: Filters events for all providers using ETW keywords. <br> `globalLevel`: Sets the verbosity for global events: <br> - `1` (Critical): Only critical events. <br> - `2` (Error): Critical and error events. <br> - `3` (Warning): Critical, error, and warning events. <br> - `4` (Informational): Adds informational events. <br> - `5` (Verbose): Captures all events, including detailed debug info. <br> `capture`: Whether to capture network packets (`yes` or `no`). <br> `capturetype`: Specifies the packet capture type (`physical`, `vmswitch`, or `both`). <br> `report`: Generate an HTML report after tracing (`yes`, `no`, or `disabled`). <br> `persistent`: Keeps the session running after a system reboot (`yes` or `no`). <br> `traceFile`: Full path and filename for the trace output. <br> `maxSize`: Maximum size of the trace file in megabytes. <br> `fileMode`: Specifies the method of file writing mode: <br> - `single`: All data is written to one file up to the specified file size in megabytes. <br> - `circular`: Overwrites oldest data when file reaches max size (acts as a ring buffer). <br> - `append`: Adds new trace data to the end of an existing file. <br> `overwrite`: Overwrites existing trace file (`yes` or `no`). <br> `correlation`: Enables correlation for events (`yes`, `no`, or `disabled`). <br> `capturefilters`: Filters for captured packets (IP, TCP port, etc.). <br> `provider`: Specifies the ETW provider by GUID or name. <br> `keywords`: *Provider*-specific keyword filtering. <br> `level`: *Provider*-specific verbosity. <br> `bufferSize`: Size of the trace buffer in megabytes. <br> `providerFilter`: Enables *provider*-specific filtering (`yes` or `no`). <br> `perfMerge`: Merges performance data (`yes` or `no`). <br><br> Some parameters are scenario-specific and might be ignored if not relevant. Defaults are used if omitted. Using `capture=yes` can generate large files quickly. `fileMode=circular` overwrites old data when max size is reached. |
| `help` *or* `?` | Displays a list of commands and their descriptions in the current context. |

## Examples

To convert an ETL log file to XML, run the following command:

```cmd
netsh trace convert input="C:\Logs\mytrace.etl" output="C:\Logs\mytrace.xml"
```

To analyze and correlate the data between multiple ETL files into a single correlated file, run the following command:

```cmd
netsh trace correlate input="C:\Logs\trace1.etl,C:\Logs\trace2.etl" output="C:\Logs\correlated_trace.etl"
```

To export an ETL to a text file (`.txt`), run the following command:

```cmd
netsh trace export input="C:\Logs\mytrace.etl" output="C:\Logs\mytrace.txt"
```

To merge multiple ETL files into a single trace file, run the following command:

```cmd
netsh trace merge input="C:\Logs\trace1.etl,C:\Logs\trace2.etl" output="C:\Logs\merged_trace.etl"
```

To list all network interfaces available for tracing, run the following command:

```cmd
netsh trace show interfaces
```

To start a new trace session and save the log to a specific file path, run the following command:**

```cmd
netsh trace start capture=yes tracefile="C:\Logs\networktrace.etl"
```

## See also

- [Command-Line Syntax Key](command-line-syntax-key.md)
