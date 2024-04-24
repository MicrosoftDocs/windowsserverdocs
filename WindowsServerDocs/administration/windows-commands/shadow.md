---
title: shadow
description: Reference article for the shadow command, which enables you to remotely control an active session of another user on a Remote Desktop Session Host server.
ms.topic: reference
ms.assetid: f81d9717-6883-4e14-9508-4b2a87e48ea7
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# shadow

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Enables you to remotely control an active session of another user on a Remote Desktop Session Host server.

## Syntax

```
shadow {<sessionname> | <sessionID>} [/server:<servername>] [/v]
```

### Parameters

| Parameter | Description |
|--|--|
| `<sessionname>` | Specifies the name of the session that you want to remotely control. |
| `<sessionID>` | Specifies the ID of the session that you want to remotely control. Use **query user** to display the list of sessions and their session IDs. |
| /server:`<servername>` | Specifies the Remote Desktop Session Host server containing the session that you want to remotely control. By default, the current Remote Desktop Session Host4 server is used. |
| /v | Displays information about the actions being performed. |
| /? | Displays help at the command prompt. |

#### Remarks

- You can either view or actively control the session. If you choose to actively control a user's session, you will be able to input keyboard and mouse actions to the session.

- You can always remotely control your own sessions (except the current session), but you must have Full Control permission or remote Control special access permission to remotely control another session.

- You can also initiate remote control by using Remote Desktop Services Manager.

- Before monitoring begins, the server warns the user that the session is about to be remotely controlled, unless this warning is disabled. Your session might appear to be frozen for a few seconds while it waits for a response from the user. To configure remote control for users and sessions, use the Remote Desktop Services Configuration tool or the Remote Desktop Services extensions to Local Users and Groups and active directory Users and computers.

- Your session must be capable of supporting the video resolution used at the session that you are remotely controlling or the operation fails.

- The console session can neither remotely control another session nor can it be remotely controlled by another session.

- When you want to end remote control (shadowing), press CTRL+`*` (by using `*` from the numeric keypad only).

## Examples

To shadow *session 93*, type:

```
shadow 93
```

To shadow the session *ACCTG01*, type:

```
shadow ACCTG01
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Remote Desktop Services (Terminal Services) Command Reference](remote-desktop-services-terminal-services-command-reference.md)
