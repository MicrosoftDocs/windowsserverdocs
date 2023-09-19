---
title: pktmon etl2pcap
description: Reference article for the pktmon etl2pcap command that provides a listing of parameters and what they do.
ms.topic: reference
author: khdownie
ms.author: wscontent
ms.date: 06/24/2021
---

# pktmon etl2pcap

>Applies to: Windows Server 2022, Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Convert pktmon log file to pcapng format. Dropped packets are not included by default. These logs can be analyzed using Wireshark (or any pcapng analyzer).

## Syntax

```
pktmon etl2pcap <file> [--out <name>] [--drop-only] [--component-id <id>]
```

Where `<file>` is the ETL file to convert.

### Parameters

| **Parameter** | **Description** |
| ------------- | --------------- |
| **-o, --out \<name\>** | Name of the formatted pcapng file. |
| **-d, --drop-only** | Convert dropped packets only. |
| **-c, --component-id \<id\>** | Filter packets by a specific component ID. |

### Output filtering

All information about the packet drop reports and packet flow through the networking stack is lost in pcapng format output. Log contents should be carefully prefiltered to show the complete conversion. For example:

- Pcapng format doesn't distinguish between a flowing packet and a dropped packet. To separate all the packets in the capture from dropped packets, generate two pcapng files; one that contains all the packets (`pktmon etl2pcap log.etl --out log-capture.etl`), and another that contains only dropped packets (`pktmon etl2pcap log.etl  --drop-only --out log-drop.etl`). This way you're able to analyze the dropped packets in a separate log.
- Pcapng format doesn't distinguish between different networking components where a packet was captured. For such multilayered scenarios, specify the desired component ID in the pcapng output `pktmon etl2pcap log.etl --component-id 5`. Repeat this command for each set of component IDs that you're interested in.

## Related links

- [Pktmon](pktmon.md)
- [Pktmon counters](pktmon-counters.md)
- [Pktmon etl2txt](pktmon-etl2txt.md)
- [Pktmon filter](pktmon-filter.md)
- [Pktmon filter add](pktmon-filter-add.md)
- [Pktmon hex2pkt](pktmon-hex2pkt.md)
- [Pktmon list](pktmon-list.md)
- [Pktmon reset](pktmon-reset.md)
- [Pktmon start](pktmon-start.md)
- [Pktmon status](pktmon-status.md)
- [Pktmon unload](pktmon-unload.md)
- [Packet Monitor overview](/windows-server/networking/technologies/pktmon/pktmon)
