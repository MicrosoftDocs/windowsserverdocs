---
title: Online Virtual Hard Disk Resizing Overview
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ccdbe6f4-d719-4feb-a82a-a1b8f612ca15
author: cwatsonmsft
---
# Online Virtual Hard Disk Resizing Overview
Starting in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)], Hyper\-V delivers the ability to expand or shrink the size of a virtual hard disk while the virtual machine is still running. For more information about resizing virtual hard disks, see [Configure Online Virtual Hard Disk Resize](../Topic/Configure-Online-Virtual-Hard-Disk-Resize.md).  
  
## Key benefits  
Storage administrators can avoid costly downtime by performing maintenance operations on running virtual hard disks. Shutting down virtual machines is no longer required and this eliminates interruption to users accessing those virtual machines and helps reduce maintenance costs. Prior to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], if a virtual machine was online or a virtual hard disk was in use, it was not possible to perform maintenance on the virtual hard disk without temporarily shutting down the virtual machine.  
  
## Requirements  
The following functionality is required for resizing a virtual hard disk:  
  
-   A server capable of running Hyper\-V. The server must have processor support for hardware virtualization. The Hyper\-V role must be installed.  
  
-   A user account that is a member of the local Hyper\-V Administrators group or the Administrators group.  
  
The following functionality is required for resizing a virtual hard disk:  
  
-   **VHDX** \- the ability to expand and shrink virtual hard disks is exclusive to virtual hard disks that are using the .vhdx file format. Online resizing is supported for VHDX disk types, including fixed, differencing, and dynamic disks. Virtual hard disks that use the .vhd file format are not supported for resizing operations.  
  
-   **SCSI controller** \- the ability to expand or shrink the capacity of a virtual hard disk is exclusive to .vhdx files that are attached to a SCSI controller. VHDX files that are attached to an IDE controller are not supported.  
  
## Understanding online resizing functionality  
There are important concepts to understand when increasing or decreasing the capacity of a virtual hard disk.  
  
### Expanding a virtual hard disk  
Expanding a virtual hard disk increases the disk capacity of the virtual hard disk. However, to make the additional disk space available to the virtual machine requires some extra configuration. From the perspective of the virtual machine, the virtual hard disk expansion is reflected under **Disk Manager** as an unallocated disk volume. The size of this unallocated volume is the difference between the original virtual hard disk and the nominated size of the expanded virtual hard disk.  
  
To make the full virtual hard disk capacity available to the virtual machine, you need to use **Disk Manager** to expand the volume within the virtual machine. You can do this by using the Extend Volume Wizard within **Disk Manager**. After this is complete, you will be able to view the expanded disk capacity in the operating system of the virtual machine.  
  
### Shrinking a virtual hard disk  
As expected, when you shrink a virtual hard disk, the virtual hard disk capacity is decreased. However, there is a limit to amount of disk space that can be adjusted when you shrink a virtual hard disk. That limit is defined by the size of the volume that is currently in use by the virtual machine. The **Hyper\-V Manager** user interface shows the minimum disk size available for shrinking a virtual hard disk.  
  
If you want to shrink the size of the virtual hard disk below the size of the currently used volume within the virtual machine, you must first use **Disk Manager** in the operating system of the virtual machine to shrink the volume. After that is complete, you can reduce the size of the virtual hard disk.  
  
## Performing online resizing operations  
In Windows Server 2012 R2, the option to resize a virtual hard disk is available through the Edit Virtual Hard Disk Wizard. However, the user interface option to shrink a virtual hard disk is only visible for virtual hard disks that have been previously expanded.  
  
Administrators can use the Windows PowerShell interface for online virtual hard disk resizing operations.  
  
## See Also  
[Hyper\-V Virtual Hard Disk Format Overview](assetId:///248806ae-6797-46d1-b1be-24cbf1bafba4)  
[Virtual Hard Disk Sharing Overview](../Topic/Virtual-Hard-Disk-Sharing-Overview.md)  
  
