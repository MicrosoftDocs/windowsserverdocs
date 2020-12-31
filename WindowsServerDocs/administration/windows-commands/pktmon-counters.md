---
title: pktmon counters
description: Reference article for the pktmon counters command.
ms.topic: reference
author: khdownie
ms.author: v-kedow
ms.date: 12/31/2020
---

# pktmon counters

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Pktmon counters allows you to query and display current per-component counters to confirm the presence of expected traffic and get a high-level view of how the traffic flowed in the machine.

## Syntax

```
pktmon [comp] counters [-t { all | drop | flow }] [-z] [--json]
```

### Parameters

| **Parameter** | **Description** |
| ------------- | --------------- |
| **-t, --counter-type** | Select which types of counters to show. Supported values are all counters (default), drops only, or flows only. |
| **-z, --show-zeros** | Show counters that are zero in both directions. |
| **-i, --show-hidden** | Show components that are hidden by default. |
| **--json** | Output the counters in JSON format. |

## Additional References

- [Pktmon](pktmon.md)
- [Pktmon comp](pktmon-comp.md)
- [Pktmon filter](pktmon-filter.md)
- [Pktmon filter add](pktmon-filter-add.md)
- [Pktmon format](pktmon-format.md)
- [Pktmon list](pktmon-list.md)
- [Pktmon pcapng](pktmon-pcapng.md)
- [Pktmon reset](pktmon-reset.md)
- [Pktmon start](pktmon-start.md)
- [Pktmon unload](pktmon-unload.md)
- [Packet Monitor overview](/windows-server/networking/technologies/pktmon/pktmon)
