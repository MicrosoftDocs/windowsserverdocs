---
title: list providers
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 844b4036-c0b9-449d-8347-7d58ef9bf16d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# list providers

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

lists shadow copy providers that are currently registered on the system.  
  
for examples of how to use this command, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
list providers  
```  
  
## <a name="BKMK_examples"></a>Examples  
To list the currently registered shadow copy providers, type:  
  
```  
list providers  
```  
  
Output that is similar to the following displays:  
  
```  
* ProviderID: {b5946137-7b9f-4925-af80-51abd60b20d5}  
        type: [1] VSS_PROV_SYSTEM  
        Name: Microsoft Software shadow copy provider 1.0  
        version: 1.0.0.7  
        clsID: {65ee1dba-8ff4-4a58-ac1c-3470ee2f376a}  
1 provider registered.  
```  
  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
  

