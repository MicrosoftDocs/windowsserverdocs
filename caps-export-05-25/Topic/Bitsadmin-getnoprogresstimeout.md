---
title: Bitsadmin getnoprogresstimeout
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9cd9b19b-cbb4-4352-8419-978080f016b6
author: britw
---
# Bitsadmin getnoprogresstimeout
Retrieves the length of time, in seconds, that the service tries to transfer the file after a transient error occurs.  
  
## Syntax  
  
```  
bitsadmin /GetNoProgressTimeout <Job>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|Job|The job's display name or GUID|  
  
## <a name="BKMK_examples"></a>Examples  
The following example retrieves the progress time out value for the job named *myDownloadJob*.  
  
```  
C:\>bitsadmin /GetNoProgressTimeout myDownloadJob  
```  
  
## Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
