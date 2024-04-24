---
title: tskill
description: Reference article for the tskill command, which ends a process running in a session on a Remote Desktop Session Host server.
ms.topic: reference
ms.assetid: 08986e6a-6900-4ece-85a1-8f73b14db1b3
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# tskill

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Ends a process running in a session on a Remote Desktop Session Host server.

> [!NOTE]
> You can use this command to end only those processes that belong to you, unless you are an administrator. Administrators have full access to all **tskill** functions and can end processes that are running in other user sessions.
>
> To find out what's new in the latest version, see [What's New in Remote Desktop Services in Windows Server](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn283323(v=ws.11)).

## Syntax

```
tskill {<processID> | <processname>} [/server:<servername>] [/id:<sessionID> | /a] [/v]
```

### Parameters

| Parameter | Description |
|--|--|
| `<processID>` | Specifies the ID of the process that you want to end. |
| `<processname>` | Specifies the name of the process that you want to end. This parameter can include wildcard characters. |
| /server:`<servername>` | Specifies the terminal server that contains the process that you want to end. If **/server** isn't specified, the current Remote Desktop Session Host server is used. |
| /id:`<sessionID>` | Ends the process that is running in the specified session. |
| /a | Ends the process that is running in all sessions. |
| /v | Displays information about the actions being performed. |
| /? | Displays help at the command prompt. |

#### Remarks

- When all processes that are running in a session end, the session also ends.

- If you use the `<processname>` and the `/server:<servername>` parameters, you must also specify either the `/id:<sessionID>` or the **/a** parameter.

## Examples

To end process 6543, type:

```
tskill 6543
```

To end the process explorer running on session 5, type:

```
tskill explorer /id:5
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Remote Desktop Services (Terminal Services) Command Reference](remote-desktop-services-terminal-services-command-reference.md)
