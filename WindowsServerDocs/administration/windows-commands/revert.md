---
title: revert
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 75ad40e4-502a-401e-b11e-8b31e00424b5
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# revert

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

reverts a volume back to a specified shadow copy. This is supported only for shadow copies in the CLIENTACCESSIBLE context. These shadow copies are persistent and can only be made by the system provider. If used without parameters, **revert** displays help at the command prompt.  
  
## Syntax  
  
```  
revert <shadowcopyID>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------|--------|  
|<shadowcopyID>|Specifies the shadow copy ID to revert the volume to.|  
  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
  

