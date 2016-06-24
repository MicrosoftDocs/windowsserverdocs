---
title: Bitsadmin setmaxdownloadtime
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 16b96cf1-5738-415c-9b9d-c4ea8d5e4fec
author: britw
---
# Bitsadmin setmaxdownloadtime
Sets the download timeout in seconds.  
  
## Syntax  
  
```  
bitsadmin /SetMaxDownloadTime <Job> <Timeout>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|Job|The job's display name or GUID|  
|Timeout|The timeout in seconds|  
  
## Remarks  
  
-   N/A  
  
## <a name="BKMK_examples"></a>Examples  
The following example sets the timeout for the job named *myDownloadJob* to 10 seconds.  
  
```  
C:\>bitsadmin /SetMaxDownloadTime myDownloadJob 10  
```  
  
## Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

