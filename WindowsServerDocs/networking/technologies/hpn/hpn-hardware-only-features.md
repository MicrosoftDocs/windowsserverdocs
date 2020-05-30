---
title: High-performance networking
description: This topic provides an overview of the Offload and Optimization Technologies in Windows Server 2016, and includes links to additional guidance about these technologies.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 0cafb1cc-5798-42f5-89b6-3ffe7ac024ba
manager: dougkim
ms.author: lizross 
author: eross-msft
ms.date: 09/12/2018 
---


# Hardware Only (HO) features and technologies

These hardware accelerations improve networking performance in conjunction with the software but are not intimately part of any software feature. Examples of these include Interrupt Moderation, Flow Control, and Receive-side IPv4 Checksum Offload.

>[!TIP]
>SH and HO features are available if the installed NIC supports it. The feature descriptions below will cover how to tell if your NIC supports the feature.

## Address Checksum Offload

Address checksum offloads are a NIC feature that offloads the calculation of address checksums (IP, TCP, UDP) to the NIC hardware for both send and receive.

On the receive path, the checksum offload calculates the checksums in the IP, TCP, and UDP headers (as appropriate) and indicates to the OS whether the checksums passed, failed, or not checked. If the NIC asserts that the checksums are valid, the OS accepts the packet unchallenged. If the NIC asserts the checksums are invalid or not checked, the IP/TCP/UDP stack internally calculates the checksums again. If the computed checksum fails, the packet gets discarded.

On the send path, the checksum offload calculates and inserts the checksums into the IP, TCP, or UDP header as appropriate.

Disabling checksum offloads on the send path does not disable checksum calculation and insertion for packets sent to the miniport driver using the Large Send Offload (LSO) feature.  To disable all checksum offload calculations, the user must also disable LSO.

_**Manage Address Checksum Offloads**_

In the Advanced Properties there are several distinct properties:

-   IPv4 Checksum Offload

-   TCP Checksum Offload (IPv4)

-   TCP Checksum Offload (IPv6)

-   UDP Checksum Offload (IPv4)

-   UDP Checksum Offload (IPv6)

By default, these are all always enabled. We recommend always enabling all of these offloads.

The Checksum Offloads can be managed using the Enable-NetAdapterChecksumOffload and Disable-NetAdapterChecksumOffload cmdlets. For example, the following cmdlet enables the TCP (IPv4) and UDP (IPv4) checksum calculations:

```PowerShell
Enable-NetAdapterChecksumOffload –Name * -TcpIPv4 -UdpIPv4
```

_**Tips on using Address Checksum Offloads**_

Address Checksum Offloads should ALWAYS be enabled no matter what workload or circumstance. This most basic of all offload technologies always improve your network performance. Checksum offloading is also required for other stateless offloads to work including receive side scaling (RSS), receive segment coalescing (RSC), and large send offload (LSO).

## Interrupt Moderation (IM)

IM buffers multiple received packets before interrupting the operating system. When a NIC receives a packet, it starts a timer. When the buffer is full, or the timer expires, whichever comes first, the NIC interrupts the operating system. 

Many NICs support more than just on/off for Interrupt Moderation. Most NICs support the concepts of a low, medium, and high rate for IM. The different rates represent shorter or longer timers and appropriate buffer size adjustments to reduce latency (low interrupt moderation) or reduce interrupts (high interrupt moderation).

There is a balance to be struck between reducing interrupts and excessively delaying packet delivery. Generally, packet processing is more efficient with Interrupt Moderation enabled. High performance or low latency applications may need to evaluate the impact of disabling or reducing Interrupt Moderation.

## Jumbo frames

Jumbo frames is a NIC and network feature that allows an application to send frames that are much larger than the default 1500 bytes. Typically the limit on jumbo frames is about 9000 bytes but may be smaller.

There were no changes to jumbo frame support in Windows Server 2012 R2.

In Windows Server 2016 there is a new offload: MTU_for_HNV. This new offload works with Jumbo Frame settings to ensure encapsulated traffic doesn't require segmentation between the host and the adjacent switch. This new feature of the SDN stack has the NIC automatically calculate what MTU to advertise and what MTU to use on the wire. These values for MTU are different if any HNV offload is in use. (In the feature compatibility table, Table 1, MTU_for_HNV would have the same interactions as the HNVv2 offloads have since it is directly related to the HNVv2 offloads.)

## Large Send Offload (LSO)

LSO allows an application to pass a large block of data to the NIC, and the NIC breaks the data into packets that fit within the Maximum Transfer Unit (MTU) of the network.

## Receive Segment Coalescing (RSC)

Receive Segment Coalescing, also known as Large Receive Offload, is a NIC feature that takes packets that are part of the same stream that arrives between network interrupts and coalesces them into a single packet before delivering them to the operating system. RSC is not available on NICs that are bound to the Hyper-V Virtual Switch. For more information, see [Receive Segment Coalescing (RSC)](https://docs.microsoft.com/windows-server/networking/technologies/hpn/rsc-in-the-vswitch).