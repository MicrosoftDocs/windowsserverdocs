---
title: Using the disable-Server Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b69fcfe0-b744-4794-bc75-2c9218c0ba66
---
# Using the disable-Server Command
Disables all services for a Windows Deployment Services server.  
  
## Syntax  
  
```  
WDSUTIL [Options] /Disable-Server [/Server:<Server name>]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|  
  
## <a name="BKMK_examples"></a>Examples  
To disable the server, run one of the following:  
  
```  
WDSUTIL /Disable-Server  
WDSUTIL /Verbose /Disable-Server /Server:MyWDSServer  
```  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
[Using the enable-Server Command]()  
  
[Using the get-Server Command]()  
  
[Using the Initialize-Server Command]()  
  
[Subcommand: set-Server]()  
  
[Subcommand: start-Server]()  
  
[Subcommand: stop-Server]()  
  
[The uninitialize-Server Option]()  
  

