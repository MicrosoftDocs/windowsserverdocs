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

Starts packet monitoring.

## Syntax

```
pktmon start [-c { all | nics | [ids...] }] [-d] [--etw [-p size] [-k keywords]]
             [-f] [-s] [--log-mode {circular | multi-file | real-time | memory}]
```

### Parameters

| **Parameter** | **Description** |
| ------------- | --------------- |
| **-c, --components** | Select components to monitor. Can be all components, NICs only, or a list of component IDs. Defaults to all. |
| **-d, --drop-only** | Only report dropped packets. By default, successful packet propagation is reported as well. |
| **--etw** | Start a logging session for packet capture. |
| **-p, --packet-size** | Number of bytes to log from each packet. To always log the entire packet, set this to 0. Default is 128 bytes. |
| **-k, --keywords** | Hexadecimal bitmask (i.e. sum of the below flags) that controls which events are logged. Default is 0x012. See Keyword flags, below. |
| **-f, --file-name** | .etl log file. Default is PktMon.etl |
| **-s, --file-size** | Maximum log file size in megabytes. Default is 512 MB. |
| **-l, --log-mode** | Select logging mode. Default is circular. See Logging modes, below. |

### Keyword flags

The following flags apply to the **-k** or **--keywords** parameter (see above).

| **Flag** | **Description** |
| --------- | ----------- |
| **0x001** | Internal Packet Monitor errors.
| **0x002** | Information about components, counters and filters. This information is added to the end of the log file.
| **0x004** | Source and destination information for the first packet in NET_BUFFER_LIST group.
| **0x008** | Select packet metadata from NDIS_NET_BUFFER_LIST_INFO enumeration.
| **0x010** | Raw packet, truncated to the size specified in the [--packet-size] parameter.

### Logging modes

The logging mode is set using the **-l** or **--log-mode** parameter (see above).

| **Mode** | **Description** |
| -------- | --------------- |
| **circular** | New events overwrite the oldest ones when the maximum file size is reached. |
| **multi-file** | A new log file is created when the maximum file size is reached. Log files are sequentially numbered: PktMon1.etl, PktMon2.etl, etc. |
| **real-time** | Display events and packets on screen at real time. No log file is created. Press **Ctrl+C** to stop monitoring. |
| **memory** | Events are written to a circular memory buffer. Buffer size is specified in [--file-size] parameter. Buffer contents are written to a log file during stop operation. |

## Examples

The following command starts the capture and enables packet logging:

```PowerShell
C:\Test> pktmon start --etw
```

The following command starts the capture, enables packet logging, and selects the real-time logging mode:

```PowerShell
C:\Test> pktmon start --etw -l real-time
```

The following command will capture packet counters of all the network adapters without logging packets:

```PowerShell
C:\Test> pktmon start -c nics
```

The following command will capture only the dropped packets that pass through components 4 and 5, and log them:

```PowerShell
C:\Test> pktmon start --etw -c 4,5 -d
```

## Additional References

- [Pktmon](pktmon.md)
- [Pktmon comp](pktmon-comp.md)
- [Pktmon counters](pktmon-counters.md)
- [Pktmon filter](pktmon-filter.md)
- [Pktmon filter add](pktmon-filter-add.md)
- [Pktmon format](pktmon-format.md)
- [Pktmon list](pktmon-list.md)
- [Pktmon pcapng](pktmon-pcapng.md)
- [Pktmon reset](pktmon-reset.md)
- [Pktmon unload](pktmon-unload.md)
- [Packet Monitor overview](/windows-server/networking/technologies/pktmon/pktmon)
