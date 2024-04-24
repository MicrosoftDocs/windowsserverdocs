---
title: pktmon unload
description: Reference article for the pktmon unload command that provides a listing of parameters and what they do.
ms.topic: reference
author: khdownie
ms.author: wscontent
ms.date: 06/24/2021
---

# pktmon unload

>Applies to: Windows Server 2022, Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Stop the PktMon driver service and unload PktMon.sys. Effectively equivalent to 'sc.exe stop PktMon'. Measurement (if active) will immediately stop, and any state will be deleted (counters, filters, etc.).

## Syntax

```
pktmon unload
```

## Related links

- [Pktmon](pktmon.md)
- [Pktmon counters](pktmon-counters.md)
- [Pktmon etl2pcap](pktmon-etl2pcap.md)
- [Pktmon etl2txt](pktmon-etl2txt.md)
- [Pktmon filter](pktmon-filter.md)
- [Pktmon filter add](pktmon-filter-add.md)
- [Pktmon hex2pkt](pktmon-hex2pkt.md)
- [Pktmon list](pktmon-list.md)
- [Pktmon reset](pktmon-reset.md)
- [Pktmon start](pktmon-start.md)
- [Pktmon status](pktmon-status.md)
- [Packet Monitor overview](../../networking/technologies/pktmon/pktmon.md)
