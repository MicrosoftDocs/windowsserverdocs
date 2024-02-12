---
title: pktmon
description: Reference article for the pktmon network diagnostics tool for Windows that can be used for packet capture, packet drop detection, packet filtering, and counting.
ms.topic: reference
author: khdownie
ms.author: wscontent
ms.date: 06/24/2021
---

# pktmon

>Applies to: Windows Server 2022, Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Packet Monitor (Pktmon) is an in-box, cross-component network diagnostics tool for Windows. It can be used for advanced packet capture and event collection, drop detection, filtering, and counting. Pktmon is especially helpful in virtualization scenarios such as container networking and SDN, because it provides visibility within the networking stack.

## Syntax

```
pktmon { filter | list | start | stop | status | unload | counters | reset | etl2txt | etl2pcap | hex2pkt | help } [options]
```

### Commands

| **Command** | **Description** |
| --------- | ----------- |
| [pktmon filter](pktmon-filter.md) | Manage packet filters. |
| [pktmon list](pktmon-list.md) | List packet processing components. |
| [pktmon start](pktmon-start.md) | Start packet capture and event collection. |
| pktmon stop | Stop data collection. |
| pktmon status | Query current status. |
| [pktmon unload](pktmon-unload.md) | Unload PktMon driver. |
| [pktmon counters](pktmon-counters.md) | Display current packet counters. |
| [pktmon reset](pktmon-reset.md) | Reset packet counters to zero. |
| [pktmon etl2txt](pktmon-format.md) | Convert log file to text format. |
| [pktmon etl2pcap](pktmon-pcapng.md) | Convert log file to pcapng format. |
| pktmon hex2pkt | Decode packet in hexadecimal format. |
| pktmon help | Show help text for specific command. |

## Related links

- [Packet Monitor overview](../../networking/technologies/pktmon/pktmon.md)
- [Pktmon support for Microsoft Network Monitor (Netmon)](../../networking/technologies/pktmon/pktmon-netmon-support.md)
