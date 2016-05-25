---
title: Recover_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8cc3a73d-9456-41a0-b375-2b4cc37c3992
author: JasonGerend
---
# Recover_1
Refreshes the state of all disks in a disk group, attempt to recover disks in an invalid disk group, and resynchronizes mirrored volumes and RAID\-5 volumes that have stale data.  
  
> [!IMPORTANT]  
> This DiskPart command is not available in any edition of [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)].  
  
## Syntax  
  
```  
recover [noerr]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|noerr|For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|  
  
## Remarks  
  
-   This command operates on a disk group.  
  
-   This command applies only to groups of dynamic disks. If this command is used on a group with a basic disk, it will not return an error but no action will be taken.  
  
-   This command operates on disks that are failed or failing. It also operates on volumes that are failed, failing, or in failed redundancy state.  
  
-   A disk that is part of a disk group must be selected for this command to succeed. Use the **select disk** command to select a disk and shift the focus to it.  
  
## <a name="BKMK_examples"></a>Examples  
To recover the disk group that contains the disk with focus, type:  
  
```  
recover  
```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)  
  
