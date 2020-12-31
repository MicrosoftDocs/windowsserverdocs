---
title: pktmon filter
description: Reference article for the pktmon filter command.
ms.topic: reference
author: khdownie
ms.author: v-kedow
ms.date: 12/31/2020
---

# pktmon filter

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Pktmon filter allows you to list, add, or remove packet filters.

## Syntax

```
pktmon filter { list | add | remove } [OPTIONS | help]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| pktmon filter list | Display active packet filters. |
| pktmon filter add |  Add a filter to control which packets are reported. |
| pktmon filter remove | Remove all packet filters. |

## Additional References

- [Pktmon](pktmon.md)
- [Pktmon filter add](pktmon-filter-add.md)
- [Packet Monitor overview](/windows-server/networking/technologies/pktmon/pktmon)
