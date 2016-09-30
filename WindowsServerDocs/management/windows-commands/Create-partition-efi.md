---
title: Create partition efi
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3cfc1fca-6515-4a4d-bfae-615fa8045ea9 JasonGerend
---
# Create partition efi
On Itanium\-based computers, creates an Extensible Firmware Interface \(EFI\) system partition on a GUID Partition Table \(GPT\) disk.  
  
For examples of how this command can be used, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
create partition efi [size=<n>] [offset=<n>] [noerr]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|size\=<n>|The size of the partition in megabytes \(MB\). If no size is given, the partition continues until there is no more free space in the current region.|  
|offset\=<n>|The offset in kilobytes \(KB\), at which the partition is created. If no offset is given, the partition is placed in the first disk extent that is large enough to hold it.|  
|noerr|For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|  
  
## Remarks  
  
-   After the partition has been created, the focus is given to the new partition.  
  
-   A GPT disk must be selected for this operation to succeed. Use the **select disk** command to select a disk and shift the focus to it.  
  
## <a name="BKMK_examples"></a>Examples  
To create an EFI partition of 1000 megabytes on the selected disk, type:  
  
```  
create partition efi size=1000  
```  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)  
  

