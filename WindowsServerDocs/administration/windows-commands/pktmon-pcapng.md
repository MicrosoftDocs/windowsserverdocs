---
title: pktmon pcapng
description: Reference article for the pktmon pcapng command.
ms.topic: reference
author: khdownie
ms.author: v-kedow
ms.date: 12/31/2020
---

# pktmon pcapng

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Pktmon pcapng converts log files to pcapng format. Dropped packets are not included by default.

## Syntax

```
pktmon pcapng log.etl [-o log.pcapng]
```

### Parameters

| **Parameter** | **Description** |
| ------------- | --------------- |
| **-o, --out** | Name of the formatted pcapng file. |
| **-d, --drop-only** | Convert dropped packets only. |
| **-c, --component-id** | Filter packets by a specific component ID. |

## Example

The following example converts only the dropped packets from network interface cards in the log file *PktMon.etl* to pcapng format:

```powershell
C:\Test> pktmon pcapng C:\tmp\PktMon.etl -d -c nics
```

## Additional References

- [Pktmon](pktmon.md)
- [Pktmon comp](pktmon-comp.md)
- [Pktmon counters](pktmon-counters.md)
- [Pktmon filter](pktmon-filter.md)
- [Pktmon filter add](pktmon-filter-add.md)
- [Pktmon format](pktmon-format.md)
- [Pktmon list](pktmon-list.md)
- [Pktmon unload](pktmon-unload.md)
- [Pktmon reset](pktmon-reset.md)
- [Pktmon start](pktmon-start.md)
- [Packet Monitor overview](/windows-server/networking/technologies/pktmon/pktmon)
