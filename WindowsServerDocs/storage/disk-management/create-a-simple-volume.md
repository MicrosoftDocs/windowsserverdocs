---
title: Create a simple volume
description: Describes how to create a simple volume from disk space from a dynamic disk.
ms.date: 10/10/2017
ms.prod: windows-server-threshold 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jgerend 
---

# Create a simple volume

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

A simple volume is a dynamic volume that is made up of disk space from a single dynamic disk. A simple volume can consist of a single region on a disk or multiple regions of the same disk that are linked together. You can create simple volumes only on dynamic disks. Simple volumes are not fault tolerant.

## Creating a simple volume

-   [Using the Windows interface](#BKMK_WINUI)
-   [Using a command line](#BKMK_CMD)

> [!NOTE]
> You must be a member of the **Backup Operators** or **Administrators** group, at minimum, to complete these steps.

<a id="BKMK_WINUI"></a>
#### To create a simple volume using the Windows interface

1.  In Disk Management, right-click the unallocated space on the dynamic disk on which you want to create the simple volume, and then click **New Simple Volume**.

2.  In the New Volume Wizard, click **Next**, click **Simple**, and then follow the on-screen instructions.

<a id="BKMK_CMD"></a>
#### To create a simple volume using a command line

1.  Open a command prompt and type `diskpart`.

2.  At the **DISKPART** prompt, type `list disk`. Make note of the number of the disk where you want to create a simple volume.

3.  At the **DISKPART** prompt, type `create volume simple [size=<size>] [disk=<disknumber>]`.

4.  At the **DISKPART** prompt, type `assign letter=<driveletter>`.

<br />

| Value | Description |
| --- | --- |
<p>**list disk**</p> | <p>Displays a list of disks and information about them, such as their size, the amount of available free space, whether the disk is a basic or dynamic disk, and whether the disk uses the Master Boot Record (MBR) or GUID Partition Table (GPT) partition style. The disk marked with an asterisk (*) has focus.</p> |
| <p>**create volume simple**</p> | <p>Creates a simple volume. After you create the volume, the focus automatically shifts to the new volume.</p>    |
| <p>**size=** <em>size</em></p> | <p>The size of the volume in megabytes (MB). If no size is given, the new volume takes up the remaining free space on the disk.</p>   |
| <p>**disk=** <em>disknumber</em></p>  | <p>The dynamic disk on which to create the volume. If no disk is given, the current disk is used.</p> |
| <p>**assign letter**=<em>driveletter</em></p> | <p>Assigns a drive letter, <em>driveletter</em>, to the volume with focus. If no drive letter or mount point is specified, the next available drive letter is assigned. If the drive letter or mount point is already in use, an error is generated.</p>|

## See Also

-   [Command-line syntax notation](https://technet.microsoft.com/library/cc742449(v=ws.11).aspx)


