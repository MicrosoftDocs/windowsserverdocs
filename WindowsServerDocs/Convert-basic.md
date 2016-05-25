---
title: Convert basic
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 61329896-3b56-4959-8d58-45cbe18ba860
author: JasonGerend
---
# Convert basic
Converts an empty dynamic disk to a basic disk.  
  
For instructions regarding how to use this command, see [Change a Dynamic Disk Back to a Basic Disk](http://go.microsoft.com/fwlink/?LinkId=207048) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=207048\).  
  
## Syntax  
  
```  
convert basic [noerr]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|noerr|For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|  
  
## Remarks  
  
> [!IMPORTANT]  
> The disk must be empty to convert it to a basic disk. Back up your data, and then delete all partitions or volumes before converting the disk.  
  
-   A dynamic disk must be selected for this operation to succeed. Use the **select disk** command to select a dynamic disk and shift the focus to it.  
  
## <a name="BKMK_examples"></a>Examples  
To convert the selected dynamic disk to basic, type:  
  
```  
convert basic  
```  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)  
  

