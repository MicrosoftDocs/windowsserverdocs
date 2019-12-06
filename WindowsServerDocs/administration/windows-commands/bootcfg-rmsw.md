---
title: bootcfg rmsw
description: "Windows Commands topic for **bootcfg rmsw** - removes operating system load options for a specified operating system entry."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fd7e4248-880e-4e2b-929e-87f8d44b9a63
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# bootcfg rmsw

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

removes operating system load options for a specified operating system entry.

## Syntax
```
bootcfg /rmsw [/s <computer> [/u <Domain>\<User> [/p <Password>]]] [/mm] [/bv] [/so] [/ng] /id <OSEntryLineNum>
```
## Parameters

|      Parameter       |                                                                                                      Description                                                                                                       |
|----------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    /s <computer>     |                                                   Specifies the name or IP address of a remote computer (do not use backslashes). The default is the local computer.                                                   |
| /u <Domain>\\<User>  |          Runs the command with the account permissions of the user specified by <User> or <Domain>\\<User>. The default is the permissions of the current logged on user on the computer issuing the command.          |
|    /p <Password>     |                                                                 Specifies the password of the user account that is specified in the **/u** parameter.                                                                  |
|         /mm          |           removes the /maxmem option and its associated maximum memory value from the specified <OSEntryLineNum>. The /maxmem option specifies the maximum amount of RAM that the operating system can use.            |
|         /bv          |                     removes the /basevideo option from the specified <OSEntryLineNum>. The /basevideo option directs the operating system to use standard VGA mode for the installed video driver.                     |
|         /so          |                         removes the /sos option from the specified <OSEntryLineNum>. The /sos option directs the operating system to display device driver names while they are being loaded.                          |
|         /ng          |                         removes the /noguiboot option from the specified <OSEntryLineNum>. The /noguiboot option disables the progress bar that appears before the CTRL+ALT+del logon prompt.                          |
| /id <OSEntryLineNum> | Specifies the operating system entry line number in the [operating systems] section of the Boot.ini file from which the OS Load Options are removed. The first line after the [operating systems] section header is 1. |
|          /?          |                                                                                          Displays help at the command prompt.                                                                                          |

## <a name="BKMK_examples"></a>Examples
The following examples show how you can use the **bootcfg /rmsw**command:
```
bootcfg /rmsw /mm 64 /id 2 
bootcfg /rmsw /so /id 3 
bootcfg /rmsw /so /ng /s srvmain /u hiropln /id 2 
bootcfg /rmsw /ng /id 2 
bootcfg /rmsw /mm 96 /ng /s srvmain /u maindom\hiropln /p p@ssW23 /id 2       
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
