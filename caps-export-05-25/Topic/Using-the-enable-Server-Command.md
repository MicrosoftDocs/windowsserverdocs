---
title: Using the enable-Server Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 939ffbfb-cf3c-4310-9627-6e7e0c0644d6
---
# Using the enable-Server Command
Enables all services for Windows Deployment Services.  
  
## Syntax  
  
```  
WDSUTIL [Options] /Enable-Server [/Server:<Server name>]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). If no server name is specified, the local server will be used.|  
  
## <a name="BKMK_examples"></a>Examples  
To enable the services on the server, run one of the following:  
  
```  
WDSUTIL /Enable-Server  
WDSUTIL /Verbose /Enable-Server /Server:MyWDSServer  
```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Using the disable-Server Command](../Topic/Using-the-disable-Server-Command.md)  
  
[Using the get-Server Command](../Topic/Using-the-get-Server-Command.md)  
  
[Using the Initialize-Server Command](../Topic/Using-the-Initialize-Server-Command.md)  
  
[Subcommand: set-Server](../Topic/Subcommand--set-Server.md)  
  
[Subcommand: start-Server](../Topic/Subcommand--start-Server.md)  
  
[Subcommand: stop-Server](../Topic/Subcommand--stop-Server.md)  
  
[The uninitialize-Server Option](../Topic/The-uninitialize-Server-Option.md)  
  
