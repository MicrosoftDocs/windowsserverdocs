---
title: list
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 57b6c8d0-872e-4dba-9715-1db8ab892e98
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# list

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

lists writers, shadow copies, or currently registered shadow copy providers that are on the system. If used without parameters, **list** displays help at the command prompt.  
  
for examples of how to use this command, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
list writers [metadata | detailed | status]  
list shadows {all | set <SetID> | id <shadowID>}  
list providers  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------|--------|  
|writers|lists writers. See [list writers](list-writers.md) for syntax and parameters.|  
|shadows|lists persistent and existing non\-persistent shadow copies. See [list shadows](list-shadows.md) for syntax and parameters.|  
|providers|lists currently registered shadow copy providers. See [list providers](list-providers.md) for syntax and parameters.|  
  
## <a name="BKMK_examples"></a>Examples  
To list all shadow copies, type:  
  
```  
list shadows all  
```  
  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
  

