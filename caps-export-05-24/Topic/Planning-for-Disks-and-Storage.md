---
title: Planning for Disks and Storage
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 64132b06-7987-4b8e-b7d0-02c0976940c8
author: cwatsonmsft
---
# Planning for Disks and Storage
This section describes the storage configuration options that a server running Hyper\-V supports. It also provides information that will help you plan your storage requirements. For step\-by\-step procedures that explain how to create virtual hard disks, attach physical disks, and configure iSCSI\-based storage, see [Configuring Disks and Storage](https://technet.microsoft.com/library/ee344823(v=ws.10).aspx).  
  
You can use the following types of physical storage with a server that runs Hyper\-V:  
  
-   **Direct\-attached storage \(storage attached to the management operating system\).** You can use Serial Advanced Technology Attachment \(SATA\), external Serial Advanced Technology Attachment \(eSATA\), Parallel Advanced Technology Attachment \(PATA\), Serial Attached SCSI \(SAS\), SCSI, USB, and Firewire.  
  
-   **Storage area networks \(SANs\).** You can use Internet SCSI \(iSCSI\), Fibre Channel, and SAS technologies.  
  
> [!NOTE]  
> Network\-attached storage \(NAS\) is not supported for Hyper\-V.  
  
For more information about the requirements and other considerations about hardware, see [Hardware Considerations](https://technet.microsoft.com/library/cc816844(v=ws.10).aspx).  
  
## Determining your storage configuration options on the management operating system  
On the management operating system, you can select to use either virtual hard disks or physical disks that are directly attached to a virtual machine. Virtual hard disks can have a capacity of up to 2040 gigabytes and include the following types:  
  
-   **Fixed size**. A fixed size virtual hard disk is a disk that occupies physical disk space on the management operating system equal to the maximum size of the disk, regardless of whether a virtual machine requires the disk space. A fixed size virtual hard disk takes longer to create than other types of disks because the allocated size of the .vhd file is determined when it is created. This type of virtual hard disk provides improved performance compared to other types because fixed virtual hard disks are stored in a contiguous block on the management operating system.  
  
    > [!IMPORTANT]  
    > We recommend that you use fixed size virtual hard disks for virtual machines that are running on a production environment. Because a fixed amount of space on the underlying physical storage is allocated when you create a fixed size virtual hard disk, you can ensure that there will be enough storage space for all the virtual hard disks that you create. This will help you to avoid running out of storage space, as can happen when you use dynamically expanding or differencing virtual hard disks, which continue to grow as data is written to them.  
  
-   **Dynamically expanding**. A dynamically expanding virtual hard disk is a disk in which the size of the .vhd file grows as data is written to the disk. This type provides the most efficient use of disk space. You will need to monitor the available disk space to avoid running out of disk space on the management operating system.  
  
-   **Differencing**. A differencing virtual hard disk stores the differences from the virtual hard disk on the management operating system. This allows you to isolate changes to a virtual machine and keep a virtual hard disk in an unchanged state. The differencing disk on the management operating system can be shared with virtual machines and, as a best practice, must remain read\-only. If it is not read\-only, the virtual machine’s virtual hard disk will be invalidated.  
  
With virtual hard disks, each virtual machine supports up to 512 TB of storage. Physical disks that are directly attached to a virtual machine have no size limit other than what is supported by the guest operating system.  
  
> [!NOTE]  
> For more information about virtual hard disk performance and a comparison of performance in Windows Server 2008 and Windows Server 2008 R2, see [Virtual Hard Disk Performance](http://go.microsoft.com/fwlink/?LinkId=186519) in the Microsoft Download Center \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=186519\).  
  
## Determining your storage configuration options on virtual machines  
You can select either integrated device electronics \(IDE\) or SCSI devices on virtual machines:  
  
-   **IDE devices**. Hyper\-V uses emulated devices with IDE controllers. You can have up to two IDE controllers with two disks on each controller. The startup disk \(sometimes referred to as the boot disk\) must be attached to one of the IDE devices. The startup disk can be either a virtual hard disk or a physical disk. Although a virtual machine must use an IDE device as the startup disk to start the guest operating system, you have many options to choose from when selecting the physical device that will provide the storage for the IDE device. For example, you can use any of the types of physical storage identified in the introduction section.  
  
-   **SCSI devices**. Each virtual machine supports up to 256 SCSI disks \(four SCSI controllers with each controller supporting up to 64 disks\). SCSI controllers use a type of device developed specifically for use with virtual machines and use the virtual machine bus to communicate. The virtual machine bus must be available when the guest operating system is started. Therefore, virtual hard disks attached to SCSI controllers cannot be used as startup disks.  
  
> [!CAUTION]  
> -   By default, SCSI commands are filtered in Hyper\-V in Windows Server 2008 R2. Although it is possible to disable filtering of SCSI commands, we do not recommend that you arbitrarily disable filtering because it represents a possible security risk \(when filtering of SCSI commands is turned off, SCSI commands pass directly from the virtual machine to the storage stack on the management operating system\).  
> -   Programmatically disabling SCSI filtering is supported in Hyper\-V in Windows Server 2008 R2 and may be required for certain storage management applications. You should only disable SCSI filtering after consulting with your storage vendor and determining that it is necessary for application compatibility.  
  
> [!NOTE]  
> Although the I\/O performance of physical SCSI and IDE devices can differ significantly, this is not true for the virtualized SCSI and IDE devices in Hyper\-V. Hyper\-V. IDE and SCSI devices both offer equally fast I\/O performance when integration services are installed in the guest operating system.  
  
The following table describes the various storage configuration options available with IDE devices:  
  
|Scenario|Local IDE virtual hard disk|Local directly attached IDE|Remote IDE virtual hard disk|Remote directly attached IDE|  
|------------|-------------------------------|-------------------------------|--------------------------------|--------------------------------|  
|Storage type|Direct\-attached storage|Direct\-attached storage|SAN, Fibre Channel\/iSCSI|SAN, Fibre Channel\/iSCSI|  
|Type of disk that is exposed to the management operating system|Virtual hard disk on NTFS|Physical disk directly attached to a virtual machine|Virtual hard disk on NTFS|Physical disk directly attached to a virtual machine|  
|Maximum supported disk size on virtual machine|2040 gigabytes|No size limit other than what is supported by the guest operating system|2040 gigabytes|No size limit other than what is supported by the guest operating system|  
|Virtual hard disk snapshots are supported|Yes|No|Yes|No|  
|Dynamically expanding virtual hard disk|Yes|No|Yes|No|  
|Differencing virtual hard disk|Yes|No|Yes|No|  
|Add or remove storage while the virtual machine is running|No|No|No|No|  
  
The following table describes the various storage configuration options available with SCSI devices:  
  
|Scenario|Local SCSI virtual hard disk|Local directly attached SCSI|Remote SCSI virtual hard disk|Remote directly attached SCSI|  
|------------|--------------------------------|--------------------------------|---------------------------------|---------------------------------|  
|Storage type|Direct\-attached storage|Direct\-attached storage|SAN, Fibre Channel\/iSCSI|SAN, Fibre Channel\/iSCSI|  
|Type of disk that is exposed to the management operating system|Virtual hard disk on NTFS|Physical disk directly attached to a virtual machine|Virtual hard disk on NTFS|Physical disk directly attached to a virtual machine|  
|Maximum supported disk size on virtual machine|2040 gigabytes|No size limit other than what is supported by the guest operating system|2040 gigabytes|No size limit other than what is supported by the guest operating system|  
|Virtual hard disk snapshots are supported|Yes|No|Yes|No|  
|Dynamically expanding virtual hard disk|Yes|No|Yes|No|  
|Differencing virtual hard disk|Yes|No|Yes|No|  
|Add or remove storage while the virtual machine is running|Yes in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. No in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].|No|No|No|  
  
