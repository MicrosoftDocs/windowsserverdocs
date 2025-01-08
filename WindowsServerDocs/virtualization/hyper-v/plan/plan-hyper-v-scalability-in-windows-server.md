---
title: Plan for Hyper-V scalability in Windows Server
description: Lists the maximum supported number for components you can add to or remove from Hyper-V and virtual machines, like how much memory, and how many virtual processors, in Windows Server.
ms.topic: article
ms.author: roharwoo
author: robinharwood
ms.date: 10/25/2024
zone_pivot_groups: windows-os-version
---

# Plan for Hyper-V scalability in Windows Server

This article gives you details about the maximum configuration for components you can add and remove on a Hyper-V host or its virtual machines, such as virtual processors or checkpoints. As you plan your deployment, consider the maximums that apply to each virtual machine, and those that apply to the Hyper-V host. Maximums continue to grow in Windows Server versions, in response to requests to support newer scenarios such as machine learning and data analytics.

> [!NOTE]
> For information about System Center Virtual Machine Manager (VMM), see [Virtual Machine Manager](/system-center/vmm/overview). VMM is a Microsoft product for managing a virtualized data center that is sold separately.

## Maximums for virtual machines

These maximums apply to each virtual machine when the host is run the selected product version. The guest operating system might support less than the virtual machine maximum. Not all components are available in both generations of virtual machines. For a comparison of the generations, see [Should I create a generation 1 or 2 virtual machine in Hyper-V?](should-i-create-a-generation-1-or-2-virtual-machine-in-hyper-v.md)

:::zone pivot="windows-server-2025"

|Component|Maximum|Notes|
|-------------|-----------|---------|
|Checkpoints|50|The actual number might be lower, depending on the available storage. Each checkpoint is stored as an .avhd file that uses physical storage.|
|Memory|<ul><li>240 TB for generation 2</li><li>1 TB for generation 1</li></ul>|Review the requirements for the specific operating system to determine the minimum and recommended amounts.|
|Serial (COM) ports|2|None.|
|Size of physical disks attached directly to a virtual machine|Varies|Maximum size is determined by the guest operating system.|
|Virtual Fibre Channel adapters|4|As a best practice, we recommended that you connect each virtual Fibre Channel Adapter to a different virtual SAN.|
|Virtual floppy devices|1 virtual floppy drive|None.|
|Virtual hard disk capacity|<ul><li>64 TB for VHDX format</li><li>2,040 GB for VHD format</li></ul>|Each virtual hard disk is stored on physical media as either a .vhdx or a .vhd file, depending on the format used by the virtual hard disk.|
|Virtual IDE disks|4|The startup disk (sometimes called the boot disk) must be attached to one of the IDE devices. The startup disk can be either a virtual hard disk or a physical disk attached directly to a virtual machine.|
|Virtual processors|<ul><li>2048 for generation 2</li><li>64 for generation 1</li></ul>|The number of virtual processors supported by a guest operating system might be lower. For details, see the information published for the specific operating system.|
|Virtual SCSI controllers|4|Use of virtual SCSI devices requires integration services, which are available for supported guest operating systems. For details on which operating systems are supported, see [Supported Linux and FreeBSD virtual machines](../Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md) and [Supported Windows guest operating systems](../supported-windows-guest-operating-systems-for-hyper-v-on-windows.md).|
|Virtual SCSI disks|256|Each SCSI controller supports up to 64 disks, which means that each virtual machine can be configured with as many as 256 virtual SCSI disks. (4 controllers x 64 disks per controller)|
|Virtual network adapters|68 adapters total:<ul><li>64 Hyper-V specific network adapters</li><li>4 legacy network adapters;</li></ul>|The Hyper-V specific network adapter provides better performance and requires a driver included in integration services. For more information, see [Plan for Hyper-V networking in Windows Server](plan-hyper-v-networking-in-windows-server.md).|

::: zone-end

:::zone pivot="windows-server-2022"

> [!TIP]
> This tables also applies to Azure Local.

|Component|Maximum|Notes|
|-------------|-----------|---------|
|Checkpoints|50|The actual number might be lower, depending on the available storage. Each checkpoint is stored as an .avhd file that uses physical storage.|
|Memory|<ul><li>240 TB for generation 2</li><li>1 TB for generation 1</li></ul>|Review the requirements for the specific operating system to determine the minimum and recommended amounts.|
|Serial (COM) ports|2|None.|
|Size of physical disks attached directly to a virtual machine|Varies|Maximum size is determined by the guest operating system.|
|Virtual Fibre Channel adapters|4|As a best practice, we recommended that you connect each virtual Fibre Channel Adapter to a different virtual SAN.|
|Virtual floppy devices|1 virtual floppy drive|None.|
|Virtual hard disk capacity|<ul><li>64 TB for VHDX format</li><li>2,040 GB for VHD format</li></ul>|Each virtual hard disk is stored on physical media as either a .vhdx or a .vhd file, depending on the format used by the virtual hard disk.|
|Virtual IDE disks|4|The startup disk (sometimes called the boot disk) must be attached to one of the IDE devices. The startup disk can be either a virtual hard disk or a physical disk attached directly to a virtual machine.|
|Virtual processors|<ul><li>1,024 for generation 2</li><li>64 for generation 1</li></ul>|The number of virtual processors supported by a guest operating system might be lower. For details, see the information published for the specific operating system.|
|Virtual SCSI controllers|4|Use of virtual SCSI devices requires integration services, which are available for supported guest operating systems. For details on which operating systems are supported, see [Supported Linux and FreeBSD virtual machines](../Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md) and [Supported Windows guest operating systems](../supported-windows-guest-operating-systems-for-hyper-v-on-windows.md).|
|Virtual SCSI disks|256|Each SCSI controller supports up to 64 disks, which means that each virtual machine can be configured with as many as 256 virtual SCSI disks. (4 controllers x 64 disks per controller)|
|Virtual network adapters|68 adapters total:<ul><li>64 Hyper-V specific network adapters</li><li>4 legacy network adapters;</li></ul>|The Hyper-V specific network adapter provides better performance and requires a driver included in integration services. For more information, see [Plan for Hyper-V networking in Windows Server](plan-hyper-v-networking-in-windows-server.md).|

::: zone-end

:::zone pivot="windows-server-2019"

|Component|Maximum|Notes|
|-------------|-----------|---------|
|Checkpoints|50|The actual number might be lower, depending on the available storage. Each checkpoint is stored as an .avhd file that uses physical storage.|
|Memory|<ul><li>12 TB for generation 2</li><li>1 TB for generation 1</li></ul>|Review the requirements for the specific operating system to determine the minimum and recommended amounts.|
|Serial (COM) ports|2|None.|
|Size of physical disks attached directly to a virtual machine|Varies|Maximum size is determined by the guest operating system.|
|Virtual Fibre Channel adapters|4|As a best practice, we recommended that you connect each virtual Fibre Channel Adapter to a different virtual SAN.|
|Virtual floppy devices|1 virtual floppy drive|None.|
|Virtual hard disk capacity|<ul><li>64 TB for VHDX format</li><li>2,040 GB for VHD format</li></ul>|Each virtual hard disk is stored on physical media as either a .vhdx or a .vhd file, depending on the format used by the virtual hard disk.|
|Virtual IDE disks|4|The startup disk (sometimes called the boot disk) must be attached to one of the IDE devices. The startup disk can be either a virtual hard disk or a physical disk attached directly to a virtual machine.|
|Virtual processors|<ul><li>250 for generation 2</li><li>64 for generation 1</li></ul>|The number of virtual processors supported by a guest operating system might be lower. For details, see the information published for the specific operating system.|
|Virtual SCSI controllers|4|Use of virtual SCSI devices requires integration services, which are available for supported guest operating systems. For details on which operating systems are supported, see [Supported Linux and FreeBSD virtual machines](../Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md) and [Supported Windows guest operating systems](../supported-windows-guest-operating-systems-for-hyper-v-on-windows.md).|
|Virtual SCSI disks|256|Each SCSI controller supports up to 64 disks, which means that each virtual machine can be configured with as many as 256 virtual SCSI disks. (4 controllers x 64 disks per controller)|
|Virtual network adapters|68 adapters total:<ul><li>64 Hyper-V specific network adapters</li><li>4 legacy network adapters;</li></ul>|The Hyper-V specific network adapter provides better performance and requires a driver included in integration services. For more information, see [Plan for Hyper-V networking in Windows Server](plan-hyper-v-networking-in-windows-server.md).|

::: zone-end

:::zone pivot="windows-server-2016"

|Component|Maximum|Notes|
|-------------|-----------|---------|
|Checkpoints|50|The actual number might be lower, depending on the available storage. Each checkpoint is stored as an .avhd file that uses physical storage.|
|Memory|<ul><li>12 TB for generation 2</li><li>1 TB for generation 1</li></ul>|Review the requirements for the specific operating system to determine the minimum and recommended amounts.|
|Serial (COM) ports|2|None.|
|Size of physical disks attached directly to a virtual machine|Varies|Maximum size is determined by the guest operating system.|
|Virtual Fibre Channel adapters|4|As a best practice, we recommended that you connect each virtual Fibre Channel Adapter to a different virtual SAN.|
|Virtual floppy devices|1 virtual floppy drive|None.|
|Virtual hard disk capacity|<ul><li>64 TB for VHDX format</li><li>2,040 GB for VHD format</li></ul>|Each virtual hard disk is stored on physical media as either a .vhdx or a .vhd file, depending on the format used by the virtual hard disk.|
|Virtual IDE disks|4|The startup disk (sometimes called the boot disk) must be attached to one of the IDE devices. The startup disk can be either a virtual hard disk or a physical disk attached directly to a virtual machine.|
|Virtual processors|<ul><li>240 for generation 2</li><li>64 for generation 1</li></ul>|The number of virtual processors supported by a guest operating system might be lower. For details, see the information published for the specific operating system.|
|Virtual SCSI controllers|4|Use of virtual SCSI devices requires integration services, which are available for supported guest operating systems. For details on which operating systems are supported, see [Supported Linux and FreeBSD virtual machines](../Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md) and [Supported Windows guest operating systems](../supported-windows-guest-operating-systems-for-hyper-v-on-windows.md).|
|Virtual SCSI disks|256|Each SCSI controller supports up to 64 disks, which means that each virtual machine can be configured with as many as 256 virtual SCSI disks. (4 controllers x 64 disks per controller)|
|Virtual network adapters|12 adapters total:<ul><li>8 Hyper-V specific network adapters</li><li>4 legacy network adapters</li></ul>|The Hyper-V specific network adapter provides better performance and requires a driver included in integration services. For more information, see [Plan for Hyper-V networking in Windows Server](plan-hyper-v-networking-in-windows-server.md).|

::: zone-end

## Maximums for Hyper-V hosts

These maximums apply to each Hyper-V host running the selected product version.

:::zone pivot="windows-server-2025"

|Component|Maximum|Notes|
|-------------|-----------|---------|
|Logical processors|2,048|Both of these features must be enabled in the firmware:<ul><li>Hardware-assisted virtualization</li><li>Hardware-enforced Data Execution Prevention (DEP)</li></ul>|
|Memory|<ul><li>4 PB for hosts that support 5-level paging</li><li>256 TB for hosts that support 4-level paging</li></ul>|None.|
|Network adapter teams (NIC Teaming)|No limits imposed by Hyper-V.|None.|
|Physical network adapters|No limits imposed by Hyper-V.|None.|
|Running virtual machines per server|1024|None.|
|Storage|Limited by what is supported by the host operating system. No limits imposed by Hyper-V.|**Note:** Microsoft supports network-attached storage (NAS) when using SMB 3.0. NFS-based storage isn't supported.|
|Virtual network switch ports per server|Varies; no limits imposed by Hyper-V.|The practical limit depends on the available computing resources.|
|Virtual processors available the host|2,048|The limit is applied to the host operating system (root partition)|
|Virtual processors per logical processor|No ratio imposed by Hyper-V.|None.|
|Virtual processors per server|2048|None.|
|Virtual storage area networks (SANs)|No limits imposed by Hyper-V.|None.|
|Virtual switches|Varies; no limits imposed by Hyper-V.|The practical limit depends on the available computing resources.|

::: zone-end

:::zone pivot="windows-server-2022"

|Component|Maximum|Notes|
|-------------|-----------|---------|
|Logical processors|1,024|Both of these features must be enabled in the firmware:<ul><li>Hardware-assisted virtualization</li><li>Hardware-enforced Data Execution Prevention (DEP)</li></ul>|
|Memory|<ul><li>4 PB for hosts that support 5-level paging</li><li>256 TB for hosts that support 4-level paging</li></ul>|None.|
|Network adapter teams (NIC Teaming)|No limits imposed by Hyper-V.|None.|
|Physical network adapters|No limits imposed by Hyper-V.|None.|
|Running virtual machines per server|1024|None.|
|Storage|Limited by what is supported by the host operating system. No limits imposed by Hyper-V.|**Note:** Microsoft supports network-attached storage (NAS) when using SMB 3.0. NFS-based storage isn't supported.|
|Virtual network switch ports per server|Varies; no limits imposed by Hyper-V.|The practical limit depends on the available computing resources.|
|Virtual processors available the host|1,024|The limit is applied to the host operating system (root partition)|
|Virtual processors per logical processor|No ratio imposed by Hyper-V.|None.|
|Virtual processors per server|2048|None.|
|Virtual storage area networks (SANs)|No limits imposed by Hyper-V.|None.|
|Virtual switches|Varies; no limits imposed by Hyper-V.|The practical limit depends on the available computing resources.|

::: zone-end

:::zone pivot="windows-server-2019"

|Component|Maximum|Notes|
|-------------|-----------|---------|
|Logical processors|512|Both of these features must be enabled in the firmware:<ul><li>Hardware-assisted virtualization</li><li>Hardware-enforced Data Execution Prevention (DEP)</li></ul>|
|Memory|24 TB |None.|
|Network adapter teams (NIC Teaming)|No limits imposed by Hyper-V.|None.|
|Physical network adapters|No limits imposed by Hyper-V.|None.|
|Running virtual machines per server|1024|None.|
|Storage|Limited by what is supported by the host operating system. No limits imposed by Hyper-V.|**Note:** Microsoft supports network-attached storage (NAS) when using SMB 3.0. NFS-based storage isn't supported.|
|Virtual network switch ports per server|Varies; no limits imposed by Hyper-V.|The practical limit depends on the available computing resources.|
|Virtual processors available the host|320|The limit is applied to the host operating system (root partition)|
|Virtual processors per logical processor|No ratio imposed by Hyper-V.|None.|
|Virtual processors per server|2048|None.|
|Virtual storage area networks (SANs)|No limits imposed by Hyper-V.|None.|
|Virtual switches|Varies; no limits imposed by Hyper-V.|The practical limit depends on the available computing resources.|

::: zone-end

:::zone pivot="windows-server-2016"

|Component|Maximum|Notes|
|-------------|-----------|---------|
|Logical processors|512|Both of these features must be enabled in the firmware:<ul><li>Hardware-assisted virtualization</li><li>Hardware-enforced Data Execution Prevention (DEP)</li></ul>|
|Memory|24 TB|None.|
|Network adapter teams (NIC Teaming)|No limits imposed by Hyper-V.|None.|
|Physical network adapters|No limits imposed by Hyper-V.|None.|
|Running virtual machines per server|1024|None.|
|Storage|Limited by what is supported by the host operating system. No limits imposed by Hyper-V.|**Note:** Microsoft supports network-attached storage (NAS) when using SMB 3.0. NFS-based storage isn't supported.|
|Virtual network switch ports per server|Varies; no limits imposed by Hyper-V.|The practical limit depends on the available computing resources.|
|Virtual processors available the host|320|The limit is applied to the host operating system (root partition)|
|Virtual processors per logical processor|No ratio imposed by Hyper-V.|None.|
|Virtual processors per server|2048|None.|
|Virtual storage area networks (SANs)|No limits imposed by Hyper-V.|None.|
|Virtual switches|Varies; no limits imposed by Hyper-V.|The practical limit depends on the available computing resources.|

::: zone-end

## Failover Clusters and Hyper-V
This table lists the maximums that apply when using Hyper-V and Failover Clustering. It's important to do capacity planning to ensure that there's enough hardware resources to run all the virtual machines in a clustered environment.

|Component|Maximum|Notes|
|-------------|-----------|---------|
|Nodes per cluster|64|Consider the number of nodes you want to reserve for failover, and maintenance tasks such as applying updates. We recommend that you plan for enough resources to allow for 1 node to be reserved for failover. Meaning it remains idle until another node is failed over to it, sometimes referred to as a passive node. You can increase this number if you want to reserve more nodes. There's no recommended ratio or multiplier of reserved nodes to active nodes; the only requirement is that the total number of nodes in a cluster can't exceed the maximum of 64.|
|Running virtual machines per cluster and per node|8,000 per cluster|Several factors can affect the real number of virtual machines you can run at the same time on one node, such as:<br />- Amount of physical memory being used by each virtual machine.<br />- Networking and storage bandwidth.<br />- Number of disk spindles, which affects disk I/O performance.|
