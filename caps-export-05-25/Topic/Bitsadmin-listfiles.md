---
title: Bitsadmin listfiles
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ad0d1eaa-3bd8-45e5-8f72-4da7366f0d59
author: britw
---
# Bitsadmin listfiles
Lists the files in the specified job.  
  
## Syntax  
  
```  
bitsadmin /ListFiles <Job>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|Job|The job's display name or GUID|  
  
## <a name="BKMK_examples"></a>Examples  
The following example retrieves the list of files for the job named *myDownloadJob*.  
  
```  
C:\>bitsadmin /GetNotifyFlags myDownloadJob  
```  
  
## Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
