---
title: Bitsadmin complete
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a5e86677-8f7b-43b3-929e-97706c57e7f1
author: britw
---
# Bitsadmin complete
Completes the job. The downloaded files are not available to you until you use this switch. Use this switch after the job moves to the transferred state. Otherwise, only those files that have been successfully transferred are available.  
  
## Syntax  
  
```  
bitsadmin /complete <Job>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|Job|The job's display name or GUID|  
  
## <a name="BKMK_examples"></a>Examples  
When the state of the job is TRANSFERRED, BITS has successfully transferred all files in the job. However, the files are not available until you use the **\/complete** switch. If multiple jobs use *myDownloadJob* as their name, you must replace *myDownloadJob* with the job's GUID to uniquely identify the job.  
  
```  
C:\>bitsadmin /complete myDownloadJob  
```  
  
## Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

