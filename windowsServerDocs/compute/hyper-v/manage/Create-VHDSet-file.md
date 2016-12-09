---
title: Creating Hyper-V VHD Set files
description: Steps to create a VHDset file on Hyper-v 2016
author: Jim Wooldridge
ms.author: jiwool
manager: senthilr
ms.date: 12/09/2016
ms.topic: article
ms.prod: windows-server-threshold
ms.technology:
ms.assetid: 444e1496-9e5a-41cf-bfbc-306e2ed8e00a
audience: IT Pros
ms.reviewer: kathydav
---

# Creating Hyper-V VHD Set files
VHD Set files are a new shared Virtual Disk model for guest clusters in Windows Server 2016. VHD Set files enable shared Virtual Disks to be resized online, support Hype-V Replica, and enjoy the benefits of application consistent checkpoints. 

VHD Set files are a meta data file used to store VM group virtual disk snapshot information for guest clusters.  VHD Set files are recognized by a new VHD file type, .VHDS.  All aspects of managing the shared VHD Set file VM group snapshot chains, and merging, is handled within the new Hyper-V 2016 infrastructure. Management software can execute meta operations (like online resize) on VHD Set files in the same manner they execute them on VHDX files. Consequently, management software does not require knowledge of the VHD Set file format. 

## Creating a VHD Set file from the Hyper-V UI
1.	Open Hyper-V Manager. Click **Start**, point to **Administrative Tools**, and then click **Hyper-V Manager**.
2.	In the Action pane, click **New**, and then click **Hard Disk**.
3.	On the Choose Disk Format page of the wizard, select **VHD Set** as the format of the virtual hard disk.
4.	Continue through the pages of the wizard to customize the virtual hard disk. You can click **Next** to move through each page of the wizard, or you can click the name of a page in the left pane to move directly to that page.
5.	After you have finished configuring the virtual hard disk, click **Finish**.

## Creating a VHD Set file from Powershell
Use the powershell cmdlet New-VHD, with the filetype .VHDS in the file path. For example, the following creates a VHD Set file named base.vhds that is 10 Gigabytes in size.

PS c:\>New-VHD -Path c:\base.vhds -SizeBytes 10GB

## Migrating a shared VHDX file to a VHD Set file
Migrating an existing shared VHDX to a VHDS requires taking the VM offline. The follow are the best practice steps for migrating a shared VHDX to a VHD Set file. 

1.	Remove the VHDX from the VM 
-	PS c:\>Remove-VMHardDiskDrive existing.vhdx
2.	Convert the VHDX to a VHDS
-	PS c:\>Convert-VHD existing.vhdx new.vhds
3.	Add the VHDS to the VM
-	PS c:\>Add-VMHardDiskDrive new.vhds




