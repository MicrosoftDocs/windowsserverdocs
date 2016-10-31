---
title: Using NIC Teaming for Network Subsystem Performance
description: Using NIC Teaming for Network Subsystem Performance
---

# Using NIC Teaming for Network Subsystem Performance


NIC teaming, also known as load balancing and failover (LBFO), allows multiple network adapters on a computer to be placed into a team for the following purposes:

-   Bandwidth aggregation

-   Traffic failover to prevent connectivity loss in the event of a network component failure

This feature has been a requirement for independent hardware vendors (IHVs) to enter the server network adapter market. However, NIC teaming was not included in the operating system until Windows Server 2012.

**In this topic:**

-   [NIC teaming configuration](#config)

-   [Algorithms for load distribution](#algorithms)

-   [Compatibility](#compat)

## <a href="" id="config"></a>NIC teaming configuration


There are two basic configurations for NIC teaming.

-   **Switch-independent teaming** This configuration does not require the switch to participate in the teaming. Since in switch-independent mode the switch does not know that the network adapter is part of a team in the host, the adapters may be connected to different switches. Switch independent modes of operation do not require that the team members connect to different switches; they merely make it possible.

-   **Switch-dependent teaming** This configuration requires the switch to participate in the teaming. Switch dependent teaming requires all the members of the team to be connected to the same physical switch.

## <a href="" id="algorithms"></a>Algorithms for load distribution


Outbound traffic can be distributed among the available links in many ways. One rule that guides any distribution algorithm is to try to keep all packets associated with a single flow (TCP-stream) on a single network adapter. This rule minimizes performance degradation caused by reassembling out-of-order TCP segments.

NIC teaming in Windows Server 2012 R2 supports the following traffic load distribution algorithms:

-   **Hyper-V switch port** Since virtual machines have independent MAC addresses, the virtual machine’s MAC address or the port it’s connected to on the Hyper-V switch can be the basis for dividing traffic.

-   **Address Hashing** This algorithm creates a hash based on address components of the packet and then assigns packets that have that hash value to one of the available adapters. Usually this mechanism alone is sufficient to create a reasonable balance across the available adapters.

-   **Dynamic** This algorithm takes the best aspects of each of the other two modes and combines them into a single mode. Outbound loads are distributed based on a hash of the TCP ports and IP addresses. Dynamic mode also rebalances loads in real time so that a given outbound flow may move back and forth between team members. Inbound loads are distributed as though the Hyper-V port mode was in use. Dynamic mode was added in Windows Server 2012 R2.

## <a href="" id="compat"></a>Compatibility


NIC teaming is compatible with all networking capabilities included in Windows Server 2012 R2 with five exceptions: SR-IOV, RDMA, Native host Quality of Service, TCP Chimney, and 802.1X Authentication.

NIC teaming configuration details and Windows PowerShell commands can be found in the [Windows Server 2012 R2 NIC Teaming (LBFO) Deployment and Management](http://www.microsoft.com/download/details.aspx?id=40319) guide.
