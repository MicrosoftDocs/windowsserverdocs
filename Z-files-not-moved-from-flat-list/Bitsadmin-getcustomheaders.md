---
title: Bitsadmin getcustomheaders
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1f0d38d3-e865-4474-81e8-773d65c3d1cc
author: britw
---
# Bitsadmin getcustomheaders
Retrieves the custom HTTP headers from the job.  
  
## Syntax  
  
```  
bitsadmin /GetCustomHeaders <Job>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|Job|The job's display name or GUID|  
  
## <a name="BKMK_examples"></a>Examples  
The following example gets the custom headers for the job named *myDownloadJob*.  
  
```  
C:\>bitsadmin /GetCustomHeaders myDownloadJob  
```  
  
## Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

