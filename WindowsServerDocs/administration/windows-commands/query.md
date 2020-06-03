---
title: query
description: Reference topic for **** - 

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: 675c5128-f3cf-4e8f-8a3f-b29ab2a8b6de
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# query

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays information about processes, sessions, and Remote Desktop Session Host (RD Session Host) servers.

> [!NOTE]
> In Windows Server 2008 R2, Terminal Services was renamed Remote Desktop Services. To find out what's new in the latest version, see [What's New in Remote Desktop Services in Windows Server](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn283323(v=ws.11)) in the Microsoft Docs Windows Server Library.

## Syntax

```
query process
query session
query termserver
query user
```

### Parameters

|Parameter|Description|
|-------|--------|
|[query process](query-process.md)|Displays information about processes that are running on an rd Session Host server.|
|[query session](query-session.md)|Displays information about sessions on an rd Session Host server.|
|[query termserver](query-termserver.md)|Displays a list of all rd Session Host servers on the network.|
|[query user](query-user.md)|Displays information about user sessions on an rd Session Host server.|

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
- [Remote Desktop Services (Terminal Services) Command Reference](remote-desktop-services-terminal-services-command-reference.md)
