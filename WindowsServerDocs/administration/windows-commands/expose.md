---
title: expose
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9b0a21cf-3bef-4ade-b8f1-ac42f9203947
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# expose

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

exposes a persistent shadow copy as a drive letter, share, or mount point.  
  
for examples of how to use this command, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
expose <shadowID> {<Drive:> | <Share> | <mountPoint>}  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------|--------|  
|shadowID|Specifies the shadow ID of the shadow copy you want to expose.|  
|<Drive:>|exposes the specified shadow copy as a drive letter \(for example, P:\).|  
|<Share>|exposes the specified shadow copy at a share \(for example, \\\\*MachineName*\\\).|  
|<mountPoint>|exposes the specified shadow copy to a mount point \(for example, C:\\shadowcopy\\\).|  
  
## remarks  
  
-   You can use an existing alias or an environment variable in place of *shadowID*. Use **add** without parameters to see existing aliases.  
  
## <a name="BKMK_examples"></a>Examples  
To expose the persistent shadow copy associated with the VSS\_shadow\_1 environment variable as drive X, type:  
  
```  
expose %vss_shadow_1% x:  
```  
  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
  

