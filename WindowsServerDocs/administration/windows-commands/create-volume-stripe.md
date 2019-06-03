---
title: create volume stripe
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 20dce735-5f7c-4f83-a580-d087e2913a00
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# create volume stripe

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

creates a striped volume using two or more specified dynamic disks.  
  
> [!IMPORTANT]  
> for Windows Vista, this DiskPart command is only available in the Windows Vista Ultimate, Windows Vista Enterprise, and Windows Vista Business editions.  
  
  
  
## Syntax  
  
```  
create volume stripe [size=<n>] disk=<n>,<n>[,<n>,...] [align=<n>] [noerr]  
```  
  
## Parameters  
  
|         Parameter         |                                                                                                                            Description                                                                                                                            |
|---------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|         size\=<n>         |             The amount of disk space, in megabytes \(MB\), that the volume will occupy on each disk. If no size is given, the new volume takes up the remaining free space on the smallest disk and an equal amount of space on each subsequent disk.             |
| disk\=<n>,<n>\[,<n>,...\] |                                  The dynamic disks on which the striped volume is created. You need at least two dynamic disks to create a striped volume. An amount of space equal to **size\=<n>** is allocated on each disk.                                   |
|        align\=<n>         | Aligns all volume extents to the closest alignment boundary. Typically used with hardware RAID Logical Unit Number \(LUN\) arrays to improve performance. *n* is the number of kilobytes \(KB\) from the beginning of the disk to the closest alignment boundary. |
|           noerr           |                               for scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.                                |
  
## Remarks  
  
-   After you create the volume, the focus automatically shifts to the new volume.  
  
## <a name="BKMK_examples"></a>Examples  
To create a striped volume of 1000 megabytes in size, on disks 1 and 2, type:  
  
```  
create volume stripe size=1000 disk=1,2  
```  
  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
  

  

