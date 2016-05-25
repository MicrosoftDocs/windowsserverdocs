---
title: Bootcfg timeout
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: aa858eac-2bb7-4a27-a9bc-3e4a6eb8b2c6
author: jaimeo
---
# Bootcfg timeout
Changes the operating system time\-out value.  
  
For examples of how this command can be used, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
bootcfg /timeout <TimeOutValue> [/s <Computer> [/u <Domain\User>/p <Password>]]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/timeout <TimeOutValue>|Specifies the timeout value in the \[boot loader\] section. The <TimeOutValue> is the number of seconds the user has to select an operating system from the boot loader screen before NTLDR loads the default. Valid range for <TimeOutValue> is 0\-999. If the value is 0, then NTLDR immediately starts the default operating system without displaying the boot loader screen.|  
|\/s <Computer>|Specifies the name or IP address of a remote computer \(do not use backslashes\). The default is the local computer.|  
|\/u <Domain\\User>|Runs the command with the account permissions of the user specified by <User> or <Domain\\User>. The default is the permissions of the current logged on user on the computer issuing the command.|  
|\/p <Password>|Specifies the <Password> of the user account that is specified in the **\/u** parameter.|  
|\/?|Displays help at the command prompt.|  
  
## <a name="BKMK_examples"></a>Examples  
The following examples show how you can use the **bootcfg \/timeout** command:  
  
```  
bootcfg /timeout 30  
bootcfg /s srvmain /u maindom\hiropln /p p@ssW23 /timeout 50  
```  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

