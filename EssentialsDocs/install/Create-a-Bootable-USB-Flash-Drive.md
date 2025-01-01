---
title: Create a bootable USB flash drive
description: Learn how to create a bootable USB flash drive to use to deploy Windows Server Essentials.
ms.date: 08/15/2024
ms.topic: article
ms.assetid: 2fe8e35c-69f9-40b3-a270-22e2402510d8
author: nnamuhcs
ms.author: roharwoo
manager: mtillman
---

# Create a bootable USB flash drive

>Applies to: Windows Server 2022 Essentials, Windows Server 2019 Essentials, Windows Server 2016 Essentials

You can create a bootable USB flash drive for deploying Windows Server Essentials. The first step is to prepare the USB flash drive by using DiskPart, which is a command-line utility. For information about DiskPart, see [DiskPart Command-Line Options](/windows-server/administration/windows-commands/diskpart).

> [!TIP]
> To create a bootable USB flash drive for recovering or reinstalling Windows on a PC instead of a server, see [Create a recovery drive](https://support.microsoft.com/help/4026852/windows-create-a-recovery-drive).

For additional scenarios in which you might want to create or use a bootable USB flash drive, see the following articles:

- [Restore a full system from an existing client computer backup](../manage/restore-a-full-system-from-an-existing-client-computer-backup.md)

- [Restore or repair your server running Windows Server Essentials](../manage/restore-or-repair-your-server-running-windows-server-essentials.md)


## To create a bootable USB flash drive

1.  Insert a USB flash drive into a running computer.

2.  Open a Command Prompt window as an administrator.

3.  Type `diskpart`, and then select ENTER.

4.  In the new command line window that opens, determine the USB flash drive number or drive letter by typing `list disk`, and then select ENTER. The `list disk` command displays all the disks on the computer. Note the drive number or drive letter of the USB flash drive.

5.  At the command prompt, type `select disk <X>`, where X is the drive number or drive letter of the USB flash drive, and then select ENTER.

6.  Type `clean`, and then select ENTER. This command deletes all data from the USB flash drive.

7.  To create a new primary partition on the USB flash drive, type `create partition primary`, and then select ENTER.

8.  To select the partition that you just created, type `select partition 1`, and then select ENTER.

9. To format the partition, type `format fs=ntfs quick`, and then select ENTER.

    > [!IMPORTANT]
    > If your server platform supports Unified Extensible Firmware Interface (UEFI), you should use the FAT32 format rather than NTFS. To format the partition as FAT32, type `format fs=fat32 quick`, and then select ENTER.

10. Type `active`, and then select ENTER.

11. Type `exit`, and then select ENTER.

12. When you finish preparing your custom image, save it to the root folder of the USB flash drive.

## Related content

- [Getting Started with the Windows Server Essentials ADK](Getting-Started-with-the-Windows-Server-Essentials-ADK.md)
- [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)
- [Additional Customizations](Additional-Customizations.md)
- [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)
- [Testing the Customer Experience](Testing-the-Customer-Experience.md)

- [Windows help and learning](https://windows.microsoft.com/windows/support)
