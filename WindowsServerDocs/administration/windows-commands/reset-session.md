---
title: reset session
description: Reference article for reset session command, which enables you to reset a session on a Remote Desktop Session Host server.
ms.topic: reference
ms.assetid: 4f029ecc-874e-415a-95a8-8b731bae35f9
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 07/11/2018
---

# reset session

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Enables you to reset (delete) a session on a Remote Desktop Session Host server. You should reset a session only when it malfunctions or appears to have stopped responding.

> [!NOTE]
> To find out what's new in the latest version, see [What's New in Remote Desktop Services in Windows Server](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn283323(v=ws.11)).

## Syntax

```
reset session {<sessionname> | <sessionID>} [/server:<servername>] [/v]
```

### Parameters

| Parameter | Description |
|--|--|
| `<sessionname>` | Specifies the name of the session that you want to reset. To determine the name of the session, use the [query session command](query-session.md). |
| `<sessionID>` | Specifies the ID of the session to reset. |
| /server:`<servername>` | Specifies the terminal server containing the session that you want to reset. Otherwise, it uses the current Remote Desktop Session Host server. This parameter is required only if you use this command from a remote server. |
| /v | Displays information about the actions being performed. |
| /? | Displays help at the command prompt. |

### Remarks

- You can always reset your own sessions, but you must have **Full Control** access permission to reset another user's session. Be aware that resetting a user's session without warning the user can result in the loss of data at the session.

## Examples

To reset the session designated *rdp-tcp#6*, type:

```
reset session rdp-tcp#6
```

To reset the session that uses *session ID 3*, type:

```
reset session 3
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Remote Desktop Services Command Reference](remote-desktop-services-terminal-services-command-reference.md)
