---
title: pktmon start
description: Reference article for the pktmon start command that provides a listing of parameters and what they do.
ms.topic: reference
author: khdownie
ms.author: wscontent
ms.date: 06/24/2021
---

# pktmon start

>Applies to: Windows Server 2022, Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Starts packet capture and event collection.

## Syntax

```
pktmon start [--capture [--counters-only] [--comp <selector>] [--type <type>] [--pkt-size <bytes>] [--flags <mask>]]
             [--trace --provider <name> [--keywords <k>] [--level <n>] ...]
             [--file-name <name>] [--file-size <size>] [--log-mode <mode>]
```

### Packet capture parameters

Use **-c** or **--capture** to enable packet capture and packet counters, along with the following optional parameters.

| **Parameter** | **Description** |
| ------------- | --------------- |
| **-o, --counters-only** | Collect packet counters only. No packet logging. |
| **--comp** | Select components to capture packets on. Can be all components (all), NICs only (nics), or a list of component IDs. Defaults to all. |
| **--type** | Select which packets to capture. Can be all, flow, or drop. Default is all. |
| **--pkt-size \<bytes\>** | Number of bytes to log from each packet. To always log the entire packet, set this to 0. Default is 128 bytes. |
| **--flags \<mask\>** | Hexadecimal bitmask that controls information logged during packet capture. Default is 0x012. Packet capture flags, below. |

#### Packet capture flags

The following flags apply to the **--flags** parameter (see above).

| **Flag** | **Description** |
| --------- | ----------- |
| **0x001** | Internal Packet Monitor errors. |
| **0x002** | Information about components, counters, and filters. This information is added to the end of the log file. |
| **0x004** | Source and destination information for the first packet in NET_BUFFER_LIST group. |
| **0x008** | Select packet metadata from NDIS_NET_BUFFER_LIST_INFO enumeration. |
| **0x010** | Raw packet, truncated to the size specified in the [--pkt-size] parameter. |

### Event collection parameters

Use **-t** or **--trace** to enable event collection, along with the following optional parameters.

| **Parameter** | **Description** |
| ------------- | --------------- |
| **-p, --provider \<name\>** | Event provider name or GUID. For multiple providers, use this parameter more than once. |
| **-k, --keywords \<k\>** | Hexadecimal bitmask that controls which events are logged for the corresponding provider. Default is 0xFFFFFFFF. |
| **-l, --level \<n\>** | Logging level for the corresponding provider. Default is 4 (info level). |

### Logging parameters

Use the following parameters for logging:

| **Parameter** | **Description** |
| ------------- | --------------- |
| **-f, --file-name \<name\>** | Log file name. Default is PktMon.etl. |
| **-s, --file-size \<size\>** | Maximum log file size in megabytes. Default is 512 MB. |
| **-m, --log-mode** | Sets the logging mode (see below). Default is circular. |

#### Logging modes

The following modes apply to the **-m** or **--log-mode** parameter (see above).

| **Mode** | **Description** |
| -------- | --------------- |
| **circular** | New events overwrite the oldest ones when the log is full. |
| **multi-file** | A new log file is created each time the log is full. Log files are sequentially numbered: PktMon1.etl, PktMon2.etl, etc. No limited on the number of captured events. |
| **real-time** | Display events and packets on screen at real time. No log file is created. Press **Ctrl+C** to stop monitoring. |
| **memory** | Like circular, but the entire log is stored in memory. It is written to a file when pktmon is stopped. Memory buffer size is specified in [--file-size] parameter. |

## Examples

**Example 1: Packet capture**

```PowerShell
C:\Test> pktmon start --capture
```

**Example 2: Packet counters only**

```PowerShell
C:\Test> pktmon start --capture --counters-only
```

**Example 3: Event logging**

```PowerShell
C:\Test> pktmon start --trace -p Microsoft-Windows-TCPIP -p Microsoft-Windows-NDIS
```

**Example 4: Packet capture with event logging**

```PowerShell
C:\Test> pktmon start --capture --trace -p Microsoft-Windows-TCPIP -k 0xFF -l 4
```

## Related links

- [Pktmon](pktmon.md)
- [Pktmon counters](pktmon-counters.md)
- [Pktmon etl2pcap](pktmon-etl2pcap.md)
- [Pktmon etl2txt](pktmon-etl2txt.md)
- [Pktmon filter](pktmon-filter.md)
- [Pktmon filter add](pktmon-filter-add.md)
- [Pktmon hex2pkt](pktmon-hex2pkt.md)
- [Pktmon list](pktmon-list.md)
- [Pktmon reset](pktmon-reset.md)
- [Pktmon status](pktmon-status.md)
- [Pktmon unload](pktmon-unload.md)
- [Packet Monitor overview](../../networking/technologies/pktmon/pktmon.md)
