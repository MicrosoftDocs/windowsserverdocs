---
title: Subcommand: stop-TransportServer
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dc1b1eec-6893-445e-81dc-16b3fae287fa
---
# Subcommand: stop-TransportServer
Stops all services on a Transport Server.  
  
## Syntax  
  
```  
WDSUTIL [Options] /Stop-TransportServer [/Server:<Server name>]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\[\/Server:<Server name>\]|Specifies the name of the Transport Server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). If no Transport Server is specified, the local server will be used.|  
  
## <a name="BKMK_examples"></a>Examples  
To stop the services, type one of the following:  
  
```  
WDSUTIL /Stop-TransportServer  
WDSUTIL /Verbose /Stop-TransportServer /Server:MyWDSServer  
```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Using the disable-TransportServer Command](../Topic/Using-the-disable-TransportServer-Command.md)  
  
[Using the enable-TransportServer Command](../Topic/Using-the-enable-TransportServer-Command.md)  
  
[Using the get-TransportServer Command](../Topic/Using-the-get-TransportServer-Command.md)  
  
[Subcommand: set-TransportServer](../Topic/Subcommand--set-TransportServer.md)  
  
[Subcommand: start-TransportServer](../Topic/Subcommand--start-TransportServer.md)  
  
