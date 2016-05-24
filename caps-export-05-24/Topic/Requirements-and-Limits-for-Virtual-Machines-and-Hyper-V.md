---
title: Requirements and Limits for Virtual Machines and Hyper-V
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 14ad8311-de22-4194-8b82-4bf6e338650e
author: cwatsonmsft
---
# Requirements and Limits for Virtual Machines and Hyper-V
To effectively plan for and deploy Hyper\-V in Windows Server 2008 R2, you should understand the requirements and maximum configurations for the physical and virtual hardware that will comprise the virtualized server computing environment. You will need to consider the maximums that apply to each virtual machine as well as those that apply to the physical computer that runs the Hyper\-V role.  
  
> [!NOTE]  
> For information about system requirements for System Center Virtual Machine Manager \(VMM\), see [Supported Configurations for VMM](http://go.microsoft.com/fwlink/?LinkId=161174) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=161174\). VMM is a Microsoft product for managing a virtualized data center that is sold separately—it is not a component of Windows Server 2008.  
  
## Virtual Machines  
The following table lists the maximums that apply to each virtual machine.  
  
|Component|Maximum|Notes|  
|-------------|-----------|---------|  
|Virtual processors|4|The number of virtual processors supported by a guest operating system might be lower. For more information, see [About Virtual Machines and Guest Operating Systems](https://technet.microsoft.com/library/cc794868(v=ws.10).aspx).|  
|Memory|64 GB|Review the requirements for the specific operating system to determine the minimum and recommended amounts.|  
|Virtual IDE disks|4|The startup disk \(sometimes referred to as the boot disk\) must be attached to one of the IDE devices. The startup disk can be either a virtual hard disk or a physical disk attached directly to a virtual machine.|  
|Virtual SCSI controllers|4|Use of virtual SCSI devices requires integration services to be installed in the guest operating system. For a list of the guest operating systems for which integration services are available, see [About Virtual Machines and Guest Operating Systems](https://technet.microsoft.com/library/cc794868(v=ws.10).aspx)|  
|Virtual SCSI disks|256|Each SCSI controller supports up to 64 disks, which means that each virtual machine can be configured with as many as 256 virtual SCSI disks. \(4 controllers x 64 disks per controller\)|  
|Virtual hard disk capacity|2040 GB|Each virtual hard disk is stored as a .vhd file on physical media.|  
|Size of physical disks attached directly to a virtual machine|Varies|Maximum size is determined by the guest operating system.|  
|Snapshots|50|The actual number may be lower, depending on the available storage. Each snapshot is stored as an .avhd file that consumes physical storage.|  
|Virtual network adapters|12|-   8 can be the “network adapter” type. This type provides better performance and requires a virtual machine driver that is included in the integration services packages.<br />-   4 can be the “legacy network adapter” type. This type emulates a specific physical network adapter and supports the Pre\-execution Boot Environment \(PXE\) to perform network\-based installation of an operating system.|  
|Virtual floppy devices|1 virtual floppy drive|None.|  
|Serial \(COM\) ports|2|None.|  
  
## Server running Hyper\-V  
The following table lists the requirements and maximums that apply to the server running Hyper\-V. In addition, we recommend that you review the Windows Catalog to identify servers that are qualified for use with Hyper\-V. You can identify systems that support the x64 architecture and Hyper\-V by searching the Windows Server catalog. For Windows Server 2008 you can select Hyper\-V as an additional qualification \(see [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111228](http://go.microsoft.com/fwlink/?LinkId=111228)\). For Windows Server 2008 R2, all systems that have a "Certified for Windows® Server 2008 R2" logo support Hyper\-V.  
  
|Component|Maximum|Notes|  
|-------------|-----------|---------|  
|Logical processors|64|Both of the following must be available and enabled in the BIOS:<br /><br />-   Hardware\-assisted virtualization<br />-   Hardware\-enforced Data Execution Prevention \(DEP\)|  
|Virtual processors per logical processor|12 with conditions met in the ‘Notes’ column, otherwise 8.|A ratio of 12:1 is supported on Hyper\-V in Windows Server 2008 R2 Service Pack 1 when all guest operating systems on the server run Windows 7. Otherwise, the supported ratio is 8:1.|  
|Virtual machines per server|384 running virtual machines|None.|  
|Virtual processors per server|512|None.|  
|Memory|1 TB|None.|  
|Storage|Limited by what is supported by the management operating system. No limits imposed by Hyper\-V.|For more information about the storage options for Hyper\-V, see [Implementing Disks and Storage](https://technet.microsoft.com/library/dd183729(v=ws.10).aspx). For general information about storage for Windows Server, see [Reviewing Storage Limits](http://go.microsoft.com/fwlink/?LinkID=161361) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=161361\). **Note:** Microsoft does not support network\-attached storage \(NAS\) for Hyper\-V.|  
|Physical network adapters|No limits imposed by Hyper\-V.|None.|  
|Virtual networks \(switches\)|Varies; no limits imposed by Hyper\-V.|The practical limit depends on the available computing resources.|  
|Virtual network switch ports per server|Varies; no limits imposed by Hyper\-V.|The practical limit depends on the available computing resources.|  
  
## Failover Clusters and Hyper\-V  
The following table lists the maximums that apply to highly available servers running Hyper\-V. It is important to do capacity planning to ensure that there will be enough hardware resources to run all the virtual machines in a clustered environment. For more information about requirements for failover clusters and Hyper\-V, see [Hyper\-V: Using Hyper\-V and Failover Clustering](http://go.microsoft.com/fwlink/?LinkID=129063) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=129063\).  
  
|Component|Maximum|Notes|  
|-------------|-----------|---------|  
|Nodes per cluster|16|Consider the number of nodes you want to reserve for failover, as well as maintenance tasks such as applying updates. We recommend that you plan for enough resources to allow for 1 node to be reserved for failover, which means it remains idle until another node is failed over to it. \(This is sometimes referred to as a passive node.\) You can increase this number if you want to reserve additional nodes. There is no recommended ratio or multiplier of reserved nodes to active nodes; the only specific requirement is that the total number of nodes in a cluster cannot exceed the maximum of 16.|  
|Running virtual machines per cluster and per node|1,000 per cluster, with a maximum of 384 on any one node|Several factors can affect the real number of virtual machines that can be run at the same time on one node, such as:<br /><br />-   Amount of physical memory being used by each virtual machine.<br />-   Networking and storage bandwidth.<br />-   Number of disk spindles, which affects disk I\/O performance.|  
  
