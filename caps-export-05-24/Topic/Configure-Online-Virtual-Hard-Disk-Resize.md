---
title: Configure Online Virtual Hard Disk Resize
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bcf02102-359d-427c-9dd9-2d9bab2dd9fc
author: cwatsonmsft
---
# Configure Online Virtual Hard Disk Resize
Starting in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)], Hyper\-V provides you with the ability to expand or shrink decrease the size of a virtual hard disk while the virtual machine is still running. This topic creates a virtual hard disk \(attached to a SCSI Controller\), adds the virtual hard disk to the virtual machine and details the process for expanding and shrinking a virtual hard disk.  
  
> [!NOTE]  
> The user interface option to shrink a virtual hard disk is only visible for virtual hard disks that have been expanded previously. Online resize is exclusive to SCSI attached VHDX files. For more information about resizing virtual hard disks, see [Online Virtual Hard Disk Resizing Overview](../Topic/Online-Virtual-Hard-Disk-Resizing-Overview.md).  
  
## Prerequisites  
Before you attempt to edit the size of your virtual hard disk, make sure that you have the following:  
  
-   A computer running [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] or later with the Hyper\-V role installed.  
  
-   A user account that is a member of the local Hyper\-V Administrators group, or the Administrators group.  
  
## To create a virtual hard disk for a virtual machine  
Create a virtual hard disk \(attached to a SCSI controller\) for a virtual machine using the following procedure:  
  
1.  On the Windows **Start** screen, click the **Server Manager** tile.  
  
2.  On the **Tools** menu, click **Hyper\-V Manager**.  
  
3.  Under **Virtual Machines**, select the virtual machine.  
  
4.  In the **Actions** pane, click **Settings**.  
  
5.  Click **SCSI Controller**. On the right pane, under **SCSI Controller**, click **Hard Drive**.  
  
6.  Click **Add**.  
  
7.  On the right pane, under **Hard Drive**, click **New**.  
  
8.  On the **Before You Begin** page, click **Next**.  
  
9. On the **Choose Disk Format** page, choose **VHDX** and click **Next**.  
  
10. On the **Specify Name and Location** page, type the name of the new virtual hard disk. If required, type the location of the virtual hard disk. Click **Next**.  
  
11. On the **Configure Disk** page, type disk size and click **Next**.  
  
12. On the **Completing the New Virtual Hard Disk Wizard** page, click **Finish**.  
  
## Adding a virtual hard disk to the virtual machine  
After adding a virtual hard disk, it is necessary to configure your virtual machine so that the operating system within the virtual machine can see the additional disk capacity. The disk must be brought online, initialized and formatted.  
  
These instructions assume a virtual hard disk has been created for a [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)]virtual machine.  
  
1.  On the Windows **Start** screen, click the **Server Manager** tile.  
  
2.  On the **Tools** menu, click **Hyper\-V Manager**.  
  
3.  Under **Virtual Machines**, double click to connect to the virtual machine.  
  
4.  Enter credentials and login to the virtual machine.  
  
5.  To start **Disk Manager**, start the **Server Manager**.  
  
6.  On the **Tools** menu, click **Computer Management**.  
  
7.  Under **Storage**, click **Disk Management**.  
  
8.  On the middle pane, locate the new hard disk. Right click the disk and click **Online**.  
  
9. On the middle pane, locate the new hard disk. Right click the disk and click **Initialize**.  
  
10. On the **Initialize Disk** page, click **OK**.  
  
11. On the middle pane, right click the unallocated volume and click **New Simple Volume**.  
  
12. In the **New Simple Volume Wizard**, click **Next**.  
  
13. On the **Specify Volume Size** page, click **Next**.  
  
14. On the **Assign Drive Letteror Path** page, click **Next**.  
  
    On the **Format Partition** page, click **Next**.  
  
    On the **Completing the New Simple Volume** page, click **Finish**.  
  
The new virtual hard disk will now be visible to the virtual machines operating system.  
  
## To expand the size of a virtual hard disk  
You can expand the storage capacity of the virtual hard disk using the following procedure:  
  
1.  On the Windows **Start** screen, click the **Server Manager** tile.  
  
2.  On the **Tools** menu, click **Hyper\-V Manager**.  
  
3.  Under **Virtual Machines**, select the virtual machine with the virtual hard disk that you want to expand.  
  
4.  In the **Actions** pane, click **Edit Disk** to start the **Edit Virtual Hard Disk Wizard**.  
  
5.  On the Before you Begin page, click Next.  
  
6.  On the **Locate Virtual Hard Disk** page, click **Browse**.  
  
7.  Navigate to your virtual hard disk. Select your virtual hard disk. Click **Open**.  
  
8.  Click **Next**.  
  
9. On the **Expand Virtual Disk** page, enter the new virtual hard disk size. The size is specified in gigabytes with a maximum size of 64TB for any virtual hard disk.  
  
10. Click **Next**.  
  
11. On the **Completing the Edit Virtual Hard Disk Wizard** page, click **Finish**.  
  
## Expand the volume of a virtual hard disk connected to a virtual machine  
After expanding a virtual hard disk, it is necessary to configure the disk management within your virtual machine operating system so that it can see the new disk space. This space is currently residing as an unallocated volume created in the virtual disk.  
  
These instructions assume a virtual hard disk has been expanded and that it is connected to a [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)]virtual machine.  
  
1.  On the Windows **Start** screen, click the **Server Manager** tile.  
  
2.  On the **Tools** menu, click **Hyper\-V Manager**.  
  
3.  Under **Virtual Machines**, double click the virtual machine.  
  
4.  Enter credentials and login to the virtual machine.  
  
5.  To start **Disk Manager**, start the **Server Manager**.  
  
6.  On the **Tools** menu, click **Computer Management**.  
  
7.  Under **Storage**, click **Disk Management**.  
  
8.  On the middle pane, locate the existing volume in use by the virtual machine.  
  
9. Right click the disk and click **Extend Volume**.  
  
10. On the **Welcome to the Extended Volume Wizard**, click **Next**.  
  
11. On the **Select Disk** page, click **Next**.  
  
12. On the **Completing the Extended Volume** page, click **Finish**.  
  
The operating system within the virtual machine will now see the expanded disk capacity.  
  
## To shrink the size of a virtual hard disk  
You can shrink the size of a virtual hard disk. However, you cannot shrink the size of the virtual hard disk below the size of the disk volume that is in use within the operating system of the virtual machine.  
  
Reduce the storage capacity of the virtual hard disk using the following procedure:  
  
1.  On the Windows **Start** screen, click the **Server Manager** tile.  
  
2.  On the **Tools** menu, click **Hyper\-V Manager**.  
  
3.  Under **Virtual Machines**, select the virtual machine with the virtual hard disk that you want to shrink.  
  
4.  In the **Actions** pane, click **Edit Disk** to start the **Edit Virtual Hard Disk Wizard**.  
  
5.  On the **Before you Begin** page, click **Next**.  
  
6.  On the **Locate Virtual Hard Disk** page, click **Browse**.  
  
7.  Navigate to your virtual hard disk. Select your virtual hard disk. Click **Open**.  
  
8.  Click **Next**.  
  
9. On the **Choose Action** page, click **Shrink**. Click **Next**.  
  
10. On the **Expand Virtual Disk** page, enter the new virtual hard disk size. The size is specified in gigabytes.  
  
11. Click **Next**.  
  
12. On the Completing the **Edit Virtual Hard Disk Wizard** page, click **Finish**.  
  
