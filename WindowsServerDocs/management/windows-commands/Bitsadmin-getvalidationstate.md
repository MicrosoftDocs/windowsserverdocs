---
title: Bitsadmin getvalidationstate
description: "Windows Commands topic for **Bitsadmin getvalidationstate** -- Reports the content validation state of the given file within the job. "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6ada3f1f-9967-4262-9d22-ed641e23f516
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Bitsadmin getvalidationstate

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Reports the content validation state of the given file within the job.  
  
## Syntax  
  
```  
bitsadmin /GetValidationState <Job> <file index>   
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|Job|The job's display name or GUID|  
|File index|Starts from 0|  
  
## <a name="BKMK_examples"></a>Examples  
The following example gets the content validation state of file 2 within the job named *myJob*.  
  
```  
C:\>bitsadmin /GetValidationState myJob 1  
```  
  
## Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

