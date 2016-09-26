---
title: Create partition extended
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4ad7cb66-9c66-4153-b94e-1030a7225070 JasonGerend
---
# Create partition extended
Creates an extended partition on the disk with focus. You can use this command only on Master Boot Record \(MBR\) disks.  
  
For examples of how this command can be used, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
create partition extended [size=<n>] [offset=<n>] [align=<n>] [noerr]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|size\=<n>|Specifies the size of the partition in megabytes \(MB\). If no size is given, the partition continues until there is no more free space in the extended partition.|  
|offset\=<n>|Specifies the offset in kilobytes \(KB\), at which the partition is created. If no offset is given, the partition will start at the beginning of the free space on the disk that is large enough to hold the new partition.|  
|align\=<n>|Aligns all partition extents to the closest alignment boundary. Typically used with hardware RAID Logical Unit Number \(LUN\) arrays to improve performance. <n> is the number of kilobytes \(KB\) from the beginning of the disk to the closest alignment boundary.|  
|noerr|For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|  
  
## Remarks  
  
-   After the partition has been created, the focus automatically shifts to the new partition.  
  
-   Only one extended partition can be created per disk.  
  
-   This command fails if you attempt to create an extended partition within another extended partition.  
  
-   You must create an extended partition before you can create logical drives.  
  
-   A basic MBR disk must be selected for this operation to succeed. Use the **select disk** command to select a disk and shift the focus to it.  
  
## <a name="BKMK_examples"></a>Examples  
To create an extended partition of 1000 megabytes in size, type:  
  
```  
create partition extended size=1000  
```  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)  
  

