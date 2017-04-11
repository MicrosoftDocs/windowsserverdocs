---
title: add
description: "Windows Commands topic for **add** - Mirrors the simple volume with focus to the specified disk."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6ac1f002-9702-4b55-8e4e-2098f3bb4fa9
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# add

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Mirrors the simple volume with focus to the specified disk.
> [!IMPORTANT]
> This DiskPart command is not available in any edition of Windows Vista.

## Syntax
```
add disk=<n> [align=<n>] [wait] [noerr]
```
## Parameters
|Parameter|Description|
|-------|--------|
|disk=<n>|Specifies a disk, other than the one containing the existing simple volume, to contain the mirror. You can mirror only simple volumes. The specified disk must have unallocated space at least as large as the size of the simple volume you want to mirror.|
|align=<n>|Typically used with hardware RAID Logical Unit Number (LUN) arrays to improve performance. Aligns all volume or partition extents to the closest alignment boundary. *n* is the number of kilobytes (KB) from the beginning of the disk to the closest alignment boundary.|
|wait|Waits for the volume to finish synchronizing with the added disk before returning.  Without this parameter, DiskPart returns after the mirrored volume is created and does not wait for the synchronization to complete.|
|noerr|for scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|
## remarks
-   A volume must be selected for this operation to succeed. Use the **select volume** command to select a volume and shift the focus to it.
## <a name="BKMK_examples"></a>Examples
To create a mirror of the volume with focus on disk 2, type:
```
add disk=2
```

