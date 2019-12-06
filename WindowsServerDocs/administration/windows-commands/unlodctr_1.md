---
title: unlodctr
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fc8aa6f0-c1d9-47ea-937a-28152148e774
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# unlodctr

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Removes Performance counter names and Explain text for a service or device driver from the system registry.   

## Syntax  
```  
Unlodctr <DriverName>   
```  
### Parameters  
|Parameter|Description|  
|-------|--------|  
|\<DriverName>|removes the Performance counter name settings and Explain text for driver or service <DriverName> from the Windows Server 2003 registry.|  
|/?|Displays help at the command prompt.|  

## Remarks  
> [!WARNING]  
> Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.  

If the information that you supply contains spaces, use quotation marks around the text (for example, "<DriverName>").  

## <a name="BKMK_Examples"></a>Examples  
To remove the current Performance registry settings and counter Explain text for the Simple Mail Transfer Protocol (SMTP) service:  
```  
unlodctr SMTPSVC  
```  
## Additional references  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
  
