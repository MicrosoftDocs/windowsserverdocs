---
title: bootcfg addsw
description: "Windows Commands topic for **bootcfg addsw** - adds operating system load options for a specified operating system entry."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d8389293-ecd9-42f0-b84b-b9ead4cf52e6
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# bootcfg addsw

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

adds operating system load options for a specified operating system entry.

## Syntax
```
bootcfg /addsw [/s <computer> [/u <Domain>\<User> /p <Password>]] [/mm <MaximumRAM>] [/bv] [/so] [/ng] /id <OSEntryLineNum>
```
## Parameters

|         Term         |                                                                                                            Definition                                                                                                            |
|----------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    /s <computer>     |                                                        Specifies the name or IP address of a remote computer (do not use backslashes). The default is the local computer.                                                        |
| /u <Domain>\\<User>  |               Runs the command with the account permissions of the user specified by <User> or <Domain>\\<User>. The default is the permissions of the current logged on user on the computer issuing the command.               |
|    /p <Password>     |                                                                      Specifies the password of the user account that is specified in the **/u** parameter.                                                                       |
|   /mm <MaximumRAM>   |                                          Specifies the maximum amount of RAM, in megabytes, that the operating system can use. The value must be equal to or greater than 32 Megabytes.                                          |
|         /bv          |                                    adds the **/basevideo** option to the specified <OSEntryLineNum>, directing the operating system to use standard VGA mode for the installed video driver.                                     |
|         /so          |                                      adds the **/sos** option to the specified *OSEntryLineNum*, directing the operating system to display device driver names while they are being loaded.                                      |
|         /ng          |                                         adds the **/noguiboot** option to the specified <OSEntryLineNum>, disabling the progress bar that appears before the CTRL+ALT+del logon prompt.                                          |
| /id <OSEntryLineNum> | Specifies the operating system entry line number in the [operating systems] section of the Boot.ini file to which the operating system load options are added. The first line after the [operating systems] section header is 1. |
|          /?          |                                                                                               Displays help at the command prompt.                                                                                               |

## <a name="BKMK_examples"></a>Examples
The following examples show how you can use the **bootcfg /addsw** command:
```
bootcfg /addsw /mm 64 /id 2 
bootcfg /addsw /so /id 3 
bootcfg /addsw /so /ng /s srvmain /u hiropln /id 2 
bootcfg /addsw /ng /id 2 
bootcfg /addsw /mm 96 /ng /s srvmain /u maindom\hiropln /p p@ssW23 /id 2
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
