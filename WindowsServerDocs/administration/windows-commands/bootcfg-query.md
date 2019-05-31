---
title: bootcfg query
description: "Windows Commands topic for **bootcfg query** - Queries and displays the [boot loader] and [operating systems] section entries from Boot.ini."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a4cacfd1-10a6-4a11-b0c5-f8abde72bfc8
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# bootcfg query

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Queries and displays the [boot loader] and [operating systems] section entries from Boot.ini.

## Syntax
```
bootcfg /query [/s <computer> [/u <Domain>\<User> /p <Password>]]
```
## Parameters

|        Term         |                                                                                             Definition                                                                                              |
|---------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    /s <computer>    |                                         Specifies the name or IP address of a remote computer (do not use backslashes). The default is the local computer.                                          |
| /u <Domain>\\<User> | Runs the command with the account permissions of the user specified by <User>or <Domain>\\<User>. The default is the permissions of the current logged on user on the computer issuing the command. |
|    /p <Password>    |                                                        Specifies the password of the user account that is specified in the **/u** parameter.                                                        |
|         /?          |                                                                                Displays help at the command prompt.                                                                                 |

##### Remarks
- The following is a sample of **bootcfg /query** output:
  ```
  Boot Loader Settings
  ----------
  timeout: 30
  default: multi(0)disk(0)rdisk(0)partition(1)\WINDOWS
  Boot Entries
  ------
  Boot entry ID:   1
  Friendly Name:   ""
  path:            multi(0)disk(0)rdisk(0)partition(1)\WINDOWS
  OS Load Options: /fastdetect /debug /debugport=com1:
  ```
- The Boot Loader Settings portion of the **bootcfg query** output displays each entry in the [boot loader] section of Boot.ini.
- The Boot Entries portion of the **bootcfg query** output displays the following detail for each operating system entry in the [operating systems] section of Boot.ini: Boot entry ID, Friendly Name, path, and OS Load Options.
  ## <a name="BKMK_examples"></a>Examples
  The following examples show how you can use the **bootcfg /query** command:
  ```
  bootcfg /query
  bootcfg /query /s srvmain /u maindom\hiropln /p p@ssW23
  bootcfg /query /u hiropln /p p@ssW23
  ```
  #### additional references
  [Command-Line Syntax Key](command-line-syntax-key.md)
