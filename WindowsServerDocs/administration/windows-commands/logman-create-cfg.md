---
title: logman create cfg
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bfc87093-3ff5-4e19-aa93-d185fb8e2239

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# logman create cfg

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

create a configuration data collector.  

## Syntax  
```  
logman create cfg <[-n] <name>> [options]  
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
The following command creates a configuration data collector called cfg_log using the registry key HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\Currentverion\\.  
```  
logman create cfg cfg_log -reg "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\Currentverion\\"  
```  
The following command creates a configuration data collector called cfg_log that records all WMI objects from root\wmi in the database column MSNdis_Vendordriverversion.  
```  
logman create cfg cfg_log -mgt "root\wmi:select * FROM MSNdis_Vendordriverversion"  
```  
#### additional references  
[logman](logman.md)  
