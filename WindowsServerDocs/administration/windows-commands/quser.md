---
title: quser
description: Reference article for the quser command, which displays information about user sessions on a Remote Desktop Session Host server.
ms.topic: reference
ms.assetid: 8056204f-ed11-4c91-bb1d-c799283a48a4
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# quser

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays information about user sessions on a Remote Desktop Session Host server. You can use this command to find out if a specific user is logged on to a specific Remote Desktop Session Host server. This command returns the following information:

- Name of the user

- Name of the session on the Remote Desktop Session Host server

- Session ID

- State of the session (active or disconnected)

- Idle time (the number of minutes since the last keystroke or mouse movement at the session)

- Date and time the user logged on

> [!NOTE]
> This command is the same as the [query user command](query-user.md). To find out what's new in the latest version, see [What's New in Remote Desktop Services in Windows Server](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn283323(v=ws.11)).

## Syntax

```
quser [<username> | <sessionname> | <sessionID>] [/server:<servername>]
```

### Parameters

| Parameter | Description |
|--|--|
| `<username>` | Specifies the logon name of the user that you want to query. |
| `<sessionname>` | Specifies the name of the session that you want to query. |
| `<sessionID>` | Specifies the ID of the session that you want to query. |
| /server:`<servername>` | Specifies the Remote Desktop Session Host server that you want to query. Otherwise, the current Remote Desktop Session Host server is used. This parameter is only required if you're using this command from a remote server. |
| /? | Displays help at the command prompt. |

#### Remarks

- To use this command, you must have Full Control permission or special access permission.

- If you don't specify a user using the <*username*>, <*sessionname*>, or *sessionID* parameters, a list of all users who are logged on to the server is returned. Alternatively, you can also use the **query session** command to display a list of all sessions on a server.

- When **quser** returns information, a greater than `(>)` symbol is displayed before the current session.

### Examples

To display information about all users logged on the system, type:

```
quser
```

To display information about the user *USER1* on server *Server1*, type:

```
quser USER1 /server:Server1
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [query user command](query-user.md)

- [Remote Desktop Services (Terminal Services) Command Reference](remote-desktop-services-terminal-services-command-reference.md)
