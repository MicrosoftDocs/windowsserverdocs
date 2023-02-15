---
title: pktmon filter add
description: Reference article for the pktmon filter add command.
ms.topic: reference
ms.author: wscontent
author: robinharwood
ms.date: 06/24/2021
---

# pktmon filter add

>Applies to: Windows Server 2022, Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Pktmon filter add allows you to add a filter to control which packets are reported. For a packet to be reported, it must match all conditions specified in at least one filter. Up to 32 filters can be active at once.

## Syntax

```
pktmon filter add <name> [-m <mac> [mac2]] [-v <vlan>] [-d { IPv4 | IPv6 | number }]
                         [-t { TCP [flags...] | UDP | ICMP | ICMPv6 | number }]
                         [-i <ip> [ip2]] [-p <port> [port2]] [-b] [-e [port]]
```

You may provide an optional name or description of the filter.

  > [!NOTE]
  > When two MACs (-m), IPs (-i), or ports (-p) are specified, the filter matches packets that contain both. It will not distinguish between source or destination for this purpose.

### Parameters

You can supply parameters for Ethernet frame, IP header, TCP/UDP header, cluster heartbeat, and encapsulation.

| **Parameter** | **Description** |
| ------------- | --------------- |
| **-m, --mac[-address]** | Match source or destination MAC address. See note above. |
| **-v, --vlan** | Match by VLAN ID (VID) in the 802.1Q header. |
| **-d, --data-link[-protocol], --ethertype** | Match by data link (layer 2) protocol. Can be IPv4, IPv6, ARP, or a protocol number. |
| **-t, --transport[-protocol], --ip-protocol** | Match by transport (layer 4) protocol. Can be TCP, UDP, ICMP, ICMPv6, or a protocol number. To further filter TCP packets, an optional list of TCP flags to match can be provided. Supported flags are FIN, SYN, RST, PSH, ACK, URG, ECE, and CWR. |
| **-i, --ip[-address]** | Match source or destination IP address. See note above. To match by subnet, use CIDR notation with the prefix length. |
| **-p, --port** | Match source or destination port number. See note above. |
| **-b, --heartbeat** | Match RCP heartbeat messages over UDP port 3343. |
| **-e, --encap** | Apply above filtering parameters to both inner and outer encapsulation headers. Supported encapsulation methods are VXLAN, GRE, NVGRE, and IP-in-IP. Custom VXLAN port is optional, and defaults to 4789. |

## Examples

The following set of filters will capture any ICMP traffic from or to the IP address 10.0.0.10 along with any traffic on port 53.

```PowerShell
C:\Test> pktmon filter add -i 10.0.0.10 -t icmp
C:\Test> pktmon filter add -p 53
```

The following filter will capture all the SYN packets sent or received by the IP address 10.0.0.10:

```PowerShell
C:\Test> pktmon filter add -i 10.0.0.10 -t tcp syn
```

The following filter called **MyPing** pings 10.10.10.10 using the ICMP protocol:

```PowerShell
C:\Test> pktmon filter add MyPing -i 10.10.10.10 -t ICMP
```

The following filter called **MySmbSyb** captures TCP synchronized SMB traffic:

```PowerShell
C:\Test> pktmon filter add MySmbSyn -i 10.10.10.10 -t TCP SYN -p 445
```

The following filter called **MySubnet** captures traffic on the subnet mask 255.255.255.0, or /24 in CIDR notation:

```PowerShell
C:\Test> pktmon filter add MySubnet -i 10.10.10.0/24
```

## Other references

- [Pktmon](pktmon.md)
- [Pktmon counters](pktmon-counters.md)
- [Pktmon etl2pcap](pktmon-etl2pcap.md)
- [Pktmon etl2txt](pktmon-etl2txt.md)
- [Pktmon filter](pktmon-filter.md)
- [Pktmon hex2pkt](pktmon-hex2pkt.md)
- [Pktmon list](pktmon-list.md)
- [Pktmon reset](pktmon-reset.md)
- [Pktmon start](pktmon-start.md)
- [Pktmon status](pktmon-status.md)
- [Pktmon unload](pktmon-unload.md)
- [Packet Monitor overview](../../networking/technologies/pktmon/pktmon.md)
