---
title: Bootcfg delete
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 71382e29-9b39-41c8-9c23-cf0ff829440a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Bootcfg delete
Deletes an operating system entry in the [operating systems] section of the Boot.ini file.
For examples of how this command can be used, see [Examples](#BKMK_examples).
## Syntax
```
bootcfg /delete [/s <Computer> [/u <Domain>\<User> /p <Password>]] [/id <OSEntryLineNum>]
```
## Parameters
|Term|Definition|
|--------|--------------|
|/s <Computer>|Specifies the name or IP address of a remote computer (do not use backslashes). The default is the local computer.|
|/u <Domain>\\<User>|Runs the command with the account permissions of the user specified by <User>or <Domain>\\<User>. The default is the permissions of the current logged on user on the computer issuing the command.|
|/p <Password>|Specifies the password of the user account that is specified in the **/u** parameter.|
|/id <OSEntryLineNum>|Specifies the operating system entry line number in the [operating systems] section of the Boot.ini file to delete. The first line after the [operating systems] section header is 1.|
|/?|Displays help at the command prompt.|
## <a name="BKMK_examples"></a>Examples
The following examples show how you can use the **bootcfg /delete**command:
```
bootcfg /delete /id 1
bootcfg /delete /s srvmain /u maindom\hiropln /p p@ssW23 /id 3
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
