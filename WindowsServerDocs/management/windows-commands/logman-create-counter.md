---
title: logman create counter
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1e214c32-b704-43c1-b548-e1cf43b583c3
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# logman create counter
Create a counter data collector.  
For examples of how this command can be used, see [Examples](#BKMK_examples).  
## Syntax  
```  
logman create counter <[-n] <name>> [options]  
```  
## Parameters  
|Parameter|Description|  
|-------------|---------------|  
|/?|Displays context-sensitive help.|  
|-s <computer name>|Perform the command on the specified remote computer.|  
|-config <value>|Specifies the settings file containing command options.|  
|[-n] <name>|Name of the target object.|  
|-f <bin&#124;bincirc&#124;csv&#124;tsv&#124;sql>|Specifies the log format for the data collector.|  
|-[-]u <user [password]>|Specifies the user to Run As. Entering a * for the password produces a prompt for the password. The password is not displayed when you type it at the password prompt.|  
|-m <[start] [stop] [[start] [stop] [...]]>|Change to manual start or stop instead of a scheduled begin or end time.|  
|-rf <[[hh:]mm:]ss>|Run the data collector for the specified period of time.|  
|-b <M/d/yyyy h:mm:ss[AM&#124;PM]>|Begin collecting data at the specified time.|  
|-e <M/d/yyyy h:mm:ss[AM&#124;PM]>|End data collection at the specified time.|  
|-si <[[hh:]mm:]ss>|Specifies the sample interval for performance counter data collectors.|  
|-o <path&#124;dsn!log>|Specifies the output log file or the DSN and log set name in a SQL database.|  
|-[-]r|Repeat the data collector daily at the specified begin and end times.|  
|-[-]a|Append to an existing log file.|  
|-[-]ow|Overwrite an existing log file.|  
|-[-]v <nnnnnn&#124;mmddhhmm>|Attach file versioning information to the end of the log file name.|  
|-[-]rc <task>|Run the command specified each time the log is closed.|  
|-[-]max <value>|Maximum log file size in MB or maximum number of records for SQL logs.|  
|-[-]cnf <[[hh:]mm:]ss>|When time is specified, create a new file when the specified time has elapsed. When time is not specified, create a new file when the maximum size is exceeded.|  
|-y|Answer yes to all questions without prompting.|  
|-cf <filename>|Specifies the file listing performance counters to collect. The file should contain one performance counter name per line.|  
|-c <path [path […]]>|Specifies performance counter(s) to collect.|  
|-sc <value>|Specifies the maximum number of samples to collect with a performance counter data collector.|  
## Remarks  
Where [-] is listed, an extra - negates the option.  
## <a name="BKMK_examples"></a>Examples  
The following command creates a counter called perf_log using the % Processor Time counter from the Processor(_Total) counter category.  
```  
logman create counter perf_log -c "\Processor(_Total)\% Processor Time"  
```  
The following command creates a counter called perf_log using the % Processor Time counter from the Processor(_Total) counter category, creating a log file with a maximum size of 10 MB and collecting data for 1 minute and 0 seconds.  
```  
logman create counter perf_log -c "\Processor(_Total)\% Processor Time" -max 10 -rf 01:00  
```  
#### Additional references  
[Logman](Logman.md)  
