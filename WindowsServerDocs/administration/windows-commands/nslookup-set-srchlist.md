---
title: nslookup set srchlist
description: Reference topic for **** - 

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: 8486266d-22ac-4ce5-aad6-1cd0c08110a2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# nslookup set srchlist

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

changes the default Domain Name System (DNS) domain name and search list.

## Syntax
```
Set srchlist=<DomainName>[/...]
```
### Parameters

|    Parameter    |                                                                                        Description                                                                                        |
|-----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|  <DomainName>   | Specifies new names for the default DNS domain and search list. The default domain name value is based on the host name. You can specify a maximum of six names separated by slashes (/). |
| {help &#124; ?} |                                                                   Displays a short summary of **nslookup** subcommands.                                                                   |

## Remarks
- The **set srchlist**command overrides the default DNS domain name and search list of the **set domain** command. Use the **set all** command to display the list.
  ## Examples
  To set the DNS domain to mfg.widgets.com and the search list to the three names:
  ```
  set srchlist=mfg.widgets.com/mrp2.widgets.com/widgets.com
  ```
  ## Additional References
  - [Command-Line Syntax Key](command-line-syntax-key.md)
  [nslookup set domain](nslookup-set-domain.md)
  [nslookup set all](nslookup-set-all.md)
