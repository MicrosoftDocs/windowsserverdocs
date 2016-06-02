---
title: Remove
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b0886140-da8b-4231-8cb2-f280874d99c0
author: JasonGerend
---
# Remove
Removes a drive letter or mount point from a volume.  
  
For examples of how this command can be used, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
remove [{letter=<d> | mount=<path> | all}] [dismount] [noerr]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|letter\=<d>|Specifies the drive letter to be removed.|  
|mount\=<path>|Specifies the mount point path to be removed.|  
|all|Removes all current drive letters and mount points.|  
|dismount|Dismounts the basic volume, when all drive letters and mount points have been removed from the volume, and takes the basic volume offline, making it unmountable. If other processes are using the volume, DiskPart closes any open files in use by an application before dismounting the volume. You can make the volume mountable again by assigning it a driver letter or by creating a mount point path to the volume. Dismount will fail if used on a volume that has any remaining drive letters or mount points. For scripting, using **remove all dismount** is recommended.|  
|noerr|For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|  
  
## Remarks  
  
-   If no drive letter or mount point is specified, DiskPart removes the first drive letter or mount point it encounters.  
  
-   The command can be used to change the drive letter associated with a removable drive.  
  
-   You cannot remove the drive letter on a system, boot, or paging volume. In addition, you cannot remove the drive letter for an OEM partition, any GPT partition with an unrecognized GUID, or any of the special, non\-data, GPT partitions such as the EFI system partition.  
  
## <a name="BKMK_examples"></a>Examples  
To remove the drive letter K, type:  
  
```  
remove letter=k  
```  
  
To remove G:\\MountH, type:  
  
```  
remove mount=G:\MountH  
```  
  
To remove all current drive letters and mount points, and dismount the volumes, type:  
  
```  
remove all dismount  
```  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)  
  

