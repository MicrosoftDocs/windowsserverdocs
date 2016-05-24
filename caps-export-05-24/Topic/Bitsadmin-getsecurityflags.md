---
title: Bitsadmin getsecurityflags
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c2e73519-34f4-487b-af11-97d5d08ef9bb
author: britw
---
# Bitsadmin getsecurityflags
Reports the HTTP security flags for URL redirection and checks performed on the server certificate during the transfer.  
  
## Syntax  
  
```  
bitsadmin /GetSecurityFlags <Job>   
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|Job|The job's display name or GUID|  
  
## <a name="BKMK_examples"></a>Examples  
The following example retrieves the securitly flags from a job named *myJob*.  
  
```  
C:\>bitsadmin /GetSecurityFlags myJob   
```  
  
## Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
