---
title: Create a striped volume
description: Describes how to create a striped volume that stores data in stripes across two or more physical disks. 
ms.prod: windows-server-threshold 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jrgerend 
---

# Create a striped volume

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

A striped volume is a dynamic volume that stores data in stripes on two or more physical disks. Data in a striped volume is allocated alternately and evenly (in stripes) across the disks. Striped volumes offer the best performance of all the volumes that are available in Windows, but they do not provide fault tolerance. If a disk in a striped volume fails, the data in the entire volume is lost.

You can create striped volumes only on dynamic disks. Striped volumes cannot be extended. You can create a striped volume onto a maximum of 32 dynamic disks.

## Creating a striped volume


-   [Using the Windows interface](#BKMK_WINUI)
-   [Using a command line](#BKMK_CMD)

> [!NOTE]
> You must be a member of the **Backup Operators** or **Administrators** group, at minimum, to complete these steps.

<a id="BKMK_WINUI"></a>
**To create a striped volume using the Windows interface**
1.  In Disk Management, right-click the unallocated space on one of the dynamic disks on which you want to create the striped volume, and then click **New Striped Volume**.

2.  Follow the on-screen instructions.

<a id="BKMK_CMD"></a>
**To create a striped volume using a command line**

1.  Open a command prompt and type `diskpart`.

2.  At the **DISKPART** prompt, type `list disk`.  Note the number of the disk on which you want to create a striped volume.

3.  At the **DISKPART** prompt, type `create volume stripe [size=<size>] [disk=<disknumber>[,<seconddisknumber>]]`.

<br />

| Value | Description  |
| --- | --- |
| <p>**list disk**</p>  | <p>Displays a list of disks and information about them, such as their size, the amount of available free space, whether the disk is a basic or dynamic disk, and whether the disk uses the Master Boot Record (MBR) or GUID Partition Table (GPT) partition style. The disk marked with an asterisk (*) has focus.</p> |
| <p>**create volume stripe**</p> | <p>Creates a striped volume on the specified disks. After you create the volume, the focus automatically shifts to the new volume.</p> |
| <p>**size=** <em>size</em></p> | <p>The amount of disk space, in megabytes (MB), that the volume will occupy on each disk. If no size is given, the new volume takes up the remaining free space on the smallest disk and an equal amount of space on each subsequent disk.</p>  |
| <p>**disk=** <em>disknumber</em></p> | <p>The dynamic disks on which to create the volume. An amount of space equal to **size=**<em>size</em> is allocated on each disk.</p> |


## See Also

-   [Command-line syntax notation](https://technet.microsoft.com/library/cc742449(v=ws.11).aspx)


