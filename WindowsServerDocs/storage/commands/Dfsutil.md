---
title: Dfsutil
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ef5093a4-0d24-4b21-9d04-59933ad98e2c
author: JasonGerend
robots: noindex,nofollow
---
# Dfsutil
The dfsutil command manages DFS Namespaces, servers and clients. Dfsutil commands use the original Distributed File System terminology, with updated DFS Namespaces terminology provided as explanation for most commands.  
  
For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
command </parameter> </param2>  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|[Dfsutil Root](Dfsutil-Root.md)|Displays,creates,removes,imports,exports namespace roots.|  
|[Dfsutil Link](Dfsutil-Link.md)|Displays, creates, removes, or moves folders \(links\).|  
|[Dfsutil Target](Dfsutil-Target.md)|Displays,create,remove folder target or namespace server.|  
|[Dfsutil Property](Dfsutil-Property.md)|Displays or modifies a folder target or namespace server.|  
|[Dfsutil Client](Dfsutil-Client.md)|Displays or modifies client information or registry keys.|  
|[Dfsutil Server](Dfsutil-Server.md)|Displays or modifies namespace configuration.|  
|[Dfsutil Diag](Dfsutil-Diag.md)|Perform diagnostics or view dfsdirs\/dfspath.|  
|[Dfsutil Domain](Dfsutil-Domain.md)|Displays all domain\-based namespaces in a domain.|  
|[Dfsutil Cache](Dfsutil-Cache.md)|Displays or flushes the client cache.|  
|[Dfsutil oldcli](Dfsutil-oldcli.md)|Use the Dfsutil \/oldcli command to use of the original Dfsutil syntax.|  
  
## Remarks <optional section>  
If you specify an object \(such as a namespace server\) at the end of a command, most commands will display information about the object without requiring further parameters or commands. For example, when using the Dfsutil Root command, you can append a namespace root to the command to view information about the root.  
  
## <a name="BKMK_Examples"></a>Examples  
<Here is where you put a detailed description of your example.>  
  
```  
This /is /the /example /of /calling /command /with /parameters  
```  
  
<Here is where you put a detailed description of another example.>  
  
```  
This /is /a:”different” /example  
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](../commands/Command-Line-Syntax-Key.md)  
  

