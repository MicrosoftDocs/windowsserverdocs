---
title: pktmon start
description: Reference article for the pktmon start command.
ms.topic: reference
author: khdownie
ms.author: v-kedow
ms.date: 12/31/2020
---

# pktmon start

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Pktmon start starts packet monitoring.

## Syntax

```
pktmon start [-c { all | nics | [ids...] }] [-d] [--etw [-p size] [-k keywords]]
             [-f] [-s] [--log-mode {circular | multi-file | real-time | memory}]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| -c, --components | Select components to monitor. Can be all components, NICs only, or a list of component IDs. Defaults to all. |
| -d, --drop-only | Only report dropped packets. By default, successful packet propagation is reported as well. |
| --etw | Start a logging session for packet capture. |
| -p, --packet-size | Number of bytes to log from each packet. To always log the entire packet, set this to 0. Default is 128 bytes. |
| -k, --keywords | Hexadecimal bitmask (i.e. sum of the below flags) that controls which events are logged. Default is 0x012.

Flags:
0x001 - Internal Packet Monitor errors.
0x002 - Information about components, counters and filters. This information is added to the end of the log file.
0x004 - Source and destination information for the first packet in NET_BUFFER_LIST group.
0x008 - Select packet metadata from NDIS_NET_BUFFER_LIST_INFO enumeration.
0x010 - Raw packet, truncated to the size specified in [--packet-size] parameter. |
| -f, --file-name | .etl log file. Default is PktMon.etl |


## Examples

The following 

```PowerShell
code
```

The following 

```PowerShell
code
```

## Additional References

- [Pktmon](pktmon.md)
- [Pktmon filter](pktmon-filter.md)
- [Pktmon filter add](pktmon-filter-add.md)
- [Packet Monitor overview](/windows-server/networking/technologies/pktmon/pktmon)
