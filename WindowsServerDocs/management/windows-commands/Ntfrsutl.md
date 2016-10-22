---
title: Ntfrsutl
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d7721a19-5a87-4ab6-b816-65d2da2c811f
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Ntfrsutl

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Dumps the internal tables, thread, and memory information for the NT File Replication Service \(NTFRS\). It runs against local and remote servers. The recovery setting for NTFRS in Service Control Manager \(SCM\) can be critical to locating and keeping important log events on the computer. This tool provides a convenient method of reviewing those settings.   
  
## Syntax  
  
```  
ntfrsutl[idtable|configtable|inlog|outlog][<Computer>]  
ntfrsutl[memory|threads|stage][<Computer>]  
ntfrsutl ds[<Computer>]  
ntfrsutl [sets][<Computer>]  
ntfrsutl [version][<Computer>]  
ntfrsutl poll[/quickly[=[<N>]]][/slowly[=[<N>]]][/now][<Computer>]  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------|--------|  
|idtable|ID table|  
|configtable|FRS configuration table|  
|inlog|Inbound log|  
|outlog|Outbound log|  
|<Computer>|Specifies the computer.|  
|memory|Memory usage|  
|threads||  
|stage||  
|ds|Lists the NTFRS service's view of the DS.|  
|sets|Specifies the active replica sets|  
|version|Specifies the API and NTFRS service versions.|  
|poll|Specifies the current polling intervals.<br /><br />Parameters:<br /><br /><ul><li>**\/quickly**\[**\=**\[ <N>\]\]  \(Polls quickly\)<br /><br /><ul><li>**quickly** \- Polls quickly until stable configuration is rectrieved</li><li>**quickly\=** \- Polls quickly every default minutes.</li><li>**quickly\=**<N> \- Polls quickly every *N* minutes</li></ul></li><li>**\/slowly**\[**\=**\[ <N>\]\] \(Polls slowly\)<br /><br /><ul><li>**slowly** \- Polls slowly until stable configuration is retrieved</li><li>**slowly\=** \- Polls slowly every default minutes</li><li>**slowly\=**<N> \- Polls quickly every *N* minutes</li></ul></li><li>**\/now** \(Polls now\)</li></ul>|  
|\/?|Displays Help at the command prompt.|  
  
## <a name="BKMK_Examples"></a>Examples  
To determine the polling interval for file replication:  
  
```  
C:\Program Files\SupportTools>ntfrsutl poll wrkstn-1  
```  
  
To determine the current NTFRS application program interface \(API\) version:  
  
```  
C:\Program Files\SupportTools>ntfrsutl version  
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
-   [Command-Line Reference_1](Command-Line-Reference_1.md)  
  

