---
Title: DiskPart commands
ms.prod: windows-server-threshold
ms.technology: storage
author: JasonGerend
manager: elizapo
ms.author: jgerend
---

# DiskPart commands

Applies To: Windows 10, Windows 8.1, Windows 8, Windows 7, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, and Windows Server 2008 R2, Windows Server 2008

DiskPart commands help you to manage your PC's drives (disks, partitions, volumes, or virtual hard disks). Before you can use DiskPart commands, you must first list, and then select an object to give it focus. When an object has focus, any DiskPart commands that you type will act on that object.

You can list the available objects and determine an object's number or drive letter by using the **list disk, list volume, list partition**, and **list vdisk** commands. The **list disk, list vdisk** and **list volume** commands display all disks and volumes on the computer. However, the **list partition** command only displays partitions on the disk that has focus. When you use the **list** commands, an asterisk (\*) appears next to the object with focus.

When you select an object, the focus remains on that object until you select a different object. For example, if the focus is set on disk 0 and you select volume 8 on disk 2, the focus shifts from disk 0 to disk 2, volume 8. Some commands automatically change the focus. For example, when you create a new partition, the focus automatically switches to the new partition.

You can only give focus to a partition on the selected disk. When a partition has focus, the related volume (if any) also has focus. When a volume has focus, the related disk and partition also have focus if the volume maps to a single specific partition. If this is not the case, focus on the disk and partition is lost.

## DiskPart commands

To start the DiskPart command interpreter, at the command prompt type:

`diskpart`

> [!IMPORTANT]
> Membership in the local **Administrators** group, or equivalent, is the minimum required to run DiskPart. 

You can run the following commands in the Diskpart command interpreter:

  - [Active](active.md)  
      
  - [Add](add.md)  
      
  - [Assign](assign.md)  
      
  - [Attach vdisk](attach-vdisk.md)  
      
  - [Attributes](attributes.md)  
      
  - [Automount](automount.md)  
      
  - [Break](break.md)  
      
  - [Clean](clean.md)  
      
  - [Compact vdisk](compact-vdisk.md)  
      
  - [Convert](convert.md)  
      
  - [Create](create.md)  
      
  - [Delete](delete.md)  
      
  - [Detach vdisk](detach-vdisk.md)  
      
  - [Detail](detail.md)  
      
  - [Exit](exit.md)  
      
  - [Expand vdisk](expand-vdisk.md)  
      
  - [Extend](extend.md)  
      
  - [Filesystems](filesystems.md)  
      
  - [Format](format.md)  
      
  - [GPT](gpt.md)  
      
  - [Help](help.md)  
      
  - [Import](import.md)  
      
  - [Inactive](inactive.md)  
      
  - [List](list.md)  
      
  - [Merge vdisk](merge-vdisk.md)  
      
  - [Offline](offline.md)  
      
  - [Online](online.md)  
      
  - [Recover](recover.md)  
      
  - [Rem](rem.md)  
      
  - [Remove](remove.md)  
      
  - [Repair](repair.md)  
      
  - [Rescan](rescan.md)  
      
  - [Retain](retain.md)  
      
  - [San](san.md)  
      
  - [Select](select.md)  
      
  - [Set id](set-id.md)  
      
  - [Shrink](shrink.md)  
      
  - [Uniqueid](uniqueid.md)  
      

## Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)

[Storage Cmdlets in Windows PowerShell](https://docs.microsoft.com/powershell/module/storage/)
