---
title: Convert a disk to GPT or MBR
description: Learn how to convert a disk to GPT or MBR partition scheme (style) using Disk Management and the command line in Windows.
ms.date: 06/17/2025
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
---

# Convert a disk to GPT or MBR partition scheme

Master Boot Record (MBR) disks use the legacy BIOS partitioning scheme (also known as partition style) and supports up to four primary partitions per disk. MBR is limited to disks of 2 TB or smaller and isn't recommended for larger drives. GUID Partition Table (GPT) disks use the modern Unified Extensible Firmware Interface (UEFI), supports more than four partitions, and can manage disks larger than 2 TB.

You can convert a disk's partition style only if it doesn't contain any partitions or volumes. Make sure to delete all existing partitions or volumes before attempting to change the disk's format.

## Prerequisites

You must be a member of the **Administrators** group (or have equivalent privileges) to convert a disk.

> [!IMPORTANT]
> Before you convert a disk, back up any data on the disk, and close any programs that access the disk.

## Convert a disk

You can convert your disk using either the Disk Management tool or the command line. Follow these steps for your method of choice.

# [Disk Management](#tab/disk-management)

Before you convert partition styles, back up or move the data off the disk.

1. Select **Start**, type **diskmgmt.msc**, then select **Enter**.

1. Right-click on the volume pertaining to your disk.

1. Select **Delete Volume**, then select **Yes**. Repeat this step for all volumes on the disk.

1. Right-click on the disk, then select **Convert to MBR Disk** or **Convert to GPT Disk**.

1. To verify the conversion process, right-click on your disk, select **Properties**, select the **Volumes** tab, and check the partition style information.

# [Diskpart](#tab/diskpart)

Before you convert partition styles, back up or move the data off the disk.

1. Open an elevated command prompt window, type **diskpart**, then hit **Enter**.

1. Prepare your disk for conversion by cleaning (deleting) any partitions or volumes.

   > [!NOTE]
   > If your disk doesn't have any partitions or volumes, skip to step **3** to convert your disk.

   1. Type **list disk** and hit **Enter**. Make a note of the disk number that you want to convert.

   1. Type **select disk**, provide the disk number you want to convert, then hit **Enter**.

   1. Type **clean** to delete all partitions and volumes on the disk.

1. To convert GPT to MBR, type **convert mbr**, then hit **Enter**.

   To convert MBR to GPT, type **convert gpt**, then hit **Enter**.

You're notified when the conversion process completes. To learn more, see the [diskpart](/windows-server/administration/windows-commands/diskpart) commands reference.

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

1. To convert the partitioning style, run the following command:

   For MBR to GPT conversion:

   ```powershell
   Initialize-Disk -Number <Disk Number> -PartitionStyle GPT
   ```

   For GPT to MBR conversion:

   ```powershell
   Initialize-Disk -Number <Disk Number> -PartitionStyle MBR
   ```

   > [!NOTE]
   > Once a disk is initialized, you can't convert it to another partition style without first running the `Clear-Disk` cmdlet again.

1. To verify the conversion process, run the following command and check the *Partition Style* column:

   ```powershell
   Get-Disk
   ```

---

## See also

- [Convert a disk type to Dynamic or Basic](change-disk-type-dynamic-basic.md)

