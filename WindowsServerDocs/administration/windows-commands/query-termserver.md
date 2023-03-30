---
title: query termserver
description: Reference article for the query termserver command, which displays a list of all Remote Desktop Session Host servers on the network.
ms.topic: reference
ms.assetid: 3b89d3b4-236f-4376-90b6-939a0ec4b288
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# query termserver

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays a list of all Remote Desktop Session Host servers on the network. This command searches the network for all attached Remote Desktop Session Host servers and returns the following information:

- Name of the server

- Network (and node address if the /address option is used)

> [!NOTE]
> To find out what's new in the latest version, see [What's New in Remote Desktop Services in Windows Server](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn283323(v=ws.11)).

## Syntax

```
query termserver [<servername>] [/domain:<domain>] [/address] [/continue]
```

### Parameters

| Parameter | Description |
|--|--|
| `<servername>` | Specifies the name that identifies the Remote Desktop Session Host server. |
| /domain:`<domain>` | Specifies the domain to query for terminal servers. You don't need to specify a domain if you are querying the domain in which you are currently working. |
| /address | Displays the network and node addresses for each server. |
| /continue | Prevents pausing after each screen of information is displayed. |
| /? | Displays help at the command prompt. |

### Examples

To display information about all Remote Desktop Session Host servers on the network, type:

```
query termserver
```

To display information about the Remote Desktop Session Host server named *Server3*, type:

```
query termserver Server3
```

To display information about all Remote Desktop Session Host servers in domain *CONTOSO*, type:

```
query termserver /domain:CONTOSO
```

To display the network and node address for the Remote Desktop Session Host server named *Server3*, type:

```
query termserver Server3 /address
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [query command](query.md)

- [Remote Desktop Services (Terminal Services) Command Reference](remote-desktop-services-terminal-services-command-reference.md)
