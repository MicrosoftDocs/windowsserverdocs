---
title: bootcfg dbg1394
description: "Windows Commands topic for **bootcfg dbg1394** - Configures 1394 port debugging for a specified operating system entry"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 35724697-90dd-4dbe-85b0-337fbd369dcc
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# bootcfg dbg1394

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Configures 1394 port debugging for a specified operating system entry.

## Syntax
```
bootcfg /dbg1394 {ON | OFF}[/s <computer> [/u <Domain>\<User> /p <Password>]] [/ch <Channel>] /id <OSEntryLineNum>
```
## Parameters

|      Parameter       |                                                                                                                                           Description                                                                                                                                            |
|----------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|   {ON &#124; OFF}    | Specifies the value for 1394 port debugging.<br /><br />-   **ON** - Enables remote debugging support by adding the /dbg1394 option to the specified <OSEntryLineNum>.<br />-   **OFF** - Disables remote debugging support by removing the /dbg1394 option from the specified <OSEntryLineNum>. |
|    /s <computer>     |                                                                                        Specifies the name or IP address of a remote computer (do not use backslashes). The default is the local computer.                                                                                        |
| /u <Domain>\\<User>  |                                               Runs the command with the account permissions of the user specified by <User> or <Domain>\\<User>. The default is the permissions of the current logged on user on the computer issuing the command.                                               |
|    /p <Password>     |                                                                                                      Specifies the password of the user account that is specified in the **/u** parameter.                                                                                                       |
|     /ch Channel      |                                                           Specifies the channel to use for debugging. Valid values are integers between 1 and 64. Do not use the **/ch** <Channel> parameter if 1394 port debugging is being disabled.                                                           |
| /id <OSEntryLineNum> |                                  Specifies the operating system entry line number in the [operating systems] section of the Boot.ini file to which the 1394 port debugging options are added. The first line after the [operating systems] section header is 1.                                  |
|          /?          |                                                                                                                               Displays help at the command prompt.                                                                                                                               |

## <a name="BKMK_examples"></a>Examples
The following examples show how you can use the **bootcfg /dbg1394**command:
```
bootcfg /dbg1394 /id 2 
bootcfg /dbg1394 on /ch 1 /id 3 
bootcfg /dbg1394 edit /ch 8 /id 2 
bootcfg /s srvmain /u maindom\hiropln /p p@ssW23 /dbg1394 off /id 2
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
