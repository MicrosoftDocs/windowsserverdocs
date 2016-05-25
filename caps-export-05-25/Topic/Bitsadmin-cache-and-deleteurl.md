---
title: Bitsadmin cache and deleteurl
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e108b76b-fae9-4c16-bf4c-d74c9f025953
author: britw
---
# Bitsadmin cache and deleteurl
Deletes all cache entries for the given URL.  
  
## Syntax  
  
```  
bitsadmin /DeleteURL url  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|url|The Uniform Resource Locator that identifies a remote file.|  
  
## <a name="BKMK_examples"></a>Examples  
The following example deletes all cache entries for http:\/\/www.microsoft.com\/en\/us\/default.aspx  
  
```  
C:\>bitsadmin /DeleteURL http://www.microsoft.com/en/us/default.aspx   
```  
  
## Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
