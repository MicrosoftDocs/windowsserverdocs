---
title: logoff
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 939f09cc-de8c-436c-a05d-aca5f2a06371
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# logoff

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Logs off a user from a session on a Remote Desktop Session Host (rd Session Host) server and deletes the session from the server.
for examples of how to use this command, see [Examples](#BKMK_examples).

> [!NOTE]
> In Windows Server 2008 R2, Terminal Services was renamed Remote Desktop Services. To find out what's new in the latest version, see [What s New in Remote Desktop Services in Windows Server 2012](https://technet.microsoft.com/library/hh831527) in the Windows Server TechNet Library.

## Syntax
```
logoff [<SessionName> | <SessionID>] [/server:<ServerName>] [/v]
```
## Parameters

|      Parameter       |                                                                             Description                                                                              |
|----------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    <SessionName>     |                                                                  Specifies the name of the session.                                                                  |
|     <SessionID>      |                                                 Specifies the numeric ID which identifies the session to the server.                                                 |
| /server:<ServerName> | Specifies the rd Session Host server that contains the session whose user you want to log off. If unspecified, the server on which you are currently active is used. |
|          /v          |                                                       Displays information about the actions being performed.                                                        |
|          /?          |                                                                 Displays help at the command prompt.                                                                 |

## Remarks
- You can always log off from the session to which you are currently logged on. You must, however, have Full Control permission to log off users from other sessions.
- Logging off a user from a session without warning can result in loss of data at the user's session. You should send a message to the user by using the **msg** command to warn the user before taking this action.
- if <*SessionID*> or <*SessionName*> is not specified, **logoff** logs off the user from the current session. If you specify <*SessionName*>, it must be an active one.
- When you log off a user, all processes end and the session is deleted from the server.
- You cannot log off a user from the console session.
  ## <a name="BKMK_examples"></a>Examples
- To log off a user from the current session, type:
  ```
  logoff
  ```
- To log off a user from a session by using the session's ID, for example session 12, type:
  ```
  logoff 12
  ```
- To log off a user from a session by using the name of the session and server, for example session TERM04 on Server1, type:
  ```
  logoff TERM04 /server:Server1
  ```

#### additional references
-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Remote Desktop Services &#40;Terminal Services&#41; Command Reference](remote-desktop-services-terminal-services-command-reference.md)
