---
title: exit
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 23d1044b-f5c1-4180-ae6d-f553b48da4d9
author: jaimeo
---
# exit
exits the cmd.exe program \(the command interpreter\) or the current batch script.  
  
for examples of how to use this command, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
exit [/b] [<exitCode>]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/b|exits the current batch script instead of exiting cmd.exe. if executed from outside a batch script, exits cmd.exe.|  
|<exitCode>|Specifies a numeric number. if **\/b** is specified, the ERRORLEVEL environment variable is set to that number. if you are quitting **cmd.exe**, the process exit code is set to that number.|  
|\/?|Displays help at the command prompt.|  
  
## <a name="BKMK_examples"></a>Examples  
To close the command interpreter, cmd.exe, type:  
  
```  
exit  
```  
  
## additional references  
  
-   [Command-Line Syntax Key](commandline-syntax-key.md)  
  
-   [Command-Line Reference_1](Command-Line-Reference_1.md)  
  

