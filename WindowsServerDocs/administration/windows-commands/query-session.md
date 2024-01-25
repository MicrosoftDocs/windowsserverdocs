---
title: query session
description: Reference article for the query session command, which displays information about sessions on a Remote Desktop Session Host server.
ms.topic: reference
ms.assetid: abc0ace8-0b74-4b6e-a937-a78bb4b61a1f
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# query session

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays information about sessions on a Remote Desktop Session Host server. The list includes information not only about active sessions but also about other sessions that the server runs.

> [!NOTE]
> To find out what's new in the latest version, see [What's New in Remote Desktop Services in Windows Server](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn283323(v=ws.11)).

## Syntax

```
query session [<sessionname> | <username> | <sessionID>] [/server:<servername>] [/mode] [/flow] [/connect] [/counter]
```

### Parameters

| Parameter | Description |
|--|--|
| `<sessionname>` | Specifies the name of the session that you want to query. |
| `<username>` | Specifies the name of the user whose sessions you want to query. |
| `<sessionID>` | Specifies the ID of the session that you want to query. |
| /server:`<servername>` | Identifies the rd Session Host server to query. The default is the current server. |
| /mode | Displays current line settings. |
| /flow | Displays current flow-control settings. |
| /connect | Displays current connect settings. |
| /counter | Displays current counters information, including the total number of sessions created, disconnected, and reconnected. |
| /? | Displays help at the command prompt. |

#### Remarks

- A user can always query the session to which the user is currently logged on. To query other sessions, the user must have special access permission.

- If you don't specify a session using the <*username*>, <*sessionname*>, or *sessionID* parameters, this query will display information about all active sessions in the system.

- When **query session** returns information, a greater than `(>)` symbol is displayed before the current session. For example:

    ```
    C:\>query session
        SESSIONNAME     USERNAME        ID STATE    TYPE    DEVICE
        console         Administrator1  0 active    wdcon
        >rdp-tcp#1      User1           1 active    wdtshare
        rdp-tcp                         2 listen    wdtshare
                                        4 idle
                                        5 idle
    ```

    Where:
  - **SESSIONNAME** specifies the name assigned to the session.
  - **USERNAME** indicates the user name of the user connected to the session.
  - **STATE** provides information about the current state of the session.
  - **TYPE** indicates the session type.
  - **DEVICE**, which isn't present for the console or network-connected sessions, is the device name assigned to the session.
  - Any sessions in which the initial state is configured as DISABLED won't show up in the **query session** list until they're enabled.

### Examples

To display information about all active sessions on server *Server2*, type:

```
query session /server:Server2
```

To display information about active session *modeM02*, type:

```
query session modeM02
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [query command](query.md)

- [Remote Desktop Services (Terminal Services) Command Reference](remote-desktop-services-terminal-services-command-reference.md)
