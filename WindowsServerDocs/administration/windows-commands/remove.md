---
title: remove
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b0886140-da8b-4231-8cb2-f280874d99c0
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# remove

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

removes a drive letter or mount point from a volume.

## Syntax
```
remove [{letter=<d> | mount=<path> | all}] [dismount] [noerr]
```
## Parameters
|Parameter|Description|
|-------|--------|
|letter=<d>|Specifies the drive letter to be removed.|
|mount=<path>|Specifies the mount point path to be removed.|
|all|removes all current drive letters and mount points.|
|dismount|Dismounts the basic volume, when all drive letters and mount points have been removed from the volume, and takes the basic volume offline, making it unmountable. If other processes are using the volume, DiskPart closes any open files in use by an application before dismounting the volume. You can make the volume mountable again by assigning it a driver letter or by creating a mount point path to the volume. Dismount will fail if used on a volume that has any remaining drive letters or mount points. For scripting, using **remove all dismount** is recommended.|
|noerr|for scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|
## remarks
-   if no drive letter or mount point is specified, DiskPart removes the first drive letter or mount point it encounters.
-   The command can be used to change the drive letter associated with a removable drive.
-   You cannot remove the drive letter on a system, boot, or paging volume. In addition, you cannot remove the drive letter for an OEM partition, any gpt partition with an unrecognized GUID, or any of the special, non-data, gpt partitions such as the EFI system partition.
## <a name="BKMK_examples"></a>Examples
To remove the drive letter K, type:
```
remove letter=k
```
To remove G:\mountH, type:
```
remove mount=G:\mountH
```
To remove all current drive letters and mount points, and dismount the volumes, type:
```
remove all dismount
```

