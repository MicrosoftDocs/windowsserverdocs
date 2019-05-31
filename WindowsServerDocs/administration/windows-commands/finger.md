---
title: finger
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 907ea637-5c6c-4752-84c2-46bbf2a68a33
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# finger

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays information about a user or users on a specified remote computer (typically a computer running UNIX) that is running the finger service or daemon. The remote computer specifies the format and output of the user information display. Used without parameters, **finger** displays help. 
## Syntax
```
finger [-l] [<User>] [@<Host>] [...]
```
### Parameters

| Parameter |                                                                            Description                                                                            |
|-----------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    -l     |                                                          Displays user information in long list format.                                                           |
|  <User>   | Specifies the user about which you want information. If you omit the *User* parameter, **finger** displays information about all users on the specified computer. |
|  @<Host>  |        Specifies the remote computer running the finger service where you are looking for user information. You can specify a computer name or IP address.        |
|    /?     |                                                               Displays help at the command prompt.                                                                |

## Remarks
Multiple User@Host parameters can be specified.
You must prefix **finger** parameters with a hyphen (-) rather than a slash (/).
This command is available only if the Internet Protocol (TCP/IP) protocol is installed as a component in the properties of a network adapter in Network Connections.
The Windows Server 2003 does not provide a finger service.
## <a name="BKMK_Examples"></a>Examples
To display information for user1 on the computer users.microsoft.com, type:
```
finger user1@users.microsoft.com
```
To display information for all users on the computer users.microsoft.com, type:
```
finger @users.microsoft.com
```
## additional references
-   [Command-Line Syntax Key](command-line-syntax-key.md)
