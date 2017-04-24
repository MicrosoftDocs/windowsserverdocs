---
title: convert basic
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 61329896-3b56-4959-8d58-45cbe18ba860
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# convert basic

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

converts an empty dynamic disk to a basic disk.  
  
for instructions regarding how to use this command, see [change a Dynamic Disk Back to a Basic Disk](http://go.microsoft.com/fwlink/?LinkId=207048) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=207048\).  
  
## Syntax  
  
```  
convert basic [noerr]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------|--------|  
|noerr|for scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|  
  
## remarks  
  
> [!IMPORTANT]  
> The disk must be empty to convert it to a basic disk. Back up your data, and then delete all partitions or volumes before converting the disk.  
  
-   A dynamic disk must be selected for this operation to succeed. Use the **select disk** command to select a dynamic disk and shift the focus to it.  
  
## <a name="BKMK_examples"></a>Examples  
To convert the selected dynamic disk to basic, type:  
  
```  
convert basic  
```  
  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
  

  

