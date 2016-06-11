---
title: Bitsadmin removeclientcertificate
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b417c3e5-aadd-4fcc-968f-45d8b67ca516
author: britw
---
# Bitsadmin removeclientcertificate
Removes the client certificate from the job.  
  
## Syntax  
  
```  
bitsadmin /RemoveClientCertificate <Job>   
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|Job|The job's display name or GUID|  
  
## <a name="BKMK_examples"></a>Examples  
The following example removes the client certificate from the job named *myJob*.  
  
```  
C:\>Bitsadmin /RemoveClientCertificate myJob   
```  
  
## Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

