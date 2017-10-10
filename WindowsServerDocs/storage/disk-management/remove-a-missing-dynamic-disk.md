---
title: Remove a missing dynamic disk
description: This article describes how to remove a missing dynamic disk
ms.date: 10/10/2017
ms.prod: windows-server-threshold 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jgerend 
---

# Remove a missing dynamic disk

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

A dynamic disk may become **Missing** when it is corrupted, powered down, or disconnected.

> [!IMPORTANT]
> Do not delete the volumes from a missing dynamic disk unless you are certain that the disk will not be powered up, reconnected, repaired or otherwise returned to the computer. Otherwise, you will not be able to access those volumes when the disk is returned to the computer.

## Removing a missing dynamic disk

-   [Using the Windows interface](#BKMK_WINUI)
-   [Using a command line](#BKMK_CMD)

> [!NOTE]
> You must be a member of the **Backup Operators** or **Administrators** group, at minimum, to complete these steps.

<a href="" id="BKMK_WINUI"></a>
**To remove a missing dynamic disk using the Windows interface**
1.  In Disk Manager, right-click each volume on the dynamic disk marked **Missing**, and then click **Delete Volume** to remove all volumes on the **Missing** disk.

2.  Right-click the dynamic disk marked **Missing**, and then click **Remove Disk**.

<a href="" id="BKMK_CMD"></a>
**To remove a missing dynamic disk using a command line**

1.  Open a command prompt and type `diskpart`.

2.  At the **DISKPART** prompt, type `list disk`. Make note of the disk number you want to remove from the disk list. Missing disks are numbered M0, M1, M2, and so on.

3.  At the **DISKPART** prompt, type `select disk <disknumber>`.

4.  At the **DISKPART** prompt, type `delete disk`.

<br />

| Value | Description |
| --- | --- |
| <p>**list disk**</p> | <p>Displays a list of disks and information about them, such as their size, the amount of available free space, whether the disk is a basic or dynamic disk, and whether the disk uses the Master Boot Record (MBR) or GUID Partition Table (GPT) partition style. The disk marked with an asterisk (*) has focus.</p> |
| <p>**select disk** <em>disknumber</em></p> | <p>Selects the specified disk, where <em>disknumber</em> is the disk number, and gives it focus.</p> |
| <p>**delete disk**</p>| <p>Deletes a missing dynamic disk from the disk list.</p> |



## See Also

-   [Command-line syntax notation](https://technet.microsoft.com/library/cc742449(v=ws.11).aspx)


