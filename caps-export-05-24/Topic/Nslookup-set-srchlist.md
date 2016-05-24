---
title: Nslookup set srchlist
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8486266d-22ac-4ce5-aad6-1cd0c08110a2
---
# Nslookup set srchlist
Changes the default Domain Name System \(DNS\) domain name and search list.  
  
For examples of how this command can be used, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
Set srchlist=<DomainName>[/...]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|<DomainName>|Specifies new names for the default DNS domain and search list. The default domain name value is based on the host name. You can specify a maximum of six names separated by slashes \(\/\).|  
|{help &#124; ?}|Displays a short summary of **nslookup** subcommands.|  
  
## Remarks  
  
-   The **set srchlist**command overrides the default DNS domain name and search list of the **set domain** command. Use the **set all** command to display the list.  
  
## <a name="BKMK_examples"></a>Examples  
The following example sets the DNS domain to mfg.widgets.com and the search list to the three names:  
  
```  
set srchlist=mfg.widgets.com/mrp2.widgets.com/widgets.com  
```  
  
## Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Nslookup set domain](../Topic/Nslookup-set-domain.md)  
  
[Nslookup set all](../Topic/Nslookup-set-all.md)  
  
