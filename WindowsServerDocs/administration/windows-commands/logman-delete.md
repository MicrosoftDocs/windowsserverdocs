---
title: logman delete
description: Reference topic for **** - 

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: 8f3b2422-3dce-4fb4-adbb-8536b1d7da2b

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# logman delete

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

delete an existing data collector.  

## Syntax  
```  
logman delete <[-n] <name>> [options]  
```  
### Parameters  

|        Parameter        |                                                                               Description                                                                               |
|-------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|           /?            |                                                                    Displays context-sensitive help.                                                                     |
|   -s <computer name>    |                                                          Perform the command on the specified remote computer.                                                          |
|     -config <value>     |                                                         Specifies the settings file containing command options.                                                         |
|       [-n] <name>       |                                                                   Name of the target data collector.                                                                    |
|          -ets           |                                              Send commands to Event Trace Sessions directly without saving or scheduling.                                               |
| -[-]u <user [password]> | Specifies the user to Run As. Entering a \* for the password produces a prompt for the password. The password is not displayed when you type it at the password prompt. |

## Examples  
The following command deletes the data collector perf_log.  
```  
logman delete perf_log  
```  
## Additional References  
[logman](logman.md)  
