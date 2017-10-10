---
title: Reactivate a missing or offline dynamic disk
description: This article describes how to reactivate a missing or offline dynamic disk
ms.date: 10/10/2017
ms.prod: windows-server-threshold 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jgerend 
---

# Reactivate a missing or offline dynamic disk

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

A dynamic disk: 
-  May become **Missing** when it is corrupted, powered down, or disconnected. 
- May become **Offline** if it is corrupted or intermittently unavailable. 
- May become **Offline** if you attempt to import a foreign (dynamic) disk and the import fails. An error icon appears on the **Offline** disk.

> [!NOTE]
> Only dynamic disks display the **Missing** or **Offline** status. Also, only dynamic disks can be reactivated.
 
## Reactivating a missing or offline dynamic disk

-   [Using the Windows interface](#BKMK_WINUI)
-   [Using a command line](#BKMK_CMD)

> [!NOTE]
> You must be a member of the **Backup Operators** or **Administrators** group, at minimum, to complete these steps.

<a id="BKMK_WINUI"></a>
#### To reactivate a dynamic disk by using the Windows interface

1.  In Disk Management, right-click the disk marked **Missing** or **Offline**.

2.  Click **Reactivate Disk**. The disk should be marked **Online** after the disk is reactivated.

<a id="BKMK_CMD"></a>
#### To reactivate a dynamic disk by using a command line

1.  Open a command prompt and type `diskpart`.

2.  At the **DISKPART** prompt, type `list disk`. Note the disk number of the missing or offline disk that you want to bring online. Missing disks are numbered M0, M1, M2, and so on, and offline disks are numbered 0, 1, 2, and so on.

3.  At the **DISKPART** prompt, type `select disk <disknumber>`.

4.  At the **DISKPART** prompt, type `online`.

<br />

| Value  | Description |
|--- | --- |
| <p>**list disk**</p> | <p>Displays a list of disks and information about them, such as their size, the amount of available free space, whether the disk is a basic or dynamic disk, and whether the disk uses the Master Boot Record (MBR) or GUID Partition Table (GPT) partition style. The disk marked with an asterisk (*) has focus.</p> |
| <p>**select disk** <em>disknumber</em></p> | <p>Sets the focus to the specified disk, where <em>disknumber</em> is the disk number.</p> |
| <p>**online**</p> | <p>Brings an offline disk or volume with focus online.</p>|

## See Also

-   [Command-line syntax notation](https://technet.microsoft.com/library/cc742449(v=ws.11).aspx)


