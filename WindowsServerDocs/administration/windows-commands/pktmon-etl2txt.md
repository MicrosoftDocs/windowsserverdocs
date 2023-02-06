---
title: pktmon etl2txt
description: Reference article for the pktmon etl2txt command that provides a listing of parameters and what they do.
ms.topic: reference
author: khdownie
ms.author: wscontent
ms.date: 06/24/2021
---

# pktmon etl2txt

>Applies to: Windows Server 2022, Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Convert ETL log file to text format.

## Syntax

```
pktmon etl2txt <file> [--out <name>] [--stats-only] [--timestamp-only] [--metadata]
                      [--tmfpath <path>] [--brief] [--verbose <n>] [--hex]
                      [--no-ethernet] [--vxlan <port>]
```

Where `<file>` is the ETL file to convert.

### Parameters

| **Parameter** | **Description** |
| ------------- | --------------- |
| **-o, --out \<name\>** | Name of the formatted text file. |
| **-s, --stats-only** | Display log file statistical information. |
| **-t, --timestamp-only** | Use timestamp only prefix for events and packets. |
| **-m, --metadata** | Print event metadata, such as logging level and keywords. |
| **-p, --tmfpath \<path\>** | Path to TMF files for decoding WPP traces. Multiple paths should be separated by semicolons. All WPP traces are skipped when this option is not specified. |

#### Network packet formatting options

| **Parameter** | **Description** |
| ------------- | --------------- |
| **-b, --brief** | Use abbreviated packet format. |
| **-v, --verbose \<n\>** | Verbosity level from 1 to 3. |
| **-x, --hex** | Include hexadecimal format. |
| **-e, --no-ethernet** | Don't print ethernet header. |
| **-l, --vxlan \<port\>** | Custom VXLAN port. |

## Related links

- [Pktmon](pktmon.md)
- [Pktmon counters](pktmon-counters.md)
- [Pktmon etl2pcap](pktmon-etl2pcap.md)
- [Pktmon filter](pktmon-filter.md)
- [Pktmon filter add](pktmon-filter-add.md)
- [Pktmon hex2pkt](pktmon-hex2pkt.md)
- [Pktmon list](pktmon-list.md)
- [Pktmon reset](pktmon-reset.md)
- [Pktmon start](pktmon-start.md)
- [Pktmon status](pktmon-status.md)
- [Pktmon unload](pktmon-unload.md)
- [Packet Monitor overview](/windows-server/networking/technologies/pktmon/pktmon)
