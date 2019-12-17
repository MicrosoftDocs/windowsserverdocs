---
title: logman update cfg
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9da4e8b4-3be5-42d3-b0b4-c429630c35c4 britw
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# logman update cfg

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Update the properties of an existing configuration data collector.  

## Syntax  
```  
logman update cfg <[-n] <name>> [options]  
```  
## Parameters  

|                    Parameter                     |                                                                               Description                                                                               |
|--------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|                        /?                        |                                                                    Displays context-sensitive help.                                                                     |
|                -s <computer name>                |                                                          Perform the command on the specified remote computer.                                                          |
|                 -config <value>                  |                                                         Specifies the settings file containing command options.                                                         |
|                   [-n] <name>                    |                                                                       Name of the target object.                                                                        |
| -f <bin&#124;bincirc&#124;csv&#124;tsv&#124;sql> |                                                            Specifies the log format for the data collector.                                                             |
|             -[-]u <user [password]>              | Specifies the user to Run As. Entering a \* for the password produces a prompt for the password. The password is not displayed when you type it at the password prompt. |
|    -m <[start] [stop] [[start] [stop] [...]]>    |                                                change to manual start or stop instead of a scheduled begin or end time.                                                 |
|                -rf <[[hh:]mm:]ss>                |                                                        Run the data collector for the specified period of time.                                                         |
|        -b <M/d/yyyy h:mm:ss[AM&#124;PM]>         |                                                              Begin collecting data at the specified time.                                                               |
|        -e <M/d/yyyy h:mm:ss[AM&#124;PM]>         |                                                               End data collection at the specified time.                                                                |
|                -si <[[hh:]mm:]ss>                |                                                 Specifies the sample interval for performance counter data collectors.                                                  |
|              -o <path&#124;dsn!log>              |                                              Specifies the output log file or the DSN and log set name in a SQL database.                                               |
|                      -[-]r                       |                                                  Repeat the data collector daily at the specified begin and end times.                                                  |
|                      -[-]a                       |                                                                     append to an existing log file.                                                                     |
|                      -[-]ow                      |                                                                     Overwrite an existing log file.                                                                     |
|           -[-]v <nnnnnn&#124;mmddhhmm>           |                                                   attach file versioning information to the end of the log file name.                                                   |
|                  -[-]rc <task>                   |                                                         Run the command specified each time the log is closed.                                                          |
|                 -[-]max <value>                  |                                                 Maximum log file size in MB or maximum number of records for SQL logs.                                                  |
|              -[-]cnf <[[hh:]mm:]ss>              |     When time is specified, create a new file when the specified time has elapsed. When time is not specified, create a new file when the maximum size is exceeded.     |
|                        -y                        |                                                             Answer yes to all questions without prompting.                                                              |
|                      -[-]ni                      |                                                         Enable (-ni) or disable (-ni) network interface query.                                                          |
|             -reg <path [path [...]]>             |                                                                 Specifies registry value(s) to collect.                                                                 |
|            -mgt <query [query [...]]>            |                                                      Specifies WMI object(s) to collect using SQL query language.                                                       |
|             -ftc <path [path [...]]>             |                                                           Specifies the full path to the file(s) to collect.                                                            |

## Remarks  
Where [-] is listed, an extra - negates the option.  
## <a name="BKMK_examples"></a>Examples  
The following command updates the existing configuration data collector cfg_log to collect the registry key HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\Currentverion\\.  
```  
logman update cfg cfg_log -reg "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\Currentverion\"  
```  
#### additional references  
[logman](logman.md)  
[logman create cfg](logman-create-cfg.md)  
