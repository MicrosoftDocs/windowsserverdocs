---
title: Move disks to another computer
description: This article describes how to move disks to another computer
ms.date: 10/12/2017
ms.prod: windows-server 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jgerend 
---

# Move disks to another computer

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This section describes the steps to take, and the considerations associated with, moving disks to another computer. You might want to print this procedure or write down the steps before attempting to move disks from one computer to another.

> [!NOTE]
> You must be a member of the **Backup Operators** or **Administrators** group, at minimum, to complete these steps.

## Verify volume health

Use Disk Management to make sure the status of the volumes on the disks is **Healthy**. If the status is not **Healthy**, repair the volumes before you move the disks.

To verify the volume status, from the **View** menu, check the **Status** column in the **Volume List** view, or under the **volume size** and file system information in the **Graphical View**.

## Uninstall the disks

Uninstall the disks you want to move using Device Manager.

**To uninstall disks**

1.  Open Device Manager in Computer Management.

2.  In the device list, double-click **Disk drives**.

3.  Right-click the disks you want to uninstall, and then click **Uninstall**.

4.  In the **Confirm Device Removal** dialog box, click **OK**.

## Remove dynamic disks

1. If the disks you want to move are dynamic disks, in Disk Management, right-click the disks you want to move, and then click **Remove Disk**.

2. After having removed dynamic disks, or if you are moving basic disks, you can now physically disconnect them. If the disks are external, you can now unplug them from the computer. If the disks are internal, turn off the computer, and then physically remove them.

## Install disks in the new computer

1. If the disks are external, plug them into the computer. If the disks are internal, make sure the computer is turned off and then physically install the disks in that computer.

2. Start the computer that contains the disks you moved and follow the instructions in the Found New Hardware dialog box.

## Detect new disks

1. On the new computer, open Disk Management. 
2. Click **Action** and then click **Rescan Disks**.
3. Right-click any disk marked **Foreign**. 
4. Click **Import Foreign Disks** and then follow the on-screen instructions.

## Additional considerations

-   When moved to another computer, basic volumes receive the next available drive letter on that computer. 
-   Dynamic volumes retain the drive letter they had on the previous computer. If a dynamic volume did not have a drive letter on the previous computer, it will not receive a drive letter when moved to another computer. If the drive letter is already used on the computer where a volume is moved, the volume receives the next available drive letter.

-   If an administrator has used either the **mountvol /n** or the **diskpart automount** command to prevent new volumes from being added to the system, volumes moved from another computer are prevented from being mounted and from receiving a drive letter. To use the volume, you must manually mount the volume and assign it a drive letter using Disk Management or the **DiskPart** and **mountvol** commands.

-   If you are moving spanned, striped, mirrored, or RAID-5 volumes, it is highly recommended that you move all disks containing the volume together. Otherwise, the volumes on the disks cannot be brought online and will not be accessible except to delete them.

-   You can move multiple disks from different computers to a computer by installing the disks, opening Disk Management, right-clicking any of the new disks, and then clicking **Import Foreign Disks**. When importing multiple disks from different computers, always import all the disks from one computer at a time. For example, if you want to move disks from two computers, import all disks from the first computer and then import all disks from the second computer.

-   Disk Management describes the condition of the volumes on the disks before they are imported. Review this information carefully. If there are any problems, this information will tell you what will happen to each volume on these disks once the disks have been imported.

-   If you move a GUID Partition Table (GPT) disk containing the Windows operating system to an x86-based or x64-based computer, you can access the data, but you cannot boot from that operating system.