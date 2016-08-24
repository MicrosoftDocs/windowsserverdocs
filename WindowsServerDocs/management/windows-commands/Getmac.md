---
title: Getmac
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a749a348-7cd1-4336-9f33-bb42dd0e31e1
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Getmac
Returns the media access control (MAC) address and list of network protocols associated with each address for all network cards in each computer, either locally or across a network. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).
## Syntax
```
getmac[.exe][/s <Computer> [/u <Domain\<User> [/p <Password>]]][/fo {TABLE | LIST | CSV}][/nh][/v]
```
### Parameters
|Parameter|Description|
|-------------|---------------|
|/s <Computer>|Specifies the name or IP address of a remote computer (do not use backslashes). The default is the local computer.|
|/u <Domain>\\<User>|Runs the command with the account permissions of the user specified by User or Domain\User. The default is the permissions of the current logged on user on the computer issuing the command.|
|/p <Password>|Specifies the password of the user account that is specified in the **/u** parameter.|
|/fo { TABLE &#124; LIST&#124; CSV}|Specifies the format to use for the query output. Valid values are **TABLE**, **LIST**, and **CSV**. The default format for output is **TABLE**.|
|/nh|Suppresses column header in output. Valid when the **/fo** parameter is set to **TABLE** or **CSV**.|
|/v|Specifies that the output display verbose information.|
|/?||
## Remarks
**Getmac** can be useful either when you want to enter the MAC address into a network analyzer or when you need to know what protocols are currently in use on each network adapter in a computer.
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
## Additional references
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)
