---
title: pktmon
description: Reference article for the pktmon network diagnostics tool for Windows that can be used for packet capture, packet drop detection, packet filtering, and counting.
ms.topic: reference
author: khdownie
ms.author: v-kedow
ms.date: 1/14/2021
---

# pktmon

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Packet Monitor (Pktmon) is an in-box, cross-component network diagnostics tool for Windows. It can be used for packet capture, drop detection, filtering, and counting. Pktmon is especially helpful in virtualization scenarios such as container networking and SDN, because it provides visibility within the networking stack.

## Syntax

```
pktmon { filter | comp | reset | counters | format | list | start | stop | pcapng | unload | help } [options]
```

### Commands

| **Command** | **Description** |
| --------- | ----------- |
| [pktmon filter](pktmon-filter.md) | Manage packet filters. |
| [pktmon comp](pktmon-comp.md) | Manage registered components. |
| [pktmon reset](pktmon-reset.md) | Reset counters to zero. |
| [pktmon counters](pktmon-counters.md) | Query packet counters. |
| [pktmon format](pktmon-format.md) | Convert log file to text. |
| [pktmon list](pktmon-list.md) | List all active components. |
| [pktmon start](pktmon-start.md) | Start packet monitoring. |
| pktmon stop | Stop packet monitoring. |
| [pktmon pcapng](pktmon-pcapng.md) | Convert log file to pcapng format. |
| [pktmon unload](pktmon-unload.md) | Unload pktmon driver. |
| pktmon help | Displays a short summary of subcommands. |

## Additional References

- [Packet Monitor overview](../../networking/technologies/pktmon/pktmon.md)
- [Pktmon support for Microsoft Network Monitor (Netmon)](../../networking/technologies/pktmon/pktmon-netmon-support.md)