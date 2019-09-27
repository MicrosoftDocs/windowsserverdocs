---
title: getmac
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a749a348-7cd1-4336-9f33-bb42dd0e31e1
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# getmac

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Returns the media access control (MAC) address and list of network protocols associated with each address for all network cards in each computer, either locally or across a network. 
## Syntax
```
getmac[.exe][/s <computer> [/u <Domain\<User> [/p <Password>]]][/fo {TABLE | list | CSV}][/nh][/v]
```
### Parameters

|             Parameter              |                                                                                          Description                                                                                          |
|------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|           /s <computer>            |                                      Specifies the name or IP address of a remote computer (do not use backslashes). The default is the local computer.                                       |
|        /u <Domain>\\<User>         | Runs the command with the account permissions of the user specified by User or Domain\User. The default is the permissions of the current logged on user on the computer issuing the command. |
|           /p <Password>            |                                                     Specifies the password of the user account that is specified in the **/u** parameter.                                                     |
| /fo { TABLE &#124; list&#124; CSV} |                       Specifies the format to use for the query output. Valid values are **TABLE**, **list**, and **CSV**. The default format for output is **TABLE**.                        |
|                /nh                 |                                             Suppresses column header in output. Valid when the **/fo** parameter is set to **TABLE** or **CSV**.                                              |
|                 /v                 |                                                                    Specifies that the output display verbose information.                                                                     |
|                 /?                 |                                                                                                                                                                                               |

## Remarks
**getmac** can be useful either when you want to enter the MAC address into a network analyzer or when you need to know what protocols are currently in use on each network adapter in a computer.
## <a name="BKMK_Examples"></a>Examples
The following examples show how you can use the **getmac** command:
```
getmac /fo table /nh /v
```
```
getmac /s srvmain
```
```
getmac /s srvmain /u maindom\hiropln
```
```
getmac /s srvmain /u maindom\hiropln /p p@ssW23
```
```
getmac /s srvmain /u maindom\hiropln /p p@ssW23 /fo list /v
```
```
getmac /s srvmain /u maindom\hiropln /p p@ssW23 /fo table /nh
```
## additional references
-   [Command-Line Syntax Key](command-line-syntax-key.md)
