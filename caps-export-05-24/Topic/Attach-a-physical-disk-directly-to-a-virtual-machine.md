---
title: Attach a physical disk directly to a virtual machine
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b856cfdc-da39-4a6b-8478-716504ebfd35
author: cwatsonmsft
---
# Attach a physical disk directly to a virtual machine
You can use physical disks that are directly attached to a virtual machine as a storage option, this is sometimes referred to as a pass\-through disk. This allows virtual machines to access storage that is mapped directly to the host without first configuring the volume. The storage can be either a physical disk which is internal to the server, or a SAN logical unit number \(LUN\) that is mapped to the server \(a LUN is a logical reference to a portion of a storage subsystem\). The virtual machine must have exclusive access to the storage, so the storage must be set in an Offline state in Disk Management. The storage is not limited in size, so it can be a multiterabyte LUN.  
  
When using physical disks that are directly attached to a virtual machine, you should be aware of the following:  
  
-   This type of disk cannot be dynamically expanded.  
  
-   You cannot use differencing disks with them.  
  
-   You cannot take virtual hard disk snapshots.  
  
1.  Map the storage device you plan to use to the server running Hyper\-V. In Disk Management, make sure the storage appears as a raw volume.  
  
2.  To initialize the raw volume, in Disk Management, right\-click the disk you want to initialize, and then click **Initialize Disk**. Note that before you can initialize the disk, it must be in an Online state.  
  
3.  In the **Initialize Disk** dialog box, select the disk to initialize. You can select whether to use the master boot record \(MBR\) or GUID partition table \(GPT\) partition style.  
  
4.  After a disk is initialized, return it to an Offline state. If the disk is not in an Offline state, it will not be available when configuring storage for a virtual machine.  
  
5.  Open Hyper\-V Manager.  
  
6.  If you have not yet created the virtual machine where you want to attach the physical hard disk, create it by using the **New Virtual Machine Wizard** in Hyper\-V Manager, and on the **Connect Virtual Hard Disk** page, select **Attach a virtual hard disk later**.  
  
7.  In Hyper\-V Manager, under **Virtual Machines**, select the virtual machine where you want to attach the physical hard disk.  
  
8.  In the **Action** pane, click **Settings**.  
  
9. In the navigation pane \(left pane\), click the controller that you want to attach the disk to. If you plan to use the disk as a startup disk, make sure you attach it to an IDE controller. Click **Add**.  
  
10. On the **Hard Drive** page, select the location on the controller to attach the disk.  
  
11. Under **Media**, specify the physical hard disk. If the disk does not appear in the drop\-down list under **Physical hard disks**, make sure the disk is in an Offline state in Disk Management.  
  
12. Once the physical disk is configured, you can start the virtual machine and store data on the disk. If installing an operating system, the installation process automatically prepares the disk for use. If you are using the physical disk to store data, it must first be prepared by the virtual machine.  
  
    If you are installing an operating system on the physical disk and it is in an Online state before the virtual machine is started, the virtual machine will fail to start. You must store the virtual machine configuration file in an alternate location because the physical disk is used by the operating system installation. For example, locate the configuration file on another internal drive on the host.  
  
