---
title: Hardware Considerations for Hyper-V
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0c47c8c2-e033-407f-b31d-6c6c90fb534b
author: cwatsonmsft
---
# Hardware Considerations for Hyper-V
To effectively plan for and deploy Hyper\-V, you should understand the requirements and maximum configurations for the physical and virtual hardware that will comprise the virtualized server computing environment.  
  
## Hardware requirements  
Hyper\-V requires specific hardware. To install and use the Hyper\-V role, you will need the following:  
  
-   **An x64\-based processor.** Hyper\-V is available in 64\-bit editions of Windows Server 2008 —specifically, the 64\-bit editions of Windows Server 2008 Standard, Windows Server 2008 Enterprise, and Windows Server 2008 Datacenter. Hyper\-V is not available for 32\-bit \(x86\) editions or Windows Server 2008 for Itanium\-Based Systems. However, the Hyper\-V management tools are available for 32\-bit editions. For more information about the tools, see [Installing Hyper\-V \[Node\]](https://technet.microsoft.com/library/cc794892.aspx).  
  
-   **Hardware\-assisted virtualization.** This is available in processors that include a virtualization option—specifically processors with Intel Virtualization Technology \(Intel VT\) or AMD Virtualization \(AMD\-V\) technology.  
  
-   **Hardware\-enforced Data Execution Prevention \(DEP\) must be available and enabled.** Specifically, you must enable Intel XD bit \(execute disable bit\) or AMD NX bit \(no execute bit\).  
  
You can identify systems that support the x64 architecture and Hyper\-V by searching the Windows Server catalog for Hyper\-V as an additional qualification \(see [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111228](http://go.microsoft.com/fwlink/?LinkId=111228)\).  
  
> [!TIP]  
> The settings for hardware\-assisted virtualization and hardware\-enforced DEP are available in the BIOS. However, the names of the settings may differ from the names identified above. For more information about whether a specific processor model supports Hyper\-V, check with the manufacturer of the computer. If you modify the settings for hardware\-assisted virtualization or hardware\-enforced DEP, we recommend that you turn off the power to the computer and then turn it back on. Restarting the computer may not apply the changes to the settings.  
  
## Memory  
The maximum amount of memory that can be used is determined by the operating system, as follows:  
  
-   For Windows Server 2008 Enterprise and Windows Server 2008 Datacenter, the physical computer can be configured with up to 1 TB of physical memory, and virtual machines that run either of those editions can be configured with up to 64 GB of memory per virtual machine.  
  
-   For Windows Server 2008 Standard, the physical computer can be configured with up to 32 GB of physical memory, and virtual machines that run that edition can be configured with up to 31 GB of memory per virtual machine.  
  
## Processors  
The release version of Hyper\-V is supported on physical computers with up to 16 logical processors. However, a hotfix \(KB956710\) is available that increases the maximum number of virtual processors to 24. For more information and links to the updates, see [Hyper\-V Update List](http://go.microsoft.com/fwlink/?LinkId=140282).  
  
A logical processor can be a single core or multi\-core processor. You can configure up to 4 virtual processors on a virtual machine. Note that the number of virtual processors supported by a guest operating system might be lower. For more information, see [About Virtual Machines and Guest Operating Systems](https://technet.microsoft.com/library/cc794868(v=ws.10).aspx). The following are some examples of supported systems and the number of logical processors they provide:  
  
-   A single\-processor\/dual\-core system provides 2 logical processors.  
  
-   A single\-processor\/quad\-core system provides 4 logical processors.  
  
-   A dual\-processor\/dual\-core system provides 4 logical processors.  
  
-   A dual\-processor\/quad\-core system provides 8 logical processors.  
  
-   A quad\-processor\/dual\-core system provides 8 logical processors.  
  
-   A quad\-processor\/dual\-core, hyper\-threaded system provides 16 logical processors.  
  
-   A quad\-processor\/quad\-core system provides 16 logical processors.  
  
## Networking  
Hyper\-V provides a variety of networking options and configurations to meet different networking requirements. For more information about different types of virtual networks and virtual network adapters, see [Configuring virtual networks](https://technet.microsoft.com/library/cc816585(v=ws.10).aspx).  
  
Hyper\-V networking includes the following support:  
  
-   Each virtual machine can be configured with up to 12 virtual network adapters—8 can be the “network adapter” type and 4 can be the “legacy network adapter” type. The network adapter type provides better performance and requires a virtual machine driver that is included in the integration services packages.  
  
-   Each virtual network adapter can be configured with either a static or dynamic MAC address.  
  
-   Each virtual network adapter offers integrated virtual local area network \(VLAN\) support and can be assigned a unique VLAN channel.  
  
-   You can have an unlimited number of virtual networks with up to 512 virtual machines per virtual network.  
  
> [!NOTE]  
> You cannot connect a virtual network to a wireless network adapter. As a result, you cannot provide wireless networking capabilities to virtual machines.  
  
## Storage  
Hyper\-V supports a variety of storage options. For more information about the storage options, see [Implementing Disks and Storage](https://technet.microsoft.com/library/dd183729(v=ws.10).aspx).  
  
You can use the following types of physical storage with a server that runs Hyper\-V:  
  
-   Direct\-attached storage: You can use Serial Advanced Technology Attachment \(SATA\), external Serial Advanced Technology Attachment \(eSATA\), Parallel Advanced Technology Attachment \(PATA\), Serial Attached SCSI \(SAS\), SCSI, USB, and Firewire.  
  
-   Storage area networks \(SANs\): You can use Internet SCSI \(iSCSI\), Fibre Channel, and SAS technologies.  
  
> [!IMPORTANT]  
> Microsoft does not support network\-attached storage \(NAS\) for Hyper\-V.  
  
You can configure a virtual machine to use the following types of storage:  
  
-   **Virtual IDE devices.** Each virtual machine supports up to 4 IDE devices. The startup disk \(sometimes referred to as the boot disk\) must be attached to one of the IDE devices. The startup disk can be either a virtual hard disk or a physical disk. Although a virtual machine must use a virtual IDE device as the startup disk to start the guest operating system, you have many options to choose from when selecting the physical device that will provide the storage for the virtual IDE device. For example, you can use any of the types of physical storage identified in the preceding list.  
  
-   **Virtual SCSI devices.** Each virtual machine supports up to 4 virtual SCSI controllers, and each controller supports up to 64 disks. This means that each virtual machine can be configured with as many as 256 virtual SCSI disks. Use of virtual SCSI devices requires integration services to be installed in the guest operating system. For a list of the guest operating systems for which integration services are available, see [About Virtual Machines and Guest Operating Systems](https://technet.microsoft.com/library/cc794868(v=ws.10).aspx)  
  
-   **Virtual hard disks of up to 2040 GB.** You can use fixed virtual hard disks, dynamically expanding virtual hard disks, and differencing disks.  
  
-   **Physical disks.** Physical disks attached directly to a virtual machine have no size limitation other than what is supported by the guest operating system.  
  
-   **Virtual machine storage capacity.** Using virtual hard disks, each virtual machine supports up to 512 TB of storage. Using physical disks, this number is even greater depending on what is supported by the guest operating system.  
  
-   **Virtual machine snapshots.** Hyper\-V supports up to 50 snapshots per virtual machine.  
  
> [!TIP]  
> Although the I\/O performance of physical SCSI and IDE devices can differ significantly, this is not true for the virtualized SCSI and IDE devices in Hyper\-V. Hyper\-V IDE and SCSI storage devices both offer equally fast high I\/O performance when integration services are installed in the guest operating system. For a list of the guest operating systems for which integration services are available, see [About Virtual Machines and Guest Operating Systems](https://technet.microsoft.com/library/cc794868(v=ws.10).aspx).  
  
## Other hardware components  
The following is information about the other types of physical and virtual hardware components that you can use with Hyper\-V.  
  
|||  
|-|-|  
|DVD drive|A virtual machine has 1 virtual DVD drive by default when you create the virtual machine. Virtual machines can be configured with up to 3 DVD drives, connected to an IDE controller. \(Virtual machines support up to 4 IDE devices, but one device must be the startup disk.\)<br /><br />A virtual DVD drive can access CDs and DVDs, either .iso files or physical media. However, only one virtual machine can be configured to access a physical CD\/DVD drive at a time.|  
|Virtual COM port|Each virtual machine is configured with 2 virtual serial \(COM\) ports that can be attached to a named pipe to communicate with a local or remote physical computer. **Note:** No access to a physical COM port is available from a virtual machine.|  
|Virtual floppy drive|Each virtual machine is configured with 1 virtual floppy drive, which can access virtual floppy disk \(.vfd\) files. **Note:** No access to a physical floppy drive is available from a virtual machine.|  
  
