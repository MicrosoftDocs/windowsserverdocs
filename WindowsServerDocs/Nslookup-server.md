---
title: Nslookup server
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 608267f8-f7b4-412a-8dcd-e08b5ffc2085
---
# Nslookup server
Changes the default server to the specified Domain Name System \(DNS\) domain.  
  
## Syntax  
  
```  
server <DNSDomain>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|<DNSDomain>|Required. Specifies the new DNS domain for the default server.|  
|{help &#124; ?}|Displays a short summary of **nslookup** subcommands.|  
  
## Remarks  
  
-   The **server** command uses the current default server to look up the information about the specified DNS domain. This is in contrast to the **lserver** command, which uses the initial server.  
  
## Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
[Nslookup lserver](Nslookup-lserver.md)  
  

