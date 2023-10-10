---
title: change logon
description: Reference article for the change logon command, which enables or disables logons from client sessions, or displays current logon status.
ms.topic: reference
ms.assetid: 41466260-aee9-4333-bcb6-178112c22afd
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# change logon

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Enables or disables logons from client sessions, or displays current logon status. This utility is useful for system maintenance. You must be an administrator to run this command.

> [!NOTE]
> To find out what's new in the latest version, see [What's New in Remote Desktop Services in Windows Server](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn283323(v=ws.11)).

## Syntax

```
change logon {/query | /enable | /disable | /drain | /drainuntilrestart}
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /query | Displays the current logon status, whether enabled or disabled. |
| /enable | Enables logons from client sessions, but not from the console. |
| /disable | Disables subsequent logons from client sessions, but not from the console. Does not affect currently logged on users. |
| /drain | Disables logons from new client sessions, but allows reconnections to existing sessions. |
| /drainuntilrestart | Disables logons from new client sessions until the computer is restarted, but allows reconnections to existing sessions. |
| /? | Displays help at the command prompt. |

#### Remarks

- Logons are re-enabled when you restart the system.

- If you're connected to the Remote Desktop Session Host server from a client session, and then you disable logons and log off before re-enabling logons, you won't be able to reconnect to your session. To re-enable logons from client sessions, log on at the console.

### Examples

- To display the current logon status, type:

  ```
  change logon /query
  ```

- To enable logons from client sessions, type:

  ```
  change logon /enable
  ```

- To disable client logons, type:

  ```
  change logon /disable
  ```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [change command](change.md)

- [Remote Desktop Services (Terminal Services) Command Reference](remote-desktop-services-terminal-services-command-reference.md)
