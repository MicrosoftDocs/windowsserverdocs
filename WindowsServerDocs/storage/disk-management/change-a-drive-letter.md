---
title: Change a drive letter
description: How to change or assign a drive letter in Windows by using Disk Management.
ms.date: 12/22/2017
ms.prod: windows-server-threshold 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jgerend 
---
# Change a drive letter

> **Applies To:** Windows 10, Windows 8.1, Windows 7, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

If you don't like the drive letter assigned to a disk, or if you've got a disk that doesn't yet have a drive letter, you can use Disk Management to change it.

> [!IMPORTANT]
> If you change the drive letter of a disk where Windows or apps are installed, apps might have trouble running or finding that disk. For this reason we suggest that you don't change the drive letter of a disk on which Windows or apps are installed.

Here's how to change the drive letter (to instead to mount the disk in an empty folder so that it appears as just another folder, see [Assign a mount point folder path to a drive](assign-a-mount-point-folder-path-to-a-drive.md)).

1. In Disk Management, right-click the disk for which you want to change or add a drive letter, and then select **Change Drive Letter and Paths**.<br>
![Disk Management showing a drive](media/change-drive-letter.png)
1. To change the drive letter, select **Change**. To add a drive letter if the disk doesn't already have one, select **Add**.<br>![The Change Drive Letter and Paths dialog](media/change-drive-letter2.png)
3. Select the new drive letter, select **OK**, and then select **Yes** when prompted about how programs that rely on the drive letter might not run correctly.<br>![The Change Drive Letter or Path dialog showing changing the drive letter](media/change-drive-letter3.png)