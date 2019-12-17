---
title: Manage Virtual Hard Disks (VHD)
description: This article describes how to manage Virtual Hard Disks
ms.date: 10/12/2017
ms.prod: windows-server 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jgerend 
---

# Manage Virtual Hard Disks (VHD)

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic describes how to create, attach, and detach virtual hard disks with Disk Management. Virtual hard disks (VHDs) are virtualized hard disk files that, once mounted, appear and operate pretty much identically to a physical hard drive. They're most commonly used with Hyper-V virtual machines. 

## Viewing VHDs in Disk Management

VHDs appear just like physical disks in Disk Management. When a VHD has been attached (that is, made available to the system for use), it appears blue. If the disk is detached (that is, made unavailable), its icon reverts to gray.

## Creating a VHD

> [!NOTE]
> You must be a member of the **Backup Operators** or **Administrators** group, at minimum, to complete these steps.

**To create a VHD**

1.  On the **Action** menu, select **Create VHD**.

2.  In the **Create and Attach Virtual Hard Disk** dialog box, specify both the location on the physical computer where you want the VHD file to be stored, and the size of the VHD.

3.  In **Virtual hard disk format**, select **Dynamically expanding** or **Fixed size**, and then click **OK**.

## Attaching and detaching a VHD

To make a VHD available for use (either one you have just created or another existing VHD): 

1. On the **Action** menu, select **Attach VHD**.

2. Specify the location of the VHD, using a fully-qualified path.

To detach the VHD, making it unavailable: 
Right-click the disk, select **Detach VHD**, and then click **OK**. Detaching a VHD does not delete the VHD or any data stored in it.

## Additional considerations

-   The path specifying the location for the VHD must be fully-qualified and cannot be in the \\Windows directory.
-   The minimum size for a VHD is 3 megabytes (MB).
-   A VHD can only be a basic disk.
-   Because a VHD is initialized when it is created, creating a large fixed-size VHD might take some time.
