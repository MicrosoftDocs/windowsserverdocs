---
title: Bitsadmin getpeercachingflags
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3c3c9f28-4c04-4c49-a23a-dee5bbcc8981
author: britw
---
# Bitsadmin getpeercachingflags
Retrieves flags that determine if the files of the job can be cached and served to peers, and if BITS can download content for the job from peers.  
  
## Syntax  
  
```  
bitsadmin /GetPeerCachingFlags <Job>   
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|Job|The job's display name or GUID|  
  
## <a name="BKMK_examples"></a>Examples  
The following example retrieves the flags for the job named *myJob*.  
  
```  
C:\>bitsadmin /GetPeerCachingFlags myJob  
```  
  
## Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
