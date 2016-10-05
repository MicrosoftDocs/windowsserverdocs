---
title: Exit_2
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 23d1044b-f5c1-4180-ae6d-f553b48da4d9

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Exit_2
Exits the Cmd.exe program (the command interpreter) or the current batch script.  
For examples of how to use this command, see [Examples](#BKMK_examples).  
## Syntax  
```  
exit [/b] [<ExitCode>]  
```  
## Parameters  
|Parameter|Description|  
|-------------|---------------|  
|/b|Exits the current batch script instead of exiting Cmd.exe. If executed from outside a batch script, exits Cmd.exe.|  
|<ExitCode>|Specifies a numeric number. If **/b** is specified, the ERRORLEVEL environment variable is set to that number. If you are quitting **Cmd.exe**, the process exit code is set to that number.|  
|/?|Displays help at the command prompt.|  
## <a name="BKMK_examples"></a>Examples  
To close the command interpreter, Cmd.exe, type:  
```  
exit  
```  
## Additional references  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
-   [Command-Line Reference_1](Command-Line-Reference_1.md)  
