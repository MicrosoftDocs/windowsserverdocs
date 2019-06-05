---
title: bootcfg default
description: "Windows Commands topic for **bootcfg default** - Specifies the operating system entry to designate as the default."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e21824d7-8278-41d7-a2c5-ce09803d513a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# bootcfg default

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Specifies the operating system entry to designate as the default.

## Syntax
```
bootcfg /default [/s <computer> [/u <Domain>\<User> /p <Password>]] [/id <OSEntryLineNum>]
```
## Parameters

|      Parameter       |                                                                                             Description                                                                                              |
|----------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    /s <computer>     |                                          Specifies the name or IP address of a remote computer (do not use backslashes). The default is the local computer.                                          |
| /u <Domain>\\<User>  | Runs the command with the account permissions of the user specified by <User> or <Domain>\\<User>. The default is the permissions of the current logged on user on the computer issuing the command. |
|    /p <Password>     |                                                        Specifies the password of the user account that is specified in the **/u** parameter.                                                         |
| /id <OSEntryLineNum> | Specifies the operating system entry line number in the [operating systems] section of the Boot.ini file to designate as default. The first line after the [operating systems] section header is 1.  |
|          /?          |                                                                                 Displays help at the command prompt.                                                                                 |

## <a name="BKMK_examples"></a>Examples
The following examples show how you can use the **bootcfg /default**command:
```
bootcfg /default /id 2
bootcfg /default /s srvmain /u maindom\hiropln /p p@ssW23 /id 2
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
