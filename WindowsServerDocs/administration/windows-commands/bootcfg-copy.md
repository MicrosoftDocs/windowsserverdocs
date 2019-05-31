---
title: bootcfg copy
description: "Windows Commands topic for **bootcfg copy** - Makes a copy of an existing boot entry, to which you can add command-line options."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2a236c2a-8675-444d-b695-9cbc9aff643b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# bootcfg copy

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Makes a copy of an existing boot entry, to which you can add command-line options.

## Syntax
```
bootcfg /copy [/s <computer> [/u <Domain>\<User> /p <Password>]] [/d <Description>] [/id <OSEntryLineNum>]
```
## Parameters

|      Parameter       |                                                                                             Description                                                                                             |
|----------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    /s <computer>     |                                         Specifies the name or IP address of a remote computer (do not use backslashes). The default is the local computer.                                          |
| /u <Domain>\\<User>  | Runs the command with the account permissions of the user specified by <User>or <Domain>\\<User>. The default is the permissions of the current logged on user on the computer issuing the command. |
|    /p <Password>     |                                                        Specifies the password of the user account that is specified in the **/u** parameter.                                                        |
|   /d <Description>   |                                                                    Specifies the description for the new operating system entry.                                                                    |
| /id <OSEntryLineNum> |         Specifies the operating system entry line number in the [operating systems] section of the Boot.ini file to copy. The first line after the [operating systems] section header is 1.         |
|          /?          |                                                                                Displays help at the command prompt.                                                                                 |

## <a name="BKMK_examples"></a>Examples
The following examples show how you can use the **bootcfg /copy** command to copy boot entry 1 and enter "\ABC Server\\" as the description:
```
bootcfg /copy /d "\ABC Server\" /id 1
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
