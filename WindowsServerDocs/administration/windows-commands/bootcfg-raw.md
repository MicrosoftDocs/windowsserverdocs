---
title: bootcfg raw
description: "Windows Commands topic for **bootcfg raw** - 
adds operating system load options specified as a string to an operating system entry in the **[operating systems]** section of the Boot.ini file."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e3458749-b0a0-460f-a022-3ff199a71f27
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# bootcfg raw

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

adds operating system load options specified as a string to an operating system entry in the **[operating systems]** section of the Boot.ini file.

## Syntax
```
bootcfg /raw [/s <computer> [/u <Domain>\<User> /p <Password>]] <OSLoadOptionsString> [/id <OSEntryLineNum>] [/a]
```
## Parameters

|         Term          |                                                                                                            Definition                                                                                                             |
|-----------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|     /s <computer>     |                                                        Specifies the name or IP address of a remote computer (do not use backslashes). The default is the local computer.                                                         |
| /u <Domain> \\<User>  |               Runs the command with the account permissions of the user specified by <User> or <Domain>\\<User>. The default is the permissions of the current logged on user on the computer issuing the command.                |
|     /p <Password>     |                                                                       Specifies the password of the user account that is specified in the **/u** parameter.                                                                       |
| <OSLoadOptionsString> | Specifies the operating system load options to add to the operating system entry. These load options will replace any existing load options associated with the operating system entry. No validation of <OSLoadOptions> is done. |
| /id <OSEntryLineNum>  |                       Specifies the operating system entry line number in the [operating systems] section of the Boot.ini file to update. The first line after the [operating systems] section header is 1.                       |
|          /a           |                                                       Specifies that the operating system options being added should be appended to any existing operating system options.                                                        |
|          /?           |                                                                                               Displays help at the command prompt.                                                                                                |

##### Remarks
- **bootcfg raw** is used to add text to the end of an operating system entry, overwriting any existing operating system entry options. This text should contain valid OS Load Options such as **/debug**, **/fastdetect**, **/nodebug**, **/baudrate**, **/crashdebug**, and **/sos**. For example, the following command adds "**/debug /fastdetect**" to the end of the first operating system entry, replacing any previous operating system entry options:
  ```
  bootcfg /raw "/debug /fastdetect" /id 1
  ```
  ## <a name="BKMK_examples"></a>Examples
  The following examples show how you can use the **bootcfg /raw** command:
  ```
  bootcfg /raw "/debug /sos" /id 2
  bootcfg /raw /s srvmain /u maindom\hiropln /p p@ssW23 "/crashdebug " /id 2
  ```
  #### additional references
  [Command-Line Syntax Key](command-line-syntax-key.md)
