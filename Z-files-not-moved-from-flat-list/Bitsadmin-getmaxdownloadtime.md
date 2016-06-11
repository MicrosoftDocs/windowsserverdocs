---
title: Bitsadmin getmaxdownloadtime
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cdce64f6-7125-489d-be3c-4af1dfc8c46a
author: britw
---
# Bitsadmin getmaxdownloadtime
Retrieves the download timeout in seconds.  
  
## Syntax  
  
```  
bitsadmin /GetMaxDownloadTime <Job>   
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|Job|The job's display name or GUID|  
  
## Remarks  
  
-   N\/A  
  
## <a name="BKMK_examples"></a>Examples  
The following example gets maximum download time for the job named *myDownloadJob* in seconds.  
  
```  
C:\>bitsadmin /GetMaxDownloadTime myDownloadJob  
```  
  
## Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

