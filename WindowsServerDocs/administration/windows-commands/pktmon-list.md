---
title: pktmon list
description: Reference article for the pktmon list command.
ms.topic: reference
author: khdownie
ms.author: v-kedow
ms.date: 06/17/2021
---

# pktmon list

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Lists all active networking components that can be monitored, allowing you to examine the networking stack layout. The command shows networking components (drivers) arranged by adapters bindings.

## Syntax

```
pktmon list [--all] [--include-hidden] [--json]
```

### Parameters

| **Parameter** | **Description** |
| ------------- | --------------- |
| **-a, --all** | Show all component types. Only network adapters are displayed by default. |
| **-i, --include-hidden** | Show components that are hidden by default. |
| **--json** | Output the list in JSON format. Implies -i and -a. |

## Additional References

- [Pktmon](pktmon.md)
- [Pktmon counters](pktmon-counters.md)
- [Pktmon filter](pktmon-filter.md)
- [Pktmon filter add](pktmon-filter-add.md)
- [Pktmon format](pktmon-format.md)
- [Pktmon pcapng](pktmon-pcapng.md)
- [Pktmon reset](pktmon-reset.md)
- [Pktmon start](pktmon-start.md)
- [Pktmon unload](pktmon-unload.md)
- [Packet Monitor overview](../../networking/technologies/pktmon/pktmon.md)