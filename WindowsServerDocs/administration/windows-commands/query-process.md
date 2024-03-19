---
title: query process
description: Reference article for the query process command, which displays information about processes that are running on a Remote Desktop Session Host server.
ms.topic: reference
ms.assetid: 36ce3ffc-0092-4eb1-a374-28e6616ca946
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# query process

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays information about processes that are running on a Remote Desktop Session Host server. You can use this command to find out which programs a specific user is running, and also which users are running a specific program. This command returns the following information:

- User who owns the process

- Session that owns the process

- ID of the session

- Name of the process

- ID of the process

> [!NOTE]
> To find out what's new in the latest version, see [What's New in Remote Desktop Services in Windows Server](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn283323(v=ws.11)).

## Syntax

```
query process [*|<processID>|<username>|<sessionname>|/id:<nn>|<programname>] [/server:<servername>]
```

### Parameters

| Parameter | Description |
|--|--|
| * | Lists the processes for all sessions. |
| `<processID>` | Specifies the numeric ID identifying the process that you want to query. |
| `<username>` | Specifies the name of the user whose processes you want to list. |
| `<sessionname>` | Specifies the name of the active session whose processes you want to list. |
| /id:`<nn>` | Specifies the ID of the session whose processes you want to list. |
| `<programname>` | Specifies the name of the program whose processes you want to query. The .exe extension is required. |
| /server:`<servername>` | Specifies the Remote Desktop Session Host server whose processes you want to list. If unspecified, the server where you are currently logged on is used. |
| /? | Displays help at the command prompt. |

#### Remarks

- Administrators have full access to all **query process** functions.

- If you don't specify the <*username*>, <*sessionname*>, */id:`<nn>`*, <*programname*>, or *&#42;* parameters, this query displays only the processes that belong to the current user.

- When **query process** returns information, a greater than `(>)` symbol is displayed before each process that belongs to the current session.

## Examples

To display information about the processes being used by all sessions, type:

```
query process *
```

To display information about the processes being used by *session ID 2*, type:

```
query process /ID:2
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [query command](query.md)

- [Remote Desktop Services (Terminal Services) Command Reference](remote-desktop-services-terminal-services-command-reference.md)
