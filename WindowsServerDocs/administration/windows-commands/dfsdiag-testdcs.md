---
title: dfsdiag TestDCs
description: Windows Commands topic for dfsdiag TestDCs, which checks the configuration of domain controllers in the specified domain.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: abb915ab-23eb-45d7-9a2e-b6b9a5756a70
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# dfsdiag TestDCs

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Checks the configuration of domain controllers by performing the following tests on each domain controller in the specified domain:  
  
-   Verifies that the Distributed File System (DFS) Namespace service is running and that its startup type is set to Automatic.  
  
-   Checks for the support of site-costed referrals for NETLOGON and SYSvol.  
  
-   Verifies the consistency of the site association by hostname and IP address.

## Syntax  
  
```  
dfsdiag /TestDCs [/Domain:<Domain name>]  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------|--------|  
|/Domain:`<domain_name>`|Domain that you want to check.|  
  
## Remarks  

/Domain is an optional parameter. The default value is the local domain that the local host is joined to.  
  
## <a name=BKMK_Examples></a>Examples  
To verify the configuration of domain controllers in the Contoso.com domain, type:  
  
```  
dfsdiag /TestDCs /Domain:Contoso.com  
```  
  
## Additional References  
  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
  
-   [dfsdiag](dfsdiag.md)  
  

