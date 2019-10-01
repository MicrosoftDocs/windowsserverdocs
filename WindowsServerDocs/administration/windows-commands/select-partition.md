---
title: select partition
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 25f70083-b8f7-4a8e-9b34-4b3ffbe06670
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# select partition

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

selects the specified partition and shifts the focus to it. This command can also be used to display the partition that currently has the focus in the selected disk.  
  
  
  
## Syntax  
  
```  
select partition=<n>  
```  
  
## Parameters  
  
|   Parameter    |                                                                                    Description                                                                                    |
|----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| partition\=<n> | The number of the partition to receive the focus. You can view the numbers for all partitions on the disk currently selected by using the **list partition** command in DiskPart. |
  
## Remarks  
  
-   Before you can select a partition you must first select a disk using the **select disk** command.  
  
-   if no partition number is specified, this command displays the partition that currently has the focus in the selected disk.  
  
-   if a volume is selected with a corresponding partition, the partition will be automatically selected.  
  
-   if a partition is selected with a corresponding volume, the volume will be automatically selected.  
  
## <a name="BKMK_examples"></a>Examples  
To shift the focus to partition 3, type:  
  
```  
select partitition=3  
```  
  
To display the partition that currently has the focus in the selected disk, type:  
  
```  
select partition  
```  
  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
  

  

