---
title: Pktmon support for Wireshark (pcapng)
description: Describes how to convert Pktmon logs to pcapng format for analysis in Wireshark or any other pcapng analyzer.
ms.topic: how-to
author: khdownie
ms.author: wscontent
ms.date: 04/01/2023
---

# Pktmon support for Wireshark (pcapng)

Applies to: Windows Server 2022, Windows Server 2019, Windows 10, Azure Stack Hub, Azure, Azure Stack HCI, versions 21H2 and 20H2

Packet Monitor (Pktmon) can convert logs to pcapng format. These logs can be analyzed using Wireshark (or any pcapng analyzer). However, some of the critical information could be missing in pcapng files. This article explains the expected output of pcapng files and how to take advantage of it.

## Pktmon pcapng syntax

Use the following commands to convert the pktmon capture to pcapng format.

```powershell
C:\Test> pktmon pcapng help
pktmon pcapng log.etl [-o log.pcapng]
    Convert log file to pcapng format.
    Dropped packets aren't included by default.

-o, --out
    Name of the formatted pcapng file.

-d, --drop-only
    Convert dropped packets only.

-c, --component-id
    Filter packets by a specific component ID.

Example: pktmon pcapng C:\tmp\PktMon.etl -d -c nics
```

## Output filtering

All information about the packet drop reports and packet flow through the networking stack is lost in pcapng format output. Log contents should be carefully prefiltered for conversion. For example:

- Pcapng format doesn't distinguish between a flowing packet and a dropped packet. To separate all the packets in the capture from dropped packets, generate two pcapng files; one that contains all the packets ("`pktmon pcapng log.etl --out log-capture.etl`"), and another that contains only dropped packets ("`pktmon pcapng log.etl  --drop-only --out log-drop.etl`"). This way you're able to analyze the dropped packets in a separate log.
- Pcapng format doesn't distinguish between different networking components where a packet was captured. For such multilayered scenarios, specify the desired component ID in the pcapng output "`pktmon pcapng log.etl --component-id 5`". Repeat this command for each set of component IDs that you're interested in.