---
title: fsutil volume
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9f8ba8f0-8c3e-4508-86d9-520f309214de
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# fsutil volume

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Dismounts a volume, or queries the hard disk drive to determine how much free space is currently available on the hard disk drive or which file is using a particular cluster.  
  
for examples of how to use this command, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
fsutil volume [diskfree] <volumepath>  
fsutil volume [dismount] <volumepath>  
fsutil volume [querycluster] <volumepath> <Cluster> [<Cluster>]      
```  
  
## Parameters  
  
|Parameter|Description|  
|-------|--------|  
|diskfree|Queries the hard disk drive to determine the amount of free space on it.|  
|dismount|Dismounts a volume.|  
|<volumepath>|Specifies the drive letter \(followed by a colon\).|  
|querycluster|finds which file is using a specified cluster. You can specify multiple clusters with the **querycluster** parameter.<br /><br />This parameter applies to:  Windows Server 2008 R2  and  Windows 7 .|  
|<cluster>|Specifies the logical cluster number \(LCN\).|  
  
## <a name="BKMK_examples"></a>Examples  
To dismount a volume on drive C, type:  
  
```  
fsutil volume dismount c:  
```  
  
To query the amount of free space of a volume on drive C, type:  
  
```  
fsutil volume diskfree c:  
```  
  
To find the file\(s\) that are using the clusters, specified by the logical cluster numbers 50 and 0x2000, on drive C, type:  
  
```  
fsutil volume querycluster C: 50 0x2000  
```  
  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
  
[fsutil](fsutil.md)  
  
[How NTFS Works](http://go.microsoft.com/fwlink/?LinkId=183396)  
  

