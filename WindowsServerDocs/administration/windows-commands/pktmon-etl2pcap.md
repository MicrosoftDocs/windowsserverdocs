---
title: pktmon etl2pcap
description: Reference article for the pktmon etl2pcap command.
ms.topic: reference
author: khdownie
ms.author: v-kedow
ms.date: 06/24/2021
---

# pktmon etl2pcap

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Convert pktmon log file to pcapng format. Dropped packets are not included by default.

## Syntax

```
pktmon etl2pcap <file> [--out <name>] [--drop-only] [--component-id <id>]
```

Where `<file>` is the ETL file to convert.

### Parameters

| **Parameter** | **Description** |
| ------------- | --------------- |
| **-o, --out <name>** | Name of the formatted pcapng file. |
| **-d, --drop-only** | Convert dropped packets only. |
| **-c, --component-id <id>** | Filter packets by a specific component ID. |

## Additional References

- [Pktmon](pktmon.md)
- [Pktmon counters](pktmon-counters.md)
- [Pktmon etl2txt](pktmon-etl2txt.md)
- [Pktmon filter](pktmon-filter.md)
- [Pktmon filter add](pktmon-filter-add.md)
- [Pktmon hex2pkt](pktmon-hex2pkt.md)
- [Pktmon list](pktmon-list.md)
- [Pktmon reset](pktmon-reset.md)
- [Pktmon start](pktmon-start.md)
- [Pktmon status](pktmon-status.md)
- [Pktmon unload](pktmon-unload.md)
- [Packet Monitor overview](/windows-server/networking/technologies/pktmon/pktmon)
