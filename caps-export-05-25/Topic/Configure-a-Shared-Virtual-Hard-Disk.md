---
title: Configure a Shared Virtual Hard Disk
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9662cb88-c517-442e-bbc0-682c5b40f38b
author: cwatsonmsft
---
# Configure a Shared Virtual Hard Disk
Shared VHDX files should be deployed on Cluster Shared Volumes \(CSV\) or on a Scale\-Out File Server Cluster with SMB 3.0. For more information about shared virtual hard disks, see [Virtual Hard Disk Sharing Overview](../Topic/Virtual-Hard-Disk-Sharing-Overview.md).  
  
## To create and enable a shared virtual hard disk on a virtual machine  
  
1.  Open Hyper\-V Manager if it is not already open. \(From Server Manager, click **Tools** and then click **Hyper\-V Manager**.\)  
  
2.  Under **Virtual Machines**, select the virtual machine that you want to configure with a shared virtual hard disk..  
  
3.  In the **Actions** pane, click **Settings**.  
  
4.  Click **SCSI Controller**.  
  
5.  On the left pane, under **SCSI Controller**, click **Add**.  
  
6.  On the left pane, under **Hard Drive**, click **New** to start the **New Virtual Hard Disk Wizard.**.  
  
7.  On the **Before You Begin** page, click **Next**  
  
8.  On the **Choose Disk Format**, accept the default **VHDX**. Click **Next**.  
  
9. On the **Choose Disk Type** Page, accept the default **Dynamic Expanding**. Click **Next**.  
  
10. On the **Specify Name and Location** page, enter the name of your shared virtual hard disk..  
  
11. On the **Specify Name and Location** page, click **Browse**. Navigate to your shared storage location. \(Cluster Shared Volumes \(CSV\) or on a Scale\-Out File Server Cluster with SMB 3.0\).  
  
12. Click **Select Folder**. Click **Next**.  
  
13. On the **Configure Disk** page, verify the size of the new virtual hard disk and alter to desired size or accept default. Click **Next**.  
  
14. On the Completing the New Virtual Hard Disk Wizard, review your configuration and Click **Finish**  
  
15. The new virtual hard disk is now created and needs to be enabled as a shared virtual hard disk. Click the Hard Drive you just created under **SCSI Controller**.  
  
16. Click the “**\+**” symbol next to the hard disk.  
  
17. Click **Advanced Features**.  
  
18. On the right hand size, under **Virtual hard disk sharing**, click **Enable virtual hard disk sharing**.  
  
19. Click **OK**. The shared virtual hard disk is now created and enabled.  
  
