---
title: Manage Virtual Hard Disks (VHD)
description: Learn about Virtual Hard Disks (VHD) and how to manage them with Disk Management, where you can view, create, attach, and detach them in a computer.
ms.date: 03/10/2023
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---

# Manage Virtual Hard Disks (VHD)

> **Applies To:** Windows 11, Windows 10, Windows Server 2022. Windows Server 2019, Windows Server 2016

This article describes how to create, attach, and detach virtual hard disks with Disk Management. Virtual hard disks (VHDs) are disk image file formats that have similar functionalities to a physical hard drive and are designed primarily for use with Hyper-V virtual machines.

## View a VHD in Disk Management

VHDs appear just like physical disks in Disk Management. When a VHD has been attached and made available to the system for use, it appears blue. If the disk is detached and made unavailable, its icon reverts to gray.

## Create a VHD

> [!NOTE]
> To complete the following steps, you must be a part of the **Backup Operators** or **Administrators** group.

To create a VHD follow these steps:

1. Open Disk Management. In the search box on the taskbar, enter **Computer Management**, and select **Disk Management**.

1. On the **Action** menu, select **Create VHD**.

1. In the **Create and Attach Virtual Hard Disk** dialog box, specify both the location on the physical computer where you want the VHD file to be stored and the size of the VHD.

1. In **Virtual hard disk format**, select **Dynamically expanding** or **Fixed size**, and then click **OK**.

## Attaching and detaching a VHD

To make a VHD available for use (either one you have just created or another existing VHD):

1. On the **Action** menu, select **Attach VHD**.

2. Specify the location of the VHD, using a fully-qualified path.

To detach the VHD, making it unavailable:
Right-click the disk, select **Detach VHD**, and then click **OK**. Detaching a VHD does not delete the VHD or any data stored in it.

## Additional considerations

- The path specifying the location for the VHD must be fully-qualified and cannot be in the \\Windows directory.
- The minimum size for a VHD is 3 megabytes (MB).
- A VHD can only be a basic disk.
- Because a VHD is initialized when it is created, creating a large fixed-size VHD might take some time.
