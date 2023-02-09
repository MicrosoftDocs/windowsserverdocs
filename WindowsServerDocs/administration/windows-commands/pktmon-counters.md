---
title: pktmon counters
description: Reference article for the pktmon counters command that provides a listing of parameters and what they do.
ms.topic: reference
author: khdownie
ms.author: wscontent
ms.date: 06/24/2021
---

# pktmon counters

>Applies to: Windows Server 2022, Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Pktmon counters allows you to query and display current packet counters from monitored components to confirm the presence of expected traffic and get a high-level view of how the traffic flowed in the machine.

## Syntax

```
pktmon counters [--type { all | flow | drop }] [--include-hidden] [--zero] [--drop-reason] [--live] [--refresh-rate <n>] [--json]
```

### Parameters

| **Parameter** | **Description** |
| ------------- | --------------- |
| **-t, --type** | Select which types of counters to show. Supported values are **all** counters (default), **flow** (flows only), or **drop** (drops only). |
| **-z, --zero** | Show counters that are zero in both directions. |
| **-i, --include-hidden** | Show counters from components that are hidden by default. |
| **-r, --drop-reason** | Show the most recent drop reason for each drop counter. |
| **--live** | Automatically refresh the counters. Press **Ctrl+C** to stop. |
| **--refresh-rate \<n\>** | Number of times to refresh the counters per second, from 1 to 30. Default is 10. |
| **--json** | Output the counters in JSON format. Implies -i and -r. |

## Related links

- [Pktmon](pktmon.md)
- [Pktmon etl2pcap](pktmon-etl2pcap.md)
- [Pktmon etl2txt](pktmon-etl2txt.md)
- [Pktmon filter](pktmon-filter.md)
- [Pktmon filter add](pktmon-filter-add.md)
- [Pktmon hex2pkt](pktmon-hex2pkt.md)
- [Pktmon list](pktmon-list.md)
- [Pktmon reset](pktmon-reset.md)
- [Pktmon start](pktmon-start.md)
- [Pktmon status](pktmon-status.md)
- [Pktmon unload](pktmon-unload.md)
- [Packet Monitor overview](../../networking/technologies/pktmon/pktmon.md)
