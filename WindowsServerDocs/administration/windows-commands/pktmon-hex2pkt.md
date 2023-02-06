---
title: pktmon hex2pkt
description: Reference article for the pktmon hex2pkt command that provides a listing of parameters and what they do.
ms.topic: reference
author: khdownie
ms.author: wscontent
ms.date: 06/24/2021
---

# pktmon hex2pkt

>Applies to: Windows Server 2022, Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Decode packet in hexadecimal format.

## Syntax

```
pktmon hex2pkt [--type { Ethernet | IP | HTTP }]
```

### Parameters

| **Parameter** | **Description** |
| ------------- | --------------- |
| **-t, --type** | Packet type to decode. Options are Ethernet, IP, and HTTP. Default is Ethernet. |

## Related links

- [Pktmon](pktmon.md)
- [Pktmon counters](pktmon-counters.md)
- [Pktmon etl2pcap](pktmon-etl2pcap.md)
- [Pktmon etl2txt](pktmon-etl2txt.md)
- [Pktmon filter](pktmon-filter.md)
- [Pktmon filter add](pktmon-filter-add.md)
- [Pktmon list](pktmon-list.md)
- [Pktmon reset](pktmon-reset.md)
- [Pktmon start](pktmon-start.md)
- [Pktmon status](pktmon-status.md)
- [Pktmon unload](pktmon-unload.md)
- [Packet Monitor overview](/windows-server/networking/technologies/pktmon/pktmon)
