---
title: typeperf
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0c7ca89a-03b3-4626-afcf-ef8565e90043

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# typeperf



The **typeperf** command writes performance data to the command window or to a log file. To stop **typeperf**, press CTRL+C.

For examples of how to use **typeperf**, see [Examples](#BKMK_EXAMPLES).

## Syntax

```
typeperf <counter [counter ...]> [options]
typeperf -cf <filename> [options]
typeperf -q [object] [options]
typeperf -qx [object] [options]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<counter [counter […]]>|Specifies performance counters to monitor.|

> [!NOTE]
> **\<counter>** is the full name of a performance counter in *\\\\Computer\Object(Instance)\Counter* format, such as **\\\\Server1\Processor(0)\% User Time**.

## Options

|                   Option                   |                                                         Description                                                          |
|--------------------------------------------|------------------------------------------------------------------------------------------------------------------------------|
|                     -?                     |                                               Displays context-sensitive help.                                               |
| -f \<CSV&verbar;TSV&verbar;BIN&verbar;SQL> |                                    Specifies the output file format. The default is CSV.                                     |
|              -cf \<filename>               |              Specifies a file containing a list of performance counters to monitor, with one counter per line.               |
|             -si <[[hh:]mm:]ss>             |                                  Specifies the sample interval. The default is one second.                                   |
|               -o \<filename>               |     Specifies the path for the output file, or the SQL database. The default is STDOUT (written to the command window).      |
|                -q [object]                 | Display a list of installed counters (no instances). To list counters for one object, include the object name. \*\*\*EXAMPLE |
|                -qx [object]                |        Display a list of installed counters with instances. To list counters for one object, include the object name.        |
|               -sc \<samples>               |             Specifies the number of samples to collect. The default is to collect data until CTRL+C is pressed.              |
|            -config \<filename>             |                                    Specifies a settings file containing command options.                                     |
|            -s \<computer_name>             |                   Specifies a remote computer to monitor if no computer is specified in the counter path.                    |
|                     -y                     |                                        Answer yes to all questions without prompting.                                        |

## <a name="BKMK_EXAMPLES"></a>Examples

- The following example writes the values for the local computer's performance counter **\\\\Processor(_Total)\% Processor Time** to the command window at a default sample interval of 1 second until CTRL+C is pressed.  
  ```
  typeperf "\Processor(_Total)\% Processor Time"
  ```  
- The following example writes the values for the list of counters in the file **counters.txt** to the tab-delimited file **domain2.tsv** at a sample interval of 5 seconds until 50 samples have been collected.  
  ```
  typeperf -cf counters.txt -si 5 -sc 50 -f TSV -o domain2.tsv
  ```  
- The following example queries installed counters with instances for the counter object **PhysicalDisk** and writes the resulting list to the file **counters.txt**.  
  ```
  typeperf -qx PhysicalDisk -o counters.txt
  ```
