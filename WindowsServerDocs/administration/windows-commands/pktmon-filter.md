---
title: pktmon filter
description: Reference article for the pktmon filter command that provides a listing of parameters and what they do.
ms.topic: reference
author: khdownie
ms.author: wscontent
ms.date: 06/24/2021
---

# pktmon filter

>Applies to: Windows Server 2022, Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Pktmon filter allows you to list, add, or remove packet filters.

## Syntax

```
pktmon filter { list | add | remove } [OPTIONS | help]
```

### Parameters

| **Parameter** | **Description** |
| ------------- | --------------- |
| **pktmon filter list** | Display active packet filters. |
| **pktmon filter add** |  Add a filter to control which packets are reported. |
| **pktmon filter remove** | Remove all packet filters. |

## Related links

- [Pktmon](pktmon.md)
- [Pktmon counters](pktmon-counters.md)
- [Pktmon etl2pcap](pktmon-etl2pcap.md)
- [Pktmon etl2txt](pktmon-etl2txt.md)
- [Pktmon filter add](pktmon-filter-add.md)
- [Pktmon hex2pkt](pktmon-hex2pkt.md)
- [Pktmon list](pktmon-list.md)
- [Pktmon reset](pktmon-reset.md)
- [Pktmon start](pktmon-start.md)
- [Pktmon status](pktmon-status.md)
- [Pktmon unload](pktmon-unload.md)
- [Packet Monitor overview](../../networking/technologies/pktmon/pktmon.md)
