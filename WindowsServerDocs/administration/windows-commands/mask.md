---
title: mask
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bf301474-d74a-44e7-9fad-c8a11e7ca3bd
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# mask

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

removes hardware shadow copies that were imported by using the **import** command.  
  
for examples of how to use this command, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
mask <shadowSetID>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------|--------|  
|shadowSetID|removes shadow copies that belong to the specified shadow copy Set ID.|  
  
## remarks  
  
-   You can use an existing alias or an environment variable in place of *shadowSetID*. Use **add** without parameters to see existing aliases.  
  
## <a name="BKMK_examples"></a>Examples  
To remove the imported shadow copy %import\_1%, type:  
  
```  
mask %import_1%  
```  
  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
  

