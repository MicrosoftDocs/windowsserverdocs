---
title: telnet open
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e30ad68c-2366-4754-ac36-311a2392902a vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# telnet: open

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Connects to a telnet server.    
## Syntax  
```  
o[pen] <hostname> [<Port>]  
```  
### Parameters  

| Parameter  |                                        Description                                         |
|------------|--------------------------------------------------------------------------------------------|
| <hostname> |                         Specifies the computer name or IP address.                         |
|  [<Port>]  | Specifies the TCP port that the telnet server is listening on. The default is TCP port 23. |

## <a name="BKMK_Examples"></a>Examples  
Connect to a telnet server at telnet.microsoft.com.  
```  
o telnet.microsoft.com  
```  
## additional references  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
