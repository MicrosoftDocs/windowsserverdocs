---
title: Network Ports Used by DNS
description: Learn about network ports used by DNS in Windows Server 
ms.topic: conceptual
author: gswashington
ms.author: nedpyle
ms.date: 12/10/2024

---

# Network Ports Used by DNS

>Applies to: Windows Server 2025, Windows Server 2022, Windows Server 2019, Windows Server 2016

During DNS resolution, DNS messages are sent from DNS clients to DNS servers or between DNS servers. Messages are sent over UDP and DNS servers bind to UDP port 53. When the message length exceeds the default message size for a User Datagram Protocol (UDP) datagram (512 octets), the first response to the message is sent with as much data as the UDP datagram will allow, and then the DNS server sets a flag indicating a truncated response. The message sender can then choose to reissue the request to the DNS server using TCP (over TCP port 53). The benefit of this approach is that it takes advantage of the performance of UDP but also has a backup failover solution for longer queries.

In general, all DNS queries are sent from a high-numbered source port (49152 or above) to destination port 53, and responses are sent from source port 53 to a high-numbered destination port. The following table lists the UDP and TCP ports used for different DNS message types.

> > [!NOTE]
> To comply with Internet Assigned Numbers Authority (IANA) recommendations, The default start port is 49152, and the default end port is 65535. This is a change from the configuration of versions earlier than Windows Server 2008 that used a default port range of 1025 through 5000.

| Traffic Type | Source of Transmission | Source Port | Destination of Transmission | Destination Port |
| -------- | --------- | --------- | --------- | --------- |
| Queries from local DNS server | Local DNS server | A random port numbered 49152 or above | Any remote DNS server | 53 |
| Responses to local DNS server | Any remote DNS server | 53 | Local DNS server | A random port numbered 49152 or above |
| Queries from remote DNS server | Any remote DNS server | A random port numbered 49152 or above | Local DNS server | 53 |
| Responses to remote DNS server | Local DNS server | 53 | Any remote DNS server | A random port numbered 49152 or above |

> [!NOTE]
> Starting in Windows Server 2008 the DNS Server service supports Extension Mechanisms for DNS (EDNS0, as defined in RFC 2671), which allow DNS requestors to advertise the size of their UDP packets and facilitate the transfer of packets larger than 512 bytes. When a DNS server receives a request over UDP, it identifies the requestor’s UDP packet size from the option (OPT) resource record and scales its response to contain as many resource records as are allowed in the maximum UDP packet size specified by the requestor.

Windows Server 2008 DNS support for EDNS0 is enabled by default. It can be disabled using the registry. Locate the following registry subkey:

`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\DNS\Parameters`

Add the entry EnableEDNSProbes to the subkey. Give the entry a DWORD value and set it to 0x0 to disable EDNS0.

Use extreme caution when editing the registry. Modifications to the registry are not validated by the registry editor or by Windows before they are applied, and as a result, incorrect values can be stored. This can result in unrecoverable errors in the system.

## See also

- [What's new in DNS Client](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn305896(v=ws.11))
- [What's new in DNS Server](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn305898(v=ws.11))