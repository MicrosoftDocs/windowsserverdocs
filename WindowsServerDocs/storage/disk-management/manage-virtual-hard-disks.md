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
> To complete the following steps, you must be a member of the **Backup Operators** or **Administrators** group.

To create a VHD, follow these steps:

1. Open Disk Management. In the search box on the taskbar, enter **Computer Management**, and select **Disk Management**.
1. On the **Action** menu, select **Create VHD**.
1. When the **Create and Attach Virtual Hard Disk** dialog box opens, first specify the location on the physical computer where you want the VHD file to be stored and the size of the VHD.
    </br>Do the following steps in order.</br>
    </br>**For location**
     1. Under location, select the Browse button and locate the folder you want to store the VHD.
     1. Enter a name for drive in the File name field.
     1. Use the Saves as type file form the drop-down menu, select **Virtual Disk files (*.vhd)**.
     1. Select **Save**.</br>

    </br>**For virtual hard disk format**
    1. Select **Dynamically expanding** or **Fixed size**, then select **OK**.

## Attach a VHD

To make a VHD available for use (either one you have just created or another existing VHD) do the following:

1. Open Disk management. In the search box on the taskbar, enter **Computer Management**, and select **Disk Management**.
1. On the **Action** menu, select **Attach VHD**.
1. After the Attach Virtual Hard Disk dialog box appears, select the browse button, and locate the **.vhd** file. Then select **OK**.

## Detach a VHD

When you detach a VHD, you make it unavailable. You don't delete the VHD or any data stored on it.

1. Open Disk management. In the search box on the taskbar, enter **Computer Management**, and select **Disk Management**.
1. Right-click the disk, select **Detach VHD**, and then click **OK**. 

## Additional considerations

- The path specifying the location for the VHD must be fully-qualified and cannot be in the \\Windows directory.
- The minimum size for a VHD is 3 megabytes (MB).
- A VHD can only be a basic disk.
- A VHD is initialized when it's created, and creating a large fixed-size VHD may take some time.
