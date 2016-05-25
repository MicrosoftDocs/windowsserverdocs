---
title: Bitsadmin getreplyprogress
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7f7cb0b4-ad95-44fd-a35d-0ddf5fc0b0d0
author: britw
---
# Bitsadmin getreplyprogress
Retrieves the size and progress of the server reply.  
  
## Syntax  
  
```  
bitsadmin /GetReplyProgress <Job>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|Job|The job's display name or GUID|  
  
## Remarks  
Valid only for upload\-reply jobs.  
  
## <a name="BKMK_examples"></a>Examples  
The following example retrieves the reply progress for the job named *myDownloadJob*.  
  
```  
C:\>bitsadmin /GetReplyProgress myDownloadJob  
```  
  
## Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
