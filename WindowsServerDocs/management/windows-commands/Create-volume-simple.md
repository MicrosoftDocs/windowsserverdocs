---
title: Create volume simple
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: da0f208d-7fda-471a-9db2-5de5ba5207c6 JasonGerend
---
# Create volume simple
Creates a simple volume on the specified dynamic disk.  
  
> [!IMPORTANT]  
> For Windows Vista, this DiskPart command is only available in the Windows Vista Ultimate, Windows Vista Enterprise, and Windows Vista Business editions.  
  
For examples of how this command can be used, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
create volume simple [size=<n>] [disk=<n>] [align=<n>] [noerr]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|size\=<n>|The size of the volume in megabytes \(MB\). If no size is given, the new volume takes up the remaining free space on the disk.|  
|disk\=<n>|The dynamic disk on which the volume is created. If no disk is specified, the current disk is used.|  
|align\=<n>|Aligns all volume extents to the closest alignment boundary. Typically used with hardware RAID Logical Unit Number \(LUN\) arrays to improve performance. *n* is the number of kilobytes \(KB\) from the beginning of the disk to the closest alignment boundary.|  
|noerr|For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|  
  
## Remarks  
  
-   After you create the volume, the focus automatically shifts to the new volume.  
  
## <a name="BKMK_examples"></a>Examples  
To create a volume of 1000 megabytes in size, on disk 1, type:  
  
```  
create volume simple size=1000 disk=1  
```  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)  
  

