---
title: Relog
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7480f6c0-9953-4d70-9b1c-b27e09d8db13
---
# Relog
Extracts performance counters from performance counter logs into other formats, such as text\-TSV \(for tab\-delimited text\), text\-CSV \(for comma\-delimited text\), binary\-BIN, or SQL. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).

## Syntax

```
relog [<FileName> [<FileName> ...]] [/a] [/c <Path> [<Path> ...]] [/cf <FileName>] [/f  {bin|csv|tsv|SQL}] [/t <Value>] [/o {OutputFile|DSN!CounterLog}] [/b <M/D/YYYY> [[<HH>:] <MM>:] <SS>] [/e <M/D/YYYY> [[<HH>:] <MM>:] <SS>] [/config {<FileName>|i}] [/q]
```

### Parameters
*FileName* \[*FileName ...*\]
Specifies the pathname of an existing performance counter log. You can specify multiple input files.

**\-a**
Appends output file instead of overwriting. This option does not apply to SQL format where the default is always to append.

**\-c** *Path* \[*Path ...*\]
Specifies the performance counter path to log. To specify multiple counter paths, separate them with a space and enclose the counter paths in quotation marks \(for example, **"***CounterPath1* *CounterPath2***"**\).

**\-cf** *FileName*
Specifies the pathname of the text file that lists the performance counters to be included in a relog file. Use this option to list counter paths in an input file, one per line. Default setting is all counters in the original log file are relogged.

**\-f** {**bin**| **csv**| **tsv**| **SQL**}
Specifies the pathname of the output file format. The default format is **bin**. For a SQL database, the output file specifies the *DSN\!CounterLog*. You can specify the database location by using the ODBC manager to configure the DSN \(Database System Name\).

**\-t** *Value*
Specifies sample intervals in "*N*" records. Includes every nth data point in the relog file. Default is every data point.

**\-o** {*OutputFile* | *DSN\!CounterLog*}
Specifies the pathname of the output file or SQL database where the counters will be written.

**\-b** *M***\/***D***\/***YYYY* \[\[ *HH***:**\]*MM***:**\]*SS*
Specifies begin time for copying first record from the input file. Date and time must be in this exact format *M***\/***D***\/***YYYYHH***:***MM***:***SS*.

**\-e** *M***\/***D***\/***YYYY* \[\[ *HH***:**\]*MM***:**\]*SS*
Specifies end time for copying last record from the input file. Date and time must be in this exact format *M***\/***D***\/***YYYYHH***:***MM***:***SS*.

**\-config** {*FileName* | *i*}
Specifies the pathname of the settings file that contains command\-line parameters. Use *\-i* in the configuration file as a placeholder for a list of input files that can be placed on the command line. On the command line, however, you do not need to use *i*. You can also use wildcards such as \*.blg to specify many input file names.

**\-q**
Displays the performance counters and time ranges of log files specified in the input file.

**\-y**
Bypasses prompting by answering "yes" to all questions.

**\/?**
Displays help at the command prompt.

## Remarks
Counter path format:

-   The general format for counter paths is as follows: \[**\\\\**<Computer>\] \\<Object>\[<Parent>**\/**<Instance\#Index>\] **\\**<Counter>\] where the parent, instance, index, and counter components of the format may contain either a valid name or a wildcard character. The computer, parent, instance, and index components are not necessary for all counters.

-   You determine the counter paths to use based on the counter itself. For example, the LogicalDisk object has an instance <Index>, so you must provide the <\#index> or a wildcard. Therefore, you could use the following format: **\\LogicalDisk\(\*\/\*\#\*\)\\\***

-   In comparison, the Process object does not require an instance <Index>. Therefore, you could use the following format: **\\Process\(\*\)\\ID Process**

-   The following is a list of the possible formats:

    -   \\\\<Computer>\\<Object>\(<Parent>\/<Instance\#Index>\)\\<Counter>

    -   \\\\<Computer>\\<Object>\(<Parent>\/<Instance>\)\\<Counter>

    -   \\\\<Computer>\\<Object>\(<Instance\#Index>\)\\<Counter>

    -   \\\\<Computer>\\<Object>\(<Instance>\)\\<Counter>

    -   \\\\<Computer>\\<Object>\\<Counter>

    -   \\<Object>\(<Parent>\/<Instance\#Index>\)\\<Counter>

    -   \\<Object>\(<Parent>\/<Instance>\)<Counter>

    -   \\<Object>\(<Instance\#Index>\)\\<Counter>

    -   \\<Object>\(<Instance>\)\\<Counter>

    -   \\<Object>\\<Counter>

-   If a wildcard character is specified in the parent name, all instances of the specified object that match the specified instance and counter fields will be returned.

-   If a wildcard character is specified in the instance name, all instances of the specified object and parent object will be returned if all instance names corresponding to the specified index match the wildcard character.

-   If a wildcard character is specified in the counter name, all counters of the specified object are returned.

-   Partial counter path string matches \(for example, pro\*\) are not supported.

Counter files:

-   Counter files are text files that list one or more of the performance counters in the existing log. Copy the full counter name from the log or the **\/q** output in \[**\\\\**<Computer>**\\**<Object> \[<Instance>\] **\\**<Counter>\] format. List one counter path on each line.

Copying counters:

-   When executed, **relog** copies specified counters from every record in the input file, converting the format if necessary. Wildcard paths are allowed in the counter file.

Saving input file subsets:

-   Use the **\/t** parameter to specify that input files are inserted into output files at intervals of every <n>th record. By default, data is relogged from every record.

Using **\/b** and **\/e** parameters with log files

-   You can specify that your output logs include records from before begin\-time \(that is, **\/b**\) to provide data for counters that require computation values of the formatted value. The output file will have the last records from input files with timestamps less than the **\/e** \(that is, end time\) parameter.

Using the **\/config** option:

-   The contents of the setting file used with the **\/config** option should have the following format:

    -   \[<CommandOption>\]

    -   *Value*

    -   where <CommandOption> is a command line option and <Value> specifies its value. For example:

    -   \[o\]

    -   output.txt

    -   \[f\]

    -   csv

    -   \[t\]

    -   5

For more information about incorporating **Relog** into your Windows Management Instrumentation \(WMI\) scripts, see "Scripting WMI" at the [Microsoft Windows Resource Kits Web site](http://go.microsoft.com/fwlink/?LinkId=4665).

## <a name="BKMK_Examples"></a>Examples
To resample existing trace logs at fixed intervals of 30, list counter paths, output files and formats:

```
relog c:\perflogs\daily_trace_log.blg /cf counter_file.txt /o c:\perflogs\reduced_log.csv /t 30 /f csv
```

To resample existing trace logs at fixed intervals of 30, list counter paths and output file:

```
Relog c:\perflogs\daily_trace_log.blg /cf counter_file.txt /o c:\perflogs\reduced_log.blg /t 30
```

## Additional references

-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)

-   [Command-Line Reference_1](Command-Line-Reference_1.md)


