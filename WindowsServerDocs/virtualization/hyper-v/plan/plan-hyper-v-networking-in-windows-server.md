---
title: Plan for Hyper-V networking in Windows Server
description: Describes what's needed for basic networking in Windows Server Hyper-V and gives links to instructions.
ms.topic: concept-article
ms.author: daknappe
author: dknappettmsft
ms.date: 01/21/2026
---
# Plan for Hyper-V networking in Windows Server

This article covers what you need for basic networking in Hyper-V, including considerations for live migration and other server features.

## Hyper-V networking basics

Hyper-V networking uses a virtual switch and a virtual network adapter. The virtual switch connects to an Ethernet-based network, and the virtual network adapter connects to a port on the virtual switch, enabling a virtual machine to use the network. When you create a virtual machine and connect the virtual machine to a virtual switch, a virtual network adapter is automatically added. All virtual switches are part of the Hyper-V host, but each virtual network adapter belongs to only one virtual machine. For instructions, see [Create a virtual switch for Hyper-V virtual machines](../get-started/Create-a-virtual-switch-for-Hyper-V-virtual-machines.md).

The virtual switch is a software-based layer-2 Ethernet network switch. The virtual switch provides built-in features for monitoring, controlling, and segmenting traffic, as well as security, and diagnostics. You can add to the set of built-in features by installing plug-ins, also called *extensions*. Extensions are available from independent software vendors. For more information about the switch and extensions, see [Hyper-V Virtual Switch](../../hyper-v/virtual-switch.md).

### Switch and network adapter choices

Hyper-V offers three types of virtual switches and two types of virtual network adapters. You choose the type when you create the switch or adapter. You can use Hyper-V Manager or the Hyper-V module for Windows PowerShell to create and manage virtual switches and virtual network adapters. Some advanced networking capabilities, such as extended port access control lists (ACLs), can only be managed by using cmdlets in the Hyper-V module.

You can change an existing virtual switch to a different type after creation, but changing the virtual switch type affects the networking capabilities of all connected virtual machines. You can connect a virtual network adapter to a different virtual switch, but you can't change a virtual network adapter from one type to another; instead, add another virtual network adapter and choose the appropriate type.

Virtual switch types are:

- **External virtual switch** - Connects to a wired, physical network by binding to a physical network adapter.

- **Internal virtual switch** - Connects to a network that can be used only by the virtual machines running on the host that has the virtual switch, and between the host and the virtual machines.

- **Private virtual switch** - Connects to a network that can be used only by the virtual machines running on the host that has the virtual switch, but doesn't provide networking between the host and the virtual machines.

Virtual switch options:

| Setting name | Description |
|---|---|
| Allow management operating system to share this network adapter | Allow the Hyper-V host to share the use of the virtual switch and NIC or NIC team with the virtual machine. With this enabled, the host can use any of the settings that you configure for the virtual switch, such as Quality of Service (QoS) settings, security settings, or other features of the Hyper-V virtual switch. |
| Enable single-root I/O virtualization (SR-IOV) | Allow virtual machine traffic to bypass the virtual machine switch and go directly to the physical NIC. SR-IOV is only available for virtual machines running a [supported Windows Server guest](../Supported-Windows-guest-operating-systems-for-Hyper-V-on-Windows.md). For more information, see [Single-Root I/O Virtualization](/windows-hardware/drivers/network/overview-of-single-root-i-o-virtualization--sr-iov-). |

Virtual network adapter types:

| Adapter type | Key constraints and when to use |
|---|---|
| **Network adapter** (Hyper-V specific network adapter) | Available for generation 1 and generation 2 VMs. Requires a driver included in Hyper-V integration services, provided only for [supported guest operating systems](../Supported-Windows-guest-operating-systems-for-Hyper-V-on-Windows.md). Faster performance; recommended unless you need network boot or are running an unsupported guest OS. |
| **Legacy network adapter** | Generation 1 VMs only; not available for generation 2 VMs. Emulates an Intel 21140-based PCI Fast Ethernet Adapter. Use when you need to boot to a network to install an operating system (for example, via Windows Deployment Services). |

## Hyper-V networking and related technologies

Some features rely on specific networking configurations or perform better under certain configurations.

**Failover clustering** - It's a best practice to isolate cluster traffic and use Hyper-V Quality of Service (QoS) on the virtual switch.

**Live migration** - Use performance options to reduce network and CPU usage and the time it takes to complete a live migration. For instructions, see [Set up hosts for live migration without Failover Clustering](../deploy/set-up-hosts-for-live-migration-without-failover-clustering.md).

**Storage Spaces Direct** - Storage Spaces Direct relies on the SMB3.0 network protocol and RDMA. For details, see [Storage Spaces Direct overview](/azure/azure-local/concepts/storage-spaces-direct-overview?context=/windows-server/context/windows-server-storage).
