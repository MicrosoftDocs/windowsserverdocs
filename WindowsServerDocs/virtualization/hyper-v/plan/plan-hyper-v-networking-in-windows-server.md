---
title: Plan for Hyper-V networking in Windows Server
description: Describes what's needed for basic networking in Windows Server Hyper-V and gives links to instructions.
ms.topic: article
ms.author: mosagie
author: meaghanlewis
ms.date: 02/19/2025
---
# Plan for Hyper-V networking in Windows Server

A basic understanding of networking in Hyper-V helps you plan networking for virtual machines. This article also covers some networking considerations when using live migration and when using Hyper-V with other server features and roles.

## Hyper-V networking basics

Basic networking in Hyper-V is fairly simple. It uses two parts - a virtual switch and a virtual networking adapter. You'll need at least one of each to establish networking for a virtual machine. The virtual switch connects to any Ethernet-based network. The virtual network adapter connects to a port on the virtual switch, which makes it possible for a virtual machine to use a network.

The easiest way to establish basic networking is to create a virtual switch when you install Hyper-V. Then, when you create a virtual machine, you can  connect it to the switch. Connecting to the switch automatically adds a virtual network adapter to the virtual machine. For instructions, see [Create a virtual switch for Hyper-V virtual machines](../get-started/Create-a-virtual-switch-for-Hyper-V-virtual-machines.md).

To handle different types of networking, you can add virtual switches and virtual network adapters. All switches are part of the Hyper-V host, but each virtual network adapter belongs to only one virtual machine.

The virtual switch is a software-based layer-2 Ethernet network switch. It provides built-in features for monitoring, controlling, and segmenting traffic, as well as security, and diagnostics. You can add to the set of built-in features by installing plug-ins, also called *extensions*. These are available from independent software vendors. For more information about the switch and extensions, see [Hyper-V Virtual Switch](../../hyper-v/virtual-switch.md).

### Switch and network adapter choices

Hyper-V offers three types of virtual switches and two types of virtual network adapters. You'll choose which one of each you want when you create it. You can use Hyper-V Manager or the Hyper-V module for Windows PowerShell to create and manage virtual switches and virtual network adapters. Some advanced networking capabilities, such as extended port access control lists (ACLs), can only be managed by using cmdlets in the Hyper-V module.

You can make some changes to a virtual switch or virtual network adapter after you create it. For example, it's possible to change an existing switch to a different type, but doing that affects the networking capabilities of all the virtual machines connected to that switch.  So, you probably won't do this unless you made a mistake or need to test something. As another example, you can connect a virtual network adapter to a different switch, which you might do if you want to connect to a different network. But, you can't change a virtual network adapter from one type to another. Instead of changing the type, you'd add another virtual network adapter and choose the appropriate type.

Virtual switch types are:

- **External virtual switch** - Connects to a wired, physical network by binding to a physical network adapter.

- **Internal virtual switch** - Connects to a network that can be used only by the virtual machines running on the host that has the virtual switch, and between the host and the virtual machines.

- **Private virtual switch** - Connects to a network that can be used only by the virtual machines running on the host that has the virtual switch, but doesn't provide networking between the host and the virtual machines.

Virtual switch options:

| Setting name | Description |
|---|---|
| Allow management operating system to share this network adapter | Allow the Hyper-V host to share the use of the virtual switch and NIC or NIC team with the virtual machine. With this enabled, the host can use any of the settings that you configure for the virtual switch, such as Quality of Service (QoS) settings, security settings, or other features of the Hyper-V virtual switch. |
| Enable single-root I/O virtualization (SR-IOV) | Allow virtual machine traffic to bypass the virtual machine switch and go directly to the physical NIC. SR-IOV is only available for virtual machines running Windows Server. For more information, see [Single-Root I/O Virtualization](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn641211(v=ws.11)#Sec4) in the Poster Companion Reference: Hyper-V Networking. |

Virtual network adapter types are:

- **Hyper-V specific network adapter** - Available for both generation 1 and generation 2 virtual machines. It's designed specifically for Hyper-V and requires a driver that's included in Hyper-V integration services. This type of network adapter  faster and is the recommended choice unless you need to boot to the network or are running an unsupported guest operating system. The required driver is provided only for supported guest operating systems. Note that in Hyper-V Manager and the networking cmdlets, this type is just referred to as a network adapter.

- **Legacy network adapter** - Available only in generation 1 virtual machines. Emulates an Intel 21140-based PCI Fast Ethernet Adapter and can be used to boot to a network so you can install an operating system from a service such as Windows Deployment Services.

## Hyper-V networking and related technologies

Some features rely on specific networking configurations or do better under certain configurations. Consider these when planning or updating your network infrastructure.

**Failover clustering** - It's a best practice to isolate cluster traffic and use Hyper-V Quality of Service (QoS) on the virtual switch. For details, see [Network Recommendations for a Hyper-V Cluster](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn550728(v=ws.11))

**Live migration** - Use performance options to reduce network and CPU usage and the time it takes to complete a live migration. For instructions, see [Set up hosts for live migration without Failover Clustering](../deploy/set-up-hosts-for-live-migration-without-failover-clustering.md).

**Storage Spaces Direct** - This feature relies on the SMB3.0 network protocol and RDMA. For details, see [Storage Spaces Direct overview](/azure/azure-local/concepts/storage-spaces-direct-overview?context=/windows-server/context/windows-server-storage).
