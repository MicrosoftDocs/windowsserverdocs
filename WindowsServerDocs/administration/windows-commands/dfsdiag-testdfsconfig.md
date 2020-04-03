---
title: dfsdiag TestDFSConfig
description: Windows Commands topic for dfsdiag TestDFSConfig, which checks the configuration of a Distributed File System (DFS) namespace.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 106aeeb9-ea79-4e6e-829c-eca06309bab2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# dfsdiag TestDFSConfig

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Checks the configuration of a Distributed File System (DFS) namespace by performing the following actions:  
  
-   Verifies that the DFS Namespace service is running and that its  startup type is set to Automatic on all namespace servers.  
  
-   Verifies that the DFS registry configuration is consistent among namespace servers.  
  
-   Validates the following dependencies on clustered namespace servers that are running Windows Server 2008 or later:  
  
    -   Namespace root resource dependency on network name resource.  
  
    -   Network name resource dependency on IP address resource.  
  
    -   Namespace root resource dependency on physical disk resource.

## Syntax  
  
```  
dfsdiag /TestDFSConfig /DFSRoot:<namespace>  
```  
  
#### Parameters  
  
|       Parameter       |               Description               |
|-----------------------|-----------------------------------------|
| /DFSRoot:`<namespace>` | The namespace (DFS root) to diagnose. |
  
## <a name=BKMK_Examples></a>Examples  
  
```  
dfsdiag /TestDFSConfig /DFSRoot:\\Contoso.com\MyNamespace  
```  
  
## Additional References  
  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
  
-   [dfsdiag](dfsdiag.md)  
  

