---
title: Overview of Disk Management
description: Learn how to use the Disk Management system utility in Windows to initialize drives, extend volumes, shrink partitions, and change drive letters.
ms.date: 06/24/2025
ms.topic: concept-article
author: dknappettmsft
ms.author: daknappe
#customer intent: As an administrator, I want to explore the Disk Management utility in Windows, so I can initialize drives, extend volumes, shrink partitions, and change drive letters.
---

# Overview of Disk Management

Disk Management is a system utility in Windows for advanced storage operations. You can use the utility to see information about each drive on your computer and all partitions in each drive. The utility shows partition details, including statistics and the amount of space allocated or used.

Some of the tasks you can complete with Disk Management include:

- Set up a new drive on your computer by [initializing a new disk](initialize-new-disks.md)
- [Extend a basic volume](extend-a-basic-volume.md) into unclaimed space in a volume on the same drive
- [Shrink a basic volume or partition](shrink-a-basic-volume.md), such as to enable extending into a neighboring partition
- [Change a drive letter](change-a-drive-letter.md) or assign a new drive letter

## View drives and partitions

The following image shows the Disk Management overview for several drives. **Disk 0** has three partitions, and **Disk 1** has two partitions. On **Disk 0**, the *C:* drive for Windows uses the most disk space. Two other partitions for system operations and recovery use a smaller amount of disk space.

:::image type="content" source="./media/disk-management.png" border="false" alt-text="Screenshot that shows the Disk Management utility in Windows as described in the text." lightbox="./media/disk-management.png":::

Windows typically includes three partitions on your main drive, which is usually the *C:\\* drive:

| Partition | Purpose |
|-----------|---------|
| **Local&#160;Disk&#160;(C:)** | Stores the Windows operating system installation. Common storage location for other apps and files. | 
| **EFI&#160;System**| Supports the start (_boot_) process for the computer and operating system in modern computers. |
| **Recovery** | Stores tools that support Windows recovery operations when the computer doesn't start or in other problem scenarios. For more information, see [Recovery options in Windows](https://support.microsoft.com/windows/recovery-options-in-windows-31ce2444-7de3-818c-d626-e3b5a3024da5). |

> [!IMPORTANT]
> Disk Management might show the **EFI System** and **Recovery** partitions as 100 percent _free_. However, these partitions store critical files required for the computer to operate properly. As such, the partitions are usually close to full. The recommended practice is to not modify these partitions in any way.

## Prepare resources for tasks

Some Disk Management tasks require special information about your system like a BitLocker recovery key, or an existing resource such as a restore point. The following articles can help you prepare the information and resources you need to complete the tasks:

- [Create a recovery drive](https://support.microsoft.com/windows/create-a-recovery-drive-abb4691b-5324-6d4a-8766-73fab304c246)
- [Create a restore point for your system in Windows](https://support.microsoft.com/windows/system-protection-e9126e6e-fa64-4f5f-874d-9db90e57645a)
- [Back up and restore your PC with Windows Backup](https://support.microsoft.com/windows/back-up-and-restore-with-windows-backup-87a81f8a-78fa-456e-b521-ac0560e32338)
- [Find your BitLocker recovery key](https://support.microsoft.com/windows/find-your-bitlocker-recovery-key-6b71ad27-0b89-ea08-f143-056f5ab347d6)
- [Find lost files after you upgrade to Windows](https://support.microsoft.com/windows/find-lost-files-after-the-upgrade-to-windows-10-or-11-10af49aa-b372-b067-a334-2314401297a9)

## Use other tools for tasks

The Disk Management utility supports a wide range of drive tasks, but some tasks can be completed only by using another tool.

Here are some common disk management tasks that you need to complete by using other tools in Windows:

- [Free up drive space in Windows](https://support.microsoft.com/windows/free-up-drive-space-in-windows-85529ccb-c365-490d-b548-831022bc9b32)
- [Defragment or optimize your data drives in Windows](https://support.microsoft.com/windows/defragment-optimize-your-data-drives-in-windows-54d4fed1-c96e-46db-b843-8c6b34bd27a4)
- Pool multiple hard drives like a redundant array of independent disks (RAID) with [Storage Spaces in Windows](https://support.microsoft.com/windows/storage-spaces-in-windows-b6c8b540-b8d8-fb8a-e7ab-4a75ba11f9f2)

## Troubleshoot issues

When a Disk Management task reports an error, or a procedure doesn't work as expected, try one of the following options to resolve the issue:

- Review suggestions in the [Troubleshooting Disk Management](troubleshooting-disk-management.md) article.
- Search the [Microsoft Support Community](https://answers.microsoft.com) site for posts about files, folders, and storage.
- [Ask a question](https://answers.microsoft.com) to get input from Microsoft or other community members.
- [Contact Microsoft Support](https://support.microsoft.com/contactus/) about the issue.

## Related content

- [Manage disks](manage-disks.md)
- [Manage basic volumes](manage-basic-volumes.md)