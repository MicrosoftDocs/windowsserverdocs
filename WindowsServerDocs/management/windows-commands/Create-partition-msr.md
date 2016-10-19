---
title: Create partition msr
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 04fba033-23cb-4521-bd5d-db96131f2e73
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Create partition msr

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Creates a Microsoft Reserved \(MSR\) partition on a GUID partition table \(GPT\) disk.  
  
> [!CAUTION]  
> Be very careful when using this command. Because GPT disks require a specific partition layout, creating Microsoft Reserved partitions could cause the disk to become unreadable.  
  
  
  
## Syntax  
  
```  
create partition msr [size=<n>] [offset=<n>] [noerr]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------|--------|  
|size\=<n>|The size of the partition in megabytes \(MB\). The partition is at least as long in bytes as the number specified by <n>. If no size is given, the partition continues until there is no more free space in the current region.|  
|offset\=<n>|Specifies the offset in kilobytes \(KB\), at which the partition is created. The offset rounds up to completely fill whatever sector size is used. If no offset is given, the partition is placed in the first disk extent that is large enough to hold it.|  
|noerr|For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|  
  
## Remarks  
  
-   On GPT disks that are used to boot the Windows operating system, the Extensible Firmware Interface \(EFI\) system partition is the first partition on the disk, followed by the Microsoft Reserved partition. GPT disks that are used only for data storage do not have an EFI system partition, in which case the Microsoft Reserved partition is the first partition.  
  
-   Windows does not mount Microsoft Reserved partitions. You cannot store data on them and you cannot delete them.  
  
-   A Microsoft Reserved partition is required on every GPT disk. The size of this partition depends on the total size of the GPT disk. The size of the GPT disk must be at least 32 MB to create a Microsoft Reserved partition.  
  
-   A basic GPT disk must be selected for this operation to succeed. Use the **select disk** command to select a basic GPT disk and shift the focus to it.  
  
## <a name="BKMK_examples"></a>Examples  
To create a Microsoft Reserved partition of 1000 megabytes in size, type:  
  
```  
create partition msr size=1000  
```  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

  

