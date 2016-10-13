---
title: Telnet: open
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e30ad68c-2366-4754-ac36-311a2392902a vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Telnet: open

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Connects to a Telnet server.    
## Syntax  
```  
o[pen] <HostName> [<Port>]  
```  
### Parameters  
|Parameter|Description|  
|-------------|---------------|  
|<HostName>|Specifies the computer name or IP address.|  
|[<Port>]|Specifies the TCP port that the Telnet server is listening on. The default is TCP port 23.|  
## <a name="BKMK_Examples"></a>Examples  
Connect to a Telnet server at telnet.microsoft.com.  
```  
o telnet.microsoft.com  
```  
## Additional references  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
