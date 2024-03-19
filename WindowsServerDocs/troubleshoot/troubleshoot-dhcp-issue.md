---
title: Troubleshooting guide for Dynamic Host Configuration Protocol (DHCP)
description: This article introduces a troubleshooting guide for DHCP issues.
manager: dcscontentpm
ms.date: 5/26/2020
ms.topic: troubleshooting
author: Deland-Han
ms.author: delhan
---
# Troubleshooting guide for Dynamic Host Configuration Protocol (DHCP)

For any device (such as a computer or phone) to be able to operate in a network, it must be assigned an IP address. You can assign an IP address manually or automatically. The automatic assignment is handled by the DHCP service (Microsoft or third-party server).

In this article, we will discuss general troubleshooting steps for the Microsoft IPv4 DHCP client and server.

## More information

The procedure for IPv4 address assignment usually involves three main components:

- A DHCP client device that has to obtain an IP address

- A DHCP service that provides IP addresses to the client based on specific settings

- A DHCP relay agent /IP Helper to send DHCP broadcast requests to a different network segment

A DHCP client-to-server communication consists of three kinds of interaction between the two peers:

- **Broadcast-based DORA** (Discover, Offer, Request, Acknowledgement). This process consists of the following steps:

    - The DHCP client sends a DHCP Discover broadcast request to all available DHCP servers within range.

    - A DHCP Offer broadcast response is received from the DHCP server, offering an available IP address lease.

    - The DHCP client broadcast Request asks for the offered IP address lease and the DHCP broadcast Acknowledgement at the end.

    - If the DHCP client and server are located in different logical network segments, a DHCP relay agent acts a forwarder, sending the DHCP broadcast packets back and forth between peers.

- **Unicast DHCP Renew requests**: These are sent directly to the DHCP server from the DHCP client to renew the IP address assignment after 50 percent of the IP address lease time.

- **Rebind DHCP broadcast requests**: These are made to any DHCP server within range of the client. These are sent after 87.5 percent of the IP address lease duration because this indicates that the directed unicast request didn’t work. As for the DORA process, this process involves a DHCP relay agent communication.

If a Microsoft DHCP client does not receive a valid DHCP IPv4 address, the client is likely configured to use an APIPA address. For more information, see the following Knowledge Base article:
[220874](https://support.microsoft.com/help/220874) How to use automatic TCP/IP addressing without a DHCP server

All communication is done on UDP ports 67 and 68. For more information,
see the following Knowledge Base article:
[169289](https://support.microsoft.com/help/169289) DHCP (Dynamic Host Configuration Protocol) Basics.
