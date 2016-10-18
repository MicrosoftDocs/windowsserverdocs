---
title: Dfsdiag TestDFSConfig
description: "Windows Commands topic for **** -- "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 106aeeb9-ea79-4e6e-829c-eca06309bab2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Dfsdiag TestDFSConfig

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Checks the configuration of a Distributed File System \(DFS\) namespace by performing the following actions:  
  
-   Verifies that the DFS Namespace service is running and that its  Startup Type is set to Automatic on all namespace servers.  
  
-   Verifies that the DFS registry configuration is consistent among namespace servers.  
  
-   Validates the following dependencies on clustered namespace servers that are running Windows Server 2008 or later:  
  
    -   Namespace root resource dependency on network name resource.  
  
    -   Network name resource dependency on IP address resource.  
  
    -   Namespace root resource dependency on physical disk resource.  
  
  
  
## Syntax  
  
```  
DFSDiag /TestDFSConfig /DFSRoot:<namespace>  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/DFSRoot:<namespace>|The namespace \(DFS root\) to diagnose.|  
  
## <a name="BKMK_Examples"></a>Examples  
To TBD, type:  
  
```  
DFSDiag /TestDFSConfig /DFSRoot:\\Contoso.com\MyNamespace  
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
-   [Dfsdiag](Dfsdiag.md)  
  

