---
title: Bitsadmin getdisplayname
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e5c0e76c-4cc6-42d8-ac30-30bf3dc11b9b
author: britw
---
# Bitsadmin getdisplayname
Retrieves the display name of the specified job.  
  
## Syntax  
  
```  
bitsadmin /GetDisplayName <Job>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|Job|The job's display name or GUID|  
  
## <a name="BKMK_examples"></a>Examples  
The following example retrieves the display name for the job named *myDownloadJob*.  
  
```  
C:\>bitsadmin /GetDisplayName myDownloadJob  
```  
  
Additional references  
  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

