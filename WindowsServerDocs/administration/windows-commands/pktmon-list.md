---
title: pktmon list
description: Reference article for the pktmon list command.
ms.topic: reference
author: khdownie
ms.author: v-kedow
ms.date: 12/31/2020
---

# pktmon list

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Lists all active components, allowing you to examine the networking stack layout. The command shows networking components (drivers) arranged by adapters bindings.

## Syntax

```
pktmon [comp] list
```

### Parameters

| **Parameter** | **Description** |
| ------------- | --------------- |
| **-i, --show-hidden** | Show components that are hidden by default. |
| **--json** | Output the list in JSON format. |

## Additional References

- [Pktmon](pktmon.md)
- [Pktmon comp](pktmon-comp.md)
- [Pktmon counters](pktmon-counters.md)
- [Pktmon filter](pktmon-filter.md)
- [Pktmon filter add](pktmon-filter-add.md)
- [Pktmon format](pktmon-format.md)
- [Pktmon pcapng](pktmon-pcapng.md)
- [Pktmon reset](pktmon-reset.md)
- [Pktmon start](pktmon-start.md)
- [Pktmon unload](pktmon-unload.md)
- [Packet Monitor overview](/windows-server/networking/technologies/pktmon/pktmon)
