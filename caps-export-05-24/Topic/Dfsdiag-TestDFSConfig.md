---
title: Dfsdiag TestDFSConfig
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 106aeeb9-ea79-4e6e-829c-eca06309bab2
---
# Dfsdiag TestDFSConfig
Checks the configuration of a Distributed File System \(DFS\) namespace by performing the following actions:  
  
-   Verifies that the DFS Namespace service is running and that its  Startup Type is set to Automatic on all namespace servers.  
  
-   Verifies that the DFS registry configuration is consistent among namespace servers.  
  
-   Validates the following dependencies on clustered namespace servers that are running Windows Server 2008 or later:  
  
    -   Namespace root resource dependency on network name resource.  
  
    -   Network name resource dependency on IP address resource.  
  
    -   Namespace root resource dependency on physical disk resource.  
  
For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
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
  
-   [Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
-   [Dfsdiag](../Topic/Dfsdiag.md)  
  
