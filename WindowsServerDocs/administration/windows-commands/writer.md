---
title: writer
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7cf98295-411d-4705-8573-f898ff45c140
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# writer

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

verifies that a writer or component is included or excludes a writer or component from the backup or restore procedure. If used without parameters, **writer** displays help at the command prompt.  
  
## Syntax  
  
```  
writer verify [<writer> | <component>]  
writer exclude [<writer> | <component>]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------|--------|  
|verify|verifies that the specified writer or component is included in the backup or restore procedure. The backup or restore procedure will fail if the writer or component is not included.|  
|exclude|Excludes the specified writer or component from the backup or restore procedure.|  
|\[<writer> &#124; <component>\]|Specifies the writer or component to verify or exclude. writers are specified by writer GUID or by the writer name, for example "System writer."|  
  
## <a name="BKMK_examples"></a>Examples  
To verify a writer by specifying its GUID \(for this example, 4dc3bdd4\-ab48\-4d07\-adb0\-3bee2926fd7f\), type:  
  
```  
writer verify {4dc3bdd4-ab48-4d07-adb0-3bee2926fd7f}  
```  
  
To exclude a writer with the name  System writer, type:  
  
```  
writer exclude "System writer"  
```  
  
### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
  

