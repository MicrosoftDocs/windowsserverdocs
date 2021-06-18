---
title: pktmon unload
description: Reference article for the pktmon unload command.
ms.topic: reference
author: khdownie
ms.author: v-kedow
ms.date: 1/14/2021
---

# pktmon unload

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Stop the PktMon driver service and unload PktMon.sys. Effectively equivalent to 'sc.exe stop PktMon'. Measurement (if active) will immediately stop, and any state will be deleted (counters, filters, etc.).

## Syntax

```
pktmon unload
```

## Additional References

- [Pktmon](pktmon.md)
- [Pktmon counters](pktmon-counters.md)
- [Pktmon filter](pktmon-filter.md)
- [Pktmon filter add](pktmon-filter-add.md)
- [Pktmon format](pktmon-format.md)
- [Pktmon list](pktmon-list.md)
- [Pktmon pcapng](pktmon-pcapng.md)
- [Pktmon reset](pktmon-reset.md)
- [Pktmon start](pktmon-start.md)
- [Packet Monitor overview](../../networking/technologies/pktmon/pktmon.md)