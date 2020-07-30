---
title: Converged Network Interface Card (NIC) configuration guidance
description: Converged network interface card (NIC) allows you to expose RDMA through a host-partition virtual NIC (vNIC) so that the host partition services can access Remote Direct Memory Access (RDMA) on the same NICs that the Hyper-V guests are using for TCP/IP traffic.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: d7642338-9b33-4dce-8100-8b2c38d7127a
manager: dougkim
ms.author: lizross
author: eross-msft
ms.date: 09/13/2018
---

# Converged Network Interface Card \(NIC\) configuration guidance

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

Converged network interface card \(NIC\) allows you to expose RDMA through a host\-partition virtual NIC \(vNIC\) so that the host partition services can access Remote Direct Memory Access \(RDMA\) on the same NICs that the Hyper-V guests are using for TCP/IP traffic.

Before the Converged NIC feature, management \(host partition\) services that wanted to use RDMA were required to use dedicated RDMA\-capable NICs, even if bandwidth was available on the NICs that were bound to the Hyper-V Virtual Switch.

With Converged NIC, the two workloads \(management users of RDMA and Guest traffic\) can share the same physical NICs, allowing you to install fewer NICs in your servers.

When you deploy Converged NIC with Windows Server 2016 Hyper-V hosts and Hyper-V Virtual Switches, the vNICs in the Hyper-V hosts expose RDMA services to host processes using RDMA over any Ethernet\-based RDMA technology.

>[!NOTE]
>To use Converged NIC technology, the certified network adapters in your servers must support RDMA.

This guide provides two sets of instructions, one for deployments where your servers have a single network adapter installed, which is a basic deployment of Converged NIC; and another set of instructions where your servers have two or more network adapters installed, which is a deployment of Converged NIC over a Switch Embedded Teaming \(SET\) team of RDMA\-capable network adapters.


## Prerequisites

Following are the prerequisites for the Basic and Datacenter deployments of Converged NIC.

>[!NOTE]
>For the examples provided, we use a Mellanox ConnectX-3 Pro 40 Gbps Ethernet Adapter, but you can use any of the Windows Server certified RDMA\-capable network adapters that support this feature. For more information about compatible network adapters, see the Windows Server Catalog topic [LAN Cards](https://www.windowsservercatalog.com/results.aspx?&bCatID=1468&cpID=0&avc=85&ava=0&avt=0&avq=46&OR=1).

### Basic Converged NIC prerequisites

To perform the steps in this guide for basic Converged NIC configuration, you must have the following.

- Two servers that run Windows Server 2016 Datacenter edition or Windows Server 2016 Standard edition.
- One RDMA-capable, certified network adapter installed on each server.
- Hyper-V server role installed on each server.

### Datacenter Converged NIC prerequisites

To perform the steps in this guide for datacenter Converged NIC configuration, you must have the following.

- Two servers that run Windows Server 2016 Datacenter edition or Windows Server 2016 Standard edition.
- Two RDMA-capable, certified network adapters installed on each server.
- Hyper-V server role installed on each server.
- You must be familiar with Switch Embedded Teaming \(SET\), an alternative NIC Teaming solution used in environments that include Hyper-V and the Software Defined Networking (SDN) stack in Windows Server 2016. SET integrates some NIC Teaming functionality into the Hyper-V Virtual Switch. For more information, see [Remote Direct Memory Access (RDMA) and Switch Embedded Teaming (SET)](../../../virtualization/hyper-v-virtual-switch/RDMA-and-Switch-Embedded-Teaming.md).

## Related topics
- [Converged NIC Configuration with a Single Network Adapter](cnic-single.md)
- [Converged NIC Teamed NIC Configuration](cnic-datacenter.md)
- [Physical Switch Configuration for Converged NIC](cnic-app-switch-config.md)
- [Troubleshooting Converged NIC Configurations](cnic-app-troubleshoot.md)

---