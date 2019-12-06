---
title: mountvol
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fea8ad4d-f04a-4aaa-a3e5-75931e867b39
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# mountvol



Creates, deletes, or lists a volume mount point.

For examples of how to use this command see [Examples](#BKMK_examples).

## Syntax

```
mountvol [<Drive>:]<Path VolumeName>
mountvol [<Drive>:]<Path> /d
mountvol [<Drive>:]<Path> /l
mountvol [<Drive>:]<Path> /p
mountvol /r
mountvol [/n | /e]
mountvol <Drive>: /s
```

## Parameters

|Parameter|Description|
|---------|-----------|
|[\<Drive>:]<Path>|Specifies the existing NTFS directory where the mount point will reside.|
|\<VolumeName>|Specifies the volume name that is the target of the mount point. The volume name uses the following syntax, where *GUID* is a globally unique identifier:</br>`\\\\?\Volume\{GUID}\`</br>The brackets { } are required.|
|/d|Removes the volume mount point from the specified folder.|
|/l|Lists the mounted volume name for the specified folder.|
|/p|Removes the volume mount point from the specified directory, dismounts the basic volume, and takes the basic volume offline, making it unmountable. If other processes are using the volume, **mountvol** closes any open handles before dismounting the volume.|
|/r|Removes volume mount point directories and registry settings for volumes that are no longer in the system, preventing them from being automatically mounted and given their former volume mount point(s) when added back to the system.|
|/n|Disables automatic mounting of new basic volumes. New volumes are not mounted automatically when added to the system.|
|/e|Re-enables automatic mounting of new basic volumes.|
|/s|Mounts the EFI system partition on the specified drive.|
|/?|Displays help at the command prompt.|

## Remarks

-   **Mountvol** allows you to link volumes without requiring a drive letter.
-   Volumes that are dismounted by using **/p** are listed in the volumes list as "NOT MOUNTED UNTIL A VOLUME MOUNT POINT IS CREATED." If the volume has more than one mount point, use **/d** to remove the additional mount points before using **/p**. You can make the basic volume mountable again by assigning a volume mount point.
-   If you need to expand your volume space without reformatting or replacing a hard drive, you can add a mount path to another volume. The benefit of using one volume with several mount paths is that you can access all local volumes by using a single drive letter (such as `C:`). You do not need to remember which volume corresponds to which drive letter—although you can still mount local volumes and assign them drive letters.

## <a name="BKMK_examples"></a>Examples

To create a mount point, type:
```
mountvol \sysmount \\?\Volume\{2eca078d-5cbc-43d3-aff8-7e8511f60d0e}\
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
