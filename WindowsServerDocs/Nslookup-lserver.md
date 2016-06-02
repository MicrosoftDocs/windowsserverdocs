---
title: Nslookup lserver
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: aee5ea0b-bb17-4c14-bde7-2f7a91f2f22b
---
# Nslookup lserver
Changes the default server to the specified Domain Name System \(DNS\) domain.  
  
## Syntax  
  
```  
lserver <DNSDomain>   
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|<DNSDomain>|Specifies the new DNS domain for the default server.|  
|{help &#124; ?}|Displays a short summary of **nslookup** subcommands.|  
  
## Remarks  
  
-   The **lserver** command uses the initial server to look up the information about the specified DNS domain. This is in contrast to the **server** command, which uses the current default server.  
  
## Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
[Nslookup server](Nslookup-server.md)  
  

