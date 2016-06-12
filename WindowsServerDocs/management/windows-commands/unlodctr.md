---
title: unlodctr
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fc8aa6f0-c1d9-47ea-937a-28152148e774
author: jaimeo
---
# unlodctr
removes Performance counter names and Explain text for a service or device driver from the system registry. for examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
Unlodctr <DriverName>   
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|<DriverName>|removes the Performance counter name settings and Explain text for driver or service <DriverName> from the Windows Server 2003 registry.|  
|\/?|Displays help at the command prompt.|  
  
## remarks  
  
> [!WARNING]  
> Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.  
  
if the information that you supply contains spaces, use quotation marks around the text \(for example, "<DriverName>"\).  
  
## <a name="BKMK_Examples"></a>Examples  
To remove the current Performance registry settings and counter Explain text for the Simple Mail Transfer Protocol \(SMTP\) service:  
  
```  
unlodctr SMTPSVC  
```  
  
## additional references  
  
-   [Command-Line Syntax Key](commandline-syntax-key.md)  
  
-   [Command-Line Reference_1](Command-Line-Reference_1.md)  
  

