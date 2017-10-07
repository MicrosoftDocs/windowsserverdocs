---
title: Change a basic disk into a dynamic disk
description: This topic describes how to change a basic disk to a dynamic disk to create volumes spanning multiple disks.
ms.prod: windows-server-threshold 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jrgerend 
---

# Change a basic disk into a dynamic disk

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

When you change a basic disk to a dynamic disk, you can create volumes that span multiple disks (spanned and striped volumes). Dynamic volumes can be used in most but not all situations.

Basic disks support only primary partitions, extended partitions, and logical drives. Basic disks have been supported in operating systems since MS-DOS, while dynamic disks have been supported in operating systems since Windows 2000.

<br />

> [!CAUTION]
> Do not convert disks to dynamic that contain multiple installations of Windows 2000, Windows XP Professional, or the Windows Server 2003 family of operating systems. It is likely that you will no longer be able to start the second installation. For more information, see [How basic disks and volumes work](http://go.microsoft.com/fwlink/?LinkId=64134).

<br />

> [!NOTE]
> The decision to convert a basic disk to a dynamic disk has implications that should be considered carefully. 
Before you convert disks, close any programs that are running on those disks.

## Changing a basic disk into a dynamic disk

-   [Using the Windows interface](#BKMK_WINUI)
-   [Using a command line](#BKMK_CMD)

> [!NOTE]
> You must be a member of the **Backup Operators** or **Administrators** group, at minimum, to complete these steps.

<a id="BKMK_WINUI"></a>
#### To change a basic disk into a dynamic disk using the Windows interface

1.  In Disk Management, right-click the basic disk you want to convert.

2.  Click **Convert to Dynamic disk**.

3.  Follow the on-screen instructions.

> [!NOTE]
> If you do not see the **Convert to Dynamic disk** menu item, check that you are not right-clicking a volume instead of a disk. The disk might have been previously converted to a dynamic disk, or the computer is a portable computer. (Dynamic disks are not supported on portable computers, removable disks, detachable disks that use Universal Serial Bus (USB) or IEEE 1394 (also called FireWire) interfaces, or on disks connected to shared SCSI buses.) In addition, you cannot convert cluster disks connected to shared SCSI or Fibre Channel buses to dynamic disks. The Cluster service supports basic disks only.)

> [!CAUTION]
> If you are using a basic disk as a storage area for shadow copies and you intend to convert the disk containing shadow copies into a dynamic disk, 
it is important to take the following precautions before doing so, to avoid data loss: 
  -    If the disk is a non-boot volume, and is a different volume from where the original files reside, you must first dismount and take offline the volume containing the original files.
  -    You must bring the volume containing the original files back online within 20 minutes, otherwise, you will lose the data stored in the existing shadow copies. 
  
  If the shadow copies are located on a boot volume, you can convert the disk to dynamic without losing shadow copies. You can use the **mountvol** command with the **/p** option to dismount the volume and take it offline. You can mount the volume and bring it online using either the **mountvol** command or the Disk Management snap-in.

<a id="BKMK_CMD"></a>
#### To change a basic disk into a dynamic disk using a command line
1.  Open a command prompt and type `diskpart`.

2.  At the **DISKPART** prompt, type `list disk`. Note the disk number you want to convert to dynamic.

3.  At the **DISKPART** prompt, type `select disk <disknumber>`.

4.  At the **DISKPART** prompt, type `convert dynamic`.

<br />

| Value | Description |
| --- | --- |
| <p>**list disk**</p> | <p>Displays a list of disks and information about them, such as their size, the amount of available free space, whether the disk is a basic or dynamic disk, and whether the disk uses the Master Boot Record (MBR) or GUID partition table (GPT) partition style. The disk marked with an asterisk (*) has focus.</p> |
| <p>**select disk**</p> | <p>Selects the specified disk, where <em>disknumber</em> is the disk number, and gives it focus.</p> |
| <p>**convert dynamic**</p> | <p>Converts a basic disk into a dynamic disk. Any existing partitions on the disk become simple volumes.</p>  |

## Additional considerations

-   For additional information about converting basic disks to dynamic disks, see http://go.microsoft.com/fwlink/?LinkId=64136.
-   After you convert a basic disk to a dynamic disk, you cannot change the dynamic volumes back to partitions. Instead, you must delete all dynamic volumes on the disk and then use the **Convert To Basic Disk** command. 
-   If you want to keep your data, you must first back it up or move it to another volume.
-   Once converted, a dynamic disk will not contain basic volumes (primary partitions or logical drives).
-   When you convert a basic disk to a dynamic disk, any existing partitions or logical drives on the basic disk become simple volumes on the dynamic disk.
-   For the conversion to succeed, any Master Boot Record (MBR) disks to be converted must contain at least 1 megabyte (MB) of space for the dynamic disk database.

## See Also

-   [Command-line syntax notation](https://technet.microsoft.com/library/cc742449(v=ws.11).aspx)


