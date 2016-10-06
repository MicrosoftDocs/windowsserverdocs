---
title: Select partition
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 25f70083-b8f7-4a8e-9b34-4b3ffbe06670
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Select partition

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Selects the specified partition and shifts the focus to it. This command can also be used to display the partition that currently has the focus in the selected disk.  
  
For examples of how this command can be used, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
select partition=<n>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|partition\=<n>|The number of the partition to receive the focus. You can view the numbers for all partitions on the disk currently selected by using the **list partition** command in DiskPart.|  
  
## Remarks  
  
-   Before you can select a partition you must first select a disk using the **select disk** command.  
  
-   If no partition number is specified, this command displays the partition that currently has the focus in the selected disk.  
  
-   If a volume is selected with a corresponding partition, the partition will be automatically selected.  
  
-   If a partition is selected with a corresponding volume, the volume will be automatically selected.  
  
## <a name="BKMK_examples"></a>Examples  
To shift the focus to partition 3, type:  
  
```  
select partitition=3  
```  
  
To display the partition that currently has the focus in the selected disk, type:  
  
```  
select partition  
```  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)  
  

