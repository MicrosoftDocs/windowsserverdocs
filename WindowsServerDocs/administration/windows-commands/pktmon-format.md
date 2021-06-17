---
title: pktmon format
description: Reference article for the pktmon format command.
ms.topic: reference
author: khdownie
ms.author: v-kedow
ms.date: 1/14/2021
---

# pktmon format

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Pktmon format converts log files to text format.

## Syntax

```
pktmon format log.etl [-o log.txt] [-b] [-v [level]] [-x] [-e] [-l [port]
```

### Parameters

| **Parameter** | **Description** |
| ------------- | --------------- |
| **-o, --out** | Name of the formatted text file. |
| **-s, --stats-only** | Display log file statistical information. |
| **-b, --brief** | Abbreviated packet format. |
| **-v, --verbose** | Verbosity level [1..3]. |
| **-x, --hex** | Hexadecimal format. |
| **-e, --no-ethernet** | Don't print ethernet header. |
| **-l, --vxlan** | Custom VXLAN port. |

## Additional References

- [Pktmon](pktmon.md)
- [Pktmon comp](pktmon-comp.md)
- [Pktmon counters](pktmon-counters.md)
- [Pktmon filter](pktmon-filter.md)
- [Pktmon filter add](pktmon-filter-add.md)
- [Pktmon list](pktmon-list.md)
- [Pktmon pcapng](pktmon-pcapng.md)
- [Pktmon reset](pktmon-reset.md)
- [Pktmon start](pktmon-start.md)
- [Pktmon unload](pktmon-unload.md)
- [Packet Monitor overview](../../networking/technologies/pktmon/pktmon.md)