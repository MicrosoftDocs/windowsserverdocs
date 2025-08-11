---
title: Manage Virtual Hard Disks (VHD)
description: Manage virtual hard disks (VHDs) with the Disk Management utility in Windows, where you can view, create, attach, and detach a VHD.
ms.topic: how-to
ms.author: daknappe
author: dknappettmsft
ms.date: 06/24/2025
#customer intent: As an administrator, I want to use Disk Management in Windows to manage VHDs, so I can create, view, attach, and detach VHDs.
---

# Manage Virtual Hard Disks (VHDs)

You can create, attach, and detach virtual hard disks (VHDs) with the Disk Management system utility in Windows. VHDs are disk image file formats that have similar functionalities to a physical hard drive. The VHD file type is `.vhd` or `.vhdx` (recommended). VHDs are designed primarily for use with Hyper-V virtual machines.

A VHD is created and initialized at the same time. In the Disk Management view, the VHD looks just like a physical disk. When the VHD is attached and available for use, the disk icon is colored blue. When the VHD is detached and unavailable, the disk icon is colored gray.

## Prerequisites

To complete the procedures in this article, the following prerequisite must be met:

- The user account must be a member of the **Backup Operators** or **Administrators** group.

## Create a VHD

To create a VHD, follow these steps:

1. From the Windows **Start** menu, search for and open Disk Management with Administrator permissions.

1. Expand the **Action** menu and select **Create VHD**.

1. In the **Create and Attach Virtual Hard Disk** dialog, specify the location on the physical computer where you want to store the VHD file:

   1. For the **Location** field, select **Browse**. Locate and select the folder to store the new VHD, and select **OK**.

      > [!NOTE]
      > The location must be a fully qualified path that doesn't include the _\Windows_ directory.

   1. For the **File name** field, enter a name for the new VHD.

   1. Expand the **Save as type** dropdown list and select **Virtual Disk files (*.vhdx)**.

   1. Select **Save**.

1. For the **Virtual hard disk size** field, enter the file size for the new VHD.

   > [!NOTE]
   > A VHD can be only a basic disk with a minimum size of 3 megabytes (MB). A large fixed-size VHD can take extra time to create.

1. For the **Virtual hard disk type** field, select **Dynamically expanding** or **Fixed size**.

1. Select **OK** to finish.

## Attach a VHD

To make a VHD available for use (either a disk you created or another existing VHD), follow these steps:

1. From the Windows **Start** menu, search for and open Disk Management with Administrator permissions.

1. Expand the **Action** menu and select **Attach VHD**.

1. In the **Attach Virtual Hard Disk** dialog, select **Browse**. Locate and select the `.vhdx` or `.vhd` file for the VHD, and select **OK**.

1. In the **Attach Virtual Hard Disk** dialog, select **OK** to finish.

## Detach a VHD

When you detach a VHD, you make the disk unavailable. You don't delete the VHD or any data stored on the disk.

Detach a VHD by following these steps:

1. From the Windows **Start** menu, search for and open Disk Management with Administrator permissions.

1. Locate the VHD that you want to attach in the list of disks.

1. Right-click the VHD, select **Detach VHD**, and then select **OK**.
