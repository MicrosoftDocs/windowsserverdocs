---
title: Repair
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9f84f661-f3cd-48c8-bf08-87819cf626fe JasonGerend
---
# Repair
Repairs the RAID\-5 volume with focus by replacing the failed disk region with the specified dynamic disk.  
  
For examples of how this command can be used, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
repair disk=<n> [align=<n>] [noerr]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|disk\=<n>|Specifies the dynamic disk that will replace the failed disk region.|  
|align\=<n>|Aligns all volume or partition extents to the closest alignment boundary. *n* is the number of kilobytes \(KB\) from the beginning of the disk to the closest alignment boundary.|  
|noerr|For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|  
  
## Remarks  
  
-   The specified dynamic disk must have free space greater than or equal to the total size of the failed disk region in the RAID\-5 volume.  
  
-   A volume in a RAID\-5 array must be selected for this operation to succeed. Use the **select volume** command to select a volume and shift the focus to it.  
  
## <a name="BKMK_examples"></a>Examples  
To replace the volume with focus by replacing it with dynamic disk 4, type:  
  
```  
repair disk=4  
```  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)  
  

