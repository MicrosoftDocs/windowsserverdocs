---
title: Bitsadmin getdescription
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f3974603-ebbe-4d31-8217-040fe2d90c85
author: britw
---
# Bitsadmin getdescription
Retrieves the description of the specified job.  
  
## Syntax  
  
```  
bitsadmin /GetDescription <Job>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|Job|The job's display name or GUID|  
  
## <a name="BKMK_examples"></a>Examples  
The following example retrieves the description for the job named *myDownloadJob*.  
  
```  
C:\>bitsadmin /GetDescription myDownloadJob  
```  
  
## Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

