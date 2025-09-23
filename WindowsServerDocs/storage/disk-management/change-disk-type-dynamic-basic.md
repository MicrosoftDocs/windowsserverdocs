---
title: Convert a disk to Dynamic or Basic
description: Learn how to convert a disk type to Dynamic or Basic using Disk Management and the command line in Windows.
ms.date: 06/17/2025
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
---

# Convert a disk type to Dynamic or Basic

Converting a disk between dynamic and basic types allows you to change how storage is managed on your Windows system. Basic disks use primary partitions, extended partitions, and logical drives, making them suitable for most standard configurations. Dynamic disks offer advanced features like spanning, striping, and mirroring volumes, but are now deprecated and not recommended for new deployments. Instead, use basic disks or the newer [Storage Spaces](../storage-spaces/overview.md) technology when you want to pool disks together into larger volumes. If you want to mirror the volume from which Windows boots, you might want to use a hardware RAID controller, such as the one included on many motherboards.

## Prerequisites

You must be a member of the **Administrators** group (or have equivalent privileges) to convert a disk.

> [!IMPORTANT]
> Before you convert a disk, back up any data on the disk, and close any programs that access the disk.

## Convert a disk

You can convert your disk using either the Disk Management tool or the command line. Follow these steps for your method of choice.

# [Disk Management](#tab/disk-management)

Before you convert your disk type, back up or move the data off the disk.

1. Select **Start**, type **diskmgmt.msc**, then hit **Enter**.

1. Right-click on the volume pertaining to your disk.

1. Select **Delete Volume**, then select **Yes**. Repeat this step for all volumes on the disk.

1. Right-click on the disk and select either:

   1. **Convert to Dynamic Disk**, select the correct disk that you want to convert, then select **OK**.

   1. **Convert to Basic Disk**.

Once conversion is complete, you'll see either **Basic** or **Dynamic** under your disk. If a new volume is created, you can see the disk type under the **Type** column.

# [Diskpart](#tab/diskpart)

Before you convert partition styles, back up or move the data off the disk.

1. Open an elevated command prompt window, type **diskpart**, then hit **Enter**.

1. Prepare your disk for conversion by cleaning (deleting) any partitions or volumes.

   > [!NOTE]
   > If your disk doesn't have any partitions or volumes, skip to step **3** to convert your disk.

   1. Type **list disk** and hit **Enter**. Note of the disk number that you want to convert.

   1. Type **select disk**, provide the disk number you want to convert, then hit **Enter**.

   1. Type **clean** to delete all partitions and volumes on the disk.

1. Type **convert basic** or **convert dynamic**, then hit **Enter**.

Once conversion is complete, you're notified of the process.

# [PowerShell](#tab/powershell)

Before you convert partition styles, back up or move the data off the disk.

1. Open an elevated PowerShell window.

1. Prepare your disk for conversion by cleaning (deleting) any partitions or volumes.

   > [!NOTE]
   > If your disk doesn't have any partitions or volumes, skip to step **3** to convert your disk.

   1. To list all disks, run the following command:

      ```powershell
      Get-Disk
      ```

      Note the disk number you want to convert.

   1. To remove all partitions and volumes from the disk, run the following command. Replace `<Disk Number>` with the disk number you noted earlier:

      ```powershell
      Clear-Disk -Number <Disk Number> -RemoveData -Confirm:$false
      ```

1. To convert the disk type to **basic**, run the following command and replace `Disk Number` with your actual disk number:

   ```powershell
   $diskNumber = Disk Number
   $convert = @(
     "select disk $diskNumber",
     "convert basic"
   )
   $convert | ForEach-Object { $_ } | diskpart
   ```

   To convert the disk type to **dynamic**, run the following command and replace `Disk Number` with your actual disk number:

   ```powershell
   $diskNumber = Disk Number
   $convert = @(
     "select disk $diskNumber",
     "convert dynamic"
   )
   $convert | ForEach-Object { $_ } | diskpart
   ```

Once conversion is complete, you're notified of the process.

---

## Related links

- [Convert a disk to GPT or MBR partition scheme](change-disk-partition-scheme.md)

