---
title: List providers
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 844b4036-c0b9-449d-8347-7d58ef9bf16d
author: JasonGerend
---
# List providers
Lists shadow copy providers that are currently registered on the system.  
  
For examples of how to use this command, see [Examples](#BKMK_examples).  
  
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
        Type: [1] VSS_PROV_SYSTEM  
        Name: Microsoft Software Shadow Copy provider 1.0  
        Version: 1.0.0.7  
        CLSID: {65ee1dba-8ff4-4a58-ac1c-3470ee2f376a}  
1 provider registered.  
```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
