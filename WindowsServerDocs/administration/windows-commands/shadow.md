---
title: shadow
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f81d9717-6883-4e14-9508-4b2a87e48ea7 Lizap
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# shadow

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Enables you to remotely control an active session of another user on a Remote Desktop Session Host (rd Session Host) server.
for examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax
```
shadow {<SessionName> | <SessionID>} [/server:<ServerName>] [/v]
```

### Parameters
|Parameter|Description|
|-------|--------|
|\<SessionName>|Specifies the name of the session that you want to remotely control.|
|\<SessionID>|Specifies the ID of the session that you want to remotely control. Use **query user** to display the list of sessions and their session IDs.|
|/server:\<ServerName>|Specifies the rd Session Host server containing the session that you want to remotely control. By default, the current rd Session Host4 server is used.|
|/v|Displays information about the actions being performed.|
|/?|Displays help at the command prompt.|

## Remarks
-   You can either view or actively control the session. If you choose to actively control a user's session, you will be able to input keyboard and mouse actions to the session.
-   You can always remotely control your own sessions (except the current session), but you must have Full Control permission or remote Control special access permission to remotely control another session.
-   You can also initiate remote control by using Remote Desktop Services Manager.
-   Before monitoring begins, the server warns the user that the session is about to be remotely controlled, unless this warning is disabled. Your session might appear to be frozen for a few seconds while it waits for a response from the user. To configure remote control for users and sessions, use the Remote Desktop Services Configuration tool or the Remote Desktop Services extensions to Local Users and Groups and active directory Users and computers.
-   Your session must be capable of supporting the video resolution used at the session that you are remotely controlling or the operation fails.
-   The console session can neither remotely control another session nor can it be remotely controlled by another session.
-   When you want to end remote control (shadowing), press CTRL+\* (by using \* from the numeric keypad only).

## <a name="BKMK_examples"></a>Examples
-   To shadow session 93, type:
    ```
    shadow 93
    ```
-   To shadow the session ACCTG01, type:
    ```
    shadow ACCTG01
    ```

#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[Remote Desktop Services &#40;Terminal Services&#41; Command Reference](remote-desktop-services-terminal-services-command-reference.md)
