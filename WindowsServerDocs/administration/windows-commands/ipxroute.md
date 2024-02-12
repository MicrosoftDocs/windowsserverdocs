---
title: ipxroute
description: Reference article for the ipxroute command, which displays and modifies information about the routing tables used by the IPX protocol.
ms.topic: reference
ms.assetid: 3a30304f-655e-43d2-a4ac-7568abf8975c
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ipxroute

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays and modifies information about the routing tables used by the IPX protocol. Used without parameters, **ipxroute** displays the default settings for packets that are sent to unknown, broadcast, and multicast addresses.

## Syntax

```
ipxroute servers [/type=x]
ipxroute ripout <network>
ipxroute resolve {guid | name} {GUID | <adaptername>}
ipxroute board= N [def] [gbr] [mbr] [remove=xxxxxxxxxxxx]
ipxroute config
```

### Parameters
| Parameter | Description |
| ------- | -------- |
| servers`[/type=x]` | Displays the Service Access Point (SAP) table for the specified server type. **x** must be an integer. For example, `/type=4` displays all file servers. If you don't specify **/type**, `ipxroute servers` displays all types of servers, listing them by server name. |
| resolve`{GUID | name}` `{GUID | adaptername}` | Resolves the name of the GUID to its friendly name, or the friendly name to its GUID. |
| board= *n* | Specifies the network adapter for which to query or set parameters. |
| def | Sends packets to the ALL ROUTES broadcast. If a packet is transmitted to a unique Media Access Card (MAC) address that is not in the source routing table, **ipxroute** sends the packet to the SINGLE ROUTES broadcast by default. |
| gbr | Sends packets to the ALL ROUTES broadcast. If a packet is transmitted to the broadcast address (FFFFFFFFFFFF), **ipxroute** sends the packet to the SINGLE ROUTES broadcast by default. |
| mbr | Sends packets to the ALL ROUTES broadcast. If a packet is transmitted to a multicast address (C000xxxxxxxx), **ipxroute** sends the packet to the SINGLE ROUTES broadcast by default. |
| remove=*xxxxxxxxxxxx* | removes the given node address from the source routing table. |
| config | Displays information about all of the bindings for which IPX is configured. |
| /? | Displays help at the command prompt. |

### Examples

To display the network segments that the workstation is attached to, the workstation node address, and frame type being used, type:

```
ipxroute config
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
