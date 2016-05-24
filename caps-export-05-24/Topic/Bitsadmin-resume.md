---
title: Bitsadmin resume
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7c7540a9-a11a-4910-923a-2a2a61cbf11d
author: britw
---
# Bitsadmin resume
Activates a new or suspended job in the transfer queue.  
  
## Syntax  
  
```  
bitsadmin /Resume <Job>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|Job|The job's display name or GUID|  
  
## <a name="BKMK_examples"></a>Examples  
The following example resumes the job named *myDownloadJob*.  
  
```  
C:\>bitsadmin /Resume myDownloadJob  
```  
  
Additional references  
  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
