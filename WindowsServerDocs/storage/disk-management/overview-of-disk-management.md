---
title: Overview of Disk Management
description: Learn how to use the Disk Management system utility in Windows to initialize drives, extend volumes, shrink partitions, and change drive letters.
ms.date: 03/20/2023
ms.topic: conceptual
author: JasonGerend
manager: brianlic
ms.author: jgerend
---

# Overview of Disk Management

> **Applies To:** Windows 11, Windows 10, Windows Server 2022, Windows Server 2019, Windows Server 2016

Disk Management is a system utility in Windows for advanced storage operations. Here are some tasks you can complete with Disk Management:

- Set up a new drive. For more information, see [Initialize new disks](initialize-new-disks.md).

- Extend a volume into space that's not already part of a volume on the same drive. For more information, see [Extend a basic volume](extend-a-basic-volume.md).

- Shrink a partition, such as to enable extending into a neighboring partition. For more information, see [Shrink a basic volume](shrink-a-basic-volume.md).

- Change a drive letter or assign a new drive letter. For more information, see [Change a drive letter](change-a-drive-letter.md).

## Review drives and partitions

Disk Management shows the details for each drive on your PC and all partitions for each drive. The details include statistics about the partitions, including the amount of space allocated or used.

The following image shows the Disk Management overview for several drives. Disk 0 has three partitions, and Disk 1 has two partitions. On Disk 0, the C: drive for Windows uses the most disk space. Two other partitions for system operations and recovery use a smaller amount of disk space.

:::image type="content" source="./media/disk-management.png" alt-text="Screenshot that shows the Disk Management utility in Windows as described in the text." border="false":::

Windows typically includes three partitions on your main drive (usually the C:\ drive). These partitions include the EFI System Partition, the Local Disk (C:) Partition, and a Recovery Partition.

- The Windows operating system is installed on the **Local Disk (C:) Partition**. This partition is the common storage location for your other apps and files.

- Modern PCs use the **EFI System Partition** to start (boot) your PC and your operating system.

- The **Recovery Partition** stores special tools to help you recover Windows, in case there's a problem starting the PC or other serious issues.

> [!IMPORTANT]
> Disk Management might show the EFI System Partition and Recovery Partition as 100 percent free. However, these partitions store critical files that your PC needs to operate properly, and the partitions are generally nearly full. It's recommended to not modify these partitions in any way.

## Troubleshoot issues

Sometimes a Disk Management task reports an error, or a procedure doesn't work as expected. There are several options available to help you resolve the issue.

- Review suggestions in the [Troubleshooting Disk Management](troubleshooting-disk-management.md) article.

- Search the [Microsoft Community](https://answers.microsoft.com/en-us/windows/forum/files?sort=LastReplyDate&dir=Desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=all&isFilterExpanded=false&page=1) website for posts about files, folders, and storage.

- If you don't find an answer on the site, you can post a question for input from Microsoft or other members of the community. You can also [Contact Microsoft Support](https://support.microsoft.com/contactus/).

## Complete related tasks

Disk Management supports a wide range of drive tasks, but some tasks need to be completed by using a different tool. Here are some common disk management tasks to complete with other tools in Windows:

- Free up disk space. For more information, see [Free up drive space in Windows](https://support.microsoft.com/windows/free-up-drive-space-in-windows-85529ccb-c365-490d-b548-831022bc9b32).

- Defragment or optimize your drives. For more information, see [Ways to improve your computer's performance](https://support.microsoft.com/windows/ways-to-improve-your-computer-s-performance-c6018c78-0edd-a71a-7040-02267d68ea90).

- Pool multiple hard drives together, similar to a RAID (redundant array of independent disks). For more information, see [Storage Spaces in Windows](https://support.microsoft.com/windows/storage-spaces-in-windows-b6c8b540-b8d8-fb8a-e7ab-4a75ba11f9f2).

## Related links

- [Manage disks](manage-disks.md)
- [Manage basic volumes](manage-basic-volumes.md)
- [Troubleshooting Disk Management](troubleshooting-disk-management.md)
- [Recovery options in Windows](https://support.microsoft.com/windows/recovery-options-in-windows-31ce2444-7de3-818c-d626-e3b5a3024da5)
- [Find lost files after the upgrade to Windows](https://support.microsoft.com/windows/find-lost-files-after-the-upgrade-to-windows-10-or-11-10af49aa-b372-b067-a334-2314401297a9)
- [Backup and Restore in Windows](https://support.microsoft.com/windows/backup-and-restore-in-windows-352091d2-bb9d-3ea3-ed18-52ef2b88cbef)
- [Create a recovery drive](https://support.microsoft.com/windows/create-a-recovery-drive-abb4691b-5324-6d4a-8766-73fab304c246)
- [Create a system restore point](https://support.microsoft.com/windows/create-a-system-restore-point-77e02e2a-3298-c869-9974-ef5658ea3be9)
- [Where to look for your BitLocker recovery key](https://support.microsoft.com/windows/where-to-look-for-your-bitlocker-recovery-key-fd2b3501-a4b9-61e9-f5e6-2a545ad77b3e)