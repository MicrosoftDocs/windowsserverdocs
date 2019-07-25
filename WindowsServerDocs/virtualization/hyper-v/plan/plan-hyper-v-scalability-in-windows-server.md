---
title: Plan for Hyper-V scalability in Windows Server 2016
description: "Lists the maximum supported number for components you can add to or remove from Hyper-V and virtual machines, like how much memory and how many virtual processors."
ms.prod: windows-server-threshold
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
author: KBDAzure
ms.author: kathydav
ms.date: 09/28/2016

---
# Plan for Hyper-V scalability in Windows Server 2016

> Applies To: Windows Server 2016, Windows Server 2019
  
This article gives you details about the maximum configuration for components you can add and remove on a Hyper-V host or its virtual machines, such as virtual processors or checkpoints. As you plan your deployment, consider the maximums that apply to each virtual machine, as well as those that apply to the Hyper-V host. 

Maximums for memory and logical processors are the biggest increases from Windows Server 2012, in response to requests to support newer scenarios such as machine learning and data analytics. The Windows Server blog recently published the performance results of  a virtual machine with 5.5 terabytes of memory and 128 virtual processors running 4 TB in-memory database. Performance was greater than 95% of the performance of a physical server. For details, see [Windows Server 2016 Hyper-V large-scale VM performance for in-memory transaction processing](https://blogs.technet.microsoft.com/windowsserver/2016/09/28/windows-server-2016-hyper-v-large-scale-vm-performance-for-in-memory-transaction-processing/). Other numbers are similar to those that apply to Windows Server 2012. \(Maximums for Windows Server 2012 R2 were the same as Windows Server 2012.\) 
  
> [!NOTE]  
> For information about System Center Virtual Machine Manager (VMM), see [Virtual Machine Manager](https://technet.microsoft.com/system-center-docs/vmm/vmm). VMM is a Microsoft product for managing a virtualized data center that is sold separately.  
  
## Maximums for virtual machines  
These maximums apply to each virtual machine. Not all components are available in both generations of virtual machines. For a comparison of the generations, see [Should I create a generation 1 or 2 virtual machine in Hyper-V?](should-i-create-a-generation-1-or-2-virtual-machine-in-hyper-v.md) 
  
|Component|Maximum|Notes|  
|-------------|-----------|---------|  
|Checkpoints|50|The actual number may be lower, depending on the available storage. Each checkpoint is stored as an .avhd file that uses physical storage.|  
|Memory|12 TB for generation 2; <br>1 TB for generation 1|Review the requirements for the specific operating system to determine the minimum and recommended amounts.|  
|Serial (COM) ports|2|None.|  
|Size of physical disks attached directly to a virtual machine|Varies|Maximum size is determined by the guest operating system.|  
|Virtual Fibre Channel adapters|4|As a best practice, we recommended that you connect each virtual Fibre Channel Adapter to a different virtual SAN.|  
|Virtual floppy devices|1 virtual floppy drive|None.|
|Virtual hard disk capacity|64 TB for VHDX format;<br>2040 GB for VHD format|Each virtual hard disk is stored on physical media as either a .vhdx or a .vhd file, depending on the format used by the virtual hard disk.|  
|Virtual IDE disks|4|The startup disk (sometimes called the boot disk) must be attached to one of the IDE devices. The startup disk can be either a virtual hard disk or a physical disk attached directly to a virtual machine.|  
|Virtual processors|240 for generation 2;<br>64 for generation 1;<br>320 available to the host OS (root partition)|The number of virtual processors supported by a guest operating system might be lower. For details, see the information published for the specific operating system.|
|Virtual SCSI controllers|4|Use of virtual SCSI devices requires integration services, which are available for supported guest operating systems. For details on which operating systems are supported, see [Supported Linux and FreeBSD virtual machines](../Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md) and [Supported Windows guest operating systems](../supported-windows-guest-operating-systems-for-hyper-v-on-windows.md).|  
|Virtual SCSI disks|256|Each SCSI controller supports up to 64 disks, which means that each virtual machine can be configured with as many as 256 virtual SCSI disks. (4 controllers x 64 disks per controller)|  
|Virtual network adapters|Windows Server 2016 supports 12 total:<br> - 8 Hyper-V specific network adapters<br>- 4 legacy network adapters <br> Windows Server 2019 supports 72 total: <br> - 64 Hyper-V specific network adapters<br>- 4 legacy network adapters  |The Hyper-V specific network adapter provides better performance and requires a driver included in integration services. For more information, see [Plan for Hyper-V networking in Windows Server](plan-hyper-v-networking-in-windows-server.md).|  
  
## Maximums for Hyper-V hosts  
These maximums apply to each Hyper-V host.  
  
|Component|Maximum|Notes|  
|-------------|-----------|---------|  
|Logical processors|512|Both of these must be enabled in the firmware:<br /><br />- Hardware-assisted virtualization<br />- Hardware-enforced Data Execution Prevention (DEP)<br /><br />The host OS (root partition) will only see maximum 320 logical processors|  
|Memory|24 TB|None.|  
|Network adapter teams (NIC Teaming)|No limits imposed by Hyper-V.|For details, see [NIC Teaming](../../../networking/technologies/nic-teaming/NIC-Teaming.md).|  
|Physical network adapters|No limits imposed by Hyper-V.|None.|  
|Running virtual machines per server|1024|None.|  
|Storage|Limited by what is supported by the host operating system. No limits imposed by Hyper-V.|**Note:** Microsoft supports network-attached storage (NAS) when using SMB 3.0. NFS-based storage is not supported.|
|Virtual network switch ports per server|Varies; no limits imposed by Hyper-V.|The practical limit depends on the available computing resources.|  
|Virtual processors per logical processor|No ratio imposed by Hyper-V.|None.|  
|Virtual processors per server|2048|None.|  
|Virtual storage area networks (SANs)|No limits imposed by Hyper-V.|None.|  
|Virtual switches|Varies; no limits imposed by Hyper-V.|The practical limit depends on the available computing resources.|  
 
## Failover Clusters and Hyper-V  
This table lists the maximums that apply when using Hyper-V and Failover Clustering. It's important to do capacity planning to ensure that there will be enough hardware resources to run all the virtual machines in a clustered environment.  

To learn about updates to Failover Clustering, including new features for virtual machines, see [What's New in Failover Clustering in Windows Server 2016](../../../failover-clustering/whats-new-in-failover-clustering.md).

|Component|Maximum|Notes|  
|-------------|-----------|---------|  
|Nodes per cluster|64|Consider the number of nodes you want to reserve for failover, as well as maintenance tasks such as applying updates. We recommend that you plan for enough resources to allow for 1 node to be reserved for failover, which means it remains idle until another node is failed over to it. (This is sometimes referred to as a passive node.) You can increase this number if you want to reserve additional nodes. There is no recommended ratio or multiplier of reserved nodes to active nodes; the only requirement is that the total number of nodes in a cluster can't exceed the maximum of 64.|  
|Running virtual machines per cluster and per node|8,000 per cluster|Several factors can affect the real number of virtual machines you can run at the same time on one node, such as:<br />- Amount of physical memory being used by each virtual machine.<br />- Networking and storage bandwidth.<br />- Number of disk spindles, which affects disk I/O performance.|  
  

