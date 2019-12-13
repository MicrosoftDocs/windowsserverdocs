---
title: select volume
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5d70d776-80ad-4f20-8288-a7997fb1df28
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# select volume

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

selects the specified volume and shifts the focus to it. This command can also be used to display the volume that currently has the focus in the selected disk.  
  
  
  
## Syntax  
  
```  
select volume={<n>|<d>}  
```  
  
## Parameters  
  
| Parameter |                                                                               Description                                                                                |
|-----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    <n>    | The number of the volume to receive the focus. You can view the numbers for all volumes on the disk currently selected by using the **list volume** command in DiskPart. |
|    <d>    |                                                 The drive letter or mount point path of the volume to receive the focus.                                                 |
  
## Remarks  
  
-   if no volume is specified, this command displays the volume that currently has the focus in the selected disk.  
  
-   On a basic disk, selecting a volume also gives the focus to the corresponding partition.  
  
-   if a volume is selected with a corresponding partition, the partition will be automatically selected.  
  
-   if a partition is selected with a corresponding volume, the volume will be automatically selected.  
  
## <a name="BKMK_examples"></a>Examples  
To shift the focus to volume 2, type:  
  
```  
select volume=2  
```  
  
To shift the focus to drive C, type:  
  
```  
select volume=c  
```  
  
To shift the focus to the volume mounted on a folder named "mountpath", type:  
  
```  
select volume=c:\mountpath  
```  
  
To display the volume that currently has the focus in the selected disk, type:  
  
```  
select volume  
```  
  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
  

  

