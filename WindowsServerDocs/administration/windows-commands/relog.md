---
title: relog
description: Reference article for the relog command, which extracts performance counter information from the performance counter log files.
ms.topic: reference
ms.assetid: 7480f6c0-9953-4d70-9b1c-b27e09d8db13
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 07/11/2018
---

# relog

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Extracts performance counters from performance counter logs into other formats, such as text-TSV (for tab-delimited text), text-CSV (for comma-delimited text), binary-BIN, or SQL.

>[!NOTE]
>For more information about incorporating **relog** into your Windows Management Instrumentation (WMI) scripts, see the [Scripting blog](https://devblogs.microsoft.com/scripting/).

## Syntax

```
relog [<filename> [<filename> ...]] [/a] [/c <path> [<path> ...]] [/cf <filename>] [/f  {bin|csv|tsv|SQL}] [/t <value>] [/o {outputfile|DSN!CounterLog}] [/b <M/D/YYYY> [[<HH>:] <MM>:] <SS>] [/e <M/D/YYYY> [[<HH>:] <MM>:] <SS>] [/config {<filename>|i}] [/q]
```

### Parameters

| Parameter | Description |
|--|--|
| `filename [filename ...]` | Specifies the pathname of an existing performance counter log. You can specify multiple input files. |
| -a | Appends output file instead of overwriting. This option does not apply to SQL format where the default is always to append. |
| -c `path [path ...]` | Specifies the performance counter path to log. To specify multiple counter paths, separate them with a space and enclose the counter paths in quotation marks (for example, `"path1 path2"`). |
| -cf filename | Specifies the pathname of the text file that lists the performance counters to be included in a relog file. Use this option to list counter paths in an input file, one per line. Default setting is all counters in the original log file are relogged. |
| -f `{bin | csv | tsv | SQL}` | Specifies the pathname of the output file format. The default format is **bin**. For a SQL database, the output file specifies the `DSN!CounterLog`. You can specify the database location by using the ODBC manager to configure the DSN (Database System Name). |
| -t value | Specifies sample intervals in *n* records. Includes every nth data point in the relog file. Default is every data point. |
| -o `{Outputfile | SQL:DSN!Counter_Log}` | Specifies the pathname of the output file or SQL database where the counters will be written. <P>**Note:** For the 64-bit and 32-bit versions of relog.exe, you must define a DSN in the ODBC Data Source (64-bit and 32-bit respectively) on the system. Use the "SQL Server" ODBC driver to define a DSN. |
| -b `<M/D/YYYY> [[<HH>:]<MM>:]<SS>]` | Specifies the beginning time to copy the first record from the input file. Date and time must be in this exact format M/D/YYYYHH:MM:SS. |
| -e `<M/D/YYYY> [[<HH>:]<MM>:]<SS>]` | Specifies the end time to copy the last record from the input file. Date and time must be in this exact format M/D/YYYYHH:MM:SS. |
| -config `{filename | i}` | Specifies the pathname of the settings file that contains command-line parameters. If you're using a configuration file, you can use **-i** as a placeholder for a list of input files that can be placed on the command line. If you're using the command line, don't use **-i**. You can also use wildcards, such as `*.blg` to specify several input file names at once. |
| -q | Displays the performance counters and time ranges of log files specified in the input file. |
| -y | Bypasses prompting by answering "yes" to all questions. |
| /? | Displays help at the command prompt. |

#### Remarks

- The general format for counter paths is as follows: `[\<computer>] \<object>[<parent>\<instance#index>] \<counter>]` where the parent, instance, index, and counter components of the format may contain either a valid name or a wildcard character. The computer, parent, instance, and index components aren't necessary for all counters.

- You determine the counter paths to use based on the counter itself. For example, the **LogicalDisk** object has an instance `<index>`, so you must provide the `<#index>` or a wildcard. Therefore, you could use the following format: `\LogicalDisk(*/*#*)\\*`.

- In comparison, the **Process** object doesn't require an instance `<index>`. Therefore, you can use the following format: `\Process(*)\ID Process`.

- If a wildcard character is specified in the **Parent** name, all instances of the specified object that match the specified instance and counter fields will be returned.

- If a wildcard character is specified in the **Instance** name, all instances of the specified object and parent object will be returned if all instance names corresponding to the specified index match the wildcard character.

- If a wildcard character is specified in the **Counter** name, all counters of the specified object are returned.

- Partial counter path string matches (for example, pro*) aren't supported.

- Counter files are text files that list one or more of the performance counters in the existing log. Copy the full counter name from the log or the **/q** output in `<computer>\<object>\<instance>\<counter>` format. List one counter path on each line.

- When run, the **relog** command copies specified counters from every record in the input file, converting the format if necessary. Wildcard paths are allowed in the counter file.

- Use the **/t** parameter to specify that input files are inserted into output files at intervals of every `nth` record. By default, data is relogged from every record.

- You can specify that your output logs include records from before the beginning time (that is, **/b**) to provide data for counters that require computation values of the formatted value. The output file will have the last records from input files with timestamps less than the **/e** (that is, end time) parameter.

- The contents of the setting file used with the **/config** option should have the following format: `<commandoption>\<value>`, where `<commandoption>` is a command line option and `<value>` specifies its value.

##Q# Examples

To resample existing trace logs at fixed intervals of 30, list counter paths, output files, and formats, type:

```
relog c:\perflogs\daily_trace_log.blg /cf counter_file.txt /o c:\perflogs\reduced_log.csv /t 30 /f csv
```

To resample existing trace logs at fixed intervals of 30, list counter paths, and output file, type:

```
relog c:\perflogs\daily_trace_log.blg /cf counter_file.txt /o c:\perflogs\reduced_log.blg /t 30
```

To resample existing trace logs into a database, type:

```
relog "c:\perflogs\daily_trace_log.blg" -f sql -o "SQL:sql2016x64odbc!counter_log"
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
