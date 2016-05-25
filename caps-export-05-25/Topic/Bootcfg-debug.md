---
title: Bootcfg debug
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 28afa5fb-a236-46e2-b1a4-a3c43a49c437
author: jaimeo
---
# Bootcfg debug
Adds or changes the debug settings for a specified operating system entry.  
  
For examples of how this command can be used, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
bootcfg /debug {ON | OFF | EDIT}[/s <Computer> [/u <Domain>\<User> /p <Password>]] [/port {COM1 | COM2 | COM3 | COM4}] [/baud {9600 | 19200 | 38400 | 57600 | 115200}] [/id <OSEntryLineNum>]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|{ON &#124; OFF&#124; EDIT}|Specifies the value for debugging.<br /><br />**ON** \- Enables remote debugging support by adding the \/debug option to the specified <OSEntryLineNum>.<br /><br />**OFF** \- Disables remote debugging support by removing the \/debug option from the specified <OSEntryLineNum>.<br /><br />**EDIT** \- Allows changes to port and baud rate settings by changing the values associated with the \/debug option for the specified <OSEntryLineNum>.|  
|\/s <Computer>|Specifies the name or IP address of a remote computer \(do not use backslashes\). The default is the local computer.|  
|\/u <Domain>\\<User>|Runs the command with the account permissions of the user specified by <User> or <Domain>\\<User>. The default is the permissions of the current logged on user on the computer issuing the command.|  
|\/p <Password>|Specifies the password of the user account that is specified in the **\/u** parameter.|  
|\/port {COM1 &#124; COM2 &#124; COM3 &#124; COM4}|Specifies the COM port to be used for debugging. Do not use the **\/port** parameter if debugging is being disabled.|  
|\/baud {9600&#124; 19200&#124; 38400&#124; 57600&#124; 115200}|Specifies the baud rate to be used for debugging. Do not use the **\/baud** parameter if debugging is being disabled.|  
|\/id <OSEntryLineNum>|Specifies the operating system entry line number in the \[operating systems\] section of the Boot.ini file to which the debugging options are added. The first line after the \[operating systems\] section header is 1.|  
|\/?|Displays help at the command prompt.|  
  
##### Remarks  
  
-   If 1394 port debugging is required, use [Bootcfg dbg1394](../Topic/Bootcfg-dbg1394.md).  
  
## <a name="BKMK_examples"></a>Examples  
The following examples show how you can use the **bootcfg \/debug**command:  
  
```  
bootcfg /debug on /port com1 /id 2   
bootcfg /debug edit /port com2 /baud 19200 /id 2   
bootcfg /s srvmain /u maindom\hiropln /p p@ssW23 /debug off /id 2  
```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
