---
title: Create Hyper-V VHD Set files
description: Steps to create a VHDset file on Hyper-v 2016
author: jiwool
ms.author: jiwool
manager: senthilr
ms.date: 01/26/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: compute-hyper-v
ms.assetid: 444e1496-9e5a-41cf-bfbc-306e2ed8e00a
audience: IT Pros
ms.reviewer: kathydav
---

# Create Hyper-V VHD Set files
VHD Set files are a new shared Virtual Disk model for guest clusters in Windows Server 2016. VHD Set files support online resizing of shared virtual disks, support Hyper-V Replica, and can be included in application-consistent checkpoints. 

VHD Set files use a new VHD file type, .VHDS. VHD Set files store checkpoint information about the group virtual disk used in guest clusters, in the form of metadata.

Hyper-V handles all aspects of managing the checkpoint chains and merging the shared VHD set. Management software can run disk operations like online resizing on VHD Set files in the same way it does for .VHDX files. This means that management software doesn't need to know about the VHD Set file format.

## Create a VHD Set file from Hyper-V Manager

1.	Open Hyper-V Manager. Click **Start**, point to **Administrative Tools**, and then click **Hyper-V Manager**.
2.	In the Action pane, click **New**, and then click **Hard Disk**.
3.	On the **Choose Disk Format** page, select **VHD Set** as the format of the virtual hard disk.
4.	Continue through the pages of the wizard to customize the virtual hard disk. You can click **Next** to move through each page of the wizard, or you can click the name of a page in the left pane to move directly to that page.
5.	After you have finished configuring the virtual hard disk, click **Finish**.

## Create a VHD Set file from Windows PowerShell

Use the [New-VHD](https://technet.microsoft.com/library/hh848503.aspx) cmdlet, with the file type .VHDS in the file path. This example creates a VHD Set file named base.vhds that is 10 Gigabytes in size.

``` PowerShell
PS c:\>New-VHD -Path c:\base.vhds -SizeBytes 10GB
```

## Migrate a shared VHDX file to a VHD Set file

Migrating an existing shared VHDX to a VHDS requires taking the VM offline. This is the recommended process using Windows PowerShell:

1. Remove the VHDX from the VM. For example, run: 
   ``` PowerShell
   PS c:\>Remove-VMHardDiskDrive existing.vhdx
   ```
  
2. Convert the VHDX to a VHDS. For example, run:
   ``` PowerShell
   PS c:\>Convert-VHD existing.vhdx new.vhds
   ```
  
3. Add the VHDS to the VM. For example, run:
   ``` PowerShell
   PS c:\>Add-VMHardDiskDrive new.vhds
   ```
  



